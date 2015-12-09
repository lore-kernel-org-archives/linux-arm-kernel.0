From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 9 Dec 2015 16:45:05 +0800
Subject: [PATCH 1/3] usb: misc: generic_onboard_hub: add generic onboard
 USB HUB driver
In-Reply-To: <87k2opm4ee.fsf@saruman.tx.rr.com>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <1449538670-7954-2-git-send-email-peter.chen@freescale.com>
 <87poyhmyrc.fsf@saruman.tx.rr.com>
 <20151208091854.GA16881@shlinux2>
 <87k2opm4ee.fsf@saruman.tx.rr.com>
Message-ID: <20151209084504.GE941@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 07:55:05AM -0600, Felipe Balbi wrote:
> 
> Hi,
> 
> Peter Chen <peter.chen@freescale.com> writes:
> >> seriously ? Is this really all ? What about that reset line below ?
> >
> > The clock is PHY input clock on the HUB, this clock may from SoC's
> > PLL.
> 
> oh, you might have misunderstood my comment. I'm saying that there is
> more than one thing you could cache in your private structure. That's
> all.
> 

How? I need to handle clock at both ->probe and ->remove.

> >> > +static int usb_hub_generic_probe(struct platform_device *pdev)
> >> > +{
> >> > +	struct device *dev = &pdev->dev;
> >> > +	struct usb_hub_generic_platform_data *pdata = dev->platform_data;
> >> > +	struct usb_hub_generic_data *hub_data;
> >> > +	int reset_pol = 0, duration_us = 50, ret = 0;
> >> > +	struct gpio_desc *gpiod_reset = NULL;
> >> > +
> >> > +	hub_data = devm_kzalloc(dev, sizeof(*hub_data), GFP_KERNEL);
> >> > +	if (!hub_data)
> >> > +		return -ENOMEM;
> >> > +
> >> > +	if (dev->of_node) {
> >> > +		struct device_node *node = dev->of_node;
> >> > +
> >> > +		hub_data->clk = devm_clk_get(dev, "external_clk");
> >> > +		if (IS_ERR(hub_data->clk)) {
> >> > +			dev_dbg(dev, "Can't get external clock: %ld\n",
> >> > +					PTR_ERR(hub_data->clk));
> >> 
> >> how about setting clock to NULL to here ? then you don't need IS_ERR()
> >> checks anywhere else.
> >> 
> >> > +		}
> >> 
> >> braces shouldn't be used here, if you add NULL trick above,
> >> however... then you can keep them.
> >> 
> >
> > Braces aren't needed, it may not too much useful to using NULL
> > as a indicator for error pointer.
> 
> heh, it's not about using it as an error pointer. I'm merely trying to
> make clk optional. NULL is a valid clk, meaning you won't get NULL
> pointer dereferences when passing it along clk_*() calls (if you find
> any, it's likely a bug in CCF), so NULL can be used to cope with
> optional clocks:
> 
>          clk = clk_get(dev, "foo");
>          if (IS_ERR(clk)) {
>          	if (PTR_ERR(clk) == -EPROBE_DEFER)
>                 	return -EPROBE_DEFER;
>                 else
>                 	clk = NULL;
>          }
> 

Get your point, so at coming code, we don't need to add condition
to enable optional clock.

> >> > +		/*
> >> > +		 * Try to get the information for HUB reset, the
> >> > +		 * default setting like below:
> >> > +		 *
> >> > +		 * - Reset state is low
> >> > +		 * - The duration is 50us
> >> > +		 */
> >> > +		if (of_find_property(node, "hub-reset-active-high", NULL))
> >> > +			reset_pol = 1;
> >> 
> >> you see, this is definitely *not* generic. You should write a generic
> >> reset-gpio.c reset controller and describe the polarity on the gpio
> >> binding. This driver *always* uses reset_assert(); reset_deassert(); and
> >> reset-gpio implements though by gpiod_set_value() correctly.
> >> 
> >> Polarity _must_ be described elsewhere in DT.
> >> 
> >> > +		of_property_read_u32(node, "hub-reset-duration-us",
> >> > +			&duration_us);
> >> 
> >> likewise, this should be described as a debounce time for the GPIO.
> >> 
> >
> > Yes, if we are a reset gpio driver.
> 
> even if you use a raw GPIO, polarity and duration must come through DT.
> 
> >> > +		usleep_range(duration_us, duration_us + 100);
> >> > +		gpiod_set_value(gpiod_reset, reset_pol ? 0 : 1);
> >> 
> >> wrong. You should _not_ have polarity checks here. You should have
> >> already initialized the gpio as ACTIVE_HIGH or ACTIVE_LOW and gpiolib
> >> will handle the polarity for you.
> >
> > Yes, you are right. I did not understand ACTIVE_LOW for gpio flag
> > before.
> 
> with open source code, that's a rather poor excuse, Peter.

I will pay attention to it, thanks.
At my dts example, it is like below, I just treat it at raw gpio
handling.

	usb_hub1 {
		compatible = "generic-onboard-hub";
		clocks = <&clks IMX6QDL_CLK_CKO>;
		clock-names = "external_clk";
		hub-reset-active-high;
		hub-reset-gpios = <&gpio7 12 0>;
		hub-reset-duration-us = <2>;
	};

I will change it like below:
	usb_hub1 {
		compatible = "generic-onboard-hub";
		clocks = <&clks IMX6QDL_CLK_CKO>;
		clock-names = "clk";
		reset-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;
		reset-duration-us = <2>;
	};

> 
> >> > +static int __init usb_hub_generic_init(void)
> >> > +{
> >> > +	return platform_driver_register(&usb_hub_generic_driver);
> >> > +}
> >> > +subsys_initcall(usb_hub_generic_init);
> >> > +
> >> > +static void __exit usb_hub_generic_exit(void)
> >> > +{
> >> > +	platform_driver_unregister(&usb_hub_generic_driver);
> >> > +}
> >> > +module_exit(usb_hub_generic_exit);
> >> 
> >> module_platform_driver();
> >
> > I want this driver to be called before module init's.
> 
> why ?

The USB HUB should be in ready state before controller
tries to talk with it, otherwise, it may has noise at
the bus during the HUB reset/power on process.

-- 

Best Regards,
Peter Chen
