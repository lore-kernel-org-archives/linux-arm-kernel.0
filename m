From: zyw@rock-chips.com (Chris Zhong)
Date: Sat, 10 Oct 2015 17:55:26 +0800
Subject: [PATCH 06/10] drm: rockchip: Support Synopsys DesignWare MIPI DSI
 host controller
In-Reply-To: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
References: <1444470930-17150-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1444470930-17150-7-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Synopsys DesignWare MIPI DSI host controller which is
embedded in the rk3288 SoCs.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

 drivers/gpu/drm/rockchip/Kconfig                |  10 +
 drivers/gpu/drm/rockchip/Makefile               |   1 +
 drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c | 249 ++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c     |   3 +
 4 files changed, 263 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 35215f6..24395f3 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -25,3 +25,13 @@ config ROCKCHIP_DW_HDMI
 	  for the Synopsys DesignWare HDMI driver. If you want to
 	  enable HDMI on RK3288 based SoC, you should selet this
 	  option.
+
+config ROCKCHIP_DW_MIPI_DSI
+	bool "Rockchip specific extensions for Synopsys DW MIPI DSI"
+	depends on DRM_ROCKCHIP
+	select DRM_DW_MIPI_DSI
+	help
+	 This selects support for Rockchip SoC specific extensions
+	 for the Synopsys DesignWare HDMI driver. If you want to
+	 enable MIPI DSI on RK3288 based SoC, you should selet this
+	 option.
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index f3d8a19..6a97059 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -6,5 +6,6 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o rockchip_drm_fbdev.o \
 		rockchip_drm_gem.o
 
 obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
+obj-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw_mipi_dsi_rockchip.o
 
 obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_drm_vop.o
