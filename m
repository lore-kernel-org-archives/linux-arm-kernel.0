From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 00:43:47 +0800
Subject: [RFC PATCH 04/11] drm: sun4i: add support for H3's TCON0/1
In-Reply-To: <20170517164354.16399-1-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
Message-ID: <20170517164354.16399-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

Allwinner H3 has two special TCONs, both come without channel0. And the
TCON1 of H3 has no special clocks even for the channel1.

Add support for these kinds of TCON.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 78 ++++++++++++++++++++++++++++----------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  3 ++
 2 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 89a215ff2370..7009292f99e4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -57,6 +57,7 @@ void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel)
 {
 	/* Disable the TCON's channel */
 	if (channel == 0) {
+		WARN_ON(!tcon->quirks->has_channel_0);
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
 				   SUN4I_TCON0_CTL_TCON_ENABLE, 0);
 		clk_disable_unprepare(tcon->dclk);
@@ -66,7 +67,8 @@ void sun4i_tcon_channel_disable(struct sun4i_tcon *tcon, int channel)
 	WARN_ON(!tcon->quirks->has_channel_1);
 	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
 			   SUN4I_TCON1_CTL_TCON_ENABLE, 0);
-	clk_disable_unprepare(tcon->sclk1);
+	if (tcon->quirks->has_channel_1_clk)
+		clk_disable_unprepare(tcon->sclk1);
 }
 EXPORT_SYMBOL(sun4i_tcon_channel_disable);
 
@@ -74,6 +76,7 @@ void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel)
 {
 	/* Enable the TCON's channel */
 	if (channel == 0) {
+		WARN_ON(!tcon->quirks->has_channel_0);
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_CTL_REG,
 				   SUN4I_TCON0_CTL_TCON_ENABLE,
 				   SUN4I_TCON0_CTL_TCON_ENABLE);
@@ -85,7 +88,8 @@ void sun4i_tcon_channel_enable(struct sun4i_tcon *tcon, int channel)
 	regmap_update_bits(tcon->regs, SUN4I_TCON1_CTL_REG,
 			   SUN4I_TCON1_CTL_TCON_ENABLE,
 			   SUN4I_TCON1_CTL_TCON_ENABLE);
-	clk_prepare_enable(tcon->sclk1);
+	if (tcon->quirks->has_channel_1_clk)
+		clk_prepare_enable(tcon->sclk1);
 }
 EXPORT_SYMBOL(sun4i_tcon_channel_enable);
 
@@ -132,6 +136,7 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 
 	/* Configure the dot clock */
 	clk_set_rate(tcon->dclk, mode->crtc_clock * 1000);
+	WARN_ON(!tcon->quirks->has_channel_0);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 0);
@@ -209,7 +214,8 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon,
 	WARN_ON(!tcon->quirks->has_channel_1);
 
 	/* Configure the dot clock */
-	clk_set_rate(tcon->sclk1, mode->crtc_clock * 1000);
+	if (tcon->quirks->has_channel_1_clk)
+		clk_set_rate(tcon->sclk1, mode->crtc_clock * 1000);
 
 	/* Adjust clock delay */
 	clk_delay = sun4i_tcon_get_clk_delay(mode, 1);
@@ -327,13 +333,15 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 	}
 	clk_prepare_enable(tcon->clk);
 
-	tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
-	if (IS_ERR(tcon->sclk0)) {
-		dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
-		return PTR_ERR(tcon->sclk0);
+	if (tcon->quirks->has_channel_0) {
+		tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
+		if (IS_ERR(tcon->sclk0)) {
+			dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
+			return PTR_ERR(tcon->sclk0);
+		}
 	}
 
-	if (tcon->quirks->has_channel_1) {
+	if (tcon->quirks->has_channel_1 && tcon->quirks->has_channel_1_clk) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
 		if (IS_ERR(tcon->sclk1)) {
 			dev_err(dev, "Couldn't get the TCON channel 1 clock\n");
@@ -533,10 +541,12 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 		goto err_free_clocks;
 	}
 
-	ret = sun4i_dclk_create(dev, tcon);
-	if (ret) {
-		dev_err(dev, "Couldn't create our TCON dot clock\n");
-		goto err_free_clocks;
+	if (tcon->quirks->has_channel_0) {
+		ret = sun4i_dclk_create(dev, tcon);
+		if (ret) {
+			dev_err(dev, "Couldn't create our TCON dot clock\n");
+			goto err_free_clocks;
+		}
 	}
 
 	ret = sun4i_tcon_init_irq(dev, tcon);
@@ -561,7 +571,8 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	return 0;
 
 err_free_dotclock:
-	sun4i_dclk_free(tcon);
+	if (tcon->quirks->has_channel_0)
+		sun4i_dclk_free(tcon);
 err_free_clocks:
 	sun4i_tcon_free_clocks(tcon);
 err_assert_reset:
@@ -575,7 +586,9 @@ static void sun4i_tcon_unbind(struct device *dev, struct device *master,
 	struct sun4i_tcon *tcon = dev_get_drvdata(dev);
 
 	list_del(&tcon->list);
-	sun4i_dclk_free(tcon);
+
+	if (tcon->quirks->has_channel_0)
+		sun4i_dclk_free(tcon);
 	sun4i_tcon_free_clocks(tcon);
 }
 
@@ -606,24 +619,41 @@ static int sun4i_tcon_remove(struct platform_device *pdev)
 }
 
 static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
-	.has_unknown_mux = true,
-	.has_channel_1	= true,
+	.has_unknown_mux	= true,
+	.has_channel_0		= true,
+	.has_channel_1		= true,
+	.has_channel_1_clk	= true,
 };
 
 static const struct sun4i_tcon_quirks sun6i_a31_quirks = {
-	.has_channel_1	= true,
+	.has_channel_0		= true,
+	.has_channel_1		= true,
+	.has_channel_1_clk	= true,
 };
 
 static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
-	.has_channel_1	= true,
+	.has_channel_0		= true,
+	.has_channel_1		= true,
+	.has_channel_1_clk	= true,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
-	/* nothing is supported */
+	.has_channel_0	= true,
 };
 
 static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
-	/* nothing is supported */
+	.has_channel_0	= true,
+};
+
+static const struct sun4i_tcon_quirks sun8i_h3_tcon0_quirks = {
+	.has_channel_1		= true,
+	.has_channel_1_clk	= true,
+	.swappable_input	= true,
+};
+
+static const struct sun4i_tcon_quirks sun8i_h3_tcon1_quirks = {
+	.has_channel_1		= true,
+	.swappable_input	= true,
 };
 
 static const struct of_device_id sun4i_tcon_of_table[] = {
@@ -632,6 +662,14 @@ static const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
+	{
+		.compatible = "allwinner,sun8i-h3-tcon0",
+		.data = &sun8i_h3_tcon0_quirks
+	},
+	{
+		.compatible = "allwinner,sun8i-h3-tcon1",
+		.data = &sun8i_h3_tcon1_quirks
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 568dc736238a..6aeb2d68b523 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -145,7 +145,10 @@
 
 struct sun4i_tcon_quirks {
 	bool	has_unknown_mux; /* sun5i has undocumented mux */
+	bool	has_channel_0;	/* some A83T+ TCONs don't have channel 0*/
 	bool	has_channel_1;	/* a33 does not have channel 1 */
+	/* H3 TCON1 doesn't have channel 1 sclk */
+	bool	has_channel_1_clk;
 	/* Some DE2 can swap the mixer<->TCON connection */
 	bool	swappable_input;
 };
-- 
2.12.2
