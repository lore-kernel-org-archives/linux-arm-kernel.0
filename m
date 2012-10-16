From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 16 Oct 2012 11:39:14 +0200
Subject: [PATCH 1/4] leds: leds-ns2: add device tree binding
In-Reply-To: <20121015195809.GJ20922@titan.lakedaemon.net>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
 <1350315295-14567-2-git-send-email-simon.guinot@sequanux.org>
 <20121015174144.GH20922@titan.lakedaemon.net>
 <20121015191222.GB28384@kw.sim.vm.gnt>
 <20121015195809.GJ20922@titan.lakedaemon.net>
Message-ID: <20121016093914.GD28384@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 03:58:09PM -0400, Jason Cooper wrote:
> On Mon, Oct 15, 2012 at 09:12:22PM +0200, Simon Guinot wrote:
> > On Mon, Oct 15, 2012 at 01:41:44PM -0400, Jason Cooper wrote:
> > > On Mon, Oct 15, 2012 at 05:34:52PM +0200, Simon Guinot wrote:
> > > > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > > > ---
> > > >  .../devicetree/bindings/gpio/leds-ns2.txt          |   26 ++++++
> > > >  drivers/leds/leds-ns2.c                            |   84 +++++++++++++++++++-
> > > >  2 files changed, 107 insertions(+), 3 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/gpio/leds-ns2.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/gpio/leds-ns2.txt b/Documentation/devicetree/bindings/gpio/leds-ns2.txt
> > > > new file mode 100644
> > > > index 0000000..1a84969
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/gpio/leds-ns2.txt
> > > > @@ -0,0 +1,26 @@
> > > > +Binding for dual-GPIO LED found on Network Space v2 (and parents).
> > > > +
> > > > +Required properties:
> > > > +- compatible: "ns2-leds".
> > > > +
> > > > +Each LED is represented as a sub-node of the ns2-leds device.
> > > > +
> > > > +Required sub-node properties:
> > > > +- cmd-gpio: Command LED GPIO. See OF device-tree GPIO specification.
> > > > +- slow-gpio: Slow LED GPIO. See OF device-tree GPIO specification.
> > > > +
> > > > +Optional sub-node properties:
> > > > +- label: Name for this LED. If omitted, the label is taken from the node name.
> > > > +- linux,default-trigger: Trigger assigned to the LED.
> > > > +
> > > > +Example:
> > > > +
> > > > +ns2-leds {
> > > > +	compatible = "ns2-leds";
> > > > +
> > > > +	blue-sata {
> > > > +		label = "ns2:blue:sata";
> > > > +		slow-gpio = <&gpio0 29 0>;
> > > > +		cmd-gpio = <&gpio0 30 0>;
> > > > +	};
> > > > +};
> > > > diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
> > > > index d176ec8..55d199b 100644
> > > > --- a/drivers/leds/leds-ns2.c
> > > > +++ b/drivers/leds/leds-ns2.c
> > > > @@ -30,6 +30,7 @@
> > > >  #include <linux/leds.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/platform_data/leds-kirkwood-ns2.h>
> > > > +#include <linux/of_gpio.h>
> > > >  
> > > >  /*
> > > >   * The Network Space v2 dual-GPIO LED is wired to a CPLD and can blink in
> > > > @@ -263,6 +264,68 @@ static void delete_ns2_led(struct ns2_led_data *led_dat)
> > > >  	gpio_free(led_dat->slow);
> > > >  }
> > > >  
> > > > +#ifdef CONFIG_OF_GPIO
> > > > +/*
> > > > + * Translate OpenFirmware node properties into platform_data.
> > > > + */
> > > > +static int __devinit
> > > > +ns2_leds_get_of_pdata(struct device *dev, struct ns2_led_platform_data *pdata)
> > > > +{
> > > > +	struct device_node *np = dev->of_node;
> > > > +	struct device_node *child;
> > > > +	struct ns2_led *leds;
> > > > +	int num_leds = 0;
> > > > +	int i = 0;
> > > > +
> > > > +	num_leds = of_get_child_count(np);
> > > > +	if (!num_leds)
> > > > +		return -ENODEV;
> > > > +
> > > > +	leds = devm_kzalloc(dev, num_leds * sizeof(struct ns2_led),
> > > > +			    GFP_KERNEL);
> > > > +	if (!leds)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	for_each_child_of_node(np, child) {
> > > > +		const char *string;
> > > > +		int ret;
> > > > +
> > > > +		ret = of_get_named_gpio(child, "cmd-gpio", 0);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > 
> > > free leds?
> > 
> > Maybe I missed something but I though it was the purpose of using devres
> > function as devm_kzalloc.
> 
> You are correct.  alloc/return involks a visceral reaction, akin to a
> bull seeing red, my mistake.  :-)
> 
> > 
> > > 
> > > > +		leds[i].cmd = ret;
> > > > +		ret = of_get_named_gpio(child, "slow-gpio", 0);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > 
> > > same here.
> > > 
> > > > +		leds[i].slow = ret;
> > > > +		ret = of_property_read_string(child, "label", &string);
> > > > +		leds[i].name = (ret == 0) ? string : child->name;
> > > > +		ret = of_property_read_string(child, "linux,default-trigger",
> > > > +					      &string);
> > > > +		if (ret == 0)
> > > > +			leds[i].default_trigger = string;
> > > > +
> > > > +		i++;
> > > > +	}
> > > > +
> > > > +	pdata->leds = leds;
> > > > +	pdata->num_leds = num_leds;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct of_device_id of_ns2_leds_match[] = {
> > > > +	{ .compatible = "ns2-leds", },
> > > 
> > > Is this LaCie-specific?  eg "lacie,ns2-leds"?
> > 
> > Yes I think it is LaCie specific.
> 
> Ok, please change.
> 
> > 
> > > 
> > > > +	{},
> > > > +};
> > > > +#else
> > > > +static int __devinit
> > > > +ns2_leds_get_of_pdata(struct device *dev, struct ns2_led_platform_data *pdata)
> > > > +{
> > > > +	return -ENODEV;
> > > > +}
> > > > +#endif /* CONFIG_OF_GPIO */
> > > 
> > > The above doesn't look right to me.  The only time
> > > ns2_leds_get_of_pdata() gets called is when OF_GPIO is enabled.  You
> > > should be able to remove the #else block.
> > 
> > Yes you are right.
> > 
> > > 
> > > > +
> > > >  static int __devinit ns2_led_probe(struct platform_device *pdev)
> > > >  {
> > > >  	struct ns2_led_platform_data *pdata = pdev->dev.platform_data;
> > > > @@ -270,11 +333,25 @@ static int __devinit ns2_led_probe(struct platform_device *pdev)
> > > >  	int i;
> > > >  	int ret;
> > > >  
> > > > +#ifdef CONFIG_OF_GPIO
> > > > +	if (!pdata) {
> > > > +		pdata = devm_kzalloc(&pdev->dev,
> > > > +				     sizeof(struct ns2_led_platform_data),
> > > > +				     GFP_KERNEL);
> > > > +		if (!pdata)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		ret = ns2_leds_get_of_pdata(&pdev->dev, pdata);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +#else
> > > >  	if (!pdata)
> > > >  		return -EINVAL;
> > > > +#endif /* CONFIG_OF_GPIO */
> > > >  
> > > >  	leds_data = devm_kzalloc(&pdev->dev, sizeof(struct ns2_led_data) *
> > > > -			    pdata->num_leds, GFP_KERNEL);
> > > > +				 pdata->num_leds, GFP_KERNEL);
> > > >  	if (!leds_data)
> > > >  		return -ENOMEM;
> > > >  
> > > > @@ -312,8 +389,9 @@ static struct platform_driver ns2_led_driver = {
> > > >  	.probe		= ns2_led_probe,
> > > >  	.remove		= __devexit_p(ns2_led_remove),
> > > >  	.driver		= {
> > > > -		.name	= "leds-ns2",
> > > > -		.owner	= THIS_MODULE,
> > > > +		.name		= "leds-ns2",
> > > > +		.owner		= THIS_MODULE,
> > > 
> > > nit.  whitespace before '=', above two lines.
> > 
> > Sorry I don't get it. For the two lines before, I used two tabs before
> > '='. As a result, this lines are aligned with the next one. I got no
> > warnings and no errors from checkpatch.pl.
> 
> It's not a checkpatch problem.  It's that before your patch, the equals
> signs were lined up.  Afterwards, they aren't.  In either case, if you
> would like to fix the whitespace (line up all struct elements and the
> equals signs), that should be a separate patch.

The current patch inserts a new field (of_match_table) in the structure.
This new field breaks the equals signs alignment. I think it is correct
to restore the alignment broken by a patch in the same patch context.

Do you really want me to put this in a separate patch ?

> 
> > 
> > > 
> > > > +		.of_match_table	= of_match_ptr(of_ns2_leds_match),
> > > 
> > > Have you tried this with OF_GPIO=n?  of_match_ptr() handles CONFIG_OF
> > > being enabled/disabled.  Which means the case of CONFIG_OF=y,
> > > CONFIG_OF_GPIO=n appears to be unhandled.
> > 
> > Good caught. I guess I have just copied a bug from the driver gpio-fan.
> 
> On the next round, please add a separate patch fixing gpio-fan.c.

After a second look, I noticed that several drivers are also mixing up
CONFIG_OF and CONFIG_OF_GPIO checks: gpio-fan, leds-gpio, gpio_keys.c,
i2c-gpio.c, spi-s3c64xx.c, ...

I also noticed that CONFIG_OF_GPIO can't be selected separately from
CONFIG_OF. From Kconfig, CONFIG_OF implies CONFIG_OF_GPIO.

So, I am no longer convinced we have a bug here. But if there is, we
will need more than a single patch to fix it :)

Let me know your advice about that.

Simon

> 
> There shouldn't be any harm in moving the struct of_device_id {} outside
> of the #ifdef and just above the struct platform_driver {} declaration.
> That would maintain the convention.  _probe() will just return -EINVAL
> if OF_GPIO isn't enabled (without pdata, of course).
> 
> thx,
> 
> Jason.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121016/2ce47165/attachment-0001.sig>
