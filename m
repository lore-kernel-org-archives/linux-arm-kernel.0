From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 17 Jan 2013 11:45:23 +0100
Subject: [PATCH 2/7] reset: Add reset controller API
In-Reply-To: <50F7267E.8090309@wwwdotorg.org>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-3-git-send-email-p.zabel@pengutronix.de>
 <50F7267E.8090309@wwwdotorg.org>
Message-ID: <1358419524.2411.126.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Am Mittwoch, den 16.01.2013, 15:15 -0700 schrieb Stephen Warren:
> On 01/16/2013 09:13 AM, Philipp Zabel wrote:
> > This adds a simple API for devices to request being reset
> > by separate reset controller hardware and implements the
> > reset signal device tree binding.
> 
> 
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> 
> > +obj-$(CONFIG_RESET_CONTROLLER) += core.o
> > +
> 
> nit: blank line at EOF.

Ok.

> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> 
> > +/**
> > + * reset_control_reset - reset the controlled device
> > + * @rstc: reset controller
> > + */
> > +int reset_control_reset(struct reset_control *rstc)
> 
> What time period is the reset signal asserted for; should there be a
> parameter to control this?

"The reset controller knows".

On i.MX, the SRC does all necessary things in hardware (and optionally
causes an interrupt to signal when it's ready - right now the SRC driver
just polls for the reset line to deassert).

For reset controllers that need to be manually asserted/deasserted, and
still want to provide the .reset callback, we should think about some
timing configuration. But IMHO that should be separate from the API.

I've thought about adding an example gpio-reset controller driver, which
knows about the necessary delays and just toggles gpios. This could be
represented in the device tree as follows:

	gpio_reset: gpio_reset {
		compatible = "gpio-reset"
		gpios = <&gpioa 0 0>, <&gpioc 5 0>, <&gpiod 3 1>;
		reset-delays = <10>, <100>, <50>;
		#reset-cells = <1>;
	};

	device-to-be-reset {
		resets = <&gpio_reset 2>; /* GPIOD3, active-low, 50ms */
	};

Or one could add another reset-cell to configure the delay:

	gpio_reset: gpio_reset {
		compatible = "gpio-reset"
		gpios = <&gpioa 0 0>, <&gpioc 5 0>, <&gpiod 3 1>;
		#reset-cells = <2>;
	};

	device-to-be-reset {
		resets = <&gpio_reset 2 50>; /* GPIOD3, active-low, 50ms */
	};

I'd prefer the former over the latter. In any case, I think the timing
information should reside either in the reset controller or in the
framework.

> > +{
> > +	if (rstc->rcdev->ops->reset)
> > +		return rstc->rcdev->ops->reset(rstc->id);
> > +
> > +	return 0;
> > +}
> 
> If there's no op, shouldn't the function fail?

Yes, I'll change that.

> > +/**
> > + * reset_control_is_asserted - deasserts the reset line
> 
> Comment seems wrong.
> 
> Is this API useful; why wouldn't drivers just assert to de-assert it
> based on their needs?

Probably not, I'll drop this.

> > +/**
> > + * reset_control_get - Lookup and obtain a reference to a reset controller.
> > + * @dev: device to be reset by the controller
> > + * @id: reset line name
> > + *
> > + * Returns a struct reset_control or IS_ERR() condition containing errno.
> 
> OK, so NULL can't ever (legally) be returned.

Right.

> > +struct reset_control *reset_control_get(struct device *dev, const char *id)
> 
> > +	rcdev_node = NULL;
> > +	for (i = 0; rcdev_node == NULL; i++) {
> ...
> > +		rcdev_node = args.np;
> > +		rcdev_index = args.args[0];
> 
> Even though the loop condition tests rcdev_node, it'd be a lot easier to
> realize that the loop bails out here because of that if you explicitly
> wrote a break; here. Otherwise, it took a while for me to realize.

Ok.

> > +void reset_control_put(struct reset_control *rstc)
> > +{
> > +	if (rstc == NULL || IS_ERR(rstc))
> > +		return;
> 
> ... so (re: two comments above) you don't need to check for NULL here;
> if someone passes NULL in here, they're passing some value that
> reset_control_get() never passed back, so this API is free to do
> whatever it wants...

Yes, I'll remove it.

> > +	kfree(rstc);
> > +	module_put(rstc->rcdev->owner);
> 
> You need to module_put() first, or copy rstc->rcdev, since otherwise
> you're reading *rstc after it's freed.

Ow, sorry for wasting your time with this one.

> This implementation only supports device tree. People might want the
> APIs to work on non-device-tree systems too, although I guess that
> should be easy enough to retrofit without changing the driver-visible API...

Indeed.

regards
Philipp
