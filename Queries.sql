use practice;
select * from pizza_sales;

Desc pizza_sales; 

#KPI's
Select sum(total_price) as Total_Revenue from pizza_sales;

Select sum(total_price) / count(distinct order_id) as Avg_Order_Value from pizza_sales;

Select sum(quantity) as Total_Pizza_Sold from pizza_sales;

Select count(distinct order_id) as Total_Orders from pizza_sales;

Select Cast(cast(sum(quantity) as Decimal(10,2)) / cast(count(distinct order_id) as Decimal(10,2)) as Decimal(10,2)) 
as Avg_Pizzas_per_Order from pizza_sales;

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------

#Changing of datatype
ALTER TABLE pizza_sales 
ADD COLUMN order_date_fixed DATE;

UPDATE pizza_sales
SET order_date_fixed = STR_TO_DATE(order_date, '%d-%m-%Y');

Select order_date, order_date_fixed from pizza_sales
limit 10;

ALTER TABLE pizza_sales DROP COLUMN order_date;
ALTER TABLE pizza_sales CHANGE order_date_fixed order_date DATE;

####################################################################################################

ALTER TABLE pizza_sales
ADD COLUMN order_time_fixed TIME;

UPDATE pizza_sales
SET order_time_fixed = STR_TO_DATE(COALESCE(NULLIF(order_time, ''), '00:00:00'), '%H:%i:%s');

SELECT order_time, order_time_fixed
FROM pizza_sales
LIMIT 10;


ALTER TABLE pizza_sales DROP COLUMN order_time;

ALTER TABLE pizza_sales CHANGE order_time_fixed order_time TIME;

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Other datas
Select Order_day, Total_Orders from (Select dayname(order_date) as Order_Day, dayofweek(order_date) as wkd, 
count(distinct order_id) as Total_Orders
from pizza_sales
group by 1,2) as abc
order by wkd;

Select monthname(order_date) as Month_Name, count(distinct order_id) as Count
from pizza_sales
group by 1
order by 2 desc;

#For 1st month only
Select pizza_Category, Sum(total_price) Total_Sales,
sum(total_price) * 100 / (select sum(total_price) from pizza_sales where month(order_date) = 1) 
as Percentage_of_Total_Sales 
from pizza_sales
where month(order_date) = 1
group by 1;

#For overall month
Select pizza_Category, Sum(total_price) Total_Sales,
sum(total_price) * 100 / (select sum(total_price) from pizza_sales) 
as Percentage_of_Total_Sales 
from pizza_sales
group by 1;

#For 1st Qtr
Select pizza_Size, cast(Sum(total_price) as decimal(10,2)) Total_Sales,
cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales where quarter(order_date) = 1) as Decimal(10,2) ) 
as Percentage_of_Total_Sales 
from pizza_sales
where quarter(order_date) = 1
group by 1
order by percentage_of_total_sales desc;

#For overall month
Select pizza_Size, cast(Sum(total_price) as decimal(10,2)) Total_Sales,
cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as Decimal(10,2)) 
as Percentage_of_Total_Sales 
from pizza_sales
group by 1
order by percentage_of_total_sales desc;

Select pizza_name, Sum(total_price) as Total_Revenue from pizza_sales
group by 1
order by 2 desc
limit 5;

Select pizza_name, Sum(total_price) as Total_Revenue from pizza_sales
group by 1
order by 2
limit 5;

Select pizza_name, Sum(quantity) as Total_Quantity from pizza_sales
group by 1
order by 2 desc
limit 5;

Select pizza_name, Sum(quantity) as Total_Quantity from pizza_sales
group by 1
order by 2 
limit 5;

Select pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
group by 1
order by 2 desc
limit 5;

Select pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
group by 1
order by 2
limit 5;




