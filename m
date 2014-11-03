From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 03 Nov 2014 16:19:15 +0100
Subject: [PATCH v2 3/3] imx-drm: parallel-display: Fix dpms mode handling
In-Reply-To: <1415026488-25309-4-git-send-email-mpa@pengutronix.de>
References: <1415026488-25309-1-git-send-email-mpa@pengutronix.de>
 <1415026488-25309-4-git-send-email-mpa@pengutronix.de>
Message-ID: <1415027955.26755.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 03.11.2014, 15:54 +0100 schrieb Markus Pargmann:
> We have to call drm_panel_prepare() and drm_panel_unprepare() when
> switching on or off. This patch also replaces the if statement with an
> switch statement to only catch ON and OFF modes.

... which is wrong. A driver is expected to map all 4 DPMS states to
something sane, so the if statement did exactly the right thing here.

Regards,
Lucas

> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/staging/imx-drm/parallel-display.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
> index 0992bbf01adc..62788177c9d4 100644
> --- a/drivers/staging/imx-drm/parallel-display.c
> +++ b/drivers/staging/imx-drm/parallel-display.c
> @@ -106,10 +106,18 @@ static void imx_pd_encoder_dpms(struct drm_encoder *encoder, int mode)
>  {
>  	struct imx_parallel_display *imxpd = enc_to_imxpd(encoder);
>  
> -	if (mode != DRM_MODE_DPMS_ON)
> -		drm_panel_disable(imxpd->panel);
> -	else
> +	switch (mode) {
> +	case DRM_MODE_DPMS_ON:
> +		drm_panel_prepare(imxpd->panel);
>  		drm_panel_enable(imxpd->panel);
> +		break;
> +	case DRM_MODE_DPMS_OFF:
> +		drm_panel_disable(imxpd->panel);
> +		drm_panel_unprepare(imxpd->panel);
> +		break;
> +	default:
> +		break;
> +	}
>  }
>  
>  static bool imx_pd_encoder_mode_fixup(struct drm_encoder *encoder,

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
