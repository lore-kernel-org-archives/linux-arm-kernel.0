From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 11:40:07 +0800
Subject: [PATCH 06/18] drm/sun4i: tcon: Don't rely on encoders to enable
 the TCON
In-Reply-To: <e8e204b4b366f609db5b7d848f8cfb88345cd2d7.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <e8e204b4b366f609db5b7d848f8cfb88345cd2d7.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67LNwLWWJEkw=FKE-kPkVHPK7XZC-OY02A1a94w6E5e1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 10:13 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> So far, we've required all the TCON-connected encoders to call the TCON
> enable and disable functions.
>
> This was made this way because in the RGB/LVDS case, the TCON is the CRTC
> and the encoder. However, in all the other cases (HDMI, TV, DSI, etc.), we
> have another encoder down the road that needs to be programmed.
>
> We also needed to know which channel the encoder is connected to, which is
> encoder-specific.
>
> The CRTC's enable and disable callbacks can work just fine for our use
> case, and we can get the channel to use just by looking at the type of
> encoder, since that is fixed. Implement those callbacks, which will
> remove some of the encoder boilerplate.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Overall this looks good. A few minor comments below.

> ---
>  drivers/gpu/drm/sun4i/sun4i_crtc.c     | 22 ++++++-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c |  8 +--
>  drivers/gpu/drm/sun4i/sun4i_rgb.c      | 14 +---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c     | 91 +++++++++++++--------------
>  drivers/gpu/drm/sun4i/sun4i_tcon.h     | 10 +---
>  drivers/gpu/drm/sun4i/sun4i_tv.c       |  6 +--
>  6 files changed, 70 insertions(+), 81 deletions(-)
>

[...]

>  static void sun4i_rgb_encoder_mode_set(struct drm_encoder *encoder,
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index d9791292553e..dc70bc2a42a5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -14,6 +14,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_encoder.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
>
> @@ -32,66 +33,62 @@
>  #include "sun4i_tcon.h"
>  #include "sunxi_engine.h"
>
> -void sun4i_tcon_disable(struct sun4i_tcon *tcon)
> +static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
> +                                         bool enabled)
>  {
> -       DRM_DEBUG_DRIVER("Disabling TCON\n");
> +       struct clk *clk;
>
> -       /* Disable the TCON */
> -       regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
> -                          SUN4I_TCON_GCTL_TCON_ENABLE, 0);
> -}
> -EXPORT_SYMBOL(sun4i_tcon_disable);
> -
> -void sun4i_tcon_enable(struct sun4i_tcon *tcon)
> -{
> -       DRM_DEBUG_DRIVER("Enabling TCON\n");
> -
> -       /* Enable the TCON */
> -       regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
> -                          SUN4I_TCON_GCTL_TCON_ENABLE,
> -                          SUN4I_TCON_GCTL_TCON_ENABLE);
> -}
> -EXPORT_SYMBOL(sun4i_tcon_enable);
> -
> -void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel)
> -{
> -       DRM_DEBUG_DRIVER("Disabling TCON channel %d\n", channel);
> -
> -       /* Disable the TCON's channel */
> -       if (channel == 0) {
> +       switch (channel) {
> +       case 0:
>                 regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
> -                                  SUN4I_TCON0_CTL_TCON_ENABLE, 0);
> -               clk_disable_unprepare(tcon->dclk);
> +                                  SUN4I_TCON0_CTL_TCON_ENABLE,
> +                                  enabled ? SUN4I_TCON0_CTL_TCON_ENABLE : 0);
> +               clk = tcon->dclk;
> +               break;
> +       case 1:
> +               WARN_ON(!tcon->quirks->has_channel_1);
> +               regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
> +                                  SUN4I_TCON1_CTL_TCON_ENABLE,
> +                                  enabled ? SUN4I_TCON1_CTL_TCON_ENABLE : 0);
> +               clk = tcon->sclk1;
> +               break;
> +       default:
> +               DRM_DEBUG_DRIVER("Unknown channel... doing nothing\n");
>                 return;
>         }
>
> -       WARN_ON(!tcon->quirks->has_channel_1);
> -       regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
> -                          SUN4I_TCON1_CTL_TCON_ENABLE, 0);
> -       clk_disable_unprepare(tcon->sclk1);
> +       if (enabled)
> +               clk_prepare_enable(clk);

