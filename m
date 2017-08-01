From: broonie@kernel.org (Mark Brown)
Date: Tue, 01 Aug 2017 15:16:33 +0100
Subject: Applied "ASoC: sun4i-i2s: Extend quirks scope" to the asoc tree
In-Reply-To: <20170729141753.20174-2-codekipper@gmail.com>
Message-ID: <E1dcXyL-0008Lz-2M@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-i2s: Extend quirks scope

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 47bea0c836867b6b1cdb714d58f2bfc8e2f5c386 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Sat, 29 Jul 2017 16:17:42 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Extend quirks scope

In preparation for the changes required to support newer SoCs then
quirks has been moved and also added to the device structure.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 62b307b0c846..d7ee7a443e4e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -90,6 +90,15 @@
 #define SUN4I_I2S_RX_CHAN_SEL_REG	0x38
 #define SUN4I_I2S_RX_CHAN_MAP_REG	0x3c
 
+/**
+ * struct sun4i_i2s_quirks - Differences between SoC variants.
+ *
+ * @has_reset: SoC needs reset deasserted.
+ */
+struct sun4i_i2s_quirks {
+	bool				has_reset;
+};
+
 struct sun4i_i2s {
 	struct clk	*bus_clk;
 	struct clk	*mod_clk;
@@ -100,6 +109,8 @@ struct sun4i_i2s {
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
+
+	const struct sun4i_i2s_quirks	*variant;
 };
 
 struct sun4i_i2s_clk_div {
@@ -654,10 +665,6 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-struct sun4i_i2s_quirks {
-	bool has_reset;
-};
-
 static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_reset	= false,
 };
@@ -669,7 +676,6 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
-	const struct sun4i_i2s_quirks *quirks;
 	struct resource *res;
 	void __iomem *regs;
 	int irq, ret;
@@ -690,8 +696,8 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	quirks = of_device_get_match_data(&pdev->dev);
-	if (!quirks) {
+	i2s->variant = of_device_get_match_data(&pdev->dev);
+	if (!i2s->variant) {
 		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
 		return -ENODEV;
 	}
@@ -715,7 +721,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->mod_clk);
 	}
 
-	if (quirks->has_reset) {
+	if (i2s->variant->has_reset) {
 		i2s->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 		if (IS_ERR(i2s->rst)) {
 			dev_err(&pdev->dev, "Failed to get reset control\n");
-- 
2.13.2
