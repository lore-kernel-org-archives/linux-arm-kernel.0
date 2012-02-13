From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Mon, 13 Feb 2012 18:17:37 +0100
Subject: [PATCH 1/4 v2] i2c/gpio: add DT support
In-Reply-To: <1328754308-7365-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328754308-7365-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4F3945B1.9070900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.02.2012 03:25, Jean-Christophe PLAGNIOL-VILLARD wrote:

Hi!

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA at public.gmane.org
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ at public.gmane.org
> ---
> v2:
> 
> 	use devm
> 	update DT bindings to i2c-gpio and sda-open-drain...
> 	update against "of: introduce helper to manage boolean"
> 
> Best Regards,
> J.
>  .../devicetree/bindings/gpio/gpio_i2c.txt          |   32 +++++++
>  drivers/i2c/busses/i2c-gpio.c                      |   95 +++++++++++++++----
>  2 files changed, 107 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_i2c.txt b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> new file mode 100644
> index 0000000..9710ed2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> @@ -0,0 +1,32 @@
> +Device-Tree bindings for i2c gpio driver
> +
> +Required properties:
> +	- compatible = "i2c-gpio";
> +	- gpios: sda and scl gpio
> +
> +
> +Optional properties:
> +	- i2c-gpio,sda-open-drain: sda as open drain
> +	- i2c-gpio,scl-open-drain: scl as open drain
> +	- i2c-gpio,scl-output-only: scl as output only


> +	- udelay: delay between GPIO operations (may depend on each platform)
> +	- timeout: timeout to get data (ms)


If these are really needed then I would prefer to have these fully
qualified (with unit type "-ms/-millisecs" appended).

Regulator framework, with its "-microvolt/-microamp", serve here as
prime example of being quite descriptive (one doesn't neet to look up
the docs). Please see:

  http://permalink.gmane.org/gmane.linux.ports.arm.omap/67637

> +
> +Example nodes:
> +
> +i2c-gpio at 0 {
> +	compatible = "i2c-gpio";
> +	gpios = <&pioA 23 0 /* sda */
> +		 &pioA 24 0 /* scl */
> +		>;
> +	i2c-gpio,sda-open-drain;
> +	i2c-gpio,scl-open-drain;
> +	udelay = <2>;		/* ~100 kHz */
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	rv3029c2 at 56 {
> +		compatible = "rv3029c2";
> +		reg = <0x56>;
> +	};
> +};
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index a651779..d7032c1 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -14,8 +14,15 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_i2c.h>
>  
> -#include <asm/gpio.h>
> +struct i2c_gpio_private_data {
> +	struct i2c_adapter adap;
> +	struct i2c_algo_bit_data bit_data;
> +	struct i2c_gpio_platform_data pdata;
> +};
>  
>  /* Toggle SDA by changing the direction of the pin */
>  static void i2c_gpio_setsda_dir(void *data, int state)
> @@ -78,24 +85,63 @@ static int i2c_gpio_getscl(void *data)
>  	return gpio_get_value(pdata->scl_pin);
>  }
>  
> +static int __devinit of_i2c_gpio_probe(struct device_node *np,
> +			     struct i2c_gpio_platform_data *pdata)
> +{
> +	u32 reg;
> +
> +	if (of_gpio_count(np) < 2)
> +		return -ENODEV;
> +
> +	pdata->sda_pin = of_get_gpio(np, 0);
> +	pdata->scl_pin = of_get_gpio(np, 1);
> +
> +	if (pdata->sda_pin < 0 || pdata->scl_pin < 0) {
> +		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
> +		       np->full_name, pdata->sda_pin, pdata->scl_pin);
> +		return -ENODEV;
> +	}
> +



> +	if (of_property_read_u32(np, "udelay", &reg))
> +		pdata->udelay = reg;
> +
> +	if (of_property_read_u32(np, "timeout", &reg))
> +		pdata->timeout = msecs_to_jiffies(reg);


