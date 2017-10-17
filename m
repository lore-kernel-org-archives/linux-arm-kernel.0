From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 20:17:59 +0800
Subject: [PATCH 02/10] drm/sun4i: tcon: Add support for A10 TCON
In-Reply-To: <20171017121807.2994-1-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
Message-ID: <20171017121807.2994-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Liu <net147@gmail.com>

The A10 has two TCONs that are similar to the ones found on other SoCs.
Like the A31, TCON0 has a register used to mux the TCON outputs to the
downstream encoders. The bit fields are slightly different.

Signed-off-by: Jonathan Liu <net147@gmail.com>
[wens at csie.org: Reworked for A10 and fixed up commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../bindings/display/sunxi/sun4i-drm.txt           |  1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 30 ++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 46df3b78ae9e..b2c08af73a95 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -86,6 +86,7 @@ The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
 
 Required properties:
  - compatible: value must be either:
+   * allwinner,sun4i-a10-tcon
    * allwinner,sun5i-a13-tcon
    * allwinner,sun6i-a31-tcon
    * allwinner,sun6i-a31s-tcon
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index b5879d4620d8..b8089ac6feef 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -184,7 +184,8 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
 
 static bool sun4i_drv_node_is_tcon(struct device_node *node)
 {
-	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
+	return of_device_is_compatible(node, "allwinner,sun4i-a10-tcon") ||
+		of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun6i-a31s-tcon") ||
 		of_device_is_compatible(node, "allwinner,sun8i-a33-tcon") ||
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 68751b999877..c6e77f9840c2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -782,6 +782,30 @@ static int sun4i_tcon_remove(struct platform_device *pdev)
 }
 
 /* platform specific TCON muxing callbacks */
+static int sun4i_a10_tcon_set_mux(struct sun4i_tcon *tcon,
+				  struct drm_encoder *encoder)
+{
+	struct sun4i_tcon *tcon0 = sun4i_get_tcon0(encoder->dev);
+	u32 shift;
+
+	if (!tcon0)
+		return -EINVAL;
+
+	switch (encoder->encoder_type) {
+	case DRM_MODE_ENCODER_TMDS:
+		/* HDMI */
+		shift = 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(tcon0->regs, SUN4I_TCON_MUX_CTRL_REG,
+			   0x3 << shift, tcon->id << shift);
+
+	return 0;
+}
+
 static int sun5i_a13_tcon_set_mux(struct sun4i_tcon *tcon,
 				  struct drm_encoder *encoder)
 {
@@ -823,6 +847,11 @@ static int sun6i_tcon_set_mux(struct sun4i_tcon *tcon,
 	return 0;
 }
 
+static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
+	.has_channel_1		= true,
+	.set_mux		= sun4i_a10_tcon_set_mux,
+};
+
 static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
 	.has_channel_1		= true,
 	.set_mux		= sun5i_a13_tcon_set_mux,
@@ -848,6 +877,7 @@ static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
 };
 
 static const struct of_device_id sun4i_tcon_of_table[] = {
+	{ .compatible = "allwinner,sun4i-a10-tcon", .data = &sun4i_a10_quirks },
 	{ .compatible = "allwinner,sun5i-a13-tcon", .data = &sun5i_a13_quirks },
 	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
-- 
2.14.2
