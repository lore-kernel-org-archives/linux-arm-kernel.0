From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 23 Dec 2014 11:46:33 +0800
Subject: [PATCH RFC v3 12/18] drm: imx: Support Synopsys DesignWare MIPI DSI
 host controller
In-Reply-To: <1419306399-9387-1-git-send-email-Ying.Liu@freescale.com>
References: <1419306399-9387-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1419306399-9387-13-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Synopsys DesignWare MIPI DSI host controller
which is embedded in the i.MX6q/sdl SoCs.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v2->v3:
 * To address Andy Yan's comments, move the common Synopsys DesignWare MIPI DSI
   host controller logic into it's drm/bridge driver and leave the i.MX specific
   logic only.

v1->v2:
 * Address almost all comments from Thierry Reding and Russell.
 * Update the DT documentation to remove the display-timings node in the panel node.
 * Update the DT documentation to state that the nodes which represent the possible
   DRM CRTCs the controller may connect with should be placed in the node "ports".
 * Remove the flag 'enabled' from the struct imx_mipi_dsi.
 * Move the format_to_bpp() function in v1 to the common DRM MIPI DSI driver.
 * Improve the way we wait for check status for DPHY and command packet transfer.
 * Improve the DPMS support for the encoder.
 * Split the functions of ->host_attach() and ->mode_valid() clearly as suggested by
   Thierry Reding.
 * Improve the logics in imx_mipi_dsi_dcs_long_write().
 * Enable/disable the pllref_clk and pllref_gate_clk at the component binding/unbinding
   stages to help remove the flag 'enabled'.
 * Update the module license to be "GPL".
 * Other minor changes, such as coding style issues and macro naming issues.

 .../devicetree/bindings/drm/imx/mipi_dsi.txt       |  75 +++++++
 drivers/gpu/drm/imx/Kconfig                        |   7 +
 drivers/gpu/drm/imx/Makefile                       |   1 +
 drivers/gpu/drm/imx/dw_mipi_dsi-imx.c              | 226 +++++++++++++++++++++
 4 files changed, 309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt
 create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx.c

diff --git a/Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt b/Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt
new file mode 100644
index 0000000..93cc4ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt
@@ -0,0 +1,75 @@
+i.MX specific Device-Tree bindings for Synopsys DesignWare MIPI DSI host controller
+
+MIPI DSI host controller
+========================
+
+The MIPI DSI host controller is a Synopsys DesignWare IP.
+The common device tree documentation for this controller can be found
+at [1].
+
+Required properties:
+ - #address-cells: Should be <1>.
+ - #size-cells: Should be <0>.
+ - compatible: The compatible string should be "fsl,imx6q-mipi-dsi"
+   for i.MX6q/sdl SoCs.
+ - reg: Physical base address of the controller and length of memory
+   mapped region.
+ - interrupts: The controller's interrupt number to the CPU(s).
+ - gpr: Should be <&gpr>.
+   The phandle points to the iomuxc-gpr region containing the
+   multiplexer control register for the controller.
+ - clocks, clock-names: Phandles to the controller pllref, pllref_gate
+   and core_cfg clocks, as described in [2] and [3].
+
+Required sub-nodes:
+ - ports: This node may contain up to four port nodes with endpoint
+   definitions as defined in [4], corresponding to the four inputs to
+   the controller multiplexer.
+ - A node to represent a DSI peripheral as described in [5].
+
+[1] Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt.
+[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[3] Documentation/devicetree/bindings/clock/imx6q-clock.txt
+[4] Documentation/devicetree/bindings/media/video-interfaces.txt
+[5] Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt
+
+example:
+	gpr: iomuxc-gpr at 020e0000 {
+		/* ... */
+	};
+
+	mipi_dsi: mipi at 021e0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,imx6q-mipi-dsi";
+		reg = <0x021e0000 0x4000>;
+		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+		gpr = <&gpr>;
+		clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
+			 <&clks IMX6QDL_CLK_MIPI_CORE_CFG>;
+		clock-names = "pllref", "core_cfg";
+
+		ports {
+			port at 0 {
+				reg = <0>;
+
+				mipi_mux_0: endpoint {
+					remote-endpoint = <&ipu1_di0_mipi>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				mipi_mux_1: endpoint {
+					remote-endpoint = <&ipu1_di1_mipi>;
+				};
+			};
+		};
+
+		panel {
+			compatible = "truly,tft480800-16-e-dsi";
+			reg = <0>;
+			/* ... */
+		};
+	};
diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
index 82fb758..c576f6b 100644
--- a/drivers/gpu/drm/imx/Kconfig
+++ b/drivers/gpu/drm/imx/Kconfig
@@ -51,3 +51,10 @@ config DRM_IMX_HDMI
 	depends on DRM_IMX
 	help
 	  Choose this if you want to use HDMI on i.MX6.
+
+config DRM_IMX_MIPI_DSI
+	tristate "Freescale i.MX DRM MIPI DSI"
+	select DRM_DW_MIPI_DSI
+	depends on DRM_IMX
+	help
+	  Choose this if you want to use MIPI DSI on i.MX6.
diff --git a/drivers/gpu/drm/imx/Makefile b/drivers/gpu/drm/imx/Makefile
index 582c438..f0dc278 100644
--- a/drivers/gpu/drm/imx/Makefile
+++ b/drivers/gpu/drm/imx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_DRM_IMX_LDB) += imx-ldb.o
 imx-ipuv3-crtc-objs  := ipuv3-crtc.o ipuv3-plane.o
 obj-$(CONFIG_DRM_IMX_IPUV3)	+= imx-ipuv3-crtc.o
 obj-$(CONFIG_DRM_IMX_HDMI) += imx-hdmi.o
