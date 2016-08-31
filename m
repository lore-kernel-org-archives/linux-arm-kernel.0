From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 31 Aug 2016 16:14:08 +0300
Subject: [PATCH v3 3/8] drm/tilcdc: Add blue-and-red-crossed devicetree
 property
In-Reply-To: <cover.1472634657.git.jsarha@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
Message-ID: <1fc6a6bb5b56b9bac845502b0724d7a07f0675fb.1472634657.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "blue-and-red-wiring"-device tree property and update devicetree
binding document. The red and blue components are reversed between 24
and 16 bit modes on am335x LCDC output pins. To get 24 RGB format the
red and blue wires has to be crossed and this in turn causes 16 colors
output to be in BGR format. With straight wiring the 16 color is RGB
and 24 bit is BGR. The new property describes whether the red and blue
wires are crossed or not. If the property is not present or its value
is not recognized the legacy mode is assumed. The legacy configuration
supports RGB565, RGB888 and XRGB8888 formats. However, depending on
wiring, the red and blue colors are swapped in either 16 or 24-bit
color modes.

For more details see section 3.1.1 in AM335x Silicon Errata:
http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=sprz360

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  | 22 ++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                | 42 ++++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |  4 +++
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |  9 ++---
 4 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
index 6efa4c5..5b7b5f8 100644
--- a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
+++ b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
@@ -17,6 +17,18 @@ Optional properties:
    the lcd controller.
  - max-pixelclock: The maximum pixel clock that can be supported
    by the lcd controller in KHz.
+ - blue-and-red-wiring: Recognized values "default", "straight" or
+   "crossed". This property deals with the LCDC revision 2 (found on
+   AM335x) color errata [1].
+     - "default" and "straight" indicates normal wiring that supports
+      RGB565, BGR888, and XBGR8888 color formats.
+    - "crossed" indicates wiring that has blue and red wires
+      crossed. This setup supports BGR565, RGB888 and XRGB8888
+      formats.
+    - If the property is not present or its value is not recognized
+      the legacy mode is assumed. This configuration supports RGB565,
+      RGB888 and XRGB8888 formats. However, depending on wiring, the red
+      and blue colors are swapped in either 16 or 24-bit color modes.
 
 Optional nodes:
 
@@ -28,6 +40,14 @@ Optional nodes:
    Documentation/devicetree/bindings/display/tilcdc/tfp410.txt for connecting
    tfp410 DVI encoder or lcd panel to lcdc
 
+[1] There is an errata about AM335x color wiring. For 16-bit color mode
+    the wires work as they should (LCD_DATA[0:4] is for Blue[3:7]),
+    but for 24 bit color modes the wiring of blue and red components is
+    crossed and LCD_DATA[0:4] is for Red[3:7] and LCD_DATA[11:15] is
+    for Blue[3-7]. For more details see section 3.1.1 in AM335x
+    Silicon Errata:
+    http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=sprz360
+
 Example:
 
 	fb: fb at 4830e000 {
@@ -37,6 +57,8 @@ Example:
 		interrupts = <36>;
 		ti,hwmods = "lcdc";
 
+		blue-and-red-wiring = "crossed";
+
 		port {
 			lcdc_0: endpoint at 0 {
 				remote-endpoint = <&hdmi_0>;
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index e45c268..4371537 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -33,6 +33,20 @@
 
 static LIST_HEAD(module_list);
 
+static const u32 tilcdc_rev1_formats[] = { DRM_FORMAT_RGB565 };
+
+static const u32 tilcdc_straight_formats[] = { DRM_FORMAT_RGB565,
+					       DRM_FORMAT_BGR888,
+					       DRM_FORMAT_XBGR8888 };
+
+static const u32 tilcdc_crossed_formats[] = { DRM_FORMAT_BGR565,
+					      DRM_FORMAT_RGB888,
+					      DRM_FORMAT_XRGB8888 };
+
+static const u32 tilcdc_legacy_formats[] = { DRM_FORMAT_RGB565,
+					     DRM_FORMAT_RGB888,
+					     DRM_FORMAT_XRGB8888 };
+
 void tilcdc_module_init(struct tilcdc_module *mod, const char *name,
 		const struct tilcdc_module_ops *funcs)
 {
@@ -318,6 +332,34 @@ static int tilcdc_load(struct drm_device *dev, unsigned long flags)
 
 	pm_runtime_put_sync(dev->dev);
 
+	if (priv->rev == 1) {
+		DBG("Revision 1 LCDC supports only RGB565 format");
+		priv->pixelformats = tilcdc_rev1_formats;
+		priv->num_pixelformats = ARRAY_SIZE(tilcdc_rev1_formats);
+	} else {
+		const char *str = "\0";
+
+		of_property_read_string(node, "blue-and-red-wiring", &str);
+		if (0 == strcmp(str, "crossed")) {
+			DBG("Configured for crossed blue and red wires");
+			priv->pixelformats = tilcdc_crossed_formats;
+			priv->num_pixelformats =
+				ARRAY_SIZE(tilcdc_crossed_formats);
+		} else if(0 == strcmp(str, "default") ||
+			  0 == strcmp(str, "straight")) {
+			DBG("Configured for straight blue and red wires");
+			priv->pixelformats = tilcdc_straight_formats;
+			priv->num_pixelformats =
+				ARRAY_SIZE(tilcdc_straight_formats);
+		} else {
+			DBG("Blue and red wiring '%s' unknown, use legacy mode",
+			    str);
+			priv->pixelformats = tilcdc_legacy_formats;
+			priv->num_pixelformats =
+				ARRAY_SIZE(tilcdc_legacy_formats);
+		}
+	}
+
 	ret = modeset_init(dev);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize mode setting\n");
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index 13001df..0e19c14 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -65,6 +65,10 @@ struct tilcdc_drm_private {
 	 */
 	uint32_t max_width;
 
+	/* Supported pixel formats */
+	const uint32_t *pixelformats;
+	uint32_t num_pixelformats;
+
 	/* The context for pm susped/resume cycle is stored here */
 	struct drm_atomic_state *saved_state;
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
index 41911e3..74c65fa 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
@@ -24,10 +24,6 @@
 
 #include "tilcdc_drv.h"
 
-static const u32 tilcdc_formats[] = { DRM_FORMAT_RGB565,
-				      DRM_FORMAT_RGB888,
-				      DRM_FORMAT_XRGB8888 };
-
 static struct drm_plane_funcs tilcdc_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
@@ -114,12 +110,13 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 int tilcdc_plane_init(struct drm_device *dev,
 		      struct drm_plane *plane)
 {
+	struct tilcdc_drm_private *priv = dev->dev_private;
 	int ret;
 
 	ret = drm_plane_init(dev, plane, 1,
 			     &tilcdc_plane_funcs,
-			     tilcdc_formats,
-			     ARRAY_SIZE(tilcdc_formats),
+			     priv->pixelformats,
+			     priv->num_pixelformats,
 			     true);
 	if (ret) {
 		dev_err(dev->dev, "Failed to initialize plane: %d\n", ret);
-- 
1.9.1
