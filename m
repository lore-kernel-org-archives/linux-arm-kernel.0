From: peda@axentia.se (Peter Rosin)
Date: Mon, 26 Mar 2018 23:24:46 +0200
Subject: [PATCH v2 4/5] drm: bridge: lvds-encoder: allow specifying the input
 bus format
In-Reply-To: <20180326212447.7380-1-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se>
Message-ID: <20180326212447.7380-5-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the bridge changes the bus format, allow this to be described in
the bridge, instead of providing false information about the bus
format of the connector or panel.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/display/bridge/lvds-transmitter.txt   |  6 ++++++
 drivers/gpu/drm/bridge/lvds-encoder.c              | 25 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index 50220190c203..8d40a2069252 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -30,6 +30,12 @@ Required properties:
   device-specific version corresponding to the device first
   followed by the generic version.
 
+Optional properties:
+
+- interface-pix-fmt:
+  List of valid input bus formats of the encoder. Recognized bus formats
+  are listed in ../bus-format.txt
+
 Required nodes:
 
 This device has two video ports. Their connections are modeled using the OF
diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
index 75b0d3f6e4de..b78619b5560a 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -9,6 +9,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <linux/of_graph.h>
@@ -16,6 +17,8 @@
 struct lvds_encoder {
 	struct drm_bridge bridge;
 	struct drm_bridge *panel_bridge;
+	int num_bus_formats;
+	u32 *bus_formats;
 };
 
 static int lvds_encoder_attach(struct drm_bridge *bridge)
@@ -28,8 +31,22 @@ static int lvds_encoder_attach(struct drm_bridge *bridge)
 				 bridge);
 }
 
+static int lvds_encoder_input_formats(struct drm_bridge *bridge,
+				      const u32 **bus_formats)
+{
+	struct lvds_encoder *lvds_encoder = container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->num_bus_formats)
+		*bus_formats = lvds_encoder->bus_formats;
+
+	return lvds_encoder->num_bus_formats;
+}
+
 static struct drm_bridge_funcs funcs = {
 	.attach = lvds_encoder_attach,
+	.input_formats = lvds_encoder_input_formats,
 };
 
 static int lvds_encoder_probe(struct platform_device *pdev)
@@ -39,6 +56,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	struct device_node *panel_node;
 	struct drm_panel *panel;
 	struct lvds_encoder *lvds_encoder;
+	int ret;
 
 	lvds_encoder = devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
 				    GFP_KERNEL);
@@ -79,6 +97,12 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	if (IS_ERR(lvds_encoder->panel_bridge))
 		return PTR_ERR(lvds_encoder->panel_bridge);
 
+	ret = drm_of_bus_formats(pdev->dev.of_node, "interface-pix-fmt",
+				 &lvds_encoder->bus_formats);
+	if (ret < 0)
+		return ret;
+	lvds_encoder->num_bus_formats = ret;
+
 	/* The panel_bridge bridge is attached to the panel's of_node,
 	 * but we need a bridge attached to our of_node for our user
 	 * to look up.
@@ -96,6 +120,7 @@ static int lvds_encoder_remove(struct platform_device *pdev)
 {
 	struct lvds_encoder *lvds_encoder = platform_get_drvdata(pdev);
 
+	kfree(lvds_encoder->bus_formats);
 	drm_bridge_remove(&lvds_encoder->bridge);
 
 	return 0;
-- 
2.11.0
