From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 17 May 2013 12:50:55 +0200
Subject: [PATCH 1/3] staging: drm/imx: set correct sync pins for
 parallel display
In-Reply-To: <1368782393-9660-2-git-send-email-list-09_linuc_arm@tqsc.de>
References: <1368782393-9660-1-git-send-email-list-09_linuc_arm@tqsc.de>
 <1368782393-9660-2-git-send-email-list-09_linuc_arm@tqsc.de>
Message-ID: <1368787855.4011.6.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 17.05.2013, 11:19 +0200 schrieb Markus Niebel:
> From: Markus Niebel <Markus.Niebel@tqs.de>
> 
> partial fix of changes from
> "staging: drm/imx: Add support for VGA via TVE on i.MX53"
> 
> Have to call imx_drm_crtc_panel_format_pins with the correct pins instead of (0, 0)
> This enables configuration of correct waveforms for vsync / hsync
> 
> TODO: configure pins via device tree
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
> ---
>  drivers/staging/imx-drm/parallel-display.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
> index e7fba62..e49a906 100644
> --- a/drivers/staging/imx-drm/parallel-display.c
> +++ b/drivers/staging/imx-drm/parallel-display.c
> @@ -114,8 +114,8 @@ static void imx_pd_encoder_prepare(struct drm_encoder *encoder)
>  {
>  	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
>  
> -	imx_drm_crtc_panel_format(encoder->crtc, DRM_MODE_ENCODER_NONE,
> -			imxpd->interface_pix_fmt);
> +	imx_drm_crtc_panel_format_pins(encoder->crtc, DRM_MODE_ENCODER_NONE,
> +			imxpd->interface_pix_fmt, 2, 3);
>  }
>  
>  static void imx_pd_encoder_commit(struct drm_encoder *encoder)

Rather than putting this here, as long as it is not configurable from
device tree, I'd prefer to use this patch instead:

--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -144,7 +144,7 @@ int imx_drm_crtc_panel_format(struct drm_crtc *crtc, u32 encoder_type,
                u32 interface_pix_fmt)
 {
        return imx_drm_crtc_panel_format_pins(crtc, encoder_type,
-                                             interface_pix_fmt, 0, 0);
+                                             interface_pix_fmt, 2, 3);
 }
 EXPORT_SYMBOL_GPL(imx_drm_crtc_panel_format);
 
Because this will fix the same issue also for LDB, HDMI, and MIPI/DSI drivers.

regards
Philipp
