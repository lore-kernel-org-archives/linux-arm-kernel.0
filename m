From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Sep 2016 14:13:49 +0200
Subject: [PATCH v4 2/5] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <20160930121352.30184-1-maxime.ripard@free-electrons.com>
References: <20160930121352.30184-1-maxime.ripard@free-electrons.com>
Message-ID: <20160930121352.30184-3-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards have an entirely passive RGB to VGA bridge, based on either
DACs or resistor ladders.

Those might or might not have an i2c bus routed to the VGA connector in
order to access the screen EDIDs.

Add a bridge that doesn't do anything but expose the modes available on the
screen, either based on the EDIDs if available, or based on the XGA
standards.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../bindings/display/bridge/rgb-to-vga-bridge.txt  |  48 +++++
 drivers/gpu/drm/bridge/Kconfig                     |   7 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/rgb-to-vga.c                | 239 +++++++++++++++++++++
 4 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
 create mode 100644 drivers/gpu/drm/bridge/rgb-to-vga.c

diff --git a/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
new file mode 100644
index 000000000000..a8375bc1f9cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
@@ -0,0 +1,48 @@
+Dumb RGB to VGA bridge
+----------------------
+
+This binding is aimed for dumb RGB to VGA bridges that do not require
+any configuration.
+
+Required properties:
+
+- compatible: Must be "rgb-to-vga-bridge"
+
+Required nodes:
+
+This device has two video ports. Their connections are modeled using the OF
+graph bindings specified in Documentation/devicetree/bindings/graph.txt.
+
+- Video port 0 for RGB input
+- Video port 1 for VGA output
+
+
+Example
+-------
+
+bridge {
+	compatible = "rgb-to-vga-bridge";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+
+			vga_bridge_in: endpoint {
+				remote-endpoint = <&tcon0_out_vga>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			vga_bridge_out: endpoint {
+				remote-endpoint = <&vga_con_in>;
+			};
+		};
+	};
+};
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index b590e678052d..d690398c541c 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -17,6 +17,13 @@ config DRM_ANALOGIX_ANX78XX
 	  the HDMI output of an application processor to MyDP
 	  or DisplayPort.
 
+config DRM_RGB_TO_VGA
+	tristate "Dumb RGB to VGA Bridge support"
+	depends on OF
+	select DRM_KMS_HELPER
+	help
+	  Support for passive RGB to VGA bridges
+
 config DRM_DW_HDMI
 	tristate
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index efdb07e878f5..3bb8cbe09fe9 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,6 +1,7 @@
 ccflags-y := -Iinclude/drm
 
 obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
+obj-$(CONFIG_DRM_RGB_TO_VGA) += rgb-to-vga.o
 obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
 obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
