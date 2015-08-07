From: ykk@rock-chips.com (Yakir Yang)
Date: Fri,  7 Aug 2015 05:46:20 -0500
Subject: [PATCH v2 4/8] drm: rockchip/dp: add rockchip platform dp driver
In-Reply-To: <1438943674-18191-1-git-send-email-ykk@rock-chips.com>
References: <1438943674-18191-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1438944380-18897-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip have three clocks for dp controller, we leave pclk_edp
to analogix_dp driver control, and keep the sclk_edp_24m and
sclk_edp in platform driver.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v2: None

 drivers/gpu/drm/rockchip/Kconfig                |  10 +
 drivers/gpu/drm/rockchip/Makefile               |   1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 419 ++++++++++++++++++++++++
 3 files changed, 430 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 35215f6..096ed77 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -25,3 +25,13 @@ config ROCKCHIP_DW_HDMI
 	  for the Synopsys DesignWare HDMI driver. If you want to
 	  enable HDMI on RK3288 based SoC, you should selet this
 	  option.
+
+
+config ROCKCHIP_ANALOGIX_DP
+        tristate "Rockchip specific extensions for Analogix DP driver"
+        depends on DRM_ROCKCHIP
+        select DRM_ANALOGIX_DP
+        help
+	  This selects support for Rockchip SoC specific extensions
+	  for the Analogix Core DP driver. If you want to enable DP
+	  on RK3288 based SoC, you should selet this option.
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index f3d8a19..8ad01fb 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -6,5 +6,6 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o rockchip_drm_fbdev.o \
 		rockchip_drm_gem.o
 
 obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