I don't know if you have received my previous mail[1] but as I said
there - of_property_read_* returns non-zero (< 0) value on _error_.
Thus, logic of above two statements has to be reversed.

[1] http://permalink.gmane.org/gmane.linux.drivers.i2c/10009

Thanks

> +
> +	pdata->sda_is_open_drain =
> +		!!of_property_read_bool(np, "i2c-gpio,sda-open-drain");
> +	pdata->scl_is_open_drain =
> +		!!of_property_read_bool(np, "i2c-gpio,scl-open-drain");
> +	pdata->scl_is_output_only =
> +		!!of_property_read_bool(np, "i2c-gpio,scl-output-only");
> +
> +	return 0;
> +}
> +
>  static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  {
> +	struct i2c_gpio_private_data *priv;
>  	struct i2c_gpio_platform_data *pdata;
>  	struct i2c_algo_bit_data *bit_data;
>  	struct i2c_adapter *adap;
>  	int ret;
>  
> -	pdata = pdev->dev.platform_data;
> -	if (!pdata)
> -		return -ENXIO;
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	adap = &priv->adap;
> +	bit_data = &priv->bit_data;
> +	pdata = &priv->pdata;
>  
> -	ret = -ENOMEM;
> -	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> -	if (!adap)
> -		goto err_alloc_adap;
> -	bit_data = kzalloc(sizeof(struct i2c_algo_bit_data), GFP_KERNEL);
> -	if (!bit_data)
> -		goto err_alloc_bit_data;
> +	if (pdev->dev.of_node) {
> +		ret = of_i2c_gpio_probe(pdev->dev.of_node, pdata);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (!pdev->dev.platform_data)
> +			return -ENXIO;
> +		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
> +	}
>  
>  	ret = gpio_request(pdata->sda_pin, "sda");
>  	if (ret)
> @@ -143,6 +189,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  	adap->algo_data = bit_data;
>  	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>  	adap->dev.parent = &pdev->dev;
> +	adap->dev.of_node = pdev->dev.of_node;
>  
>  	/*
>  	 * If "dev->id" is negative we consider it as zero.
> @@ -154,7 +201,9 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_add_bus;
>  
> -	platform_set_drvdata(pdev, adap);
> +	of_i2c_register_devices(adap);
> +
> +	platform_set_drvdata(pdev, priv);
>  
>  	dev_info(&pdev->dev, "using pins %u (SDA) and %u (SCL%s)\n",
>  		 pdata->sda_pin, pdata->scl_pin,
> @@ -168,34 +217,40 @@ err_add_bus:
>  err_request_scl:
>  	gpio_free(pdata->sda_pin);
>  err_request_sda:
> -	kfree(bit_data);
> -err_alloc_bit_data:
> -	kfree(adap);
> -err_alloc_adap:
>  	return ret;
>  }
>  
>  static int __devexit i2c_gpio_remove(struct platform_device *pdev)
>  {
> +	struct i2c_gpio_private_data *priv;
>  	struct i2c_gpio_platform_data *pdata;
>  	struct i2c_adapter *adap;
>  
> -	adap = platform_get_drvdata(pdev);
> -	pdata = pdev->dev.platform_data;
> +	priv = platform_get_drvdata(pdev);
> +	adap = &priv->adap;
> +	pdata = &priv->pdata;
>  
>  	i2c_del_adapter(adap);
>  	gpio_free(pdata->scl_pin);
>  	gpio_free(pdata->sda_pin);
> -	kfree(adap->algo_data);
> -	kfree(adap);
>  
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id i2c_gpio_dt_ids[] = {
> +	{ .compatible = "i2c-gpio", },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, i2c_gpio_dt_ids);
> +#endif
> +
>  static struct platform_driver i2c_gpio_driver = {
>  	.driver		= {
>  		.name	= "i2c-gpio",
>  		.owner	= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(i2c_gpio_dt_ids),
>  	},
>  	.probe		= i2c_gpio_probe,
>  	.remove		= __devexit_p(i2c_gpio_remove),
