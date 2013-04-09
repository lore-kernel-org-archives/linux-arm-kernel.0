From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 09 Apr 2013 17:04:26 +0200
Subject: [PATCH v2 1/4] imx-drm: parallel-display: Fix valid_mode checking
In-Reply-To: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
Message-ID: <1365519866.4023.47.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rogerio,

Am Dienstag, den 09.04.2013, 11:07 -0300 schrieb Rogerio Pimentel:
> It fixes the logic of valid_mode checking, it's now
> in accordance with drm_mode_status enumeration.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
> ---
> Changes since v1:
> Removed the "if(np)" block and now using the existent functions to get
> the modes by fixing the mode_valid logic test 
>  drivers/staging/imx-drm/parallel-display.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
> index a8064fc..49c90c3 100644
> --- a/drivers/staging/imx-drm/parallel-display.c
> +++ b/drivers/staging/imx-drm/parallel-display.c
> @@ -64,7 +64,7 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
>  		num_modes = drm_add_edid_modes(connector, imxpd->edid);
>  	}
>  
> -	if (imxpd->mode_valid) {
> +	if (imxpd->mode_valid == MODE_OK) {

It's a bit unfortunate that the imxpd->mode_valid variable is named the
same as the imx_pd_connector_helper_funcs.mode_valid callback, but it is
not the same. imxpd->mode_valid seems to be used as a bool here, and I
don't think that should stay the same.

>  		struct drm_display_mode *mode = drm_mode_create(connector->dev);
>  		drm_mode_copy(mode, &imxpd->mode);
>  		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> @@ -78,7 +78,7 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
>  static int imx_pd_connector_mode_valid(struct drm_connector *connector,
>  			  struct drm_display_mode *mode)
>  {
> -	return 0;
> +	return MODE_OK;

This hunk is correct.

Eventually, we should check available display interface clock
frequencies here.

regards
Philipp