+obj-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
 
 obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_drm_vop.o
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
new file mode 100644
index 0000000..2f86e5e
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -0,0 +1,419 @@
+/*
+ * Rockchip SoC DP (Display Port) interface driver.
+ *
+ * Copyright (C) Fuzhou Rockchip Electronics Co., Ltd.
+ * Author: Andy Yan <andy.yan@rock-chips.com>
+ *         Yakir Yang <ykk@rock-chips.com>
+ *         Jeff Chen <jeff.chen@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_of.h>
+#include <drm/drm_dp_helper.h>
+
+#include <linux/component.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <video/of_videomode.h>
+#include <video/videomode.h>
+
+#include <drm/bridge/analogix_dp.h>
+
+#include "rockchip_drm_drv.h"
+#include "rockchip_drm_vop.h"
+
+#define encoder_to_dp(c) \
+		container_of(c, struct rockchip_dp_device, encoder)
+
+#define plat_data_to_dp(pd) \
+		container_of(pd, struct rockchip_dp_device, plat_data)
+
+/* dp grf register offset */
+#define DP_VOP_SEL                              0x025c /* grf_soc_con6 */
+#define DP_REF_CLK_SEL                          0x0274 /* grf_soc_con12 */
+
+#define GRF_DP_REF_CLK_SEL_INTER                BIT(4)
+#define DP_SEL_VOP_LIT				BIT(5)
+
+struct rockchip_dp_device {
+	struct drm_device        *drm_dev;
+	struct device            *dev;
+	struct drm_encoder       encoder;
+	struct drm_display_mode  mode;
+
+	struct clk               *clk_dp;
+	struct clk               *clk_24m_parent;
+	struct clk               *clk_24m;
+	struct regmap            *grf;
+	struct reset_control     *rst;
+
+	struct analogix_dp_plat_data plat_data;
+};
+
+static int rockchip_dp_clk_enable(struct rockchip_dp_device *dp)
+{
+	int ret = 0;
+
+	ret = clk_prepare_enable(dp->clk_dp);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot enable clk_dp %d\n", ret);
+		goto err_clk_dp;
+	}
+
+	ret = clk_set_rate(dp->clk_24m, 24000000);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot set dp clk_24m %d\n",
+			ret);
+		goto err_clk_24m;
+	}
+
+	ret = clk_prepare_enable(dp->clk_24m);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot enable dp clk_24m %d\n",
+			ret);
+		goto err_clk_24m;
+	}
+
+	return 0;
+
+err_clk_24m:
+	clk_disable_unprepare(dp->clk_dp);
+err_clk_dp:
+	return ret;
+}
+
+static int rockchip_dp_clk_disable(struct rockchip_dp_device *dp)
+{
+	clk_disable_unprepare(dp->clk_dp);
+	clk_disable_unprepare(dp->clk_24m);
+
+	return 0;
+}
+
+static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
+{
+	u32 val;
+	int ret;
+
+	val = GRF_DP_REF_CLK_SEL_INTER | (GRF_DP_REF_CLK_SEL_INTER << 16);
+	ret = regmap_write(dp->grf, DP_REF_CLK_SEL, val);
+	if (ret != 0) {
+		dev_err(dp->dev, "Could not write to GRF: %d\n", ret);
+		return ret;
+	}
+
+	reset_control_assert(dp->rst);
+	usleep_range(10, 20);
+	reset_control_deassert(dp->rst);
+
+	return 0;
+}
+
+static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
+{
+	struct rockchip_dp_device *dp = plat_data_to_dp(plat_data);
+	int ret;
+
+	ret = rockchip_dp_clk_enable(dp);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot enable dp clk %d\n", ret);
+		return -1;
+	}
+
+	ret = rockchip_dp_pre_init(dp);
+	if (ret < 0) {
+		dev_err(dp->dev, "dp pre init fail %d\n", ret);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int rockchip_dp_poweroff(struct analogix_dp_plat_data *plat_data)
+{
+	struct rockchip_dp_device *dp = plat_data_to_dp(plat_data);
+
+	rockchip_dp_clk_disable(dp);
+
+	return 0;
+}
+
+static bool
+rockchip_dp_drm_encoder_mode_fixup(struct drm_encoder *encoder,
+				   const struct drm_display_mode *mode,
+				   struct drm_display_mode *adjusted_mode)
+{
+	/* do nothing */
+	return true;
+}
+
+static void rockchip_dp_drm_encoder_mode_set(struct drm_encoder *encoder,
+					     struct drm_display_mode *mode,
+					     struct drm_display_mode *adjusted)
+{
+	/* do nothing */
+}
+
+static void rockchip_dp_drm_encoder_prepare(struct drm_encoder *encoder)
+{
+	struct rockchip_dp_device *dp = encoder_to_dp(encoder);
+	u32 val;
+	int ret;
+
+	ret = rockchip_drm_crtc_mode_config(encoder->crtc,
+					    DRM_MODE_CONNECTOR_eDP,
+					    ROCKCHIP_OUT_MODE_AAAA);
+	if (ret < 0) {
+		dev_err(dp->dev, "Could not set crtc mode config: %d.\n", ret);
+		return;
+	}
+
+	ret = rockchip_drm_encoder_get_mux_id(dp->dev->of_node, encoder);
+	if (ret < 0)
+		return;
+
+	if (ret)
+		val = DP_SEL_VOP_LIT | (DP_SEL_VOP_LIT << 16);
+	else
+		val = DP_SEL_VOP_LIT << 16;
+
+	dev_info(dp->dev, "vop %s output to dp\n", (ret) ? "LIT" : "BIG");
+
+	ret = regmap_write(dp->grf, DP_VOP_SEL, val);
+	if (ret != 0) {
+		dev_err(dp->dev, "Could not write to GRF: %d\n", ret);
+		return;
+	}
+}
+
+static void rockchip_dp_drm_encoder_nop(struct drm_encoder *encoder)
+{
+	/* do nothing */
+}
+
+static struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {
+	.mode_fixup = rockchip_dp_drm_encoder_mode_fixup,
+	.mode_set = rockchip_dp_drm_encoder_mode_set,
+	.prepare = rockchip_dp_drm_encoder_prepare,
+	.commit = rockchip_dp_drm_encoder_nop,
+	.disable = rockchip_dp_drm_encoder_nop,
+};
+
+static void rockchip_dp_drm_encoder_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+}
+
+static struct drm_encoder_funcs rockchip_dp_encoder_funcs = {
+	.destroy = rockchip_dp_drm_encoder_destroy,
+};
+
+static int rockchip_dp_init(struct rockchip_dp_device *dp)
+{
+	struct device *dev = dp->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(dp->grf)) {
+		dev_err(dev,
+			"rk3288-dp needs rockchip,grf property\n");
+		return PTR_ERR(dp->grf);
+	}
+
+	dp->clk_dp = devm_clk_get(dev, "clk_dp");
+	if (IS_ERR(dp->clk_dp)) {
+		dev_err(dev, "cannot get clk_dp\n");
+		return PTR_ERR(dp->clk_dp);
+	}
+
+	dp->clk_24m = devm_clk_get(dev, "clk_dp_24m");
+	if (IS_ERR(dp->clk_24m)) {
+		dev_err(dev, "cannot get clk_dp_24m\n");
+		return PTR_ERR(dp->clk_24m);
+	}
+
+	dp->rst = devm_reset_control_get(dev, "dp");
+	if (IS_ERR(dp->rst)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(dp->rst);
+	}
+
+	ret = rockchip_dp_clk_enable(dp);
+	if (ret < 0) {
+		dev_err(dp->dev, "cannot enable dp clk %d\n", ret);
+		return ret;
+	}
+
+	ret = rockchip_dp_pre_init(dp);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to pre init %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rockchip_dp_drm_create_encoder(struct rockchip_dp_device *dp)
+{
+	struct drm_encoder *encoder = &dp->encoder;
+	struct drm_device *drm_dev = dp->drm_dev;
+	struct device *dev = dp->dev;
+	int ret;
+
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
+							     dev->of_node);
+	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
+
+	ret = drm_encoder_init(drm_dev, encoder, &rockchip_dp_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS);
+	if (ret) {
+		DRM_ERROR("failed to initialize encoder with drm\n");
+		return ret;
+	}
+
+	drm_encoder_helper_add(encoder, &rockchip_dp_encoder_helper_funcs);
+
+	return 0;
+}
+
+static int rockchip_dp_bind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
+	struct drm_device *drm_dev = data;
+	int ret;
+
+	/*
+	 * Just like the probe function said, we don't need the
+	 * device drvrate anymore, we should leave the charge to
+	 * analogix dp driver, set the device drvdata to NULL.
+	 */
+	dev_set_drvdata(dev, NULL);
+
+	ret = rockchip_dp_init(dp);
+	if (ret < 0)
+		return ret;
+
+	dp->drm_dev = drm_dev;
+
+	ret = rockchip_dp_drm_create_encoder(dp);
+	if (ret) {
+		DRM_ERROR("failed to create drm encoder\n");
+		return ret;
+	}
+
+	dp->plat_data.attach = NULL;
+	dp->plat_data.power_on = rockchip_dp_poweron;
+	dp->plat_data.power_off = rockchip_dp_poweroff;
+
+	return analogix_dp_bind(dev, dp->drm_dev, &dp->encoder,
+				&dp->plat_data);
+}
+
+static void rockchip_dp_unbind(struct device *dev, struct device *master,
+			       void *data)
+{
+	return analogix_dp_unbind(dev, master, data);
+}
+
+static const struct component_ops rockchip_dp_component_ops = {
+	.bind = rockchip_dp_bind,
+	.unbind = rockchip_dp_unbind,
+};
+
+static int rockchip_dp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *panel_node;
+	struct rockchip_dp_device *dp;
+	struct drm_panel *panel;
+
+	panel_node = of_parse_phandle(dev->of_node, "rockchip,panel", 0);
+	if (!panel_node) {
+		DRM_ERROR("failed to find rockchip,panel dt node\n");
+		return -ENODEV;
+	}
+
+	panel = of_drm_find_panel(panel_node);
+	if (!panel) {
+		DRM_ERROR("failed to find panel\n");
+		of_node_put(panel_node);
+		return -EPROBE_DEFER;
+	}
+
+	of_node_put(panel_node);
+
+	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
+	if (!dp)
+		return -ENOMEM;
+
+	dp->dev = dev;
+
+	dp->plat_data.panel = panel;
+
+	/*
+	 * We just use the drvdata until driver run into component
+	 * add function, and then we would set drvdata to null, so
+	 * that analogix dp driver could take charge of the drvdata.
+	 */
+	platform_set_drvdata(pdev, dp);
+
+	return component_add(dev, &rockchip_dp_component_ops);
+}
+
+static int rockchip_dp_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &rockchip_dp_component_ops);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int rockchip_dp_suspend(struct device *dev)
+{
+	return analogix_dp_suspend(dev);
+}
+
+static int rockchip_dp_resume(struct device *dev)
+{
+	return analogix_dp_resume(dev);
+}
+#endif
+
+static const struct dev_pm_ops rockchip_dp_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(rockchip_dp_suspend, rockchip_dp_resume)
+};
+
+static const struct of_device_id rockchip_dp_dt_ids[] = {
+	{.compatible = "rockchip,rk3288-dp",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, rockchip_dp_dt_ids);
+
+static struct platform_driver rockchip_dp_driver = {
+	.probe = rockchip_dp_probe,
+	.remove = rockchip_dp_remove,
+	.driver = {
+		   .name = "rockchip-dp",
+		   .owner = THIS_MODULE,
+		   .pm = &rockchip_dp_pm_ops,
+		   .of_match_table = of_match_ptr(rockchip_dp_dt_ids),
+	},
+};
+
+module_platform_driver(rockchip_dp_driver);
+
+MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
+MODULE_AUTHOR("Jeff chen <jeff.chen@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip Specific Analogix-DP Driver Extension");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
