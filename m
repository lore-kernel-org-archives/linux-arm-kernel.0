From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Sep 2015 17:04:39 +0900
Subject: [PATCH v4 05/16] drm: bridge: analogix/dp: dynamic parse sync_pol
 & interlace & colorimetry
In-Reply-To: <1441086934-25107-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441086934-25107-1-git-send-email-ykk@rock-chips.com>
Message-ID: <55E7FF17.20402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.09.2015 14:55, Yakir Yang wrote:
> Both hsync/vsync polarity and interlace mode can be parsed from
> drm display mode, and dynamic_range and ycbcr_coeff can be judge
> by the video code, same to color space and color depth can be
> parsed from EDID.
> 
> But presumably Exynos still relaies on the DT properties, so take

s/relaies/relies/

> good use of mode_fixup() in to achieve the compatibility hacks.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v4:
> - Take Krzysztof suggest, provide backword compatibility with samsung.
> - Take Thierry suggest, add "color-depth" and "color-space" dynamic parsed.
> 
> Changes in v3:
> - Take Thierry Reding suggest, dynamic parse video timing info from
>   struct drm_display_mode and struct drm_display_info.
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 141 +++++++++++++--------
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |   2 +-
>  drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |  14 +-
>  drivers/gpu/drm/exynos/exynos_dp.c                 |  58 ++++++++-
>  4 files changed, 151 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 7196097..f0db92e 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -897,8 +897,8 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>  		return;
>  	}
>  
> -	ret = analogix_dp_set_link_train(dp, dp->video_info->lane_count,
> -					 dp->video_info->link_rate);
> +	ret = analogix_dp_set_link_train(dp, dp->video_info.lane_count,
> +					 dp->video_info.link_rate);
>  	if (ret) {
>  		dev_err(dp->dev, "unable to do link train\n");
>  		return;
> @@ -1081,6 +1081,82 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>  	dp->dpms_mode = DRM_MODE_DPMS_OFF;
>  }
>  
> +static void analogix_dp_bridge_mode_set(struct drm_bridge *bridge,
> +					struct drm_display_mode *orig_mode,
> +					struct drm_display_mode *mode)
> +{
> +	struct analogix_dp_device *dp = bridge->driver_private;
> +	struct drm_display_info *display_info = &dp->connector.display_info;
> +	struct video_info *video_info = &dp->video_info;
> +	struct device_node *dp_node = dp->dev->of_node;
> +	int vic;
> +
> +	/* interlaces & hsync pol & vsync pol */
> +	video_info->interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
> +	video_info->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
> +	video_info->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
> +
> +	/* dynamic_range & colorimetry */
> +	vic = drm_match_cea_mode(mode);
> +	if ((vic == 6) || (vic == 7) || (vic == 21) || (vic == 22) ||
> +	    (vic == 2) || (vic == 3) || (vic == 17) || (vic == 18)) {
> +		video_info->dynamic_range = CEA;
> +		video_info->ycbcr_coeff = COLOR_YCBCR601;
> +	} else if (vic) {
> +		video_info->dynamic_range = CEA;
> +		video_info->ycbcr_coeff = COLOR_YCBCR709;
> +	} else {
> +		video_info->dynamic_range = VESA;
> +		video_info->ycbcr_coeff = COLOR_YCBCR709;
> +	}
> +
> +	switch (display_info->bpc) {
> +	case 12:
> +		video_info->color_depth = COLOR_12;
> +		break;
> +	case 10:
> +		video_info->color_depth = COLOR_10;
> +		break;
> +	case 8:
> +		video_info->color_depth = COLOR_8;
> +		break;
> +	case 6:
> +		video_info->color_depth = COLOR_6;
> +		break;
> +	default:
> +		video_info->color_depth = COLOR_8;
> +		break;
> +	}
> +
> +	if (display_info->color_formats | DRM_COLOR_FORMAT_YCRCB444)
> +		video_info->color_space = COLOR_YCBCR444;
> +	else if (display_info->color_formats | DRM_COLOR_FORMAT_YCRCB422)
> +		video_info->color_space = COLOR_YCBCR422;
> +	else if (display_info->color_formats | DRM_COLOR_FORMAT_RGB444)
> +		video_info->color_space = COLOR_RGB;
> +	else
> +		video_info->color_space = COLOR_RGB;
> +
> +	/*
> +	 * NOTE: those property parseing code is used for

s/parseing/parsing/

BTW, you can easily integrate spell-check to vim... It is not that I
search for such misspellings - they are highlighted...

> +	 * providing backward compatibility for samsung platform.
> +	 */
> +	of_property_read_u32(dp_node, "samsung,color-space",
> +			     &video_info->color_space);
> +	of_property_read_u32(dp_node, "samsung,dynamic-range",
> +			     &video_info->dynamic_range);
> +	of_property_read_u32(dp_node, "samsung,ycbcr-coeff",
> +			     &video_info->ycbcr_coeff);
> +	of_property_read_u32(dp_node, "samsung,color-depth",
> +			     &video_info->color_depth);
> +	of_property_read_u32(dp_node, "hsync-active-high",
> +			     (unsigned int *)&video_info->h_sync_polarity);
> +	of_property_read_u32(dp_node, "vsync-active-high",
> +			     (unsigned int *)&video_info->v_sync_polarity);
> +	of_property_read_u32(dp_node, "interlaced",
> +			     (unsigned int *)&video_info->interlaced);

You made assumption that the sizeof(bool) is always equal to
sizeof(u32)... Then you cast it to pointer to unsigned int but function
wants pointer to u32. Just for reading boolean property. There's easier
way - of_property_read_bool. It returns bool.


> +}
> +
>  static void analogix_dp_bridge_nop(struct drm_bridge *bridge)
>  {
>  	/* do nothing */
> @@ -1091,6 +1167,7 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
>  	.disable = analogix_dp_bridge_disable,
>  	.pre_enable = analogix_dp_bridge_nop,
>  	.post_disable = analogix_dp_bridge_nop,
> +	.mode_set = analogix_dp_bridge_mode_set,
>  	.attach = analogix_dp_bridge_attach,
>  };
>  
> @@ -1121,62 +1198,24 @@ static int analogix_dp_create_bridge(struct drm_device *drm_dev,
>  	return 0;
>  }
>  
> -static struct video_info *analogix_dp_dt_parse_pdata(struct device *dev)
> +static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
>  {
> -	struct device_node *dp_node = dev->of_node;
> -	struct video_info *dp_video_config;
> -
> -	dp_video_config = devm_kzalloc(dev, sizeof(*dp_video_config),
> -				       GFP_KERNEL);
> -	if (!dp_video_config)
> -		return ERR_PTR(-ENOMEM);
> -
> -	dp_video_config->h_sync_polarity =
> -		of_property_read_bool(dp_node, "hsync-active-high");
> -
> -	dp_video_config->v_sync_polarity =
> -		of_property_read_bool(dp_node, "vsync-active-high");
> -
> -	dp_video_config->interlaced =
> -		of_property_read_bool(dp_node, "interlaced");
> -
> -	if (of_property_read_u32(dp_node, "samsung,color-space",
> -				 &dp_video_config->color_space)) {
> -		dev_err(dev, "failed to get color-space\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	if (of_property_read_u32(dp_node, "samsung,dynamic-range",
> -				 &dp_video_config->dynamic_range)) {
> -		dev_err(dev, "failed to get dynamic-range\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	if (of_property_read_u32(dp_node, "samsung,ycbcr-coeff",
> -				 &dp_video_config->ycbcr_coeff)) {
> -		dev_err(dev, "failed to get ycbcr-coeff\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> -	if (of_property_read_u32(dp_node, "samsung,color-depth",
> -				 &dp_video_config->color_depth)) {
> -		dev_err(dev, "failed to get color-depth\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> +	struct device_node *dp_node = dp->dev->of_node;
> +	struct video_info *video_config = &dp->video_info;
>  
>  	if (of_property_read_u32(dp_node, "samsung,link-rate",
> -				 &dp_video_config->link_rate)) {
> +				 &video_info->link_rate)) {
>  		dev_err(dev, "failed to get link-rate\n");
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
>  
>  	if (of_property_read_u32(dp_node, "samsung,lane-count",
> -				 &dp_video_config->lane_count)) {
> +				 &video_info->lane_count)) {
>  		dev_err(dev, "failed to get lane-count\n");
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
>  
> -	return dp_video_config;
> +	return 0;
>  }
>  
>  int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
> @@ -1205,9 +1244,9 @@ int analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
>  	 */
>  	dp->plat_data = plat_data;
>  
> -	dp->video_info = analogix_dp_dt_parse_pdata(&pdev->dev);
> -	if (IS_ERR(dp->video_info))
> -		return PTR_ERR(dp->video_info);
> +	ret = analogix_dp_dt_parse_pdata(dp);
> +	if (ret)
> +		return ret;
>  
>  	dp->phy = devm_phy_get(dp->dev, "dp");
>  	if (IS_ERR(dp->phy)) {
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index ffabbd0..6e3d5bc 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -154,7 +154,7 @@ struct analogix_dp_device {
>  	unsigned int		irq;
>  	void __iomem		*reg_base;
>  
> -	struct video_info	*video_info;
> +	struct video_info	video_info;
>  	struct link_train	link_train;
>  	struct work_struct	hotplug_work;
>  	struct phy		*phy;
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index b879d8c..6a643be 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -1084,15 +1084,15 @@ void analogix_dp_set_video_color_format(struct analogix_dp_device *dp)
>  	u32 reg;
>  
>  	/* Configure the input color depth, color space, dynamic range */
> -	reg = (dp->video_info->dynamic_range << IN_D_RANGE_SHIFT) |
> -		(dp->video_info->color_depth << IN_BPC_SHIFT) |
> -		(dp->video_info->color_space << IN_COLOR_F_SHIFT);
> +	reg = (dp->video_info.dynamic_range << IN_D_RANGE_SHIFT) |
> +		(dp->video_info.color_depth << IN_BPC_SHIFT) |
> +		(dp->video_info.color_space << IN_COLOR_F_SHIFT);
>  	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_2);
>  
>  	/* Set Input Color YCbCr Coefficients to ITU601 or ITU709 */
>  	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_3);
>  	reg &= ~IN_YC_COEFFI_MASK;
> -	if (dp->video_info->ycbcr_coeff)
> +	if (dp->video_info.ycbcr_coeff)
>  		reg |= IN_YC_COEFFI_ITU709;
>  	else
>  		reg |= IN_YC_COEFFI_ITU601;
> @@ -1229,17 +1229,17 @@ void analogix_dp_config_video_slave_mode(struct analogix_dp_device *dp)
>  
>  	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
>  	reg &= ~INTERACE_SCAN_CFG;
> -	reg |= (dp->video_info->interlaced << 2);
> +	reg |= (dp->video_info.interlaced << 2);
>  	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
>  
>  	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
>  	reg &= ~VSYNC_POLARITY_CFG;
> -	reg |= (dp->video_info->v_sync_polarity << 1);
> +	reg |= (dp->video_info.v_sync_polarity << 1);
>  	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
>  
>  	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
>  	reg &= ~HSYNC_POLARITY_CFG;
> -	reg |= (dp->video_info->h_sync_polarity << 0);
> +	reg |= (dp->video_info.h_sync_polarity << 0);
>  	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_10);
>  
>  	reg = AUDIO_MODE_SPDIF_MODE | VIDEO_MODE_SLAVE_MODE;
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
> index 7e1be72..6060d2c 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -28,8 +28,13 @@
>  
>  #include "exynos_drm_crtc.h"
>  
> -#define plat_data_to_dp(pd) \
> -		container_of(pd, struct exynos_dp_device, plat_data)
> +#define to_dp(nm)	container_of(nm, struct exynos_dp_device, nm)
> +
> +struct video_info {
> +	bool h_sync_polarity;
> +	bool v_sync_polarity;
> +	bool interlaced;
> +};
>  
>  struct exynos_dp_device {
>  	struct drm_encoder         encoder;
> @@ -39,12 +44,13 @@ struct exynos_dp_device {
>  
>  	struct exynos_drm_panel_info priv;
>  	struct analogix_dp_plat_data plat_data;
> +	struct video_info            video_info;
>  };
>  
>  int exynos_dp_crtc_clock_enable(struct analogix_dp_plat_data *plat_data,
>  				bool enable)
>  {
> -	struct exynos_dp_device *dp = plat_data_to_dp(plat_data);
> +	struct exynos_dp_device *dp = to_dp(plat_data);
>  	struct drm_encoder *encoder = &dp->encoder;
>  	struct exynos_drm_crtc *crtc;
>  
> @@ -71,7 +77,7 @@ static int exynos_dp_poweroff(struct analogix_dp_plat_data *plat_data)
>  static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data,
>  			       struct drm_connector *connector)
>  {
> -	struct exynos_dp_device *dp = plat_data_to_dp(plat_data);
> +	struct exynos_dp_device *dp = to_dp(plat_data);
>  	struct drm_display_mode *mode;
>  
>  	if (dp->plat_data.panel)
> @@ -99,7 +105,7 @@ static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data,
>  static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_data,
>  				   struct drm_bridge *bridge)
>  {
> -	struct exynos_dp_device *dp = plat_data_to_dp(plat_data);
> +	struct exynos_dp_device *dp = to_dp(plat_data);
>  	struct drm_encoder *encoder = &dp->encoder;
>  	int ret;
>  
> @@ -122,6 +128,28 @@ static bool exynos_dp_mode_fixup(struct drm_encoder *encoder,
>  				 const struct drm_display_mode *mode,
>  				 struct drm_display_mode *adjusted_mode)
>  {
> +	struct exynos_dp_device *dp = to_dp(encoder);
> +	int flags = adjusted_mode->flags;
> +
> +	flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC |
> +		   DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC |
> +		   DRM_MODE_FLAG_INTERLACE);
> +
> +	if (dp->video_info.h_sync_polarity)
> +		flags |= DRM_MODE_FLAG_PHSYNC;
> +	else
> +		flags |= DRM_MODE_FLAG_NHSYNC;
> +
> +	if (dp->video_info.v_sync_polarity)
> +		flags |= DRM_MODE_FLAG_PVSYNC;
> +	else
> +		flags |= DRM_MODE_FLAG_NVSYNC;
> +
> +	if (dp->video_info.interlaced)
> +		flags |= DRM_MODE_FLAG_INTERLACE;
> +
> +	adjusted_mode->flags = flags;
> +
>  	return true;
>  }
>  
> @@ -163,6 +191,22 @@ static int exynos_dp_dt_parse_panel(struct exynos_dp_device *dp)
>  	return 0;
>  }
>  
> +static int exynos_dp_dt_parse_video_info(struct exynos_dp_device *dp)
> +{
> +	struct device_node *dp_node = dp->dev->of_node;
> +
> +	dp->video_info.h_sync_polarity =
> +		of_property_read_bool(dp_node, "hsync-active-high");
> +
> +	dp->video_info.v_sync_polarity =
> +		of_property_read_bool(dp_node, "vsync-active-high");
> +
> +	dp->video_info.interlaced =
> +		of_property_read_bool(dp_node, "interlaced");
> +
> +	return 0;

Probably you wanted to follow the convention of other DT-parse functions
but there is no need. This function cannot fail so maybe make it void?
It would simplify a bit the code in exynos_dp_bind().

Best regards,
Krzysztof
