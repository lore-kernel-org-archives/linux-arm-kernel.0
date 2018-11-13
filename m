From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 13 Nov 2018 09:35:04 +0100
Subject: [PATCH] drm/meson: venc: dmt mode must use encp
In-Reply-To: <1542048069-22603-1-git-send-email-jramirez@baylibre.com>
References: <1542048069-22603-1-git-send-email-jramirez@baylibre.com>
Message-ID: <9f20e9d1-2e15-c087-db52-674300d7581d@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2018 19:41, Jorge Ramirez-Ortiz wrote:
> From: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> 
> The video mode for DMT is only populated to support encp.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> ---
>  drivers/gpu/drm/meson/meson_venc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 514245e..acbbad3 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -854,6 +854,13 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
>  	unsigned int sof_lines;
>  	unsigned int vsync_lines;
>  
> +	/* Use VENCI for 480i and 576i and double HDMI pixels */
> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
> +		hdmi_repeat = true;
> +		use_enci = true;
> +		venc_hdmi_latency = 1;
> +	}
> +
>  	if (meson_venc_hdmi_supported_vic(vic)) {
>  		vmode = meson_venc_hdmi_get_vic_vmode(vic);
>  		if (!vmode) {
> @@ -865,13 +872,7 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
>  	} else {
>  		meson_venc_hdmi_get_dmt_vmode(mode, &vmode_dmt);
>  		vmode = &vmode_dmt;
> -	}
> -
> -	/* Use VENCI for 480i and 576i and double HDMI pixels */
> -	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
> -		hdmi_repeat = true;
> -		use_enci = true;
> -		venc_hdmi_latency = 1;
> +		use_enci = false;
>  	}
>  
>  	/* Repeat VENC pixels for 480/576i/p, 720p50/60 and 1080p50/60 */
> 

Thanks !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I'll apply to drm-misc-fixes !

Neil
