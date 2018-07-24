From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 24 Jul 2018 17:02:50 +0900
Subject: [PATCH v3 3/9] drm/exynos: enable out_bridge in
 exynos_dsi_enable()
In-Reply-To: <1529396370-18761-4-git-send-email-m.purski@samsung.com>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619081959eucas1p14aee2dfc0231d2f645e3c9071b92341e@eucas1p1.samsung.com>
 <1529396370-18761-4-git-send-email-m.purski@samsung.com>
Message-ID: <20180724080250epcas1p399b546f087dc1acd81dd5824f4498433~EP0x1jr7b1293312933epcas1p3z@epcas1p3.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2018? 06? 19? 17:19? Maciej Purski ?(?) ? ?:
> As the out bridge will not be enabled directly by the framework,
> it should be enabled by DSI. Exynos_dsi_enable() should handle a case,
> when there is an out_bridge connected as a DSI peripheral.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 34 +++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index c0408c0..8aa7ace 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1386,25 +1386,33 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
>  
>  	dsi->state |= DSIM_STATE_ENABLED;
>  
> -	ret = drm_panel_prepare(dsi->panel);
> -	if (ret < 0) {
> -		dsi->state &= ~DSIM_STATE_ENABLED;
> -		pm_runtime_put_sync(dsi->dev);
> -		return;
> +	if (dsi->panel) {
> +		ret = drm_panel_prepare(dsi->panel);
> +		if (ret < 0) {
> +			dsi->state &= ~DSIM_STATE_ENABLED;

Why did you remove pm_runtime_put_sync call?

> +			return;
> +		}
>  	}
>  
> +	if (dsi->out_bridge)
> +		drm_bridge_pre_enable(dsi->out_bridge);
> +
>  	exynos_dsi_set_display_mode(dsi);
>  	exynos_dsi_set_display_enable(dsi, true);
>  
> -	ret = drm_panel_enable(dsi->panel);
> -	if (ret < 0) {
> -		dsi->state &= ~DSIM_STATE_ENABLED;
> -		exynos_dsi_set_display_enable(dsi, false);
> -		drm_panel_unprepare(dsi->panel);
> -		pm_runtime_put_sync(dsi->dev);
> -		return;
> +	if (dsi->panel) {
> +		ret = drm_panel_enable(dsi->panel);
> +		if (ret < 0) {
> +			dsi->state &= ~DSIM_STATE_ENABLED;
> +			exynos_dsi_set_display_enable(dsi, false);
> +			drm_panel_unprepare(dsi->panel);

Ditto.

Thanks,
Inki Dae

> +			return;
> +		}
>  	}
>  
> +	if (dsi->out_bridge)
> +		drm_bridge_enable(dsi->out_bridge);
> +
>  	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
>  }
>  
> @@ -1418,8 +1426,10 @@ static void exynos_dsi_disable(struct drm_encoder *encoder)
>  	dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
>  
>  	drm_panel_disable(dsi->panel);
> +	drm_bridge_disable(dsi->out_bridge);
>  	exynos_dsi_set_display_enable(dsi, false);
>  	drm_panel_unprepare(dsi->panel);
> +	drm_bridge_post_disable(dsi->out_bridge);
>  
>  	dsi->state &= ~DSIM_STATE_ENABLED;
>  
> 
