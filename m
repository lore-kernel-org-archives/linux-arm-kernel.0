From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 16 Jun 2015 13:22:13 +0530
Subject: [PATCH 1/4] mfd: 88pm800: add device tree support
In-Reply-To: <20150601083835.GE3329@x1>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150601083835.GE3329@x1>
Message-ID: <557FD5AD.5020405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 01 June 2015 02:08 PM, Lee Jones wrote:
> On Sat, 30 May 2015, Vaibhav Hiremath wrote:
>

Thanks for your review. and sorry for delayed response.

>> Add DT support to the 88pm800 driver along with below properties
>> 	- marvell,88pm800-irq-write-clear :
>> 	  Idicates whether interrupt status is cleared by write
>>
>> Also, creates the DT binding text file,
>> Documentation/devicetree/bindings/mfd/88pm800.txt
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/mfd/88pm800.txt | 57 +++++++++++++++++++++++
>>   drivers/mfd/88pm800.c                             | 39 ++++++++++++++++
>
> These should be submitted separately.
>


Ok, will separate it in next version.


>>   2 files changed, 96 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> new file mode 100644
>> index 0000000..094951b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> @@ -0,0 +1,57 @@
>> +* Marvell 88PM800 Power Management IC
>> +
>> +Required parent device properties:
>> +- compatible : "marvell,88pm800"
>> +- reg : the I2C slave address for the 88pm800 chip
>> +- interrupts : IRQ line for the 88pm800 chip
>> +- interrupt-controller: describes the 88pm800 as an interrupt controller
>> +- #interrupt-cells : should be 1.
>> +		- The cell is the 88pm800 local IRQ number
>> +
>> +Optional parent device properties:
>> +- marvell,88pm800-irq-write-clr: indicates whether interrupt status is cleared by write
>
> Drop the device name.  These bindings should be as generic as possible.
>

OK, how about simply

"mfd-irq_clr_on_write"

> Also describe what the absence of the property means.
>

Ok.

>> +88pm800 consists of a large and varied group of sub-devices:
>
> 3?
>

I have explicitly mentioned in note that more device list will follow.
I just wanted to add entries as and when we add/enable driver support.

>> +Device			 Supply Names	 Description
>> +------			 ------------	 -----------
>> +88pm80x-onkey		:		: On key
>> +88pm80x-rtc		:		: RTC
>> +88pm80x			:		: Regulators
>
> Surely regulators is 88pm80x-regulator, no?
>

did not understand what change is expected here.

>> +Note: More device list will follow
>> +
>> +Example:
>> +
>> +	pmic: 88pm800 at 30 {
>> +		compatible = "marvell,88pm800";
>> +		reg = <0x30>;
>> +		interrupts = <0 77 0x4>;
>
> Please use the #defines in include/dt-bindings/
>

Ok.

>> +		interrupt-parent = <&gic>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +
>> +		marvell,88pm800-irq-write-clr;
>> +
>> +		regulators {
>> +			compatible = "marvell,88pm80x-regulator";
>> +
>> +			buck1a: BUCK1A {
>> +				regulator-compatible = "88PM800-BUCK1A";
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <1800000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +			ldo1: LDO1 {
>> +				regulator-compatible = "88PM800-LDO1";
>> +				regulator-min-microvolt = <1700000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +		};
>
> '\n' here.
>
>> +		rtc {
>> +			compatible = "marvell,88pm80x-rtc";
>> +		};
>> +	};
>> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
>> index 841717a..06ee058 100644
>> --- a/drivers/mfd/88pm800.c
>> +++ b/drivers/mfd/88pm800.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/mfd/core.h>
>>   #include <linux/mfd/88pm80x.h>
>>   #include <linux/slab.h>
>> +#include <linux/of_device.h>
>>
>>   /* Interrupt Registers */
>>   #define PM800_INT_STATUS1		(0x05)
>> @@ -121,6 +122,11 @@ static const struct i2c_device_id pm80x_id_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
>>
>> +static const struct of_device_id pm80x_of_match_table[] = {
>> +	{ .compatible = "marvell,88pm800", },
>> +	{},
>> +};
>> +
>>   static struct resource rtc_resources[] = {
>>   	{
>>   	 .name = "88pm80x-rtc",
>> @@ -133,6 +139,7 @@ static struct resource rtc_resources[] = {
>>   static struct mfd_cell rtc_devs[] = {
>>   	{
>>   	 .name = "88pm80x-rtc",
>> +	 .of_compatible = "marvell,88pm80x-rtc",
>>   	 .num_resources = ARRAY_SIZE(rtc_resources),
>>   	 .resources = &rtc_resources[0],
>>   	 .id = -1,
>> @@ -151,6 +158,7 @@ static struct resource onkey_resources[] = {
>>   static const struct mfd_cell onkey_devs[] = {
>>   	{
>>   	 .name = "88pm80x-onkey",
>> +	 .of_compatible = "marvell,88pm80x-onkey",
>>   	 .num_resources = 1,
>>   	 .resources = &onkey_resources[0],
>>   	 .id = -1,
>> @@ -160,6 +168,7 @@ static const struct mfd_cell onkey_devs[] = {
>>   static const struct mfd_cell regulator_devs[] = {
>>   	{
>>   	 .name = "88pm80x-regulator",
>> +	 .of_compatible = "marvell,88pm80x-regulator",
>>   	 .id = -1,
>>   	},
>>   };
>> @@ -538,14 +547,43 @@ out:
>>   	return ret;
>>   }
>>
>> +static int pm800_probe_dt(struct device_node *np,
>> +			 struct device *dev,
>
> Do you even use dev?
>

Yeah, not used. Will remove it.

>> +			 struct pm80x_platform_data *pdata)
>> +{
>> +	pdata->irq_mode =
>> +		of_property_read_bool(np, "marvell,88pm800-irq-write-clear");
>
> You write a new function for this?
>

Just felt clean this way.
I am ok to merge it in parent function.

>> +	return 0;
>> +}
>> +
>> +
>
> Superfluous '\n'.
>
>>   static int pm800_probe(struct i2c_client *client,
>>   				 const struct i2c_device_id *id)
>>   {
>>   	int ret = 0;
>>   	struct pm80x_chip *chip;
>>   	struct pm80x_platform_data *pdata = dev_get_platdata(&client->dev);
>> +	struct device_node *node = client->dev.of_node;
>
> It's more common to use 'np'.
>

ok.

>>   	struct pm80x_subchip *subchip;
>>
>> +	if (!pdata && !node) {
>> +		dev_err(&client->dev,
>> +			"pm80x requires platform data or of_node\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!pdata) {
>> +		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
>> +		if (!pdata) {
>> +			dev_err(&client->dev, "failed to allocaate memory\n");
>> +			return -ENOMEM;
>> +		}
>> +		ret = pm800_probe_dt(node, &client->dev, pdata);
>> +		if (ret)
>> +			return ret;
>> +	}
>
> All this for a single attribute?  Please simplify.
>

Ok, let me kill probe_dt function here.

Thanks,
Vaibhav