I wonder if it's better to enable the clk before the TCON?

> +       else
> +               clk_disable_unprepare(clk);
>  }
> -EXPORT_SYMBOL(sun4i_tcon_channel_disable);
>
> -void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel)
> +void sun4i_tcon_set_status(struct sun4i_tcon *tcon,
> +                          struct drm_encoder *encoder,
> +                          bool enabled)
>  {
> -       DRM_DEBUG_DRIVER("Enabling TCON channel %d\n", channel);
> -
> -       /* Enable the TCON's channel */
> -       if (channel == 0) {
> -               regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
> -                                  SUN4I_TCON0_CTL_TCON_ENABLE,
> -                                  SUN4I_TCON0_CTL_TCON_ENABLE);
> -               clk_prepare_enable(tcon->dclk);
> +       int channel;
> +
> +       switch (encoder->encoder_type) {
> +       case DRM_MODE_ENCODER_NONE:
> +               channel = 0;
> +               break;
> +       case DRM_MODE_ENCODER_TMDS:
> +       case DRM_MODE_ENCODER_TVDAC:
> +               channel = 1;
> +               break;
> +       default:
> +               DRM_DEBUG_DRIVER("Unknown encoder type, doing nothing...\n");

We could simply add all the possible types, and print a big warning
if someone does something unexpected. IMHO this is better than having
the user enable some hidden debug flag to figure why the display isn't
working properly.

>                 return;
>         }
>
> -       WARN_ON(!tcon->quirks->has_channel_1);
> -       regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
> -                          SUN4I_TCON1_CTL_TCON_ENABLE,
> -                          SUN4I_TCON1_CTL_TCON_ENABLE);
> -       clk_prepare_enable(tcon->sclk1);
> +       sun4i_tcon_channel_set_status(tcon, channel, enabled);
> +
> +       regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
> +                          SUN4I_TCON_GCTL_TCON_ENABLE,
> +                          enabled ? SUN4I_TCON_GCTL_TCON_ENABLE : 0);

The global enable bit should be set first.

Also the manual says "When it?s disabled, the module will be reset to
idle state."
so you might get away with just disabling the global enable bit and returning
directly after disabling the clock?

>  }
> -EXPORT_SYMBOL(sun4i_tcon_channel_enable);
> +EXPORT_SYMBOL(sun4i_tcon_set_status);

The TCON and CRTC code are part of the same module.
There is no need to export this function.

ChenYu

>
>  void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
>  {
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> index 552c88ec16be..824732c90a2a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> @@ -183,15 +183,9 @@ struct sun4i_tcon {
>  struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
>  struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
>
> -/* Global Control */
> -void sun4i_tcon_disable(struct sun4i_tcon *tcon);
> -void sun4i_tcon_enable(struct sun4i_tcon *tcon);
> -
> -/* Channel Control */
> -void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel);
> -void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel);
> -
>  void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
> +void sun4i_tcon_set_status(struct sun4i_tcon *crtc, struct drm_encoder *encoder,
> +                          bool enable);
>
>  /* Mode Related Controls */
>  void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
> index 73bfe7b1cd78..78d6cf77fdd3 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -345,12 +345,9 @@ static void sun4i_tv_disable(struct drm_encoder *encoder)
>  {
>         struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
>         struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
> -       struct sun4i_tcon *tcon = crtc->tcon;
>
>         DRM_DEBUG_DRIVER("Disabling the TV Output\n");
>
> -       sun4i_tcon_channel_disable(tcon, 1);
> -
>         regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
>                            SUN4I_TVE_EN_ENABLE,
>                            0);
> @@ -362,7 +359,6 @@ static void sun4i_tv_enable(struct drm_encoder *encoder)
>  {
>         struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
>         struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
> -       struct sun4i_tcon *tcon = crtc->tcon;
>
>         DRM_DEBUG_DRIVER("Enabling the TV Output\n");
>
> @@ -371,8 +367,6 @@ static void sun4i_tv_enable(struct drm_encoder *encoder)
>         regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
>                            SUN4I_TVE_EN_ENABLE,
>                            SUN4I_TVE_EN_ENABLE);
> -
> -       sun4i_tcon_channel_enable(tcon, 1);
>  }
>
>  static void sun4i_tv_mode_set(struct drm_encoder *encoder,
> --
> git-series 0.9.1
