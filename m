From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Oct 2016 00:06:22 +0800
Subject: [PATCH 2/9] drm/sun4i: tcon: Move SoC specific quirks to a DT matched
 data structure
In-Reply-To: <20161006160629.11198-1-wens@csie.org>
References: <20161006160629.11198-1-wens@csie.org>
Message-ID: <20161006160629.11198-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already have some differences between the 2 supported SoCs.
More will be added as we support other SoCs. To avoid bloating
the probe function with even more conditionals, move the quirks
to a separate data structure that's tied to the compatible string.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 35 ++++++++++++++++++++---------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 13 +++++++++----
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index cadacb517f95..c6c1c7ce94a1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -20,6 +20,7 @@
 #include <linux/component.h>
 #include <linux/ioport.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
@@ -62,7 +63,7 @@ void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel)
 		return;
 	}
 
-	WARN_ON(!tcon->has_channel_1);
+	WARN_ON(!tcon->quirks->has_channel_1);
 	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
 			   SUN4I_TCON1_CTL_TCON_ENABLE, 0);
 	clk_disable_unprepare(tcon->sclk1);
@@ -80,7 +81,7 @@ void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel)
 		return;
 	}
 
-	WARN_ON(!tcon->has_channel_1);
+	WARN_ON(!tcon->quirks->has_channel_1);
 	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
 			   SUN4I_TCON1_CTL_TCON_ENABLE,
 			   SUN4I_TCON1_CTL_TCON_ENABLE);
@@ -202,7 +203,7 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	u8 clk_delay;
 	u32 val;
 
-	WARN_ON(!tcon->has_channel_1);
+	WARN_ON(!tcon->quirks->has_channel_1);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
@@ -266,7 +267,7 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	/*
 	 * FIXME: Undocumented bits
 	 */
-	if (tcon->has_mux)
+	if (tcon->quirks->is_sun5i)
 		regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
 }
 EXPORT_SYMBOL(sun4i_tcon1_mode_set);
@@ -327,7 +328,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		return PTR_ERR(tcon->sclk0);
 	}
 
-	if (tcon->has_channel_1) {
+	if (tcon->quirks->has_channel_1) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
 		if (IS_ERR(tcon->sclk1)) {
 			dev_err(dev, "Couldn't get the TCON channel 1 clock\n");
@@ -487,14 +488,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	drv->tcon = tcon;
 	tcon->drm = drm;
 	tcon->dev = dev;
-
-	if (of_device_is_compatible(dev->of_node, "allwinner,sun5i-a13-tcon")) {
-		tcon->has_mux = true;
-		tcon->has_channel_1 = true;
-	} else {
-		tcon->has_mux = false;
-		tcon->has_channel_1 = false;
-	}
+	tcon->quirks = of_device_get_match_data(dev);
 
 	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
 	if (IS_ERR(tcon->lcd_rst)) {
@@ -588,9 +582,20 @@ static int sun4i_tcon_remove(struct platform_device *pdev)
 	return 0;
 }
 
+const struct sun4i_tcon_quirks sun5i_a13_quirks = {
+	.is_sun5i	= true,
+	.has_channel_1	= true,
+	.has_bypass_src	= true,
+	.has_dma_src	= true,
+};
+
+const struct sun4i_tcon_quirks sun8i_a33_quirks = {
+	/* nothing is supported */
+};
+
 static const struct of_device_id sun4i_tcon_of_table[] = {
-	{ .compatible = "allwinner,sun5i-a13-tcon" },
-	{ .compatible = "allwinner,sun8i-a33-tcon" },
+	{ .compatible = "allwinner,sun5i-a13-tcon", .data = &sun5i_a13_quirks },
+	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 12bd48925f4d..96c4f15c6922 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -142,6 +142,13 @@
 
 #define SUN4I_TCON_MAX_CHANNELS		2
 
+struct sun4i_tcon_quirks {
+	bool	is_sun5i;	/* sun5i has undocumented mux */
+	bool	has_channel_1;	/* a33 does not have channel 1 */
+	bool	has_bypass_src;	/* has separate input bypassing CEU */
+	bool	has_dma_src;	/* has DMA input */
+};
+
 struct sun4i_tcon {
 	struct device			*dev;
 	struct drm_device		*drm;
@@ -160,12 +167,10 @@ struct sun4i_tcon {
 	/* Reset control */
 	struct reset_control		*lcd_rst;
 
-	/* Platform adjustments */
-	bool				has_mux;
-
 	struct drm_panel		*panel;
 
-	bool				has_channel_1;
+	/* Platform adjustments */
+	const struct sun4i_tcon_quirks	*quirks;
 };
 
 struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
-- 
2.9.3