+obj-$(CONFIG_DRM_IMX_MIPI_DSI) += dw_mipi_dsi-imx.o
diff --git a/drivers/gpu/drm/imx/dw_mipi_dsi-imx.c b/drivers/gpu/drm/imx/dw_mipi_dsi-imx.c
new file mode 100644
index 0000000..5f5196b
--- /dev/null
+++ b/drivers/gpu/drm/imx/dw_mipi_dsi-imx.c
@@ -0,0 +1,226 @@
+/*
+ * i.MX drm driver - MIPI DSI Host Controller
+ *
+ * Copyright (C) 2011-2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include <linux/component.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/videodev2.h>
+#include <drm/bridge/dw_mipi_dsi.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_mipi_dsi.h>
+
+#include "imx-drm.h"
+
+#define DRIVER_NAME 			"imx-mipi-dsi"
+
+struct imx_mipi_dsi {
+	struct drm_encoder encoder;
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+static inline struct imx_mipi_dsi *enc_to_dsi(struct drm_encoder *enc)
+{
+	return container_of(enc, struct imx_mipi_dsi, encoder);
+}
+
+static void imx_mipi_dsi_set_ipu_di_mux(struct imx_mipi_dsi *dsi, int ipu_di)
+{
+	regmap_update_bits(dsi->regmap, IOMUXC_GPR3,
+			   IMX6Q_GPR3_MIPI_MUX_CTL_MASK,
+			   ipu_di << IMX6Q_GPR3_MIPI_MUX_CTL_SHIFT);
+}
+
+static struct drm_encoder_funcs imx_mipi_dsi_encoder_funcs = {
+	.destroy = imx_drm_encoder_destroy,
+};
+
+static bool imx_mipi_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
+					    const struct drm_display_mode *mode,
+					    struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void imx_mipi_dsi_encoder_prepare(struct drm_encoder *encoder)
+{
+	u32 encoder_pix_fmt, interface_pix_fmt;
+
+	encoder_pix_fmt = dw_mipi_dsi_get_encoder_pixel_format(encoder);
+
+	switch (encoder_pix_fmt) {
+	case MIPI_DSI_FMT_RGB888:
+		interface_pix_fmt = V4L2_PIX_FMT_RGB24;
+		break;
+	case MIPI_DSI_FMT_RGB565:
+		interface_pix_fmt = V4L2_PIX_FMT_RGB565;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	imx_drm_panel_format(encoder, interface_pix_fmt);
+}
+
+static void imx_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
+					  struct drm_display_mode *mode,
+					  struct drm_display_mode *adjusted_mode)
+{
+}
+
+static void imx_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
+{
+	struct imx_mipi_dsi *dsi = enc_to_dsi(encoder);
+	int mux = imx_drm_encoder_get_mux_id(dsi->dev->of_node, encoder);
+
+	imx_mipi_dsi_set_ipu_di_mux(dsi, mux);
+}
+
+static void imx_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+static struct drm_encoder_helper_funcs imx_mipi_dsi_encoder_helper_funcs = {
+	.mode_fixup = imx_mipi_dsi_encoder_mode_fixup,
+	.prepare = imx_mipi_dsi_encoder_prepare,
+	.mode_set = imx_mipi_dsi_encoder_mode_set,
+	.commit = imx_mipi_dsi_encoder_commit,
+	.disable = imx_mipi_dsi_encoder_disable,
+};
+
+static int imx_mipi_dsi_register(struct drm_device *drm, struct imx_mipi_dsi *dsi)
+{
+	int ret;
+
+	ret = imx_drm_encoder_parse_of(drm, &dsi->encoder, dsi->dev->of_node);
+	if (ret)
+		return ret;
+
+	drm_encoder_helper_add(&dsi->encoder, &imx_mipi_dsi_encoder_helper_funcs);
+	drm_encoder_init(drm, &dsi->encoder, &imx_mipi_dsi_encoder_funcs,
+			 DRM_MODE_ENCODER_DSI);
+	return 0;
+}
+
+static enum drm_mode_status imx_mipi_dsi_mode_valid(
+					struct drm_connector *connector,
+					struct drm_display_mode *mode)
+{
+	/* The VID_PKT_SIZE field in the DSI_VID_PKT_CFG register is 11-bit. */
+	if (mode->hdisplay > 0x7ff)
+		return MODE_BAD_HVALUE;
+
+	/* The V_ACTIVE_LINES field in the DSI_VTIMING_CFG register is 11-bit. */
+	if (mode->vdisplay > 0x7ff)
+		return MODE_BAD_VVALUE;
+
+	return MODE_OK;
+}
+
+static struct dw_mipi_dsi_plat_data imx6q_mipi_dsi_drv_data = {
+	.max_data_lanes = 2,
+	.mode_valid = imx_mipi_dsi_mode_valid,
+};
+
+static const struct of_device_id imx_mipi_dsi_dt_ids[] = {
+	{
+	 .compatible = "fsl,imx6q-mipi-dsi",
+	 .data = &imx6q_mipi_dsi_drv_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_mipi_dsi_dt_ids);
+
+static int imx_mipi_dsi_bind(struct device *dev, struct device *master, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	const struct of_device_id *of_id =
+			of_match_device(imx_mipi_dsi_dt_ids, dev);
+	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
+	struct drm_device *drm = data;
+	struct device_node *np = dev->of_node;
+	struct imx_mipi_dsi *dsi;
+	struct resource *res;
+	int ret;
+
+	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
+	if (!dsi)
+		return -ENOMEM;
+
+	dsi->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	dsi->regmap = syscon_regmap_lookup_by_phandle(np, "gpr");
+	if (IS_ERR(dsi->regmap))
+		return PTR_ERR(dsi->regmap);
+
+	ret = imx_mipi_dsi_register(drm, dsi);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, dsi);
+
+	return dw_mipi_dsi_bind(dev, master, data, &dsi->encoder, res, pdata);
+}
+
+static void imx_mipi_dsi_unbind(struct device *dev, struct device *master,
+	void *data)
+{
+	return dw_mipi_dsi_unbind(dev, master, data);
+}
+
+static const struct component_ops imx_mipi_dsi_ops = {
+	.bind	= imx_mipi_dsi_bind,
+	.unbind	= imx_mipi_dsi_unbind,
+};
+
+static int imx_mipi_dsi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &imx_mipi_dsi_ops);
+}
+
+static int imx_mipi_dsi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &imx_mipi_dsi_ops);
+	return 0;
+}
+
+static struct platform_driver imx_mipi_dsi_driver = {
+	.probe		= imx_mipi_dsi_probe,
+	.remove		= imx_mipi_dsi_remove,
+	.driver		= {
+		.of_match_table = imx_mipi_dsi_dt_ids,
+		.name	= DRIVER_NAME,
+	},
+};
+module_platform_driver(imx_mipi_dsi_driver);
+
+MODULE_DESCRIPTION("i.MX MIPI DSI host controller driver");
+MODULE_AUTHOR("Liu Ying <Ying.Liu@freescale.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.1.0
