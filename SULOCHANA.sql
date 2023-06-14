# SQL ALTERNATE PROJECT
# SUBMITTED BY SULOCHANA
# 29/05/2023

use fastkart;
#1. List Top 3 products based on QuantityAvailable. (productid, productname, QuantityAvailable ). 
-- (3 Rows) [Note: Products]
#ANS
SELECT productid, productname, QuantityAvailable
FROM products
ORDER BY QuantityAvailable DESC LIMIT 3;

#2.Display EmailId of those customers who have done more than ten purchases.
--  (EmailId, Total_Transactions). (5 Rows) [Note: Purchasedetails, products]
SELECT pd.EmailId, count(pd.QuantityPurchased) as Total_Transactions
FROM Purchasedetails pd
INNER JOIN products p 
ON pd.productid = p.productid
GROUP BY  EmailId
HAVING COUNT(QuantityPurchased)>10
ORDER BY Total_Transactions DESC;

#3.List the Total QuantityAvailable category wise in descending order. 
-- (Name of the category, QuantityAvailable) (7 Rows) [Note: products, categories]
#ANS
SELECT c.categoryname as nameofthecategory, count(p.quantityavailable) as Totalquantityavailable
FROM products p
INNER JOIN categories c 
ON p.categoryid = c.categoryid
GROUP BY categoryname
ORDER BY Totalquantityavailable DESC;

#4. Display ProductId, ProductName, CategoryName, Total_Purchased_Quantity for the product which has been sold maximum in terms of quantity? 
-- (1 Row) [Note: purchasedetails, products, categories]
#ANS
SELECT p.productid, p.productname, c.categoryname, sum(pd.quantitypurchased) as Total_purchased_quantity
FROM categories c
INNER JOIN products p
ON c.categoryid=p.categoryid
INNER JOIN purchasedetails pd
ON p.productid=pd.productid
GROUP BY productid,productname,categoryname
order by Total_purchased_quantity DESC LIMIT 1;

#5. Display the number of male and female customers in fastkart. 
-- (2 Rows) [Note: roles, users]
#ANS
SELECT gender, count(*) as No_of_customers
FROM users
GROUP BY gender;

#6.Display ProductId, ProductName, Price and Item_Classes of all the products where Item_Classes are as follows:
-- If the price of an item is less than 2,000 then “Affordable”, 
-- If the price of an item is in between 2,000 and 50,000 then “High End Stuff”, 
-- If the price of an item is more than 50,000 then “Luxury”. (57 Rows)
# ANS
SELECT productid, productname, price,
CASE 
WHEN price < 2000 THEN 'Affordable'
WHEN price >=2000 and price <=50000 THEN 'High and Stuff'
WHEN price > 50000 THEN 'Luxury'
ELSE price
end as Itemclasses
from Products;

#7.Write a query to display ProductId, ProductName, CategoryName, Old_Price(price) and New_Price as per the following criteria a. 
-- If the category is “Motors”, decrease the price by 3000 b. If the category is “Electronics”, increase the price by 50 c.
-- If the category is “Fashion”, increase the price by 150 For the rest of the categories price remains same.
-- Hint: Use case statement, there should be no permanent change done in table/DB. (57 Rows) [Note: products, categories]
# ANS
SELECT p.productid,productname,c.categoryname,p.price,
CASE categoryname
WHEN 'Motors'THEN price - 3000
WHEN 'Electronics'THEN price + 50
WHEN 'Fashion'THEN price + 150
ELSE price
END as newprice
FROM products p
INNER JOIN categories c
ON p.categoryid = c.categoryid
ORDER BY productid;

#8. Display the percentage of females present among all Users.
--  (Round up to 2 decimal places) Add “%” sign while displaying the percentage. 
-- (1 Row) [Note: users]
#ANS
SELECT round(count(Gender = 'F')/(select count(Gender) from users)*100,2) as Female , '%'
from users
WHERE Gender = 'F';

#9.Display the average balance for both card types for those records only where CVVNumber > 333 and NameOnCard ends with the alphabet “e”. 
-- (2 Rows) [Note: carddetails]
#ANS
SELECT cardtype, avg (Balance)
FROM carddetails
WHERE CVVnumber > 333
AND nameoncard like '%e'
GROUP BY cardtype; 

#10.What is the 2nd most valuable item available which does not belong to the “Motor” category. Value of an item = Price * QuantityAvailable.
--  Display ProductName, CategoryName, value. (1 Row) [Note: products, categories]
#ANS
SELECT p.productname, c.categoryname, sum(p.price*p.quantityavailable) as value
FROM products p
INNER JOIN categories c
ON p.categoryid = c.categoryid
WHERE categoryname != 'Motors'
GROUP BY productname,categoryname
ORDER BY value DESC limit 1,1;

