From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 11:56:18 +0800
Subject: [PATCH 07/18] drm/sun4i: tcon: Don't rely on encoders to set the
 TCON mode
In-Reply-To: <31e3fd8540d85c8f4637af1083c5c2a436403cd2.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <31e3fd8540d85c8f4637af1083c5c2a436403cd2.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66d500j5YWFbTYn_BZcF_q=sM+hr2q+yJ88OmL_j4DVPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 10:13 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Just like we did for the TCON enable and disable, for historical reasons we
> used to rely on the encoders calling the TCON mode_set function, while the
> CRTC has a callback for that.
>
> Let's implement it in order to reduce the boilerplate code.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_crtc.c          | 11 ++++-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c  |  1 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c      |  7 +---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c |  1 +-
>  drivers/gpu/drm/sun4i/sun4i_rgb.c           | 15 +------
>  drivers/gpu/drm/sun4i/sun4i_tcon.c          | 56 ++++++++++------------
>  drivers/gpu/drm/sun4i/sun4i_tcon.h          | 10 +----
>  drivers/gpu/drm/sun4i/sun4i_tv.c            |  6 +--
>  8 files changed, 40 insertions(+), 67 deletions(-)
>

[...]

> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index dc70bc2a42a5..c4407910dfaf 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -106,29 +106,6 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
>  }
>  EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
>
> -void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
> -                       struct drm_encoder *encoder)
> -{
> -       u32 val;
> -
> -       if (!tcon->quirks->has_unknown_mux)
> -               return;
> -
> -       if (channel != 1)
> -               return;
> -
> -       if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
> -               val = 1;
> -       else
> -               val = 0;
> -
> -       /*
> -        * FIXME: Undocumented bits
> -        */
> -       regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);
> -}
> -EXPORT_SYMBOL(sun4i_tcon_set_mux);
> -
>  static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
>                                     int channel)
>  {
> @@ -147,8 +124,8 @@ static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
>         return delay;
>  }
>
> -void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
> -                         struct drm_display_mode *mode)
> +static void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
> +                                struct drm_display_mode *mode)

Nit on the side: maybe we could mark mode as constant?
Since the function doesn't change it. Same applies to the
other mode_set functions. But this could be left to another
patch.

>  {
>         unsigned int bp, hsync, vsync;
>         u8 clk_delay;
> @@ -221,10 +198,9 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
>         /* Enable the output on the pins */
>         regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, 0);
>  }
> -EXPORT_SYMBOL(sun4i_tcon0_mode_set);
>
> -void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
> -                         struct drm_display_mode *mode)
> +static void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
> +                                struct drm_display_mode *mode)
>  {
>         unsigned int bp, hsync, vsync, vtotal;
>         u8 clk_delay;
> @@ -312,7 +288,29 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
>                            SUN4I_TCON_GCTL_IOMAP_MASK,
>                            SUN4I_TCON_GCTL_IOMAP_TCON1);
>  }
> -EXPORT_SYMBOL(sun4i_tcon1_mode_set);
> +
> +void sun4i_tcon_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
> +                        struct drm_display_mode *mode)

(also mark encoder as const?)

> +{
> +       switch (encoder->encoder_type) {
> +       case DRM_MODE_ENCODER_NONE:
> +               sun4i_tcon0_mode_set(tcon, mode);
> +               break;
> +       case DRM_MODE_ENCODER_TVDAC:
> +               /*
> +                * FIXME: Undocumented bits
> +                */
> +               if (tcon->quirks->has_unknown_mux)
> +                       regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
> +               /* Fallthrough */
> +       case DRM_MODE_ENCODER_TMDS:
> +               sun4i_tcon1_mode_set(tcon, mode);

IIRC you need to clear the mux bit here. So ...

> +               break;
> +       default:
> +               DRM_DEBUG_DRIVER("Unknown encoder type, doing nothing...\n");
> +       }

I think keeping the muxing in a separate function would be cleaner.
The above is already slightly messy if you add the bit clearing part.
With all the other muxing possibilities in the other SoC this is
going to get really messy.

> +}
> +EXPORT_SYMBOL(sun4i_tcon_mode_set);
>
>  static void sun4i_tcon_finish_page_flip(struct drm_device *dev,
>                                         struct sun4i_crtc *scrtc)

[...]

Thanks for working on this. Now we've decoupled the TCON/CRTC code
from all the encoders.

Regards
ChenYu
