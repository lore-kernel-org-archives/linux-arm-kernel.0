From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 20:18:01 +0800
Subject: [PATCH 04/10] drm/sun4i: Add support for A10 display pipeline
 components
In-Reply-To: <20171017121807.2994-1-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
Message-ID: <20171017121807.2994-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A10 display pipeline has 2 frontends, 2 backends, and 2 TCONs.
This patch adds support (or a compatible string in the frontend's
case) for these components.

The TCONs support directly outputting to CPU/RGB/LVDS LCD panels,
or it can output to HDMI via an on-chip HDMI controller, or
CVBS/YPbPr/VGA signals via on-chip TV encoders. These additional
encoders are not covered in this patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 drivers/gpu/drm/sun4i/sun4i_backend.c                         | 8 ++++++++
 drivers/gpu/drm/sun4i/sun4i_drv.c                             | 4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 5650efcfd2ac..8f9a58181f89 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -155,6 +155,7 @@ system.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun4i-a10-display-backend
     * allwinner,sun5i-a13-display-backend
     * allwinner,sun6i-a31-display-backend
     * allwinner,sun8i-a33-display-backend
@@ -187,6 +188,7 @@ deinterlacing and color space conversion.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun4i-a10-display-frontend
     * allwinner,sun5i-a13-display-frontend
     * allwinner,sun6i-a31-display-frontend
     * allwinner,sun8i-a33-display-frontend
@@ -233,6 +235,7 @@ extra node.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun4i-a10-display-engine
     * allwinner,sun5i-a10s-display-engine
     * allwinner,sun5i-a13-display-engine
     * allwinner,sun6i-a31-display-engine
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index e8477321f978..77f9e183df00 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -514,6 +514,10 @@ static int sun4i_backend_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun4i_backend_quirks sun4i_backend_quirks = {
+	.needs_output_muxing = true,
+};
+
 static const struct sun4i_backend_quirks sun5i_backend_quirks = {
 };
 
@@ -524,6 +528,10 @@ static const struct sun4i_backend_quirks sun8i_a33_backend_quirks = {
 };
 
 static const struct of_device_id sun4i_backend_of_table[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-display-backend",
+		.data = &sun4i_backend_quirks,
+	},
 	{
 		.compatible = "allwinner,sun5i-a13-display-backend",
 		.data = &sun5i_backend_quirks,
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index b8089ac6feef..5dbaf8bb414d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -177,7 +177,8 @@ static bool sun4i_drv_node_is_connector(struct device_node *node)
 
 static bool sun4i_drv_node_is_frontend(struct device_node *node)
 {
-	return of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
+	return of_device_is_compatible(node, "allwinner,sun4i-a10-display-frontend") ||
+		of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun8i-a33-display-frontend");
 }
@@ -388,6 +389,7 @@ static int sun4i_drv_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_drv_of_table[] = {
+	{ .compatible = "allwinner,sun4i-a10-display-engine" },
 	{ .compatible = "allwinner,sun5i-a10s-display-engine" },
 	{ .compatible = "allwinner,sun5i-a13-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
-- 
2.14.2
