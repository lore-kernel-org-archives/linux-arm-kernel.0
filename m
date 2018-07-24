From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 24 Jul 2018 17:04:39 +0900
Subject: [PATCH v3 2/9] drm/exynos: move connector creation to attach
 callback
In-Reply-To: <1529396370-18761-3-git-send-email-m.purski@samsung.com>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619081958eucas1p16911ee9962441735d929dc588e70ce70@eucas1p1.samsung.com>
 <1529396370-18761-3-git-send-email-m.purski@samsung.com>
Message-ID: <20180724080439epcas1p3a19bce196acc4611327aa2a78a8e5060~EP2W7G7Vi0942109421epcas1p36@epcas1p3.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2018? 06? 19? 17:19? Maciej Purski ?(?) ? ?:
> The current implementation assumes that the only possible peripheral
> device for DSIM is a panel. Using an output bridge child device
> should also be possible.
> 
> If an output bridge is available, don't create a new connector.
> Instead, call drm_bridge_attach() and set encoder's bridge to NULL
> in order to avoid an out bridge from being visible by the framework, as
> the DSI bus needs control on enabling its child output bridge.
> 
> Such sequence is required by Toshiba TC358764 bridge, which is a DSI
> peripheral bridge device.

Right, we should consider DSI to LVDS bridge.

Thanks,
Inki Dae

> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 38 ++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 9599e6b..c0408c0 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -255,6 +255,7 @@ struct exynos_dsi {
>  	struct mipi_dsi_host dsi_host;
>  	struct drm_connector connector;
>  	struct drm_panel *panel;
> +	struct drm_bridge *out_bridge;
>  	struct device *dev;
>  
>  	void __iomem *reg_base;
> @@ -1499,7 +1500,30 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
>  				  struct mipi_dsi_device *device)
>  {
>  	struct exynos_dsi *dsi = host_to_dsi(host);
> -	struct drm_device *drm = dsi->connector.dev;
> +	struct drm_encoder *encoder = &dsi->encoder;
> +	struct drm_device *drm = encoder->dev;
> +	struct drm_bridge *out_bridge;
> +
> +	out_bridge  = of_drm_find_bridge(device->dev.of_node);
> +	if (out_bridge) {
> +		drm_bridge_attach(encoder, out_bridge, NULL);
> +		dsi->out_bridge = out_bridge;
> +		encoder->bridge = NULL;
> +	} else {
> +		int ret = exynos_dsi_create_connector(encoder);
> +
> +		if (ret) {
> +			DRM_ERROR("failed to create connector ret = %d\n", ret);
> +			drm_encoder_cleanup(encoder);
> +			return ret;
> +		}
> +
> +		dsi->panel = of_drm_find_panel(device->dev.of_node);
> +		if (dsi->panel) {
> +			drm_panel_attach(dsi->panel, &dsi->connector);
> +			dsi->connector.status = connector_status_connected;
> +		}
> +	}
>  
>  	/*
>  	 * This is a temporary solution and should be made by more generic way.
> @@ -1518,11 +1542,6 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
>  	dsi->lanes = device->lanes;
>  	dsi->format = device->format;
>  	dsi->mode_flags = device->mode_flags;
> -	dsi->panel = of_drm_find_panel(device->dev.of_node);
> -	if (dsi->panel) {
> -		drm_panel_attach(dsi->panel, &dsi->connector);
> -		dsi->connector.status = connector_status_connected;
> -	}
>  	exynos_drm_crtc_get_by_type(drm, EXYNOS_DISPLAY_TYPE_LCD)->i80_mode =
>  			!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
>  
> @@ -1654,13 +1673,6 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = exynos_dsi_create_connector(encoder);
> -	if (ret) {
> -		DRM_ERROR("failed to create connector ret = %d\n", ret);
> -		drm_encoder_cleanup(encoder);
> -		return ret;
> -	}
> -
>  	if (dsi->mic_bridge_node) {
>  		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
>  		if (mic_bridge)
> 
