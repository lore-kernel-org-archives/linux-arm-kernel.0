From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 22 Oct 2013 07:11:57 +0200
Subject: [PATCHv4] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <1671561.1xYjjYivUO@avalon>
References: <20131019104555.GI18477@ns203013.ovh.net>
 <1382346813-8449-1-git-send-email-denis@eukrea.com>
 <1671561.1xYjjYivUO@avalon>
Message-ID: <20131022051157.GC17512@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:48 Tue 22 Oct     , Laurent Pinchart wrote:
> Hi Denis,
> 
> Thanks for the patch. Please see below for a couple of small comment.
> 
> On Monday 21 October 2013 11:13:33 Denis Carikli wrote:
> > Cc: Richard Purdie <rpurdie@rpsys.net>
> > Cc: Jingoo Han <jg1.han@samsung.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: devicetree at vger.kernel.org
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Eric B?nard <eric@eukrea.com>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > ---
> > ChangeLog v3->v4:
> > - The default-brightness property is now optional, it defaults to 1 if not
> > set. - def_value int becomes an u32.
> > - gbl->def_value was set to pdata->def_value in pdata mode to avoid an extra
> > check.
> > ---
> >  .../bindings/video/backlight/gpio-backlight.txt    |   20 ++++++
> >  drivers/video/backlight/gpio_backlight.c           |   69 +++++++++++++++--
> >  2 files changed, 82 insertions(+), 7 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> > b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt new
> > file mode 100644
> > index 0000000..3474d4a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> > @@ -0,0 +1,20 @@
> > +gpio-backlight bindings
> > +
> > +Required properties:
> > +  - compatible: "gpio-backlight"
> > +  - gpios: describes the gpio that is used for enabling/disabling the
> > backlight
> > +     (see GPIO binding[0] for more details).
> > +
> > +Optional properties:
> > +  - default-brightness-level: the default brightness level (can be 0(off)
> > or
> > +      1(on) since GPIOs only support theses levels).
> 
> I believe you should specify what the default value is when the property isn't 
> available.
> 
> > +
> > +[0]: Documentation/devicetree/bindings/gpio/gpio.txt
> > +
> > +Example:
> > +
> > +	backlight {
> > +		compatible = "gpio-backlight";
> > +		gpios = <&gpio3 4 0>;
> > +		default-brightness-level = <0>;
> > +	};
> > diff --git a/drivers/video/backlight/gpio_backlight.c
> > b/drivers/video/backlight/gpio_backlight.c index 81fb127..248124d 100644
> > --- a/drivers/video/backlight/gpio_backlight.c
> > +++ b/drivers/video/backlight/gpio_backlight.c
> > @@ -13,6 +13,8 @@
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_gpio.h>
> >  #include <linux/platform_data/gpio_backlight.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> > @@ -23,6 +25,7 @@ struct gpio_backlight {
> > 
> >  	int gpio;
> >  	int active;
> > +	u32 def_value;
> >  };
> > 
> >  static int gpio_backlight_update_status(struct backlight_device *bl)
> > @@ -60,6 +63,41 @@ static const struct backlight_ops gpio_backlight_ops = {
> >  	.check_fb	= gpio_backlight_check_fb,
> >  };
> > 
> > +static int gpio_backlight_probe_dt(struct platform_device *pdev,
> > +				   struct gpio_backlight *gbl)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	enum of_gpio_flags gpio_flags;
> > +	int ret;
> > +
> > +	gbl->fbdev = NULL;
> > +	gbl->gpio = of_get_gpio_flags(np, 0, &gpio_flags);
> > +
> > +	gbl->active = (gpio_flags & OF_GPIO_ACTIVE_LOW) ? 0 : 1;
> 
> I would move this line after the error check below.
> 
> > +
> > +	if (gbl->gpio == -EPROBE_DEFER) {
> > +		return ERR_PTR(-EPROBE_DEFER);
> 
> Any reason not to retrun -EPROBE_DEFER directly ?
> 
> > +	} else if (gbl->gpio < 0) {
> > +		dev_err(&pdev->dev, "Error: gpios is a required parameter.\n");
> > +		return gbl->gpio;
> > +	}
> 
> Maybe you would do something like
> 
> 	if (gbl->gpio < 0) {
> 		if (gbl->gpio == -EPROBE_DEFER)
> 			dev_err(&pdev->dev, "Error: gpios is a required parameter.\n");
it's not an error it's that the gpio driver is not yet probed

so it's need to be !=
> 		return gbl->gpio;
> 	}
> 
> > +
> > +	ret = of_property_read_u32(np, "default-brightness-level",
> > +				   &gbl->def_value);
> > +	if (ret < 0) {
> > +		/* The property is optional. */
> > +		gbl->def_value = 1;
> > +	}
> > +
> > +	if (gbl->def_value > 1) {
> > +		dev_warn(&pdev->dev,
> > +			"Warning: Invalid default-brightness-level value. Its value can 
> be
> > either 0(off) or 1(on).\n");
> 
> I believe a less verbose message (without the second sentence) would have 
> done, but that's up to you.

as it's only 0 or 1 why not just use a boolean
> 
> > +		gbl->def_value = 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int gpio_backlight_probe(struct platform_device *pdev)
> >  {
> >  	struct gpio_backlight_platform_data *pdata =
> > @@ -67,10 +105,12 @@ static int gpio_backlight_probe(struct platform_device
> > *pdev) struct backlight_properties props;
> >  	struct backlight_device *bl;
> >  	struct gpio_backlight *gbl;
> > +	struct device_node *np = pdev->dev.of_node;
> >  	int ret;
> > 
> > -	if (!pdata) {
> > -		dev_err(&pdev->dev, "failed to find platform data\n");
> > +	if (!pdata && !np) {
> > +		dev_err(&pdev->dev,
> > +			"failed to find platform data or device tree node.\n");
> >  		return -ENODEV;
> >  	}
> > 
> > @@ -79,14 +119,22 @@ static int gpio_backlight_probe(struct platform_device
> > *pdev) return -ENOMEM;
> > 
> >  	gbl->dev = &pdev->dev;
> > -	gbl->fbdev = pdata->fbdev;
> > -	gbl->gpio = pdata->gpio;
> > -	gbl->active = pdata->active_low ? 0 : 1;
> > +
> > +	if (np) {
> > +		ret = gpio_backlight_probe_dt(pdev, gbl);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		gbl->fbdev = pdata->fbdev;
> > +		gbl->gpio = pdata->gpio;
> > +		gbl->active = pdata->active_low ? 0 : 1;
> > +		gbl->def_value = pdata->def_value;
> > +	}
> > 
> >  	ret = devm_gpio_request_one(gbl->dev, gbl->gpio, GPIOF_DIR_OUT |
> >  				    (gbl->active ? GPIOF_INIT_LOW
> > 
> >  						 : GPIOF_INIT_HIGH),
> > 
> > -				    pdata->name);
> > +				    pdata ? pdata->name : "backlight");
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "unable to request GPIO\n");
> >  		return ret;
> > @@ -103,17 +151,24 @@ static int gpio_backlight_probe(struct platform_device
> > *pdev) return PTR_ERR(bl);
> >  	}
> > 
> > -	bl->props.brightness = pdata->def_value;
> > +	bl->props.brightness = gbl->def_value;
> > +
> >  	backlight_update_status(bl);
> > 
> >  	platform_set_drvdata(pdev, bl);
> >  	return 0;
> >  }
> > 
> > +static struct of_device_id gpio_backlight_of_match[] = {
> > +	{ .compatible = "gpio-backlight" },
> > +	{ /* sentinel */ }
> > +};
> > +
> >  static struct platform_driver gpio_backlight_driver = {
> >  	.driver		= {
> >  		.name		= "gpio-backlight",
> >  		.owner		= THIS_MODULE,
> > +		.of_match_table = of_match_ptr(gpio_backlight_of_match),
> >  	},
> >  	.probe		= gpio_backlight_probe,
> >  };
> -- 
> Regards,
> 
> Laurent Pinchart
> 
