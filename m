From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 11:30:21 +0800
Subject: [PATCH v3 08/15] drm/sun4i: Add LVDS support
In-Reply-To: <20171207122521.frv5zgaay3sgol6f@flea.lan>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <b900e5963180c94ca02bde178b6674622a127787.1512486553.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65Voua-AjHDnCLgDOKqUeSG-yD4wuSO5-BJ230FCp4OuQ@mail.gmail.com>
 <20171207122521.frv5zgaay3sgol6f@flea.lan>
Message-ID: <CAGb2v67CrZA0WXtQNwrAEvyPuAFa7yJuYdX4GgSoNtBYv2NJ4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 8:25 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Dec 07, 2017 at 02:05:47PM +0800, Chen-Yu Tsai wrote:
>> > +static void sun4i_tcon_lvds_set_status(struct sun4i_tcon *tcon,
>> > +                                      const struct drm_encoder *encoder,
>> > +                                      bool enabled)
>> > +{
>> > +       if (enabled) {
>> > +               u8 val;
>> > +
>> > +               regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_IF_REG,
>> > +                                  SUN4I_TCON0_LVDS_IF_EN,
>> > +                                  SUN4I_TCON0_LVDS_IF_EN);
>> > +
>> > +               regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
>> > +                            SUN4I_TCON0_LVDS_ANA0_C(2) |
>> > +                            SUN4I_TCON0_LVDS_ANA0_V(3) |
>> > +                            SUN4I_TCON0_LVDS_ANA0_PD(2) |
>> > +                            SUN4I_TCON0_LVDS_ANA0_EN_LDO);
>> > +               udelay(2);
>> > +
>> > +               regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
>> > +                                  SUN4I_TCON0_LVDS_ANA0_EN_MB,
>> > +                                  SUN4I_TCON0_LVDS_ANA0_EN_MB);
>> > +               udelay(2);
>> > +
>> > +               regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
>> > +                                  SUN4I_TCON0_LVDS_ANA0_EN_DRVC,
>> > +                                  SUN4I_TCON0_LVDS_ANA0_EN_DRVC);
>> > +
>> > +               if (sun4i_tcon_get_pixel_depth(encoder) == 18)
>> > +                       val = 7;
>> > +               else
>> > +                       val = 0xf;
>> > +
>> > +               regmap_write_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
>> > +                                 SUN4I_TCON0_LVDS_ANA0_EN_DRVD(0xf),
>> > +                                 SUN4I_TCON0_LVDS_ANA0_EN_DRVD(val));
>>
>> I suggest changing the prefix of the macros of the analog bits to
>> SUN6I_TCON0_*. The register definitions and sequence do not apply
>> to the A10/A20. Furthermore you should add a comment saying this
>> doesn't apply to the A10/A20. In the future we might want to move
>> this part into a separate function, referenced by a function pointer
>> from the quirks structure.
>
> I'll change the bit field names and add a comment like you suggested.
>
>> > +       } else {
>> > +               regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_IF_REG,
>> > +                                  SUN4I_TCON0_LVDS_IF_EN, 0);
>> > +       }
>> > +}
>> > +
>> >  void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
>> >                            const struct drm_encoder *encoder,
>> >                            bool enabled)
>> >  {
>> > +       bool is_lvds = false;
>> >         int channel;
>> >
>> >         switch (encoder->encoder_type) {
>> > +       case DRM_MODE_ENCODER_LVDS:
>> > +               is_lvds = true;
>> > +               /* Fallthrough */
>> >         case DRM_MODE_ENCODER_NONE:
>> >                 channel = 0;
>> >                 break;
>> > @@ -84,10 +171,16 @@ void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
>> >                 return;
>> >         }
>> >
>> > +       if (is_lvds && !enabled)
>> > +               sun4i_tcon_lvds_set_status(tcon, encoder, false);
>> > +
>> >         regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
>> >                            SUN4I_TCON_GCTL_TCON_ENABLE,
>> >                            enabled ? SUN4I_TCON_GCTL_TCON_ENABLE : 0);
>> >
>> > +       if (is_lvds && enabled)
>> > +               sun4i_tcon_lvds_set_status(tcon, encoder, true);
>> > +
>> >         sun4i_tcon_channel_set_status(tcon, channel, enabled);
>> >  }
>> >
>> > @@ -170,6 +263,78 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
>> >                      SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
>> >  }
>> >
>> > +static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
>> > +                                     const struct drm_encoder *encoder,
>> > +                                     const struct drm_display_mode *mode)
>> > +{
>> > +       unsigned int bp;
>> > +       u8 clk_delay;
>> > +       u32 reg, val = 0;
>> > +
>> > +       tcon->dclk_min_div = 7;
>> > +       tcon->dclk_max_div = 7;
>> > +       sun4i_tcon0_mode_set_common(tcon, mode);
>> > +
>> > +       /* Adjust clock delay */
>> > +       clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
>> > +       regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
>> > +                          SUN4I_TCON0_CTL_CLK_DELAY_MASK,
>> > +                          SUN4I_TCON0_CTL_CLK_DELAY(clk_delay));
>> > +
>> > +       /*
>> > +        * This is called a backporch in the register documentation,
>> > +        * but it really is the back porch + hsync
>> > +        */
>> > +       bp = mode->crtc_htotal - mode->crtc_hsync_start;
>> > +       DRM_DEBUG_DRIVER("Setting horizontal total %d, backporch %d\n",
>> > +                        mode->crtc_htotal, bp);
>> > +
>> > +       /* Set horizontal display timings */
>> > +       regmap_write(tcon->regs, SUN4I_TCON0_BASIC1_REG,
>> > +                    SUN4I_TCON0_BASIC1_H_TOTAL(mode->htotal) |
>> > +                    SUN4I_TCON0_BASIC1_H_BACKPORCH(bp));
>> > +
>> > +       /*
>> > +        * This is called a backporch in the register documentation,
>> > +        * but it really is the back porch + hsync
>> > +        */
>> > +       bp = mode->crtc_vtotal - mode->crtc_vsync_start;
>> > +       DRM_DEBUG_DRIVER("Setting vertical total %d, backporch %d\n",
>> > +                        mode->crtc_vtotal, bp);
>> > +
>> > +       /* Set vertical display timings */
>> > +       regmap_write(tcon->regs, SUN4I_TCON0_BASIC2_REG,
>> > +                    SUN4I_TCON0_BASIC2_V_TOTAL(mode->crtc_vtotal * 2) |
>> > +                    SUN4I_TCON0_BASIC2_V_BACKPORCH(bp));
>>
>> Can we move the above to a common function?
>
> Until we have DSI support figured out I'd rather not do too much of
> consolidation. We know already a few things are going to change there
> (like the clk_delay), but it's not clear yet how much.
>
>> > +       /* Map output pins to channel 0 */
>> > +       regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
>> > +                          SUN4I_TCON_GCTL_IOMAP_MASK,
>> > +                          SUN4I_TCON_GCTL_IOMAP_TCON0);
>> > +
>> > +       /* Enable the output on the pins */
>> > +       regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, 0xe0000000);
>>
>> Is this still needed? You are no longer using the TCON LCD pins
>> with LVDS.
>
> We do. It's a separate function of the pins, but it's the same pins.

OK. I assume you've tried it without setting it and it failed?
I just assume that these refer to the TCON LCD output, whereas
LVDS looks like a separate module and function, and shouldn't
need it.

ChenYu

>> >  static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
>> >         .has_channel_1          = true,
>> > +       .has_lvds_pll           = true,
>>
>> The A31s does not have MIPI.
>
> I'll change that.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
