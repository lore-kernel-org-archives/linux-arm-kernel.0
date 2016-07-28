From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 28 Jul 2016 11:23:11 +0200
Subject: [PATCH v2] reset: uniphier: add reset controller drivers for
 UniPhier SoCs
In-Reply-To: <CAK7LNAShnmaZ-Gd8yDEvJwdiEbf6ceWkabsFVtMz3hjfzJG2rw@mail.gmail.com>
References: <1469557209-13089-1-git-send-email-yamada.masahiro@socionext.com>
 <1469611051.2470.15.camel@pengutronix.de>
 <CAK7LNAShnmaZ-Gd8yDEvJwdiEbf6ceWkabsFVtMz3hjfzJG2rw@mail.gmail.com>
Message-ID: <1469697791.12835.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

Am Donnerstag, den 28.07.2016, 11:40 +0900 schrieb Masahiro Yamada:
> >> +static int uniphier_reset_update(struct reset_controller_dev *rcdev,
> >> +                              unsigned long id, bool assert)
> >> +{
> >> +     struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
> >> +     const struct uniphier_reset_data *p;
> >> +     bool handled = false;
> >> +
> >> +     for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
> >> +             unsigned int val;
> >> +             int ret;
> >> +
> >> +             if (p->id != id)
> >> +                     continue;
> >> +
> >> +             val = p->assert_val;
> >> +             if (!assert)
> >> +                     val = ~val;
> >> +
> >> +             ret = regmap_write_bits(priv->regmap, p->reg, p->mask, val);
> >> +             if (ret)
> >> +                     return ret;
> >> +
> >> +             handled = true;
> >
> > Why does this continue to walk through the list after the correct id was
> > found?
> 
> Looks like you already found the answer for this.

Yes.

[...]
> >> +#define UNIPHIER_MIO_RESET_USB2(index, ch)                           \
> >> +     UNIPHIER_RESETX_SIMPLE((index), 0x110 + 0x200 * (ch), BIT(24)), \
> >> +     UNIPHIER_RESETX_SIMPLE((index), 0x114 + 0x200 * (ch), BIT(0))
> >
> > Ah, so for USB2 reset you have two reset bits in separate registers. Are
> > you sure these are controlling the same reset line?
> 
> I am not a hardware guy, so I am not sure about the hardware design.
> 
> From my best guess, I think each bit controls a different block.
> But both of them must be de-asserted before starting up USB.
>
> There is no use-case where they are asserted/de-asserted independently.
> 
> So, I thought it made sense to couple them into a single ID.

If it turns out to be useful for drivers to bundle resets, I'd prefer to
do this in the framework rather than in the individual drivers, maybe
have a reset_assert/deassert_array, similarly to gpiod.

> > If the USB core does in fact have two separate reset inputs that just
> > happen to need asserting at the same time, this should still get two
> > separate ids. Same issue for the SD reset above, if the reset lines are
> > physically separate, please don't combine them in the driver.
> 
> Right.
> From the view of point of Device Tree interface,
> it should reflect the hardware design.
> I believe they are separate reset signals, so should be given with separate IDs.
> 
> But, as a software engineer, it is sometimes difficult to fully understand
> the hardware structure.
> 
> The hardware document often just says "how to use USB",
> but "how clock/reset signals are connected in each block" is not mentioned,
> or at least very unclear.

I understand the problem. If you have any way of finding out whether
these are in fact separate resets, please do. Otherwise we'll have to
guess.

> Probably, I will come back with real per-reset-line ID,
> but I need some time to take a look.

Ok, thanks.

regards
Philipp
