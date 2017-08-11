From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 18:37:20 +0200
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <fc0d0480-947b-a731-627c-32c99bbc2586@adaptrum.com>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-2-p.zabel@pengutronix.de>
 <fc0d0480-947b-a731-627c-32c99bbc2586@adaptrum.com>
Message-ID: <1502469440.2310.27.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandru,

On Fri, 2017-08-11 at 09:04 -0700, Alexandru Gagniuc wrote:
> Hi Phillip,
> 
> On 08/11/2017 06:06 AM, Philipp Zabel wrote:
> [snip]
> 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 52d5251660b9b..f7ba01a71daee 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -68,6 +68,16 @@ config RESET_PISTACHIO
> > > > ?	help
> > > > ?	??This enables the reset driver for ImgTec Pistachio SoCs.
> > 
> > +config RESET_SIMPLE
> > > > +	bool "Simple Reset Controller Driver" if COMPILE_TEST
> > +	default ARCH_SUNXI
> 
> This seems like a list with the potential to grow unbounded. I think it?
> would be better for the platforms to 'select RESET_SIMPLE' rather than?
> trying to guess all users in one big kconfig line.

That is a good point. Before that can be done, though, I have to hide
the RESET_CONTROLLER symbol and make drivers select it, instead of
hiding them behind "if RESET_CONTROLLER".

> > +struct reset_simple_devdata {
> > > > +	bool inverted;
> > +};
> > +
> > +static const struct reset_simple_devdata reset_simple_inverted = {
> > +	.inverted = true,
> 
> Hmm. I think it would be useful for new devices if there were have a way?
> to specify this in devicetree.

This is a separate issue, and it should be discussed including the
device tree list.

It could be as simple as a boolean "active-low;" property. But then
absence of that property would not mean active-high for existing
active-low drivers, which is confusing.

It could also reuse the flags already defined in
dt-bindings/reset/ti-syscon.h and have some kind of
    reset-flags = <ASSERT_SET | DEASSERT_CLEAR | STATUS_SET>;
property.

Suggestions welcome.

> > +};
> > +
> > +static const struct of_device_id reset_simple_dt_ids[] = {
> > +	{ .compatible = "allwinner,sun6i-a31-clock-reset",
> > +		.data = &reset_simple_inverted },
> > +	{ /* sentinel */ },
> 
> Are plans to have a "simple-reset" compatible binding for new
> devices?

This would go hand in hand with the above discussion.
I'm not convinced this properly describes the hardware, and I'd like to
avoid leaking Linuxisms into the device trees. But this is a decision
for the device tree maintainers, and if they like it, I'm going to
comply.

regards
Philipp
