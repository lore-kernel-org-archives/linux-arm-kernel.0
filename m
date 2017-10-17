From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 20:18:02 +0800
Subject: [PATCH 05/10] drm/sun4i: Add support for A20 display pipeline
 components
In-Reply-To: <20171017121807.2994-1-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
Message-ID: <20171017121807.2994-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Liu <net147@gmail.com>

The A20 display pipeline has 2 frontends, 2 backends, and 2 TCONs.
This patch adds support (or a compatible string in the frontend's
case) for these components.

The TCONs support directly outputting to CPU/RGB/LVDS LCD panels,
or it can output to HDMI via an on-chip HDMI controller, or
CVBS/YPbPr/VGA signals via on-chip TV encoders. These additional
encoders are not covered in this patch.

Signed-off-by: Jonathan Liu <net147@gmail.com>
[wens at csie.org: Expand commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 ++++
 drivers/gpu/drm/sun4i/sun4i_backend.c                         | 8 ++++++++
 drivers/gpu/drm/sun4i/sun4i_drv.c                             | 3 +++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                            | 7 +++++++
 4 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 8f9a58181f89..013e76b348ba 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -91,6 +91,7 @@ Required properties:
    * allwinner,sun5i-a13-tcon
    * allwinner,sun6i-a31-tcon
    * allwinner,sun6i-a31s-tcon
+   * allwinner,sun7i-a20-tcon
    * allwinner,sun8i-a33-tcon
    * allwinner,sun8i-v3s-tcon
  - reg: base address and size of memory-mapped region
@@ -158,6 +159,7 @@ Required properties:
     * allwinner,sun4i-a10-display-backend
     * allwinner,sun5i-a13-display-backend
     * allwinner,sun6i-a31-display-backend
+    * allwinner,sun7i-a20-display-backend
     * allwinner,sun8i-a33-display-backend
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
@@ -191,6 +193,7 @@ Required properties:
     * allwinner,sun4i-a10-display-frontend
     * allwinner,sun5i-a13-display-frontend
     * allwinner,sun6i-a31-display-frontend
+    * allwinner,sun7i-a20-display-frontend
     * allwinner,sun8i-a33-display-frontend
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
@@ -240,6 +243,7 @@ Required properties:
     * allwinner,sun5i-a13-display-engine
     * allwinner,sun6i-a31-display-engine
     * allwinner,sun6i-a31s-display-engine
+    * allwinner,sun7i-a20-display-engine
     * allwinner,sun8i-a33-display-engine
     * allwinner,sun8i-v3s-display-engine
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 77f9e183df00..847eecbe4d14 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -524,6 +524,10 @@ static const struct sun4i_backend_quirks sun5i_backend_quirks = {
 static const struct sun4i_backend_quirks sun6i_backend_quirks = {
 };
 
+static const struct sun4i_backend_quirks sun7i_backend_quirks = {
+	.needs_output_muxing = true,
+};
+
 static const struct sun4i_backend_quirks sun8i_a33_backend_quirks = {
 };
 
@@ -540,6 +544,10 @@ static const struct of_device_id sun4i_backend_of_table[] = {
 		.compatible = "allwinner,sun6i-a31-display-backend",
 		.data = &sun6i_backend_quirks,
 	},
+	{
+		.compatible = "allwinner,sun7i-a20-display-backend",
+		.data = &sun7i_backend_quirks,
+	},
 	{
 		.compatible = "allwinner,sun8i-a33-display-backend",
 		.data = &sun8i_a33_backend_quirks,
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 5dbaf8bb414d..03df9fe9d6dd 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -180,6 +180,7 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
 	return of_device_is_compatible(node, "allwinner,sun4i-a10-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31-display-frontend") ||
+		of_device_is_compatible(node, "allwinner,sun7i-a20-display-frontend") ||
 		of_device_is_compatible(node, "allwinner,sun8i-a33-display-frontend");
 }
 
@@ -189,6 +190,7 @@ static bool sun4i_drv_node_is_tcon(struct device_node *node)
 		of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31s-tcon") ||
+		of_device_is_compatible(node, "allwinner,sun7i-a20-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun8i-a33-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun8i-v3s-tcon");
 }
@@ -394,6 +396,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
+	{ .compatible = "allwinner,sun7i-a20-display-engine" },
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ }
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c6e77f9840c2..184d32545744 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -868,6 +868,12 @@ static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
 	.needs_de_be_mux	= true,
 };
 
+static const struct sun4i_tcon_quirks sun7i_a20_quirks = {
+	.has_channel_1		= true,
+	/* Same display pipeline structure as A10 */
+	.set_mux		= sun4i_a10_tcon_set_mux,
+};
+
 static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 	/* nothing is supported */
 };
@@ -881,6 +887,7 @@ static const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-tcon", .data = &sun5i_a13_quirks },
 	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
+	{ .compatible = "allwinner,sun7i-a20-tcon", .data = &sun7i_a20_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ }
-- 
2.14.2
