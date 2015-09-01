From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  1 Sep 2015 14:01:28 +0800
Subject: [PATCH v4 08/16] drm: rockchip/dp: add rockchip platform dp driver
In-Reply-To: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1441087288-25404-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip have three clocks for dp controller, we leave pclk_edp
to analogix_dp driver control, and keep the sclk_edp_24m and
sclk_edp in platform driver.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v4:
- Remove some deprecated DT properties in rockchip dp document.

Changes in v3:
- Take Thierry Reding and Heiko suggest, leave "sclk_edp_24m" to rockchip
  dp phy driver which name to "24m", and leave "sclk_edp" to analogix dp
  core driver which name to "dp", and leave "pclk_edp" to rockchip dp platform
  driver which name to "pclk".
- Take Heiko suggest, add devicetree binding document.
- Take Heiko suggest, remove "rockchip,panel" DT property, take use of remote
  point to get panel node.
- Add the new function point analogix_dp_platdata.get_modes init.

Changes in v2:
- Take Heiko suggest, get panel node with remote-endpoint method,
  and create devicetree binding for driver.
- Remove the clock enable/disbale with "sclk_edp" & "sclk_edp_24m",
  leave those clock to rockchip dp phy driver.

 .../bindings/video/analogix_dp-rockchip.txt        |  74 ++++
 drivers/gpu/drm/rockchip/Kconfig                   |   9 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 389 +++++++++++++++++++++
 4 files changed, 473 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
 create mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c

diff --git a/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
new file mode 100644
index 0000000..502483e
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
@@ -0,0 +1,74 @@
+Rockchip RK3288 specific extensions to the Analogix Display Port
+================================
+
+Required properties:
+- compatible: "rockchip,rk3288-edp";
+
+- reg: physical base address of the controller and length
+
+- clocks: from common clock binding: handle to dp clock.
+	  of memory mapped region.
+
+- clock-names: from common clock binding:
+	       Required elements: "dp" "pclk"
+
+- resets: Must contain an entry for each entry in reset-names.
+	  See ../reset/reset.txt for details.
+
+- reset-names: Must include the name "dp"
+
+- rockchip,grf: this soc should set GRF regs, so need get grf here.
+
+- ports: contain a port node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+
+For the below properties, please refer to Analogix DP binding document:
+ * Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
+- phys (required)
+- phy-names (required)
+- hpd-gpios (optional)
+-------------------------------------------------------------------------------
+
+Example:
+	dp-controller: dp at ff970000 {
+		compatible = "rockchip,rk3288-dp";
+		reg = <0xff970000 0x4000>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		phys = <&dp_phy>;
+		phy-names = "dp";
+
+		rockchip,grf = <&grf>;
+		resets = <&cru 111>;
+		reset-names = "dp";
+
+		status = "disabled";
+
+		ports {
+			edp_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				edp_in_vopb: endpoint at 0 {
+					reg = <0>;
+					remote-endpoint = <&vopb_out_edp>;
+				};
+				edp_in_vopl: endpoint at 1 {
+					reg = <1>;
+					remote-endpoint = <&vopl_out_edp>;
+				};
+			};
+
+			edp_out: port at 1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				edp_out_panel: endpoint {
+					reg = <0>;
+					remote-endpoint = <&panel_in_edp>
+				};
+			};
+		};
+	};
+
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 35215f6..c2ba945 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -25,3 +25,12 @@ config ROCKCHIP_DW_HDMI
 	  for the Synopsys DesignWare HDMI driver. If you want to
 	  enable HDMI on RK3288 based SoC, you should selet this
 	  option.
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
index 0000000..cebff9e
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -0,0 +1,389 @@
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
+#include <linux/mfd/syscon.h>
+#include <linux/of_graph.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/clk.h>
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
+#define GRF_GPIO7B_IOMUX                        0x0070
+#define GPIO7B3_SEL_MASK                        (0x03 << 6)
+#define GPIO7B3_SEL_EDP_HOTPLUG                 BIT(7)
+
+#define GRF_SOC_CON6                            0x025c
+#define GRF_EDP_LCD_SEL_MASK                    BIT(5)
+#define GRF_EDP_SEL_VOP_LIT                     BIT(5)
+#define GRF_EDP_SEL_VOP_BIG                     0
+
+struct rockchip_dp_device {
+	struct drm_device        *drm_dev;
+	struct device            *dev;
+	struct drm_encoder       encoder;
+	struct drm_display_mode  mode;
+
+	struct clk               *pclk;
+	struct regmap            *grf;
+	struct reset_control     *rst;
+
+	struct analogix_dp_plat_data plat_data;
+};
+
+static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
+{
+	u32 val;
+	int ret;
+
+	val = GPIO7B3_SEL_EDP_HOTPLUG | (GPIO7B3_SEL_MASK << 16);
+	ret = regmap_write(dp->grf, GRF_GPIO7B_IOMUX, val);
+	if (ret != 0) {
+		dev_err(dp->dev, "Could not config GRF edp hpd: %d\n", ret);
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
+	ret = clk_prepare_enable(dp->pclk);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to enable pclk %d\n", ret);
+		return ret;
+	}
+
+	ret = rockchip_dp_pre_init(dp);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to dp pre init %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
+{
+	struct rockchip_dp_device *dp = plat_data_to_dp(plat_data);
+
+	clk_disable_unprepare(dp->pclk);
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
+		val = GRF_EDP_SEL_VOP_LIT | (GRF_EDP_LCD_SEL_MASK << 16);
+	else
+		val = GRF_EDP_SEL_VOP_BIG | (GRF_EDP_LCD_SEL_MASK << 16);
+
+	dev_dbg(dp->dev, "vop %s output to dp\n", (ret) ? "LIT" : "BIG");
+
+	ret = regmap_write(dp->grf, GRF_SOC_CON6, val);
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
+		dev_err(dev, "failed to get rockchip,grf property\n");
+		return PTR_ERR(dp->grf);
+	}
+
+	dp->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(dp->pclk)) {
+		dev_err(dev, "failed to get pclk property\n");
+		return PTR_ERR(dp->pclk);
+	}
+
+	dp->rst = devm_reset_control_get(dev, "dp");
+	if (IS_ERR(dp->rst)) {
+		dev_err(dev, "failed to get dp reset control\n");
+		return PTR_ERR(dp->rst);
+	}
+
+	ret = clk_prepare_enable(dp->pclk);
+	if (ret < 0) {
+		dev_err(dp->dev, "failed to enable pclk %d\n", ret);
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
+	dp->plat_data.get_modes = NULL;
+	dp->plat_data.power_on = rockchip_dp_poweron;
+	dp->plat_data.power_off = rockchip_dp_powerdown;
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
+	struct device_node *panel_node, *port, *endpoint;
+	struct rockchip_dp_device *dp;
+	struct drm_panel *panel;
+
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
+	if (!panel_node) {
+		dev_err(dev, "no output node found\n");
+		return -EINVAL;
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
2.1.2
