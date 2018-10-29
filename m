From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 29 Oct 2018 15:15:13 +0100
Subject: [PATCH v6 7/7] drm/rockchip: dsi: add dual mipi support
In-Reply-To: <20181001123845.11818-8-heiko@sntech.de>
References: <20181001123845.11818-1-heiko@sntech.de>
 <CGME20181001123907epcas4p1a0537f565124dbb5a90aa67dec24604e@epcas4p1.samsung.com>
 <20181001123845.11818-8-heiko@sntech.de>
Message-ID: <700d5f2e-7351-de83-0384-8423df39d8bd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.10.2018 14:38, Heiko Stuebner wrote:
> Add the Rockchip-sepcific dual-dsi setup and hook it into the VOP as well.
> As described in the general dual-dsi devicetree binding, the panel should
> define two input ports and point each of them to one of the used dsi-
> controllers, as well as declare one of them as clock-master.
> This is used to determine the dual-dsi state and get access to both
> controller instances.
>
> v6:
>   handle master+slave component in dsi-attach
> v5:
>   use driver-internal mechanism to find dual dsi slave
> v4:
>   add component directly in probe when adding empty dsi slave controller
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

This is not what I really like (putting dual display functionality into
poor dsi driver), but it at least works.
So:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

The patchset is quite long on the list so if there will be no objections
I will merge it tomorrow.

?--
Regards
Andrzej

