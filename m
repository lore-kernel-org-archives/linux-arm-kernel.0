From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Oct 2016 12:04:44 +0200
Subject: [PATCH 05/12] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
In-Reply-To: <CAGb2v66b_zG=xK_JVBnwY=SPtvJ+c-fZjuugAHUybzZdkkcScg@mail.gmail.com>
References: <20161003110804.28235-1-wens@csie.org>
 <20161003110804.28235-6-wens@csie.org>
 <20161003114709.GC5228@lukather>
 <CAGb2v66b_zG=xK_JVBnwY=SPtvJ+c-fZjuugAHUybzZdkkcScg@mail.gmail.com>
Message-ID: <20161010100444.GD3462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 12:26:08PM +0800, Chen-Yu Tsai wrote:
> >> +struct sun4i_codec_regs {
> >> +     u32     adc_fifoc;
> >> +     u32     adc_fifos;
> >> +     u32     adc_rxdata;
> >> +};
> >> +
> >>  struct sun4i_codec {
> >>       struct device   *dev;
> >>       struct regmap   *regmap;
> >>       struct clk      *clk_apb;
> >>       struct clk      *clk_module;
> >>       struct gpio_desc *gpio_pa;
> >> +     const struct sun4i_codec_regs *regs;
> >
> > You're reimplementing reg_field here.
> 
> Are you suggesting we do reg_fields for each register?
> Or all the bit fields separately. The latter would add
> quite a few pointers.

only the one that change, so judging from your structure, only the ADC
fifo control, status and data registers.
> >> +static const struct of_device_id sun4i_codec_of_match[] = {
> >> +     {
> >> +             .compatible = "allwinner,sun4i-a10-codec",
> >> +             .data = &sun4i_codec_quirks,
> >> +     },
> >> +     {
> >> +             .compatible = "allwinner,sun6i-a31-codec",
> >> +             .data = &sun6i_a31_codec_quirks,
> >> +     },
> >> +     {
> >> +             .compatible = "allwinner,sun7i-a20-codec",
> >> +             .data = &sun7i_codec_quirks,
> >> +     },
> >> +     {}
> >> +};
> >> +MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
> >> +
> >
> > I don't really like moving blocks of code over and over again,
> > especially in the middle of an unrelated patch.
> 
> It's not completely unrelated. I want different create_card
> functions for the different SoCs, and that has to be part of the
> quirks, so the quirks and the of_match list have to be moved
> below them. I suppose I could leave the regmap parts in place,
> but keeping them together is nicer.
> 
> If I split out the addition of the .create_card field and
> code movement into a separate patch, would that be OK?

Yep, that would work.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161010/0827457c/attachment.sig>
