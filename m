From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  1 Sep 2016 17:31:59 +0200
Subject: [PATCH 2/7] drm/sun4i: support A33 tcon
In-Reply-To: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
Message-ID: <20160901153204.11217-3-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33 has a significantly different pipeline, with components that differ
too.

Make sure we had compatible for them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 7 ++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.c                         | 1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                             | 8 +++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.c                            | 8 +++++++-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index df8f4aeefe4c..d467ea93ac08 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -26,7 +26,9 @@ TCON
 The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
 
 Required properties:
- - compatible: value should be "allwinner,sun5i-a13-tcon".
+ - compatible: value must be either:
+   * allwinner,sun5i-a13-tcon
+   * allwinner,sun8i-a23-tcon
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON. Three are needed:
@@ -59,6 +61,7 @@ system.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun5i-a13-display-backend
+    * allwinner,sun8i-a33-display-backend
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the frontend and backend
     * ahb: the backend interface clock
@@ -80,6 +83,7 @@ deinterlacing and color space conversion.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun5i-a13-display-frontend
+    * allwinner,sun8i-a33-display-frontend
   - reg: base address and size of the memory-mapped region.
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the frontend and backend
@@ -104,6 +108,7 @@ extra node.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun5i-a13-display-engine
+    * allwinner,sun8i-a33-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
     frontends available.
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 3ab560450a82..9bfd2e45fceb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -345,6 +345,7 @@ static int sun4i_backend_remove(struct platform_device *pdev)
 
 static const struct of_device_id sun4i_backend_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-display-backend" },
+	{ .compatible = "allwinner,sun8i-a33-display-backend" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_backend_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 942f62e2441c..26431c2b5670 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -199,13 +199,14 @@ static const struct component_master_ops sun4i_drv_master_ops = {
 
 static bool sun4i_drv_node_is_frontend(struct device_node *node)
 {
-	return of_device_is_compatible(node,
-				       "allwinner,sun5i-a13-display-frontend");
+	return of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
+		of_device_is_compatible(node, "allwinner,sun8i-a33-display-frontend");
 }
 
 static bool sun4i_drv_node_is_tcon(struct device_node *node)
 {
-	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon");
+	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
+		of_device_is_compatible(node, "allwinner,sun8i-a23-tcon");
 }
 
 static int compare_of(struct device *dev, void *data)
@@ -320,6 +321,7 @@ static int sun4i_drv_remove(struct platform_device *pdev)
 
 static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-display-engine" },
+	{ .compatible = "allwinner,sun8i-a33-display-engine" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index fde6af1230d2..078328193168 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -488,8 +488,13 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	tcon->drm = drm;
 	tcon->dev = dev;
 
-	if (of_device_is_compatible(dev->of_node, "allwinner,sun5i-a13-tcon"))
+	if (of_device_is_compatible(dev->of_node, "allwinner,sun5i-a13-tcon")) {
 		tcon->has_mux = true;
+		tcon->has_channel_1 = true;
+	} else {
+		tcon->has_mux = false;
+		tcon->has_channel_1 = false;
+	}
 
 	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
 	if (IS_ERR(tcon->lcd_rst)) {
@@ -585,6 +590,7 @@ static int sun4i_tcon_remove(struct platform_device *pdev)
 
 static const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-tcon" },
+	{ .compatible = "allwinner,sun8i-a23-tcon" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
-- 
2.9.2
