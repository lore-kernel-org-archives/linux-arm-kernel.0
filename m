From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 08 Aug 2015 00:46:20 +0200
Subject: [PATCH v2 4/8] drm: rockchip/dp: add rockchip platform dp driver
In-Reply-To: <1438944380-18897-1-git-send-email-ykk@rock-chips.com>
References: <1438943674-18191-1-git-send-email-ykk@rock-chips.com>
 <1438944380-18897-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1730542.s7otqjtiXD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,


I think this Rockchip portion is missing a devicetree binding.

You have the ability to power down the actual edp phy by using
grf_edp_iddq_en from GRF_SOC_CON12. This is similar to how the
rk3288 usb-phy gets put into a deeper state. So maybe you could
provide a phy driver (drivers/phy) for this similar to what the
exynos-dp does.

Some more stuff inline. But I guess by no means complete, as I'm
still trying to integrate this into my development-tree.


Am Freitag, 7. August 2015, 05:46:20 schrieb Yakir Yang:
> Rockchip have three clocks for dp controller, we leave pclk_edp
> to analogix_dp driver control, and keep the sclk_edp_24m and
> sclk_edp in platform driver.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v2: None
> 
>  drivers/gpu/drm/rockchip/Kconfig                |  10 +
>  drivers/gpu/drm/rockchip/Makefile               |   1 +
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 419
> ++++++++++++++++++++++++ 3 files changed, 430 insertions(+)
>  create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig
> b/drivers/gpu/drm/rockchip/Kconfig index 35215f6..096ed77 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -25,3 +25,13 @@ config ROCKCHIP_DW_HDMI
>  	  for the Synopsys DesignWare HDMI driver. If you want to
>  	  enable HDMI on RK3288 based SoC, you should selet this
>  	  option.
> +
> +

nit: double blank line

> +config ROCKCHIP_ANALOGIX_DP
> +        tristate "Rockchip specific extensions for Analogix DP driver"
> +        depends on DRM_ROCKCHIP
> +        select DRM_ANALOGIX_DP
> +        help
> +	  This selects support for Rockchip SoC specific extensions
> +	  for the Analogix Core DP driver. If you want to enable DP
> +	  on RK3288 based SoC, you should selet this option.

[...]


> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c new file mode 100644
> index 0000000..2f86e5e
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -0,0 +1,419 @@
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
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_dp_helper.h>
> +
> +#include <linux/component.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
> +
> +#include <drm/bridge/analogix_dp.h>
> +
> +#include "rockchip_drm_drv.h"
> +#include "rockchip_drm_vop.h"
> +
> +#define encoder_to_dp(c) \
> +		container_of(c, struct rockchip_dp_device, encoder)
> +
> +#define plat_data_to_dp(pd) \
> +		container_of(pd, struct rockchip_dp_device, plat_data)
> +
> +/* dp grf register offset */
> +#define DP_VOP_SEL                              0x025c /* grf_soc_con6 */
> +#define DP_REF_CLK_SEL                          0x0274 /* grf_soc_con12 */
> +
> +#define GRF_DP_REF_CLK_SEL_INTER                BIT(4)
> +#define DP_SEL_VOP_LIT				BIT(5)
> +
> +struct rockchip_dp_device {
> +	struct drm_device        *drm_dev;
> +	struct device            *dev;
> +	struct drm_encoder       encoder;
> +	struct drm_display_mode  mode;
> +
> +	struct clk               *clk_dp;
> +	struct clk               *clk_24m_parent;

this clk_24m_parent does not seem used at all

> +	struct clk               *clk_24m;
> +	struct regmap            *grf;
> +	struct reset_control     *rst;
> +
> +	struct analogix_dp_plat_data plat_data;
> +};
> +

[...]

> +static int rockchip_dp_init(struct rockchip_dp_device *dp)
> +{
> +	struct device *dev = dp->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> +	if (IS_ERR(dp->grf)) {
> +		dev_err(dev,
> +			"rk3288-dp needs rockchip,grf property\n");
> +		return PTR_ERR(dp->grf);
> +	}
> +
> +	dp->clk_dp = devm_clk_get(dev, "clk_dp");

I've looked at the manual, but couldn't find an actual clock-name
used there. Is it really "clk_dp" or should it just be "dp"?


> +	if (IS_ERR(dp->clk_dp)) {
> +		dev_err(dev, "cannot get clk_dp\n");
> +		return PTR_ERR(dp->clk_dp);
> +	}
> +
> +	dp->clk_24m = devm_clk_get(dev, "clk_dp_24m");

Same here, maybe "dp_24m".


> +	if (IS_ERR(dp->clk_24m)) {
> +		dev_err(dev, "cannot get clk_dp_24m\n");
> +		return PTR_ERR(dp->clk_24m);
> +	}

I think you're missing the pclk here (PCLK_EDP_CTRL) or is this part of
something else?



> +
> +	dp->rst = devm_reset_control_get(dev, "dp");
> +	if (IS_ERR(dp->rst)) {
> +		dev_err(dev, "failed to get reset\n");
> +		return PTR_ERR(dp->rst);
> +	}
> +
> +	ret = rockchip_dp_clk_enable(dp);
> +	if (ret < 0) {
> +		dev_err(dp->dev, "cannot enable dp clk %d\n", ret);
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

[...]

> +static int rockchip_dp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *panel_node;
> +	struct rockchip_dp_device *dp;
> +	struct drm_panel *panel;
> +
> +	panel_node = of_parse_phandle(dev->of_node, "rockchip,panel", 0);
> +	if (!panel_node) {
> +		DRM_ERROR("failed to find rockchip,panel dt node\n");
> +		return -ENODEV;
> +	}

Personally I would prefer to continue with the of-graph framework to
attach the panel instead of defining a special node. But I'm not
authorative on this. But that way the dts could then look like [0].

I've sucessfully modified the driver currently in use in Chromeos for my
dev-tree and have ported this change over onto your driver [1].


[0] https://github.com/mmind/linux-rockchip/blob/devel/somewhat-stable/arch/arm/boot/dts/rk3288-veyron-edp.dtsi#L76
[1]
---------- 8< -------------
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index e7cf9ab..24e872d 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -20,6 +20,7 @@
 #include <linux/component.h>
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of_graph.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -335,14 +336,28 @@ static const struct component_ops rockchip_dp_component_ops = {
 static int rockchip_dp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *panel_node;
+	struct device_node *panel_node, *port, *endpoint;
 	struct rockchip_dp_device *dp;
 	struct drm_panel *panel;
 
-	panel_node = of_parse_phandle(dev->of_node, "rockchip,panel", 0);
+	port = of_graph_get_port_by_id(dev->of_node, 1);
+	if (!port) {
+		dev_err(dev, "can't find output port\n");
+		return -EINVAL;
+	}
+
+	endpoint = of_get_child_by_name(port, "endpoint");
+	of_node_put(port);
+	if (!endpoint) {
+		dev_err(dev, "no output endpoint found\n");
+		return -EINVAL;
+	}
+
+	panel_node = of_graph_get_remote_port_parent(endpoint);
+	of_node_put(endpoint);
 	if (!panel_node) {
-		DRM_ERROR("failed to find rockchip,panel dt node\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "no output node found\n");
+		return -EINVAL;
 	}
 
 	panel = of_drm_find_panel(panel_node);
---------- 8< -------------
