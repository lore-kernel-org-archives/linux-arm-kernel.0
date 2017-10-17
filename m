From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:23 +0200
Subject: [PATCH 16/23] drm/sun4i: Add A83T support
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <cfa06492ecb6bfba965e1074604525a4e939c5c1.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the A83T display pipeline.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 drivers/gpu/drm/sun4i/sun4i_drv.c                             | 2 ++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                            | 1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c                           | 4 ++++
 4 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 46df3b78ae9e..c0fa233ec1fc 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -90,6 +90,7 @@ Required properties:
    * allwinner,sun6i-a31-tcon
    * allwinner,sun6i-a31s-tcon
    * allwinner,sun8i-a33-tcon
+   * allwinner,sun8i-a83t-tcon
    * allwinner,sun8i-v3s-tcon
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
@@ -209,6 +210,7 @@ supported.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun8i-a83t-de2-mixer
     * allwinner,sun8i-v3s-de2-mixer
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
@@ -236,6 +238,7 @@ Required properties:
     * allwinner,sun6i-a31-display-engine
     * allwinner,sun6i-a31s-display-engine
     * allwinner,sun8i-a33-display-engine
+    * allwinner,sun8i-a83t-display-engine
     * allwinner,sun8i-v3s-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index a27efad9bc76..439f116bb3b5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -189,6 +189,7 @@ static bool sun4i_drv_node_is_tcon(struct device_node *node)
 		of_device_is_compatible(node, "allwinner,sun6i-a31-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31s-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun8i-a33-tcon") ||
+		of_device_is_compatible(node, "allwinner,sun8i-a83t-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun8i-v3s-tcon");
 }
 
@@ -347,6 +348,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-display-engine" },
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
+	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 6a20a467ee6d..eb3c8bad4977 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1063,6 +1063,7 @@ static const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
+	{ .compatible = "allwinner,sun8i-a83t-tcon", .data = &sun8i_v3s_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 86c6c24b5105..c6030ce130d3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -385,6 +385,10 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 
 static const struct of_device_id sun8i_mixer_of_table[] = {
 	{
+		.compatible = "allwinner,sun8i-a83t-de2-mixer",
+		.data = &sun8i_v3s_mixer_cfg,
+	},
+	{
 		.compatible = "allwinner,sun8i-v3s-de2-mixer",
 		.data = &sun8i_v3s_mixer_cfg,
 	},
-- 
git-series 0.9.1