> ---
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 136 ++++++++++++++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |   3 +
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   4 +
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   1 +
>  5 files changed, 145 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> index b3aae8439aa3..63b028602d08 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -218,6 +218,10 @@ struct dw_mipi_dsi_rockchip {
>  	struct clk *grf_clk;
>  	struct clk *phy_cfg_clk;
>  
> +	/* dual-channel */
> +	bool is_slave;
> +	struct dw_mipi_dsi_rockchip *slave;
> +
>  	unsigned int lane_mbps; /* per lane */
>  	u16 input_div;
>  	u16 feedback_div;
> @@ -226,6 +230,7 @@ struct dw_mipi_dsi_rockchip {
>  	struct dw_mipi_dsi *dmd;
>  	const struct rockchip_dw_dsi_chip_data *cdata;
>  	struct dw_mipi_dsi_plat_data pdata;
> +	int devcnt;
>  };
>  
>  struct dphy_pll_parameter_map {
> @@ -602,6 +607,8 @@ dw_mipi_dsi_encoder_atomic_check(struct drm_encoder *encoder,
>  	}
>  
>  	s->output_type = DRM_MODE_CONNECTOR_DSI;
> +	if (dsi->slave)
> +		s->output_flags = ROCKCHIP_OUTPUT_DSI_DUAL;
>  
>  	return 0;
>  }
> @@ -617,6 +624,8 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
>  		return;
>  
>  	pm_runtime_get_sync(dsi->dev);
> +	if (dsi->slave)
> +		pm_runtime_get_sync(dsi->slave->dev);
>  
>  	/*
>  	 * For the RK3399, the clk of grf must be enabled before writing grf
> @@ -630,6 +639,8 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
>  	}
>  
>  	dw_mipi_dsi_rockchip_config(dsi, mux);
> +	if (dsi->slave)
> +		dw_mipi_dsi_rockchip_config(dsi->slave, mux);
>  
>  	clk_disable_unprepare(dsi->grf_clk);
>  }
> @@ -638,6 +649,8 @@ static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
>  {
>  	struct dw_mipi_dsi_rockchip *dsi = to_dsi(encoder);
>  
> +	if (dsi->slave)
> +		pm_runtime_put(dsi->slave->dev);
>  	pm_runtime_put(dsi->dev);
>  }
>  
> @@ -673,14 +686,113 @@ static int rockchip_dsi_drm_create_encoder(struct dw_mipi_dsi_rockchip *dsi,
>  	return 0;
>  }
>  
> +static struct device
> +*dw_mipi_dsi_rockchip_find_second(struct dw_mipi_dsi_rockchip *dsi)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *node = NULL, *local;
> +
> +	match = of_match_device(dsi->dev->driver->of_match_table, dsi->dev);
> +
> +	local = of_graph_get_remote_node(dsi->dev->of_node, 1, 0);
> +	if (!local)
> +		return NULL;
> +
> +	while ((node = of_find_compatible_node(node, NULL,
> +					       match->compatible))) {
> +		struct device_node *remote;
> +
> +		/* found ourself */
> +		if (node == dsi->dev->of_node)
> +			continue;
> +
> +		remote = of_graph_get_remote_node(node, 1, 0);
> +		if (!remote)
> +			continue;
> +
> +		/* same display device in port1-ep0 for both */
> +		if (remote == local) {
> +			struct dw_mipi_dsi_rockchip *dsi2;
> +			struct platform_device *pdev;
> +
> +			pdev = of_find_device_by_node(node);
> +
> +			/*
> +			 * we have found the second, so will either return it
> +			 * or return with an error. In any case won't need the
> +			 * nodes anymore nor continue the loop.
> +			 */
> +			of_node_put(remote);
> +			of_node_put(node);
> +			of_node_put(local);
> +
> +			if (!pdev)
> +				return ERR_PTR(-EPROBE_DEFER);
> +
> +			dsi2 = platform_get_drvdata(pdev);
> +			if (!dsi2) {
> +				platform_device_put(pdev);
> +				return ERR_PTR(-EPROBE_DEFER);
> +			}
> +
> +			return &pdev->dev;
> +		}
> +
> +		of_node_put(remote);
> +	}
> +
> +	of_node_put(local);
> +
> +	return NULL;
> +}
> +
>  static int dw_mipi_dsi_rockchip_bind(struct device *dev,
>  				     struct device *master,
>  				     void *data)
>  {
>  	struct dw_mipi_dsi_rockchip *dsi = dev_get_drvdata(dev);
>  	struct drm_device *drm_dev = data;
> +	struct device *second;
> +	bool master1, master2;
>  	int ret;
>  
> +	second = dw_mipi_dsi_rockchip_find_second(dsi);
> +	if (IS_ERR(second))
> +		return PTR_ERR(second);
> +
> +	if (second) {
> +		master1 = of_property_read_bool(dsi->dev->of_node,
> +						"clock-master");
> +		master2 = of_property_read_bool(second->of_node,
> +						"clock-master");
> +
> +		if (master1 && master2) {
> +			DRM_DEV_ERROR(dsi->dev, "only one clock-master allowed\n");
> +			return -EINVAL;
> +		}
> +
> +		if (!master1 && !master2) {
> +			DRM_DEV_ERROR(dsi->dev, "no clock-master defined\n");
> +			return -EINVAL;
> +		}
> +
> +		/* we are the slave in dual-DSI */
> +		if (!master1) {
> +			dsi->is_slave = true;
> +			return 0;
> +		}
> +
> +		dsi->slave = dev_get_drvdata(second);
> +		if (!dsi->slave) {
> +			DRM_DEV_ERROR(dev, "could not get slaves data\n");
> +			return -ENODEV;
> +		}
> +
> +		dsi->slave->is_slave = true;
> +		dw_mipi_dsi_set_slave(dsi->dmd, dsi->slave->dmd);
> +		put_device(second);
> +	}
> +
>  	ret = clk_prepare_enable(dsi->pllref_clk);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "Failed to enable pllref_clk: %d\n", ret);
> @@ -708,6 +819,9 @@ static void dw_mipi_dsi_rockchip_unbind(struct device *dev,
>  {
>  	struct dw_mipi_dsi_rockchip *dsi = dev_get_drvdata(dev);
>  
> +	if (dsi->is_slave)
> +		return;
> +
>  	dw_mipi_dsi_unbind(dsi->dmd);
>  
>  	clk_disable_unprepare(dsi->pllref_clk);
> @@ -722,6 +836,7 @@ static int dw_mipi_dsi_rockchip_host_attach(void *priv_data,
>  					    struct mipi_dsi_device *device)
>  {
>  	struct dw_mipi_dsi_rockchip *dsi = priv_data;
> +	struct device *second;
>  	int ret;
>  
>  	ret = component_add(dsi->dev, &dw_mipi_dsi_rockchip_ops);
> @@ -731,6 +846,19 @@ static int dw_mipi_dsi_rockchip_host_attach(void *priv_data,
>  		return ret;
>  	}
>  
> +	second = dw_mipi_dsi_rockchip_find_second(dsi);
> +	if (IS_ERR(second))
> +		return PTR_ERR(second);
> +	if (second) {
> +		ret = component_add(second, &dw_mipi_dsi_rockchip_ops);
> +		if (ret) {
> +			DRM_DEV_ERROR(second,
> +				      "Failed to register component: %d\n",
> +				      ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -738,6 +866,11 @@ static int dw_mipi_dsi_rockchip_host_detach(void *priv_data,
>  					    struct mipi_dsi_device *device)
>  {
>  	struct dw_mipi_dsi_rockchip *dsi = priv_data;
> +	struct device *second;
> +
> +	second = dw_mipi_dsi_rockchip_find_second(dsi);
> +	if (second && !IS_ERR(second))
> +		component_del(second, &dw_mipi_dsi_rockchip_ops);
>  
>  	component_del(dsi->dev, &dw_mipi_dsi_rockchip_ops);
>  
> @@ -846,6 +979,9 @@ static int dw_mipi_dsi_rockchip_remove(struct platform_device *pdev)
>  {
>  	struct dw_mipi_dsi_rockchip *dsi = platform_get_drvdata(pdev);
>  
> +	if (dsi->devcnt == 0)
> +		component_del(dsi->dev, &dw_mipi_dsi_rockchip_ops);
> +
>  	dw_mipi_dsi_remove(dsi->dmd);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> index 453fef6a55b9..ce48568ec8a0 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> @@ -37,6 +37,7 @@ struct rockchip_crtc_state {
>  	int output_type;
>  	int output_mode;
>  	int output_bpc;
> +	int output_flags;
>  };
>  #define to_rockchip_crtc_state(s) \
>  		container_of(s, struct rockchip_crtc_state, base)
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 0c35a88e33dd..fb70fb486fbf 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -916,6 +916,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
>  	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_PVSYNC) ?
>  		   BIT(VSYNC_POSITIVE) : 0;
>  	VOP_REG_SET(vop, output, pin_pol, pin_pol);
> +	VOP_REG_SET(vop, output, mipi_dual_channel_en, 0);
>  
>  	switch (s->output_type) {
>  	case DRM_MODE_CONNECTOR_LVDS:
> @@ -933,6 +934,8 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
>  	case DRM_MODE_CONNECTOR_DSI:
>  		VOP_REG_SET(vop, output, mipi_pin_pol, pin_pol);
>  		VOP_REG_SET(vop, output, mipi_en, 1);
> +		VOP_REG_SET(vop, output, mipi_dual_channel_en,
> +			    !!(s->output_flags & ROCKCHIP_OUTPUT_DSI_DUAL));
>  		break;
>  	case DRM_MODE_CONNECTOR_DisplayPort:
>  		pin_pol &= ~BIT(DCLK_INVERT);
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> index fd5765dfd637..0fe40e1983d9 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> @@ -60,6 +60,7 @@ struct vop_output {
>  	struct vop_reg edp_en;
>  	struct vop_reg hdmi_en;
>  	struct vop_reg mipi_en;
> +	struct vop_reg mipi_dual_channel_en;
>  	struct vop_reg rgb_en;
>  };
>  
> @@ -214,6 +215,9 @@ struct vop_data {
>  /* for use special outface */
>  #define ROCKCHIP_OUT_MODE_AAAA	15
>  
> +/* output flags */
> +#define ROCKCHIP_OUTPUT_DSI_DUAL	BIT(0)
> +
>  enum alpha_mode {
>  	ALPHA_STRAIGHT,
>  	ALPHA_INVERSE,
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index 047a8867af90..08fc40af52c8 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -634,6 +634,7 @@ static const struct vop_output rk3399_output = {
>  	.hdmi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 13),
>  	.edp_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 14),
>  	.mipi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 15),
> +	.mipi_dual_channel_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 3),
>  };
>  
>  static const struct vop_data rk3399_vop_big = {
