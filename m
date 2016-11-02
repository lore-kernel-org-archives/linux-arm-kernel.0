From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 2 Nov 2016 10:58:40 +0530
Subject: [PATCH v2 4/9] regulator: lp873x: Add support for populating
 input supply
In-Reply-To: <20161030204118.ojeetnxl5qsi6lp7@rob-hp-laptop>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
 <20161021103841.8044-5-lokeshvutla@ti.com>
 <20161030204118.ojeetnxl5qsi6lp7@rob-hp-laptop>
Message-ID: <e5619d78-5752-c8fb-8a11-6629c4b7c3f6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 31 October 2016 02:11 AM, Rob Herring wrote:
> On Fri, Oct 21, 2016 at 04:08:36PM +0530, Lokesh Vutla wrote:
>> In order to have a proper topology of regulators for a platform, each
>> registering regulator needs to populate supply_name field for identifying
>> its supply's name. Add supply_name field for lp873x regulators.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
>>  drivers/regulator/lp873x-regulator.c             | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> index 52766c2..998837a 100644
>> --- a/Documentation/devicetree/bindings/mfd/lp873x.txt
>> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> @@ -7,6 +7,9 @@ Required properties:
>>    - #gpio-cells:	Should be two.  The first cell is the pin number and
>>  			the second cell is used to specify flags.
>>  			See ../gpio/gpio.txt for more information.
>> +  - xxx-in-supply:	Phandle to parent supply node of each regulator
>> +			populated under regulators node. xxx should match
>> +			the supply_name populated in driver.
> 
> The driver is irrelevant. This should reference a list in this document.

okay. See if the below updated patch is fine.

-----------------------------8<----------------------------8<----------------------------
>From 666f925423fa35c7bfcc77fa3c883cbea5d8ef8e Mon Sep 17 00:00:00 2001
From: Lokesh Vutla <lokeshvutla@ti.com>
Date: Wed, 21 Sep 2016 11:50:49 +0530
Subject: [PATCH v3] regulator: lp873x: Add support for populating input
supply

In order to have a proper topology of regulators for a platform, each
registering regulator needs to populate supply_name field for identifying
its supply's name. Add supply_name field for lp873x regulators.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
 drivers/regulator/lp873x-regulator.c             | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt
b/Documentation/devicetree/bindings/mfd/lp873x.txt
index 52766c2..ae9cf39 100644
--- a/Documentation/devicetree/bindings/mfd/lp873x.txt
+++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
@@ -7,6 +7,9 @@ Required properties:
   - #gpio-cells:	Should be two.  The first cell is the pin number and
 			the second cell is used to specify flags.
 			See ../gpio/gpio.txt for more information.
+  - xxx-in-supply:	Phandle to parent supply node of each regulator
+			populated under regulators node. xxx can be
+			buck0, buck1, ldo0 or ldo1.
   - regulators:	List of child nodes that specify the regulator
 			initialization data.
 Example:
@@ -17,6 +20,11 @@ pmic: lp8733 at 60 {
 	gpio-controller;
 	#gpio-cells = <2>;

+	buck0-in-supply = <&vsys_3v3>;
+	buck1-in-supply = <&vsys_3v3>;
+	ldo0-in-supply = <&vsys_3v3>;
+	ldo1-in-supply = <&vsys_3v3>;
+
 	regulators {
 		lp8733_buck0: buck0 {
 			regulator-name = "lp8733-buck0";
diff --git a/drivers/regulator/lp873x-regulator.c
b/drivers/regulator/lp873x-regulator.c
index e504b91..70e3df6 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -24,6 +24,7 @@
 	[_id] = {							\
 		.desc = {						\
 			.name			= _name,		\
+			.supply_name		= _of "-in",		\
 			.id			= _id,			\
 			.of_match		= of_match_ptr(_of),	\
 			.regulators_node	= of_match_ptr("regulators"),\
-- 
2.10.1