diff --git a/drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c b/drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c
new file mode 100644
index 0000000..a0bb4eb
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c
@@ -0,0 +1,249 @@
+/*
+ * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/component.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/videodev2.h>
+#include <drm/bridge/dw_mipi_dsi.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_of.h>
+
+#include "rockchip_drm_drv.h"
+#include "rockchip_drm_vop.h"
+
+#define DRIVER_NAME	"rockchip-mipi-dsi"
+
+#define GRF_SOC_CON6                    0x025c
+#define DSI0_SEL_VOP_LIT                (1 << 6)
+#define DSI1_SEL_VOP_LIT                (1 << 9)
+
+struct rockchip_mipi_dsi {
+	struct drm_encoder encoder;
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+static inline struct rockchip_mipi_dsi *enc_to_dsi(struct drm_encoder *enc)
+{
+	return container_of(enc, struct rockchip_mipi_dsi, encoder);
+}
+
+static struct drm_encoder_funcs rockchip_mipi_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static int rockchip_mipi_parse_dt(struct rockchip_mipi_dsi *dsi)
+{
+	struct device_node *np = dsi->dev->of_node;
+
+	dsi->regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(dsi->regmap)) {
+		dev_err(dsi->dev, "Unable to get rockchip,grf\n");
+		return PTR_ERR(dsi->regmap);
+	}
+
+	return 0;
+}
+
+static bool rockchip_mipi_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
+					const struct drm_display_mode *mode,
+					struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void rockchip_mipi_dsi_encoder_prepare(struct drm_encoder *encoder)
+{
+	u32 encoder_pix_fmt, interface_pix_fmt;
+
+	encoder_pix_fmt = dw_mipi_dsi_get_encoder_pixel_format(encoder);
+
+	switch (encoder_pix_fmt) {
+	case MIPI_DSI_FMT_RGB888:
+		interface_pix_fmt = ROCKCHIP_OUT_MODE_P888;
+		break;
+	case MIPI_DSI_FMT_RGB666:
+		interface_pix_fmt = ROCKCHIP_OUT_MODE_P666;
+		break;
+	case MIPI_DSI_FMT_RGB565:
+		interface_pix_fmt = ROCKCHIP_OUT_MODE_P565;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_DSI,
+				      interface_pix_fmt);
+}
+
+static void rockchip_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
+					struct drm_display_mode *mode,
+					struct drm_display_mode *adjusted_mode)
+{
+}
+
+static void rockchip_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
+{
+	struct rockchip_mipi_dsi *dsi = enc_to_dsi(encoder);
+	u32 val;
+	int mux  = rockchip_drm_encoder_get_mux_id(dsi->dev->of_node, encoder);
+
+	if (mux)
+		val = DSI0_SEL_VOP_LIT | (DSI0_SEL_VOP_LIT << 16);
+	else
+		val = DSI0_SEL_VOP_LIT << 16;
+
+	regmap_write(dsi->regmap, GRF_SOC_CON6, val);
+	dev_dbg(dsi->dev, "vop %s output to dsi0\n",
+		(mux) ? "LIT" : "BIG");
+}
+
+static void rockchip_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+static struct drm_encoder_helper_funcs
+rockchip_mipi_dsi_encoder_helper_funcs = {
+	.mode_fixup = rockchip_mipi_dsi_encoder_mode_fixup,
+	.prepare = rockchip_mipi_dsi_encoder_prepare,
+	.mode_set = rockchip_mipi_dsi_encoder_mode_set,
+	.commit = rockchip_mipi_dsi_encoder_commit,
+	.disable = rockchip_mipi_dsi_encoder_disable,
+};
+
+static int rockchip_mipi_dsi_register(struct drm_device *drm,
+				      struct rockchip_mipi_dsi *dsi)
+{
+	struct drm_encoder *encoder = &dsi->encoder;
+	struct device *dev = dsi->dev;
+
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm,
+							     dev->of_node);
+	/*
+	 * If we failed to find the CRTC(s) which this encoder is
+	 * supposed to be connected to, it's because the CRTC has
+	 * not been registered yet.  Defer probing, and hope that
+	 * the required CRTC is added later.
+	 */
+	if (encoder->possible_crtcs == 0)
+		return -EPROBE_DEFER;
+
+	drm_encoder_helper_add(&dsi->encoder,
+			       &rockchip_mipi_dsi_encoder_helper_funcs);
+	drm_encoder_init(drm, &dsi->encoder, &rockchip_mipi_dsi_encoder_funcs,
+			 DRM_MODE_ENCODER_DSI);
+	return 0;
+}
+
+static enum drm_mode_status rockchip_mipi_dsi_mode_valid(
+					struct drm_connector *connector,
+					struct drm_display_mode *mode)
+{
+	/*
+	 * The VID_PKT_SIZE field in the DSI_VID_PKT_CFG
+	 * register is 11-bit.
+	 */
+	if (mode->hdisplay > 0x7ff)
+		return MODE_BAD_HVALUE;
+
+	/*
+	 * The V_ACTIVE_LINES field in the DSI_VTIMING_CFG
+	 * register is 11-bit.
+	 */
+	if (mode->vdisplay > 0x7ff)
+		return MODE_BAD_VVALUE;
+
+	return MODE_OK;
+}
+
+static struct dw_mipi_dsi_plat_data rk3288_mipi_dsi_drv_data = {
+	.max_data_lanes = 4,
+	.mode_valid = rockchip_mipi_dsi_mode_valid,
+};
+
+static const struct of_device_id rockchip_mipi_dsi_dt_ids[] = {
+	{
+	 .compatible = "rockchip,rk3288-mipi-dsi",
+	 .data = &rk3288_mipi_dsi_drv_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rockchip_mipi_dsi_dt_ids);
+
+static int rockchip_mipi_dsi_bind(struct device *dev, struct device *master,
+			     void *data)
+{
+	const struct of_device_id *of_id =
+			of_match_device(rockchip_mipi_dsi_dt_ids, dev);
+	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
+	struct drm_device *drm = data;
+	struct rockchip_mipi_dsi *dsi;
+	int ret;
+
+	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
+	if (!dsi)
+		return -ENOMEM;
+
+	dsi->dev = dev;
+
+	ret = rockchip_mipi_dsi_register(drm, dsi);
+	if (ret)
+		return ret;
+
+	ret = rockchip_mipi_parse_dt(dsi);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, dsi);
+
+	return dw_mipi_dsi_bind(dev, master, data, &dsi->encoder, pdata);
+}
+
+static void rockchip_mipi_dsi_unbind(struct device *dev, struct device *master,
+	void *data)
+{
+	return dw_mipi_dsi_unbind(dev, master, data);
+}
+
+static const struct component_ops rockchip_mipi_dsi_ops = {
+	.bind	= rockchip_mipi_dsi_bind,
+	.unbind	= rockchip_mipi_dsi_unbind,
+};
+
+static int rockchip_mipi_dsi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &rockchip_mipi_dsi_ops);
+}
+
+static int rockchip_mipi_dsi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &rockchip_mipi_dsi_ops);
+	return 0;
+}
+
+static struct platform_driver rockchip_mipi_dsi_driver = {
+	.probe		= rockchip_mipi_dsi_probe,
+	.remove		= rockchip_mipi_dsi_remove,
+	.driver		= {
+		.of_match_table = rockchip_mipi_dsi_dt_ids,
+		.name	= DRIVER_NAME,
+	},
+};
+module_platform_driver(rockchip_mipi_dsi_driver);
+
+MODULE_DESCRIPTION("ROCKCHIP MIPI DSI host controller driver");
+MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 9986b311ed..977c17c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1194,6 +1194,9 @@ static int vop_crtc_mode_set(struct drm_crtc *crtc,
 	case DRM_MODE_CONNECTOR_HDMIA:
 		VOP_CTRL_SET(vop, hdmi_en, 1);
 		break;
+	case DRM_MODE_CONNECTOR_DSI:
+		VOP_CTRL_SET(vop, mipi_en, 1);
+		break;
 	default:
 		DRM_ERROR("unsupport connector_type[%d]\n",
 			  vop->connector_type);
-- 
2.6.1
