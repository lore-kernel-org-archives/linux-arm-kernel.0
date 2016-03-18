From: caesar.upstream@gmail.com (Caesar Wang)
Date: Fri, 18 Mar 2016 14:45:29 +0800
Subject: [PATCH v14.1 09/17] drm: rockchip: dp: add rockchip platform dp
 driver
In-Reply-To: <2523119.bAzQsAzOsc@diego>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1455534640-1877-1-git-send-email-ykk@rock-chips.com>
 <2523119.bAzQsAzOsc@diego>
Message-ID: <56EBA409.60707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016?03?18? 05:51, Heiko St?bner ??:
> Rockchip have three clocks for dp controller, we leave pclk_edp
> to analogix_dp driver control, and keep the sclk_edp_24m and
> sclk_edp in platform driver.
>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Tested-by: Caesar Wang <wxt@rock-chips.com>

As the cover-letter said, verified on 
https://github.com/Caesar-github/rockchip/tree/veyron/next-stable-chromeos
with linux-next for 20160317.

> ---
> Changes in v14.1:
> - replace rockchip_drm_encoder_get_mux_id with the new
>    drm_of_encoder_active_endpoint_id
>
> Changes in v14: None
> Changes in v13:
> - Use .enable instead of preprare/commit in encoder_helper_funcs (Heiko)
> - Fix the missing parameters with drm_encoder_init() helper function. (Heiko)
>
> Changes in v12: None
> Changes in v11: None
> Changes in v10:
> - Correct the ROCKCHIP_ANALOGIX_DP indentation in Kconfig to tabs here (Heiko)
>
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5:
> - Remove the empty line at the end of document, and correct the endpoint
>    numbers in the example DT node, and remove the regulator iomux setting
>    in driver code while using the pinctl in devicetree instead. (Heiko)
> - Add device type declared, cause the previous "platform device type
>    support (v4 11/16)" already merge into (v5 02/14).
> - Implement connector registration code. (Thierry)
>
> Changes in v4:
> - Remove some deprecated DT properties in rockchip dp document.
>
> Changes in v3:
> - Leave "sclk_edp_24m" to rockchip dp phy driver which name to "24m",
>    and leave "sclk_edp" to analogix dp core driver which name to "dp",
>    and leave "pclk_edp" to rockchip dp platform driver which name to
>    "pclk". (Thierry & Heiko)
> - Add devicetree binding document. (Heiko)
> - Remove "rockchip,panel" DT property, take use of remote point to get panel
>    node. (Heiko)
> - Add the new function point dp_platdata->get_modes() init.
>
> Changes in v2:
> - Get panel node with remote-endpoint method, and create devicetree binding
>    for driver. (Heiko)
> - Remove the clock enable/disbale with "sclk_edp" & "sclk_edp_24m",
>    leave those clock to rockchip dp phy driver.
>
>   drivers/gpu/drm/rockchip/Kconfig                |   9 +
>   drivers/gpu/drm/rockchip/Makefile               |   1 +
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 384 ++++++++++++++++++++++++
>   include/drm/bridge/analogix_dp.h                |   1 +
>   4 files changed, 395 insertions(+)
>   create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 76b3362..d30bdc3 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -16,6 +16,15 @@ config DRM_ROCKCHIP
>   	  2D or 3D acceleration; acceleration is performed by other
>   	  IP found on the SoC.
>   
> +config ROCKCHIP_ANALOGIX_DP
> +	tristate "Rockchip specific extensions for Analogix DP driver"
> +	depends on DRM_ROCKCHIP
> +	select DRM_ANALOGIX_DP
> +	help
> +	  This selects support for Rockchip SoC specific extensions
> +	  for the Analogix Core DP driver. If you want to enable DP
> +	  on RK3288 based SoC, you should selet this option.
> +
>   config ROCKCHIP_DW_HDMI
>           tristate "Rockchip specific extensions for Synopsys DW HDMI"
>           depends on DRM_ROCKCHIP
> diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
> index df8fbef..05d0713 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -6,6 +6,7 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
>   		rockchip_drm_gem.o rockchip_drm_vop.o
>   rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
>   
> +obj-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
>   obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
>   obj-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
>   obj-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> new file mode 100644
> index 0000000..a1d94d8
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -0,0 +1,384 @@
> +/*
> + * Rockchip SoC DP (Display Port) interface driver.
> + *
> + * Copyright (C) Fuzhou Rockchip Electronics Co., Ltd.
> + * Author: Andy Yan <andy.yan@rock-chips.com>
> + *         Yakir Yang <ykk@rock-chips.com>
> + *         Jeff Chen <jeff.chen@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/component.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_graph.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/clk.h>
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_dp_helper.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
> +
> +#include <drm/bridge/analogix_dp.h>
> +
> +#include "rockchip_drm_drv.h"
> +#include "rockchip_drm_vop.h"
> +
> +#define to_dp(nm)	container_of(nm, struct rockchip_dp_device, nm)
> +
> +/* dp grf register offset */
> +#define GRF_SOC_CON6                            0x025c
> +#define GRF_EDP_LCD_SEL_MASK                    BIT(5)
> +#define GRF_EDP_SEL_VOP_LIT                     BIT(5)
> +#define GRF_EDP_SEL_VOP_BIG                     0
> +
> +struct rockchip_dp_device {
> +	struct drm_device        *drm_dev;
> +	struct device            *dev;
> +	struct drm_encoder       encoder;
> +	struct drm_display_mode  mode;
> +
> +	struct clk               *pclk;
> +	struct regmap            *grf;
> +	struct reset_control     *rst;
> +
> +	struct analogix_dp_plat_data plat_data;
> +};
> +
> +static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
> +{
> +	reset_control_assert(dp->rst);
> +	usleep_range(10, 20);
> +	reset_control_deassert(dp->rst);
> +
> +	return 0;
> +}
> +
> +static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
> +{
> +	struct rockchip_dp_device *dp = to_dp(plat_data);
> +	int ret;
> +
> +	ret = clk_prepare_enable(dp->pclk);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "failed to enable pclk %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rockchip_dp_pre_init(dp);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "failed to dp pre init %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
> +{
> +	struct rockchip_dp_device *dp = to_dp(plat_data);
> +
> +	clk_disable_unprepare(dp->pclk);
> +
> +	return 0;
> +}
> +
> +static bool
> +rockchip_dp_drm_encoder_mode_fixup(struct drm_encoder *encoder,
> +				   const struct drm_display_mode *mode,
> +				   struct drm_display_mode *adjusted_mode)
> +{
> +	/* do nothing */
> +	return true;
> +}
> +
> +static void rockchip_dp_drm_encoder_mode_set(struct drm_encoder *encoder,
> +					     struct drm_display_mode *mode,
> +					     struct drm_display_mode *adjusted)
> +{
> +	/* do nothing */
> +}
> +
> +static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct rockchip_dp_device *dp = to_dp(encoder);
> +	int ret;
> +	u32 val;
> +
> +	/*
> +	 * FIXME(Yakir): driver should configure the CRTC output video
> +	 * mode with the display information which indicated the monitor
> +	 * support colorimetry.
> +	 *
> +	 * But don't know why the CRTC driver seems could only output the
> +	 * RGBaaa rightly. For example, if connect the "innolux,n116bge"
> +	 * eDP screen, EDID would indicated that screen only accepted the
> +	 * 6bpc mode. But if I configure CRTC to RGB666 output, then eDP
> +	 * screen would show a blue picture (RGB888 show a green picture).
> +	 * But if I configure CTRC to RGBaaa, and eDP driver still keep
> +	 * RGB666 input video mode, then screen would works prefect.
> +	 */
> +	ret = rockchip_drm_crtc_mode_config(encoder->crtc,
> +					    DRM_MODE_CONNECTOR_eDP,
> +					    ROCKCHIP_OUT_MODE_AAAA);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "Could not set crtc mode config (%d)\n", ret);
> +		return;
> +	}
> +
> +	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
> +	if (ret < 0)
> +		return;
> +
> +	if (ret)
> +		val = GRF_EDP_SEL_VOP_LIT | (GRF_EDP_LCD_SEL_MASK << 16);
> +	else
> +		val = GRF_EDP_SEL_VOP_BIG | (GRF_EDP_LCD_SEL_MASK << 16);
> +
> +	dev_dbg(dp->dev, "vop %s output to dp\n", (ret) ? "LIT" : "BIG");
> +
> +	ret = regmap_write(dp->grf, GRF_SOC_CON6, val);
> +	if (ret != 0) {
> +		dev_err(dp->dev, "Could not write to GRF: %d\n", ret);
> +		return;
> +	}
> +}
> +
> +static void rockchip_dp_drm_encoder_nop(struct drm_encoder *encoder)
> +{
> +	/* do nothing */
> +}
> +
> +static struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {
> +	.mode_fixup = rockchip_dp_drm_encoder_mode_fixup,
> +	.mode_set = rockchip_dp_drm_encoder_mode_set,
> +	.enable = rockchip_dp_drm_encoder_enable,
> +	.disable = rockchip_dp_drm_encoder_nop,
> +};
> +
> +static void rockchip_dp_drm_encoder_destroy(struct drm_encoder *encoder)
> +{
> +	drm_encoder_cleanup(encoder);
> +}
> +
> +static struct drm_encoder_funcs rockchip_dp_encoder_funcs = {
> +	.destroy = rockchip_dp_drm_encoder_destroy,
> +};
> +
> +static int rockchip_dp_init(struct rockchip_dp_device *dp)
> +{
> +	struct device *dev = dp->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> +	if (IS_ERR(dp->grf)) {
> +		dev_err(dev, "failed to get rockchip,grf property\n");
> +		return PTR_ERR(dp->grf);
> +	}
> +
> +	dp->pclk = devm_clk_get(dev, "pclk");
> +	if (IS_ERR(dp->pclk)) {
> +		dev_err(dev, "failed to get pclk property\n");
> +		return PTR_ERR(dp->pclk);
> +	}
> +
> +	dp->rst = devm_reset_control_get(dev, "dp");
> +	if (IS_ERR(dp->rst)) {
> +		dev_err(dev, "failed to get dp reset control\n");
> +		return PTR_ERR(dp->rst);
> +	}
> +
> +	ret = clk_prepare_enable(dp->pclk);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "failed to enable pclk %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rockchip_dp_pre_init(dp);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "failed to pre init %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_dp_drm_create_encoder(struct rockchip_dp_device *dp)
> +{
> +	struct drm_encoder *encoder = &dp->encoder;
> +	struct drm_device *drm_dev = dp->drm_dev;
> +	struct device *dev = dp->dev;
> +	int ret;
> +
> +	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
> +							     dev->of_node);
> +	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
> +
> +	ret = drm_encoder_init(drm_dev, encoder, &rockchip_dp_encoder_funcs,
> +			       DRM_MODE_ENCODER_TMDS, NULL);
> +	if (ret) {
> +		DRM_ERROR("failed to initialize encoder with drm\n");
> +		return ret;
> +	}
> +
> +	drm_encoder_helper_add(encoder, &rockchip_dp_encoder_helper_funcs);
> +
> +	return 0;
> +}
> +
> +static int rockchip_dp_bind(struct device *dev, struct device *master,
> +			    void *data)
> +{
> +	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
> +	struct drm_device *drm_dev = data;
> +	int ret;
> +
> +	/*
> +	 * Just like the probe function said, we don't need the
> +	 * device drvrate anymore, we should leave the charge to
> +	 * analogix dp driver, set the device drvdata to NULL.
> +	 */
> +	dev_set_drvdata(dev, NULL);
> +
> +	ret = rockchip_dp_init(dp);
> +	if (ret < 0)
> +		return ret;
> +
> +	dp->drm_dev = drm_dev;
> +
> +	ret = rockchip_dp_drm_create_encoder(dp);
> +	if (ret) {
> +		DRM_ERROR("failed to create drm encoder\n");
> +		return ret;
> +	}
> +
> +	dp->plat_data.encoder = &dp->encoder;
> +
> +	dp->plat_data.dev_type = RK3288_DP;
> +	dp->plat_data.power_on = rockchip_dp_poweron;
> +	dp->plat_data.power_off = rockchip_dp_powerdown;
> +
> +	return analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
> +}
> +
> +static void rockchip_dp_unbind(struct device *dev, struct device *master,
> +			       void *data)
> +{
> +	return analogix_dp_unbind(dev, master, data);
> +}
> +
> +static const struct component_ops rockchip_dp_component_ops = {
> +	.bind = rockchip_dp_bind,
> +	.unbind = rockchip_dp_unbind,
> +};
> +
> +static int rockchip_dp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *panel_node, *port, *endpoint;
> +	struct rockchip_dp_device *dp;
> +	struct drm_panel *panel;
> +
> +	port = of_graph_get_port_by_id(dev->of_node, 1);
> +	if (!port) {
> +		dev_err(dev, "can't find output port\n");
> +		return -EINVAL;
> +	}
> +
> +	endpoint = of_get_child_by_name(port, "endpoint");
> +	of_node_put(port);
> +	if (!endpoint) {
> +		dev_err(dev, "no output endpoint found\n");
> +		return -EINVAL;
> +	}
> +
> +	panel_node = of_graph_get_remote_port_parent(endpoint);
> +	of_node_put(endpoint);
> +	if (!panel_node) {
> +		dev_err(dev, "no output node found\n");
> +		return -EINVAL;
> +	}
> +
> +	panel = of_drm_find_panel(panel_node);
> +	if (!panel) {
> +		DRM_ERROR("failed to find panel\n");
> +		of_node_put(panel_node);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	of_node_put(panel_node);
> +
> +	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
> +	if (!dp)
> +		return -ENOMEM;
> +
> +	dp->dev = dev;
> +
> +	dp->plat_data.panel = panel;
> +
> +	/*
> +	 * We just use the drvdata until driver run into component
> +	 * add function, and then we would set drvdata to null, so
> +	 * that analogix dp driver could take charge of the drvdata.
> +	 */
> +	platform_set_drvdata(pdev, dp);
> +
> +	return component_add(dev, &rockchip_dp_component_ops);
> +}
> +
> +static int rockchip_dp_remove(struct platform_device *pdev)
> +{
> +	component_del(&pdev->dev, &rockchip_dp_component_ops);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int rockchip_dp_suspend(struct device *dev)
> +{
> +	return analogix_dp_suspend(dev);
> +}
> +
> +static int rockchip_dp_resume(struct device *dev)
> +{
> +	return analogix_dp_resume(dev);
> +}
> +#endif
> +
> +static const struct dev_pm_ops rockchip_dp_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(rockchip_dp_suspend, rockchip_dp_resume)
> +};
> +
> +static const struct of_device_id rockchip_dp_dt_ids[] = {
> +	{.compatible = "rockchip,rk3288-dp",},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_dp_dt_ids);
> +
> +static struct platform_driver rockchip_dp_driver = {
> +	.probe = rockchip_dp_probe,
> +	.remove = rockchip_dp_remove,
> +	.driver = {
> +		   .name = "rockchip-dp",
> +		   .owner = THIS_MODULE,
> +		   .pm = &rockchip_dp_pm_ops,
> +		   .of_match_table = of_match_ptr(rockchip_dp_dt_ids),
> +	},
> +};
> +
> +module_platform_driver(rockchip_dp_driver);
> +
> +MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> +MODULE_AUTHOR("Jeff chen <jeff.chen@rock-chips.com>");
> +MODULE_DESCRIPTION("Rockchip Specific Analogix-DP Driver Extension");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
> index d1188db..25afb31 100644
> --- a/include/drm/bridge/analogix_dp.h
> +++ b/include/drm/bridge/analogix_dp.h
> @@ -15,6 +15,7 @@
>   
>   enum analogix_dp_devtype {
>   	EXYNOS_DP,
> +	RK3288_DP,
>   };
>   
>   struct analogix_dp_plat_data {


-- 
Thanks,
Caesar
