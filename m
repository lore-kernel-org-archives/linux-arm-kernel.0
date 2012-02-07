From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Tue, 07 Feb 2012 16:35:38 +0100
Subject: [PATCH 1/4] i2c/gpio-i2c add: add DT support
In-Reply-To: <20120207032533.GC15647@game.jcrosoft.org>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
 <4F301E25.5060507@samsung.com> <20120207032533.GC15647@game.jcrosoft.org>
Message-ID: <4F3144CA.6070003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.02.2012 04:25, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 19:38 Mon 06 Feb     , Karol Lewandowski wrote:

>>> +	- udelay: half clock cycle time in us (may depend on each platform)
>>
>> Could we use "clock-frequency" as Grant have suggested during review
>> of previous patch to i2c-gpio?

> as exaplained no as for gpio the delay is platform dependent

Following sniplet from i2c-gpio suggests that in some cases both udelay 
and timeout can be calculated given presence of other parameters:

   static int __devinit i2c_gpio_probe(struct platform_device *pdev)
   ...
	if (pdata->udelay)
		bit_data->udelay = pdata->udelay;
	else if (pdata->scl_is_output_only)
		bit_data->udelay = 50;			/* 10 kHz */
	else
		bit_data->udelay = 5;			/* 100 kHz */

	if (pdata->timeout)
		bit_data->timeout = pdata->timeout;
	else
		bit_data->timeout = HZ / 10;		/* 100 ms */

However, I find it more troubling that driver manually grabs parameters 
that are specific to i2c-algo-bit (timeout, udelay).

Thus, I have feeling that it should be generically addressed there. What 
do you think?


>>
>>    https://lkml.org/lkml/2011/2/24/220
>>
>>> +	- timeout: timeout to get data
>>> +
>>> +
>>> +Example nodes:
>>> +
>>> +i2c-gpio at 0 {
>>> +	compatible = "gpio-i2c";
>>> +	gpios =<&pioA 23 0 /* sda */
>>> +		&pioA 24 0 /* scl */
>>> +		>;
>>> +	gpio-i2c,sda_is_open_drain;
>>> +	gpio-i2c,scl_is_open_drain;
>>> +	udelay =<2>;		/* ~100 kHz */
>>> +	#address-cells =<1>;
>>> +	#size-cells =<0>;
>>> +
>>> +	rv3029c2 at 56 {
>>> +		compatible = "rv3029c2";
>>> +		reg =<0x56>;
>>> +	};
>>> +};
>>> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
>>> index a651779..6b5d794 100644
>>> --- a/drivers/i2c/busses/i2c-gpio.c
>>> +++ b/drivers/i2c/busses/i2c-gpio.c
>>> @@ -14,6 +14,8 @@
>>>   #include<linux/module.h>
>>>   #include<linux/slab.h>
>>>   #include<linux/platform_device.h>
>>> +#include<linux/of_gpio.h>
>>> +#include<linux/of_i2c.h>
>>>
>>>   #include<asm/gpio.h>
>>>
>>> @@ -78,16 +80,51 @@ static int i2c_gpio_getscl(void *data)
>>>   	return gpio_get_value(pdata->scl_pin);
>>>   }
>>>
>>> +static int of_i2c_gpio_probe(struct device_node *np,
>>> +			     struct i2c_gpio_platform_data *pdata)
>>> +{
>>> +	u32 reg;
>>> +
>>
>> if (of_gpio_count(np)<  2)
>> 	return -EINVAL;
> ok
>>
>>> +	pdata->sda_pin = of_get_gpio(np, 0);
>>> +	pdata->scl_pin = of_get_gpio(np, 1);
>>
>> if (pdata->sda_pin<  0 || pdata->scl_pin<  0)
>> 	return -EINVAL;
>
>>
>>> +
>>> +	if (of_property_read_u32(np, "udelay",&reg))
>>> +		pdata->udelay = reg;
>>> +
>>> +	if (of_property_read_u32(np, "timeout",&reg))
>>> +		pdata->timeout = reg;

One more thing missed in original review - of_property_read* rnegative 
value on error, so logic has to reversed here:

   if (of_property_read_u32(np, "timeout",&reg) == 0)

or

   if (!of_property_read_u32(np, "timeout",&reg))


As I have been testing your driver on real hardware I've also made 
changes (see below) which I have previously written about. If you would 
like to see these in git-am-able format please drop me a note.

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 6b5d794..d22c2c7 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -80,29 +80,45 @@ static int i2c_gpio_getscl(void *data)
  	return gpio_get_value(pdata->scl_pin);
  }

+#ifdef CONFIG_OF
  static int of_i2c_gpio_probe(struct device_node *np,
  			     struct i2c_gpio_platform_data *pdata)
  {
  	u32 reg;

+	if (!np)
+		return -EINVAL;
+
+	if (of_gpio_count(np) < 2)
+		return -EINVAL;
+
  	pdata->sda_pin = of_get_gpio(np, 0);
  	pdata->scl_pin = of_get_gpio(np, 1);

-	if (of_property_read_u32(np, "udelay", &reg))
+	if (pdata->sda_pin < 0 || pdata->scl_pin < 0)
+		return -EINVAL;
+
+	if (!of_property_read_u32(np, "udelay", &reg))
  		pdata->udelay = reg;

-	if (of_property_read_u32(np, "timeout", &reg))
+	if (!of_property_read_u32(np, "timeout", &reg))
  		pdata->timeout = reg;

  	pdata->sda_is_open_drain =
-		!!of_get_property(np, "gpio-i2c,sda_is_open_drain", NULL);
+		!!of_get_property(np, "i2c-gpio,sda-open-drain", NULL);
  	pdata->scl_is_open_drain =
-		!!of_get_property(np, "gpio-i2c,scl_is_open_drain", NULL);
+		!!of_get_property(np, "i2c-gpio,scl-open-drain", NULL);
  	pdata->scl_is_output_only =
-		!!of_get_property(np, "gpio-i2c,scl_is_output_only", NULL);
+		!!of_get_property(np, "i2c-gpio,scl-output-only", NULL);

  	return 0;
  }
+#else
+static int of_i2c_gpio_probe(struct device_node *np,
+			     struct i2c_gpio_platform_data *pdata)
+{
+	return -EINVAL
+#endif

  static int __devinit i2c_gpio_probe(struct platform_device *pdev)
  {
@@ -116,15 +132,11 @@ static int __devinit i2c_gpio_probe(struct 
platform_device *pdev)
  	if (!pdata)
  		return -ENOMEM;

-	if (pdev->dev.of_node) {
-		of_i2c_gpio_probe(pdev->dev.of_node, pdata);
-	} else {
-		if (!pdev->dev.platform_data) {
-			ret = -ENXIO;
-			goto err_alloc_adap;
-		}
+	ret = -ENXIO;
+	if ((ret = of_i2c_gpio_probe(pdev->dev.of_node, pdata)) < 0 && 
!pdev->dev.platform_data)
+		goto err_alloc_adap;
+	else if (pdev->dev.platform_data)
  		memcpy(pdata, pdev->dev.platform_data, len);
-	}

  	ret = -ENOMEM;
  	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
@@ -235,7 +247,7 @@ static int __devexit i2c_gpio_remove(struct 
platform_device *pdev)

  #if defined(CONFIG_OF)
  static const struct of_device_id gpio_i2c_dt_ids[] = {
-	{ .compatible = "gpio-i2c", },
+	{ .compatible = "i2c-gpio", },
  	{ /* sentinel */ }
  };


Regards,
-- 
Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform
