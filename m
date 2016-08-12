From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 12 Aug 2016 10:03:42 +0930
Subject: [PATCH 02/12] pinctrl: Add core pinctrl support for Aspeed SoCs
In-Reply-To: <CACRpkdZ0p+jNHBV1AqhVWQ2Q8RRrHVfsAz3XU3_+f6My22=Zxg@mail.gmail.com>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
 <1468994313-13538-3-git-send-email-andrew@aj.id.au>
 <CACRpkdZ0p+jNHBV1AqhVWQ2Q8RRrHVfsAz3XU3_+f6My22=Zxg@mail.gmail.com>
Message-ID: <1470962022.27272.68.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-08-11 at 10:41 +0200, Linus Walleij wrote:
> On Wed, Jul 20, 2016 at 7:58 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > 
> > --- a/arch/arm/mach-aspeed/Kconfig
> > +++ b/arch/arm/mach-aspeed/Kconfig
> > @@ -5,6 +5,7 @@ menuconfig ARCH_ASPEED
> > ????????select WATCHDOG
> > ????????select ASPEED_WATCHDOG
> > ????????select MOXART_TIMER
> > +???????select PINCTRL
> > ????????help
> > ??????????Say Y here if you want to run your kernel on an ASpeed BMC SoC.
> This needs to be a separate patch sent to the ARM SoC tree.
> I don't like to merge patches to other subsystems if it can be
> avoided.

Okay, I'll split it out.

> 
> > 
> > +static inline void aspeed_sig_desc_print_val(
> > +???????????????const struct aspeed_sig_desc *desc, bool enable, u32 rv)
> > +{
> > +#if defined(CONFIG_DEBUG_PINCTRL)
> > +???????pr_debug("SCU%x[0x%08x]=0x%x, got 0x%x from 0x%08x\n", desc->reg,
> > +???????????????????????desc->mask, enable ? desc->enable : desc->disable,
> > +???????????????????????(rv & desc->mask) >> __ffs(desc->mask), rv);
> > +#endif
> > +}
> You can just use pr_debug(). CONFIG_DEBUG_PINCTRL enables
> DEBUG_KERNEL which activates debug prints so this is a truism.

Right, I will clean that up.

> 
> > 
> > +static bool aspeed_sig_desc_eval(const struct aspeed_sig_desc *desc,
> > +???????????????bool enabled, struct regmap *map)
> > +static bool aspeed_sig_expr_eval(const struct aspeed_sig_expr *expr,
> > +???????????????bool enabled, struct regmap *map)
> These need kerneldoc too, they are kind of hard to understand.

Will do.

> 
> > 
> > +static bool aspeed_gpio_in_exprs(const struct aspeed_sig_expr **exprs)
> > +{
> > +???????if (!exprs)
> > +???????????????return false;
> > +
> > +???????while (*exprs) {
> > +???????????????if (strncmp((*exprs)->signal, "GPIO", 4) == 0)
> > +???????????????????????return true;
> This looks a bit fragile and hard to debug. Do you have some better
> idea of how to do this but not resort to string comparison?

Yes, this is a little unfortunate. GPIO is not always a pin's lowest
priority function (e.g. the RGMII/RMII pins), so this makes the GPIO
case like any other mux function: We need to know when to stop
iterating the arrays when disabling mux functions of higher priority.
The alternative is probably to introduce another field to struct
aspeed_sig_expr and set that as necessary, but that feels redundant if
we keep to a consistent naming for the GPIOs.

Would it be acceptable to document that requirement? Maybe that's just
punting on the problem because it doesn't make it any less difficult to
debug. However, the failure case is already tested in
aspeed_gpio_request_enable() (where all aspeed_gpio_in_exprs() calls
fail for a pin) and to make it easier to debug I can dev_warn() at that
point.

I will do both of the above as part of a v2 unless you are really keen
for an alternative.

> 
> Apart from that it looks pretty alright, complex but such is life
> with complex hardware.

Mmm, yes. I keep hoping for a day when someone else points out that it
actually has a simple solution so I stop dreading the explanation of
the implementation's mechanics to others.

Anyway, thanks for the review!

Andrew

> 
> Yours,
> Linus Walleij
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160812/22a0ffe5/attachment.sig>
