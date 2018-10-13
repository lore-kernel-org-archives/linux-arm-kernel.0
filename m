From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 12 Oct 2018 21:36:07 -0700
Subject: [alsa-devel] [PATCH 01/10] ASoC: sun4i-i2s: Add compatibility
 with A64 codec I2S
In-Reply-To: <CAGb2v64jNCz2Qh74UU0NxqE_PipXePLNbpE4vwFQ9BSVQCd5tQ@mail.gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
 <20181013033230.6506-2-anarsoul@gmail.com>
 <CAGb2v64jNCz2Qh74UU0NxqE_PipXePLNbpE4vwFQ9BSVQCd5tQ@mail.gmail.com>
Message-ID: <CA+E=qVfLr9Qh-7Tp9AOaw8K85TLrRfb687Mzoqa6BCEbfsugGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 9:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Sat, Oct 13, 2018 at 11:33 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> >
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > The I2S block used for the audio codec in the A64 differs from other 3
> > I2S modules in A64 and isn't compatible with H3. But it is very similar
> > to what is found in A10(sun4i). However, its TX FIFO is
> > located at a different address.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  .../devicetree/bindings/sound/sun4i-i2s.txt   |  2 ++
> >  sound/soc/sunxi/sun4i-i2s.c                   | 21 +++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> > index b9d50d6cdef3..9d81f965f666 100644
> > --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> > +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> > @@ -10,6 +10,7 @@ Required properties:
> >     - "allwinner,sun6i-a31-i2s"
> >     - "allwinner,sun8i-a83t-i2s"
> >     - "allwinner,sun8i-h3-i2s"
> > +   - "allwinner,sun50i-a64-i2s"
>
> This compatible is already used as the SoC-specific compatible (in case we have
> unforeseen differences between A64 and H3 I2S).
>
> Since this is tied to the codec, I think it deserves a special
> compatible anyway.
> How about "allwinner,sun50i-a64-codec-i2s" ?

That's what I proposed a ~year ago and I was asked to change it to
allwinner,sun50i-a64-i2c.

>
> The rest looks good, so once the compatible is changed,
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> >  - reg: physical base address of the controller and length of memory mapped
> >    region.
> >  - interrupts: should contain the I2S interrupt.
> > @@ -26,6 +27,7 @@ Required properties for the following compatibles:
> >         - "allwinner,sun6i-a31-i2s"
> >         - "allwinner,sun8i-a83t-i2s"
> >         - "allwinner,sun8i-h3-i2s"
> > +       - "allwinner,sun50i-a64-i2s"
> >  - resets: phandle to the reset line for this codec
> >
> >  Example:
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index ed30d30ac720..787b67c4f845 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -967,6 +967,23 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
> >         .field_rxchansel        = REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
> >  };
> >
> > +static const struct sun4i_i2s_quirks sun50i_a64_i2s_quirks = {
> > +       .has_reset              = true,
> > +       .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
> > +       .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> > +       .has_slave_select_bit   = true,
> > +       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
> > +       .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
> > +       .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
> > +       .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
> > +       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> > +       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> > +       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> > +       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > +       .field_rxchansel        = REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
> > +};
> > +
> >  static int sun4i_i2s_init_regmap_fields(struct device *dev,
> >                                         struct sun4i_i2s *i2s)
> >  {
> > @@ -1175,6 +1192,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
> >                 .compatible = "allwinner,sun8i-h3-i2s",
> >                 .data = &sun8i_h3_i2s_quirks,
> >         },
> > +       {
> > +               .compatible = "allwinner,sun50i-a64-i2s",
> > +               .data = &sun50i_a64_i2s_quirks,
> > +       },
> >         {}
> >  };
> >  MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
> > --
> > 2.19.0
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel at alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
