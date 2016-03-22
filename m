From: inki.dae@samsung.com (Inki Dae)
Date: Wed, 23 Mar 2016 07:22:42 +0900
Subject: [PATCH v8 01/17] drm: exynos: dp: convert to drm bridge mode
In-Reply-To: <1446020345-7388-1-git-send-email-ykk@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446020345-7388-1-git-send-email-ykk@rock-chips.com>
Message-ID: <56F1C5B2.8020104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2015? 10? 28? 17:19? Yakir Yang ?(?) ? ?:
> In order to move exynos dp code to bridge directory,
> we need to convert driver drm bridge mode first. As
> dp driver already have a ptn3460 bridge, so we need
> to move ptn bridge to the next bridge of dp bridge.
> 
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

Acked-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> ---
> Changes in v8: None
> Changes in v7: None
> Changes in v6:
> - Fix the wrong code in previous series, and test on Samsung snow Chromebook
>   successfully, here are the detail changes:
> =============>
> -       if (!dp->panel && !dp->bridge) {
> +       if (!dp->panel && !dp->ptn_bridge) {
>                 ret = exynos_dp_dt_parse_panel(dp);
>                 if (ret)
> =============>
> +       encoder->bridge = bridge;
> 	bridge->driver_private = dp;
>         bridge->encoder = encoder;
>         bridge->funcs = &exynos_dp_bridge_funcs;
>         ret = drm_bridge_attach(drm_dev, bridge);
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - Keep author name list no changed (Jingoo)
> 
>  drivers/gpu/drm/exynos/exynos_dp_core.c | 103 ++++++++++++++++++++++++--------
>  drivers/gpu/drm/exynos/exynos_dp_core.h |   1 +
>  2 files changed, 78 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
> index 124fb9a..aedd074 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
> @@ -1009,9 +1009,9 @@ static int exynos_drm_attach_lcd_bridge(struct exynos_dp_device *dp,
>  {
>  	int ret;
>  
> -	encoder->bridge = dp->bridge;
> -	dp->bridge->encoder = encoder;
> -	ret = drm_bridge_attach(encoder->dev, dp->bridge);
> +	encoder->bridge->next = dp->ptn_bridge;
> +	dp->ptn_bridge->encoder = encoder;
> +	ret = drm_bridge_attach(encoder->dev, dp->ptn_bridge);
>  	if (ret) {
>  		DRM_ERROR("Failed to attach bridge to drm\n");
>  		return ret;
> @@ -1020,14 +1020,15 @@ static int exynos_drm_attach_lcd_bridge(struct exynos_dp_device *dp,
>  	return 0;
>  }
>  
> -static int exynos_dp_create_connector(struct drm_encoder *encoder)
> +static int exynos_dp_bridge_attach(struct drm_bridge *bridge)
>  {
> -	struct exynos_dp_device *dp = encoder_to_dp(encoder);
> +	struct exynos_dp_device *dp = bridge->driver_private;
> +	struct drm_encoder *encoder = &dp->encoder;
>  	struct drm_connector *connector = &dp->connector;
>  	int ret;
>  
>  	/* Pre-empt DP connector creation if there's a bridge */
> -	if (dp->bridge) {
> +	if (dp->ptn_bridge) {
>  		ret = exynos_drm_attach_lcd_bridge(dp, encoder);
>  		if (!ret)
>  			return 0;
> @@ -1052,22 +1053,9 @@ static int exynos_dp_create_connector(struct drm_encoder *encoder)
>  	return ret;
>  }
>  
> -static bool exynos_dp_mode_fixup(struct drm_encoder *encoder,
> -				 const struct drm_display_mode *mode,
> -				 struct drm_display_mode *adjusted_mode)
> -{
> -	return true;
> -}
> -
> -static void exynos_dp_mode_set(struct drm_encoder *encoder,
> -			       struct drm_display_mode *mode,
> -			       struct drm_display_mode *adjusted_mode)
> -{
> -}
> -
> -static void exynos_dp_enable(struct drm_encoder *encoder)
> +static void exynos_dp_bridge_enable(struct drm_bridge *bridge)
>  {
> -	struct exynos_dp_device *dp = encoder_to_dp(encoder);
> +	struct exynos_dp_device *dp = bridge->driver_private;
>  	struct exynos_drm_crtc *crtc = dp_to_crtc(dp);
>  
>  	if (dp->dpms_mode == DRM_MODE_DPMS_ON)
> @@ -1092,9 +1080,9 @@ static void exynos_dp_enable(struct drm_encoder *encoder)
>  	dp->dpms_mode = DRM_MODE_DPMS_ON;
>  }
>  
> -static void exynos_dp_disable(struct drm_encoder *encoder)
> +static void exynos_dp_bridge_disable(struct drm_bridge *bridge)
>  {
> -	struct exynos_dp_device *dp = encoder_to_dp(encoder);
> +	struct exynos_dp_device *dp = bridge->driver_private;
>  	struct exynos_drm_crtc *crtc = dp_to_crtc(dp);
>  
>  	if (dp->dpms_mode != DRM_MODE_DPMS_ON)
> @@ -1123,6 +1111,69 @@ static void exynos_dp_disable(struct drm_encoder *encoder)
>  	dp->dpms_mode = DRM_MODE_DPMS_OFF;
>  }
>  
> +static void exynos_dp_bridge_nop(struct drm_bridge *bridge)
> +{
> +	/* do nothing */
> +}
> +
> +static const struct drm_bridge_funcs exynos_dp_bridge_funcs = {
> +	.enable = exynos_dp_bridge_enable,
> +	.disable = exynos_dp_bridge_disable,
> +	.pre_enable = exynos_dp_bridge_nop,
> +	.post_disable = exynos_dp_bridge_nop,
> +	.attach = exynos_dp_bridge_attach,
> +};
> +
> +static int exynos_dp_create_connector(struct drm_encoder *encoder)
> +{
> +	struct exynos_dp_device *dp = encoder_to_dp(encoder);
> +	struct drm_device *drm_dev = dp->drm_dev;
> +	struct drm_bridge *bridge;
> +	int ret;
> +
> +	bridge = devm_kzalloc(drm_dev->dev, sizeof(*bridge), GFP_KERNEL);
> +	if (!bridge) {
> +		DRM_ERROR("failed to allocate for drm bridge\n");
> +		return -ENOMEM;
> +	}
> +
> +	dp->bridge = bridge;
> +
> +	encoder->bridge = bridge;
> +	bridge->driver_private = dp;
> +	bridge->encoder = encoder;
> +	bridge->funcs = &exynos_dp_bridge_funcs;
> +
> +	ret = drm_bridge_attach(drm_dev, bridge);
> +	if (ret) {
> +		DRM_ERROR("failed to attach drm bridge\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool exynos_dp_mode_fixup(struct drm_encoder *encoder,
> +				 const struct drm_display_mode *mode,
> +				 struct drm_display_mode *adjusted_mode)
> +{
> +	return true;
> +}
> +
> +static void exynos_dp_mode_set(struct drm_encoder *encoder,
> +			       struct drm_display_mode *mode,
> +			       struct drm_display_mode *adjusted_mode)
> +{
> +}
> +
> +static void exynos_dp_enable(struct drm_encoder *encoder)
> +{
> +}
> +
> +static void exynos_dp_disable(struct drm_encoder *encoder)
> +{
> +}
> +
>  static struct drm_encoder_helper_funcs exynos_dp_encoder_helper_funcs = {
>  	.mode_fixup = exynos_dp_mode_fixup,
>  	.mode_set = exynos_dp_mode_set,
> @@ -1238,7 +1289,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>  		}
>  	}
>  
> -	if (!dp->panel && !dp->bridge) {
> +	if (!dp->panel && !dp->ptn_bridge) {
>  		ret = exynos_dp_dt_parse_panel(dp);
>  		if (ret)
>  			return ret;
> @@ -1365,9 +1416,9 @@ static int exynos_dp_probe(struct platform_device *pdev)
>  	if (endpoint) {
>  		bridge_node = of_graph_get_remote_port_parent(endpoint);
>  		if (bridge_node) {
> -			dp->bridge = of_drm_find_bridge(bridge_node);
> +			dp->ptn_bridge = of_drm_find_bridge(bridge_node);
>  			of_node_put(bridge_node);
> -			if (!dp->bridge)
> +			if (!dp->ptn_bridge)
>  				return -EPROBE_DEFER;
>  		} else
>  			return -EPROBE_DEFER;
> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.h b/drivers/gpu/drm/exynos/exynos_dp_core.h
> index e413b6f..66eec4b 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp_core.h
> +++ b/drivers/gpu/drm/exynos/exynos_dp_core.h
> @@ -153,6 +153,7 @@ struct exynos_dp_device {
>  	struct drm_connector	connector;
>  	struct drm_panel	*panel;
>  	struct drm_bridge	*bridge;
> +	struct drm_bridge	*ptn_bridge;
>  	struct clk		*clock;
>  	unsigned int		irq;
>  	void __iomem		*reg_base;
> 
