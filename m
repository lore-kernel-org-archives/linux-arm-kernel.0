From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Mon, 06 Feb 2012 19:38:29 +0100
Subject: [PATCH 1/4] i2c/gpio-i2c add: add DT support
In-Reply-To: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4F301E25.5060507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.02.2012 11:38, Jean-Christophe PLAGNIOL-VILLARD wrote:

Hi!

> +Device-Tree bindings for i2c gpio driver
> +
> +Required properties:
> +	- compatible = "gpio-i2c";

Driver name is "i2c-gpio" in file i2c-gpio.c. Previous version of patch 
adding DT-support (prepared by Thomas Chou[1]) used i2c-gpio - could we 
stick to that name?

[1] https://lkml.org/lkml/2011/2/23/584

> +	- gpios: sda and scl gpio
> +
> +
> +Optional properties:
> +	- gpio-i2c,sda_is_open_drain: sda as open drain
> +	- gpio-i2c,scl_is_open_drain: scl as open drain
> +	- gpio-i2c,scl_is_output_only: scl as output only

Most of DT-properties I've seen used hyphen, not underscore.  Could we 
stick to that convention?

(Nitpick: I think that "is" in property names is redundant too.)

> +	- udelay: half clock cycle time in us (may depend on each platform)

Could we use "clock-frequency" as Grant have suggested during review of 
previous patch to i2c-gpio?

   https://lkml.org/lkml/2011/2/24/220

> +	- timeout: timeout to get data
> +
> +
> +Example nodes:
> +
> +i2c-gpio at 0 {
> +	compatible = "gpio-i2c";
> +	gpios =<&pioA 23 0 /* sda */
> +		&pioA 24 0 /* scl */
> +		>;
> +	gpio-i2c,sda_is_open_drain;
> +	gpio-i2c,scl_is_open_drain;
> +	udelay =<2>;		/* ~100 kHz */
> +	#address-cells =<1>;
> +	#size-cells =<0>;
> +
> +	rv3029c2 at 56 {
> +		compatible = "rv3029c2";
> +		reg =<0x56>;
> +	};
> +};
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index a651779..6b5d794 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -14,6 +14,8 @@
>   #include<linux/module.h>
>   #include<linux/slab.h>
>   #include<linux/platform_device.h>
> +#include<linux/of_gpio.h>
> +#include<linux/of_i2c.h>
>
>   #include<asm/gpio.h>
>
> @@ -78,16 +80,51 @@ static int i2c_gpio_getscl(void *data)
>   	return gpio_get_value(pdata->scl_pin);
>   }
>
> +static int of_i2c_gpio_probe(struct device_node *np,
> +			     struct i2c_gpio_platform_data *pdata)
> +{
> +	u32 reg;
> +

if (of_gpio_count(np) < 2)
	return -EINVAL;

> +	pdata->sda_pin = of_get_gpio(np, 0);
> +	pdata->scl_pin = of_get_gpio(np, 1);

if (pdata->sda_pin < 0 || pdata->scl_pin < 0)
	return -EINVAL;

> +
> +	if (of_property_read_u32(np, "udelay",&reg))
> +		pdata->udelay = reg;
> +
> +	if (of_property_read_u32(np, "timeout",&reg))
> +		pdata->timeout = reg;
> +
> +	pdata->sda_is_open_drain =
> +		!!of_get_property(np, "gpio-i2c,sda_is_open_drain", NULL);
> +	pdata->scl_is_open_drain =
> +		!!of_get_property(np, "gpio-i2c,scl_is_open_drain", NULL);
> +	pdata->scl_is_output_only =
> +		!!of_get_property(np, "gpio-i2c,scl_is_output_only", NULL);
> +
> +	return 0;
> +}
> +
>   static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>   {
>   	struct i2c_gpio_platform_data *pdata;
>   	struct i2c_algo_bit_data *bit_data;
>   	struct i2c_adapter *adap;
>   	int ret;
> +	int len = sizeof(struct i2c_gpio_platform_data);
>
> -	pdata = pdev->dev.platform_data;
> +	pdata = kzalloc(len, GFP_KERNEL);

Could you also take into account Grant's comment about private/platform 
data?

   https://lkml.org/lkml/2011/2/3/221

>   	if (!pdata)
> -		return -ENXIO;
> +		return -ENOMEM;
> +
> +	if (pdev->dev.of_node) {
> +		of_i2c_gpio_probe(pdev->dev.of_node, pdata);

Above might fail if configuration is corrupted.

> +	} else {
> +		if (!pdev->dev.platform_data) {
> +			ret = -ENXIO;
> +			goto err_alloc_adap;
> +		}
> +		memcpy(pdata, pdev->dev.platform_data, len);
> +	}
>
>   	ret = -ENOMEM;
>   	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> @@ -143,6 +180,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>   	adap->algo_data = bit_data;
>   	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>   	adap->dev.parent =&pdev->dev;
> +	adap->dev.of_node = pdev->dev.of_node;
>
>   	/*
>   	 * If "dev->id" is negative we consider it as zero.
> @@ -154,6 +192,8 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_add_bus;
>
> +	of_i2c_register_devices(adap);
> +
>   	platform_set_drvdata(pdev, adap);
>
>   	dev_info(&pdev->dev, "using pins %u (SDA) and %u (SCL%s)\n",
> @@ -172,6 +212,7 @@ err_request_sda:
>   err_alloc_bit_data:
>   	kfree(adap);
>   err_alloc_adap:
> +	kfree(pdata);
>   	return ret;
>   }
>
> @@ -192,10 +233,20 @@ static int __devexit i2c_gpio_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id gpio_i2c_dt_ids[] = {
> +	{ .compatible = "gpio-i2c", },

There seem to be no good reason to make DT-compatible string different 
from driver's name that's already in use:

>   static struct platform_driver i2c_gpio_driver = {
>   	.driver		= {
>   		.name	= "i2c-gpio",

Regards,
-- 
Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform
