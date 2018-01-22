From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 09:45:45 +0100
Subject: [PATCH 1/2] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
In-Reply-To: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1516474221-114596-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180122084545.kdhrpr5mkqnvkj2o@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 20, 2018 at 07:50:20PM +0100, Giulio Benetti wrote:
> Can't set dclk polarity on sun4i.
> 
> Handle both positive and negative dclk polarity,
> according to bus_flags.

It's not really that we can't set it, it's that it's been ignored.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index f4284b5..6121210 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -17,6 +17,7 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  
>  #include <uapi/drm/drm_mode.h>
>  
> @@ -173,6 +174,9 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
>  static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>  				     const struct drm_display_mode *mode)
>  {
> +	struct drm_panel *panel = tcon->panel;
> +	struct drm_connector *connector = panel->connector;
> +	struct drm_display_info display_info = connector->display_info;
>  	unsigned int bp, hsync, vsync;
>  	u8 clk_delay;
>  	u32 val = 0;
> @@ -226,8 +230,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>  	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
>  		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>  
> +	if(display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
> +		val |= SUN4I_TCON0_IO_POL_DCLK_PHASE(1);
> +

Checkpatch here returns:
ERROR: space required before the open parenthesis '('

And, where did you find that info? How does it interact with the
set_phase callback of the dotclock driver?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180122/fb1e86d8/attachment.sig>
