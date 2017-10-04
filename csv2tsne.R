library(Rtsne)
args <- commandArgs(TRUE)

## calling the installed package
inFile <- args[1]
outFile <- args[2]
train<- read.csv(inFile) ## Choose the train.csv file downloaded from the link above  

## Curating the database for analysis with both t-SNE and PCA
Labels<-train$label
train$label<-as.factor(train$label)
## for plotting
colors = rainbow(length(unique(train$label)))
names(colors) = unique(train$label)

## Executing the algorithm on curated data
tsne <- Rtsne(train[,-1], dims = 2, perplexity=30, verbose=TRUE, max_iter = 500,check_duplicates=F)
#exeTimeTsne<- system.time(Rtsne(train[,-1], dims = 2, perplexity=30, verbose=TRUE, max_iter = 500))

## Plotting
pdf(outFile)
plot(tsne$Y, main="tsne")
text(tsne$Y, labels=train$label, col=colors[train$label])
dev.off()

