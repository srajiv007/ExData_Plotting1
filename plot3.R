# Step 1 : Read the data from file into a data.frame
power_data<-read.csv("data/household_power_consumption.txt", header=TRUE, sep=";")

# Step 2: Define the filter dates
start_dt<-as.Date("2007-02-01", format = "%Y-%m-%d")
end_dt<-as.Date("2007-02-02", format = "%Y-%m-%d")

library(datasets)
# Step 3: Transform power data to include new DateTime column & transform existing character Date to class "Date"
power_data <- transform(power_data, DateTime=as.POSIXct(paste0(Date, " ", Time), format="%d/%m/%Y %H:%M:%S"), Date=as.Date(Date, format = "%d/%m/%Y"))

# Step 4: Define the filter criteria vector, filtering on the transformed Date feature
filter_criteria <- power_data$Date >= start_dt & power_data$Date <=end_dt

# Step 5: subset power data using criteria vector
filter_data <- power_data[filter_criteria, ]

# Step 6: Transform filtered data frame's Sub metering features to numeric type
filter_data <- transform(filter_data, Sub_metering_1=as.numeric(as.character(Sub_metering_1)), Sub_metering_2=as.numeric(as.character(Sub_metering_2)), Sub_metering_3=as.numeric(as.character(Sub_metering_3)))
#nrow(filter_data)

# Step 7: Generate plots using png device
png(filename = "plot3.png", height = 480, width = 480)
with(filter_data,  plot(DateTime, Sub_metering_1, main = "", xlab="", ylab="Energy sub metering", type = "l", col="black"))
with(filter_data,  lines(DateTime, Sub_metering_2, main = "", xlab="", ylab="", type = "l", col=506))
with(filter_data,  lines(DateTime, Sub_metering_3, main = "", xlab="", ylab="", type = "l", col="blue"))
legend("topright", col=c("black", 506, "blue"), lty="solid", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

