From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Nov 2017 16:41:35 +0100
Subject: [PATCH v2 11/18] drm/sun4i: Add A83T support
In-Reply-To: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
Message-ID: <1c4f6b275597dec7d97b5c1d9f749ba27c0610f3.1511797218.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the A83T display pipeline.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
 drivers/gpu/drm/sun4i/sun4i_drv.c                             | 2 ++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                            | 5 +++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c                           | 4 ++++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index d4259a4f5171..d6b52e5c48c0 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -93,6 +93,7 @@ Required properties:
    * allwinner,sun6i-a31s-tcon
    * allwinner,sun7i-a20-tcon
    * allwinner,sun8i-a33-tcon
+   * allwinner,sun8i-a83t-tcon-lcd
    * allwinner,sun8i-v3s-tcon
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
@@ -224,6 +225,7 @@ supported.
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun8i-a83t-de2-mixer
     * allwinner,sun8i-v3s-de2-mixer
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
@@ -253,6 +255,7 @@ Required properties:
     * allwinner,sun6i-a31s-display-engine
     * allwinner,sun7i-a20-display-engine
     * allwinner,sun8i-a33-display-engine
+    * allwinner,sun8i-a83t-display-engine
     * allwinner,sun8i-v3s-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 75c76cdd82bc..c418be2f22be 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -193,6 +193,7 @@ static bool sun4i_drv_node_is_tcon(struct device_node *node)
 		of_device_is_compatible(node, "allwinner,sun6i-a31s-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun7i-a20-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun8i-a33-tcon") ||
+		of_device_is_compatible(node, "allwinner,sun8i-a83t-tcon-lcd") ||
 		of_device_is_compatible(node, "allwinner,sun8i-v3s-tcon");
 }
 
@@ -353,6 +354,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31s-display-engine" },
 	{ .compatible = "allwinner,sun7i-a20-display-engine" },
 	{ .compatible = "allwinner,sun8i-a33-display-engine" },
+	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 46ce6daa0b1a..871df75793a9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1132,6 +1132,10 @@ static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 	.has_lvds_pll		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_a83t_quirks = {
+	/* nothing is supported */
+};
+
 static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
 	/* nothing is supported */
 };
@@ -1143,6 +1147,7 @@ static const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
 	{ .compatible = "allwinner,sun7i-a20-tcon", .data = &sun7i_a20_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
+	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 44d5e639ebb2..5a1376965270 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -395,6 +395,10 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 
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
