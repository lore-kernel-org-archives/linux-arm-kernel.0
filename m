From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 Feb 2013 12:04:20 +0100
Subject: [PATCH v3 2/8] reset: Add reset controller API
In-Reply-To: <5123F112.7050105@wwwdotorg.org>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
 <1361273732-23357-3-git-send-email-p.zabel@pengutronix.de>
 <5123F112.7050105@wwwdotorg.org>
Message-ID: <1361358260.4937.26.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, den 19.02.2013, 14:39 -0700 schrieb Stephen Warren:
> On 02/19/2013 04:35 AM, Philipp Zabel wrote:
> > This adds a simple API for devices to request being reset
> > by separate reset controller hardware and implements the
> > reset signal device tree binding.
> 
> I know I apparently already reviewed this before, but I have a couple
> small comments to make.

this is my fault. I added the Kconfig comment only after you looked at
the patches. Same for the change in reset_control_get below, which is
change enough to argue I should have dropped the Reviewed-by.

> When I first posted my binding proposal for this, someone said it might
> make sense to integrate the reset logic into the existing power domains
> support. I think that's drivers/base/power/. It might be worth Cc'ing
> the maintainers of that code in case they have comments.

For devices that change their power domain related state during a reset,
some kind of integration could be needed.

> > diff --git a/drivers/Makefile b/drivers/Makefile
> 
> > +# reset controllers early, since gpu drivers might rely on them to initialize
> > +obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
>
> That sounds odd now. Shouldn't -EPROBE_DEFERRED sort out any ordering
> issues?

Even so, isn't it useful to avoid the -EPROBE_DEFERRED loop when we
expect other drivers to depend on resources provided by the reset
controller drivers, but not the other way around?

> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> 
> > +struct reset_control *reset_control_get(struct device *dev, const char *id)
> ...
> > +	rstc->rcdev = rcdev;
> > +	rstc->id = args.args[0];
> 
> If the length of args < 1, then that will copy garbage data.

Will fix.

> This code will probably work fine for now, but in general, you want to
> call a function in the reset controller itself to translate from args to
> the reset controller ID. This will allow individual reset controllers to
> use a strange mapping for IDs, store flags in the DT cells that
> configure the reset (e.g. how long it should be asserted), etc. May as
> well add that now. You can add a common implementation that most simple
> drivers can use, rather like of_gpio_simple_xlate().

I wanted to keep it simple in the first round, but I agree. It might be
helpful to add it from the beginning.

> > diff --git a/include/linux/reset.h b/include/linux/reset.h
> 
> > +struct reset_control *devm_reset_control_get(struct device *dev, const char *id);
> 
> You might want an explicit devm_reset_control_put() too. It's unlikely
> it'd get much use, but at least some of the other devm_* functions do
> have manual put functions available too.

Ok.

thanks
Philipp
