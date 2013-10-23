From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 23 Oct 2013 18:34:01 +0200
Subject: [PATCHv5] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <1382536214-2095-1-git-send-email-denis@eukrea.com>
References: <1382536214-2095-1-git-send-email-denis@eukrea.com>
Message-ID: <20131023163401.GF17512@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:50 Wed 23 Oct     , Denis Carikli wrote:
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v4->v5:
> - The default-brightness property now defaults to 0 in the driver.
as said in the v4 NACK on this proporty drop it

this ned to be handled in C not in DT
> - def_value int becomes a bool.
> - The check for the gpio validity has been reworked.
> ---
>  .../bindings/video/backlight/gpio-backlight.txt    |   21 ++++++
>  drivers/video/backlight/gpio_backlight.c           |   70 ++++++++++++++++++--
>  2 files changed, 84 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> new file mode 100644
> index 0000000..9584357
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> @@ -0,0 +1,21 @@
> +gpio-backlight bindings
> +
> +Required properties:
> +  - compatible: "gpio-backlight"
> +  - gpios: describes the gpio that is used for enabling/disabling the backlight
> +     (see GPIO binding[0] for more details).
> +
> +Optional properties:
> +  - default-brightness-level: the default brightness level (can be 0(off) or
> +    1(on) since GPIOs only support theses levels). If not set will default to
> +    0.
> +
> +[0]: Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +
> +	backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&gpio3 4 0>;
> +		default-brightness-level = <1>;
> +	};
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 81fb127..3a5e1ba 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -13,6 +13,8 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/platform_data/gpio_backlight.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -23,6 +25,7 @@ struct gpio_backlight {
>  
>  	int gpio;
>  	int active;
> +	bool def_value;
>  };
>  
>  static int gpio_backlight_update_status(struct backlight_device *bl)
> @@ -60,6 +63,42 @@ static const struct backlight_ops gpio_backlight_ops = {
>  	.check_fb	= gpio_backlight_check_fb,
>  };
>  
> +static int gpio_backlight_probe_dt(struct platform_device *pdev,
> +				   struct gpio_backlight *gbl)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	enum of_gpio_flags gpio_flags;
> +	int ret;
> +
> +	gbl->fbdev = NULL;
> +	gbl->gpio = of_get_gpio_flags(np, 0, &gpio_flags);
> +
> +	if (!gpio_is_valid(gbl->gpio)) {
> +		if (gbl->gpio != -EPROBE_DEFER) {
> +			dev_err(&pdev->dev,
> +				"Error: The gpios parameter is missing or invalid.\n");
> +		}
> +		return gbl->gpio;
> +	}
> +
> +	gbl->active = (gpio_flags & OF_GPIO_ACTIVE_LOW) ? 0 : 1;
> +
> +	ret = of_property_read_u32(np, "default-brightness-level",
> +				   &gbl->def_value);
> +	if (ret < 0) {
> +		/* The property is optional. */
> +		gbl->def_value = 0;
> +	}
> +
> +	if (gbl->def_value > 1) {
> +		dev_warn(&pdev->dev,
> +			"Warning: Invalid default-brightness-level value.\n");
> +		gbl->def_value = 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>  	struct gpio_backlight_platform_data *pdata =
> @@ -67,10 +106,12 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	struct backlight_properties props;
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
> +	struct device_node *np = pdev->dev.of_node;
>  	int ret;
>  
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "failed to find platform data\n");
> +	if (!pdata && !np) {
> +		dev_err(&pdev->dev,
> +			"failed to find platform data or device tree node.\n");
>  		return -ENODEV;
>  	}
>  
> @@ -79,14 +120,22 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	gbl->dev = &pdev->dev;
> -	gbl->fbdev = pdata->fbdev;
> -	gbl->gpio = pdata->gpio;
> -	gbl->active = pdata->active_low ? 0 : 1;
> +
> +	if (np) {
> +		ret = gpio_backlight_probe_dt(pdev, gbl);
> +		if (ret)
> +			return ret;
> +	} else {
> +		gbl->fbdev = pdata->fbdev;
> +		gbl->gpio = pdata->gpio;
> +		gbl->active = pdata->active_low ? 0 : 1;
> +		gbl->def_value = pdata->def_value;
> +	}
>  
>  	ret = devm_gpio_request_one(gbl->dev, gbl->gpio, GPIOF_DIR_OUT |
>  				    (gbl->active ? GPIOF_INIT_LOW
>  						 : GPIOF_INIT_HIGH),
> -				    pdata->name);
> +				    pdata ? pdata->name : "backlight");
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "unable to request GPIO\n");
>  		return ret;
> @@ -103,17 +152,24 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  		return PTR_ERR(bl);
>  	}
>  
> -	bl->props.brightness = pdata->def_value;
> +	bl->props.brightness = gbl->def_value;
> +
>  	backlight_update_status(bl);
>  
>  	platform_set_drvdata(pdev, bl);
>  	return 0;
>  }
>  
> +static struct of_device_id gpio_backlight_of_match[] = {
> +	{ .compatible = "gpio-backlight" },
> +	{ /* sentinel */ }
> +};
> +
>  static struct platform_driver gpio_backlight_driver = {
>  	.driver		= {
>  		.name		= "gpio-backlight",
>  		.owner		= THIS_MODULE,
> +		.of_match_table = of_match_ptr(gpio_backlight_of_match),
>  	},
>  	.probe		= gpio_backlight_probe,
>  };
> -- 
> 1.7.9.5
> 
