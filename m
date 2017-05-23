From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 23 May 2017 11:11:34 +0900
Subject: [PATCH v2 1/5] drm/stm: ltdc: Add bridge support
In-Reply-To: <1495207218-11372-2-git-send-email-philippe.cornu@st.com>
References: <1495207218-11372-1-git-send-email-philippe.cornu@st.com>
 <CGME20170520011404epcas1p3bfdaa032f246a5ece9c7b510af89e7fd@epcas1p3.samsung.com>
 <1495207218-11372-2-git-send-email-philippe.cornu@st.com>
Message-ID: <c9b45faa-89f9-c31c-a5c4-2780fdb79d62@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

W dniu 2017-05-20 o 00:20, Philippe CORNU pisze:
> Add the bridge support, used by DSI host and HDMI/LVDS bridges.
>
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 74 ++++++++++++++++++++++++++++++++++------------
>   drivers/gpu/drm/stm/ltdc.h |  1 +
>   2 files changed, 56 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 7b2d63b..809e420 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -858,6 +858,43 @@ static struct drm_encoder *ltdc_rgb_encoder_create(struct drm_device *ddev)
>   	return encoder;
>   }
>   
> +static const struct drm_encoder_funcs bridge_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
> +struct drm_encoder *bridge_encoder_create(struct drm_device *ddev,
> +					  struct drm_bridge *bridge)
> +{
> +	struct drm_encoder *encoder;
> +	int ret;
> +
> +	encoder = devm_kzalloc(ddev->dev, sizeof(*encoder), GFP_KERNEL);
> +	if (!encoder)
> +		return NULL;
> +
> +	encoder->possible_crtcs = CRTC_MASK;
> +	encoder->possible_clones = 0; /* No cloning support */
> +
> +	drm_encoder_init(ddev, encoder, &bridge_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);
> +
> +	drm_encoder_helper_add(encoder, NULL);
> +
> +	/* Link drm_bridge to encoder */
> +	bridge->encoder = encoder;
> +	encoder->bridge = bridge;

I think the above two lines are redundant, drm_bridge_attach should do that.

> +
> +	ret = drm_bridge_attach(encoder, bridge, NULL);
> +	if (ret) {
> +		drm_encoder_cleanup(encoder);
> +		return NULL;
> +	}
> +
> +	DRM_DEBUG_DRIVER("Bridge encoder:%d created\n", encoder->base.id);
> +
> +	return encoder;
> +}
> +
>   /*
>    * DRM_CONNECTOR
>    */
> @@ -967,12 +1004,13 @@ static int ltdc_get_caps(struct drm_device *ddev)
>   	return 0;
>   }
>   
> -static struct drm_panel *ltdc_get_panel(struct drm_device *ddev)
> +static int ltdc_parse_dt(struct drm_device *ddev)
>   {
> +	struct ltdc_device *ldev = ddev->dev_private;
>   	struct device *dev = ddev->dev;
>   	struct device_node *np = dev->of_node;
> -	struct device_node *entity, *port = NULL;
> -	struct drm_panel *panel = NULL;
> +	struct device_node *entity;
> +	int ret;
>   
>   	DRM_DEBUG_DRIVER("\n");
>   
> @@ -985,21 +1023,13 @@ static struct drm_panel *ltdc_get_panel(struct drm_device *ddev)
>   		if (!of_device_is_available(entity))
>   			continue;
>   
> -		port = of_graph_get_remote_port_parent(entity);
> -		if (port) {
> -			panel = of_drm_find_panel(port);
> -			of_node_put(port);
> -			if (panel) {
> -				DRM_DEBUG_DRIVER("remote panel %s\n",
> -						 port->full_name);
> -			} else {
> -				DRM_DEBUG_DRIVER("panel missing\n");
> -				of_node_put(entity);
> -			}
> -		}
> +		ret = drm_of_find_panel_or_bridge(np, 0, 0,
> +						  &ldev->panel, &ldev->bridge);
> +		if (ret)
> +			return ret;
>   	}
>   
> -	return panel;
> +	return 0;
>   }
>   
>   int ltdc_load(struct drm_device *ddev)
> @@ -1017,9 +1047,9 @@ int ltdc_load(struct drm_device *ddev)
>   
>   	DRM_DEBUG_DRIVER("\n");
>   
> -	ldev->panel = ltdc_get_panel(ddev);
> -	if (!ldev->panel)
> -		return -EPROBE_DEFER;
> +	ret = ltdc_parse_dt(ddev);
> +	if (ret)
> +		return ret;
>   
>   	rstc = of_reset_control_get(np, NULL);
>   
> @@ -1077,6 +1107,12 @@ int ltdc_load(struct drm_device *ddev)
>   
>   	DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_version);
>   
> +	if (ldev->bridge) {
> +		encoder = bridge_encoder_create(ddev, ldev->bridge);
> +		if (!encoder)
> +			return -EINVAL;
> +	}
> +

I guess you could add 'else' clause after closing bracket - ldev->bridge 
and ldev->panel are mutually exclusive, but it is up to you.

Beside this:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Regards
Andrzej

>   	if (ldev->panel) {
>   		encoder = ltdc_rgb_encoder_create(ddev);
>   		if (!encoder) {
> diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> index 5427ef4..0083cad 100644
> --- a/drivers/gpu/drm/stm/ltdc.h
> +++ b/drivers/gpu/drm/stm/ltdc.h
> @@ -25,6 +25,7 @@ struct ltdc_device {
>   	void __iomem *regs;
>   	struct clk *pixel_clk;	/* lcd pixel clock */
>   	struct drm_panel *panel;
> +	struct drm_bridge *bridge;
>   	struct spinlock lock;	/* protecting irq status register */
>   	struct ltdc_caps caps;
>   	u32 clut[256];		/* color look up table */