diff --git a/drivers/gpu/drm/bridge/rgb-to-vga.c b/drivers/gpu/drm/bridge/rgb-to-vga.c
new file mode 100644
index 000000000000..14843baa5d11
--- /dev/null
+++ b/drivers/gpu/drm/bridge/rgb-to-vga.c
@@ -0,0 +1,239 @@
+/*
+ * Copyright (C) 2015-2016 Free Electrons
+ * Copyright (C) 2015-2016 NextThing Co
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/of_graph.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+
+struct dumb_vga {
+	struct drm_bridge	bridge;
+	struct drm_connector	connector;
+
+	struct i2c_adapter	*ddc;
+};
+
+static inline struct dumb_vga *
+drm_bridge_to_dumb_vga(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct dumb_vga, bridge);
+}
+
+static inline struct dumb_vga *
+drm_connector_to_dumb_vga(struct drm_connector *connector)
+{
+	return container_of(connector, struct dumb_vga, connector);
+}
+
+static int dumb_vga_get_modes(struct drm_connector *connector)
+{
+	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
+	struct edid *edid;
+	int ret;
+
+	if (IS_ERR(vga->ddc))
+		goto fallback;
+
+	edid = drm_get_edid(connector, vga->ddc);
+	if (!edid) {
+		DRM_INFO("EDID readout failed, falling back to standard modes\n");
+		goto fallback;
+	}
+
+	drm_mode_connector_update_edid_property(connector, edid);
+	return drm_add_edid_modes(connector, edid);
+
+fallback:
+	/*
+	 * In case we cannot retrieve the EDIDs (broken or missing i2c
+	 * bus), fallback on the XGA standards
+	 */
+	ret = drm_add_modes_noedid(connector, 1920, 1200);
+
+	/* And prefer a mode pretty much anyone can handle */
+	drm_set_preferred_mode(connector, 1024, 768);
+
+	return ret;
+}
+
+static struct drm_encoder *
+dumb_vga_best_encoder(struct drm_connector *connector)
+{
+	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
+
+	return vga->bridge.encoder;
+}
+
+static const struct drm_connector_helper_funcs dumb_vga_con_helper_funcs = {
+	.get_modes	= dumb_vga_get_modes,
+};
+
+static enum drm_connector_status
+dumb_vga_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
+
+	/*
+	 * Even if we have an I2C bus, we can't assume that the cable
+	 * is disconnected if drm_probe_ddc fails. Some cables don't
+	 * wire the DDC pins, or the I2C bus might not be working at
+	 * all.
+	 */
+	if (!IS_ERR(vga->ddc) && drm_probe_ddc(vga->ddc))
+		return connector_status_connected;
+
+	return connector_status_unknown;
+}
+
+static void
+dumb_vga_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs dumb_vga_con_funcs = {
+	.dpms			= drm_atomic_helper_connector_dpms,
+	.detect			= dumb_vga_connector_detect,
+	.fill_modes		= drm_helper_probe_single_connector_modes,
+	.destroy		= dumb_vga_connector_destroy,
+	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+};
+
+static int dumb_vga_attach(struct drm_bridge *bridge)
+{
+	struct dumb_vga *vga = drm_bridge_to_dumb_vga(bridge);
+	int ret;
+
+	if (!bridge->encoder) {
+		DRM_ERROR("Missing encoder\n");
+		return -ENODEV;
+	}
+
+	drm_connector_helper_add(&vga->connector,
+				 &dumb_vga_con_helper_funcs);
+	ret = drm_connector_init(bridge->dev, &vga->connector,
+				 &dumb_vga_con_funcs, DRM_MODE_CONNECTOR_VGA);
+	if (ret) {
+		DRM_ERROR("Failed to initialize connector\n");
+		return ret;
+	}
+
+	drm_mode_connector_attach_encoder(&vga->connector,
+					  bridge->encoder);
+
+	return 0;
+}
+
+static void dumb_vga_nop(struct drm_bridge *bridge) {};
+
+static const struct drm_bridge_funcs dumb_vga_bridge_funcs = {
+	.attach		= dumb_vga_attach,
+};
+
+static struct i2c_adapter *dumb_vga_retrieve_ddc(struct device *dev)
+{
+	struct device_node *end_node, *phandle, *remote;
+	struct i2c_adapter *ddc;
+
+	end_node = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
+	if (!end_node) {
+		dev_err(dev, "Missing connector endpoint\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	remote = of_graph_get_remote_port_parent(end_node);
+	of_node_put(end_node);
+	if (!remote) {
+		dev_err(dev, "Enable to parse remote node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	phandle = of_parse_phandle(remote, "ddc-i2c-bus", 0);
+	of_node_put(remote);
+	if (!phandle)
+		return ERR_PTR(-ENODEV);
+
+	ddc = of_get_i2c_adapter_by_node(phandle);
+	of_node_put(phandle);
+	if (!ddc)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return ddc;
+}
+
+static int dumb_vga_probe(struct platform_device *pdev)
+{
+	struct dumb_vga *vga;
+	int ret;
+
+	vga = devm_kzalloc(&pdev->dev, sizeof(*vga), GFP_KERNEL);
+	if (!vga)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, vga);
+
+	vga->ddc = dumb_vga_retrieve_ddc(&pdev->dev);
+	if (IS_ERR(vga->ddc)) {
+		if (PTR_ERR(vga->ddc) == -ENODEV) {
+			dev_info(&pdev->dev,
+				 "No i2c bus specified... Disabling EDID readout\n");
+		} else {
+			dev_err(&pdev->dev, "Couldn't retrieve i2c bus\n");
+			return PTR_ERR(vga->ddc);
+		}
+	}
+
+	vga->bridge.funcs = &dumb_vga_bridge_funcs;
+	vga->bridge.of_node = pdev->dev.of_node;
+
+	ret = drm_bridge_add(&vga->bridge);
+	if (ret && !IS_ERR(vga->ddc))
+		i2c_put_adapter(vga->ddc);
+
+	return ret;
+}
+
+static int dumb_vga_remove(struct platform_device *pdev)
+{
+	struct dumb_vga *vga = platform_get_drvdata(pdev);
+
+	drm_bridge_remove(&vga->bridge);
+
+	if (!IS_ERR(vga->ddc))
+		i2c_put_adapter(vga->ddc);
+
+	return 0;
+}
+
+static const struct of_device_id dumb_vga_match[] = {
+	{ .compatible = "rgb-to-vga-bridge" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dumb_vga_match);
+
+struct platform_driver dumb_vga_driver = {
+	.probe	= dumb_vga_probe,
+	.remove	= dumb_vga_remove,
+	.driver		= {
+		.name		= "rgb-to-vga-bridge",
+		.of_match_table	= dumb_vga_match,
+	},
+};
+module_platform_driver(dumb_vga_driver);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_DESCRIPTION("Dumb RGB to VGA bridge driver");
+MODULE_LICENSE("GPL");
-- 
2.9.3
