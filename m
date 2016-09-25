From: broonie@kernel.org (Mark Brown)
Date: Sat, 24 Sep 2016 22:58:48 -0700
Subject: Applied "ASoC: sun4i-codec: Add custom regmap configs" to the asoc
 tree
In-Reply-To: <20160922071313.12891-4-dannym@scratchpost.org>
Message-ID: <E1bo2Se-00033P-Gr@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Add custom regmap configs

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

>From c1d5065a0bd09bac783120b73bfa768ba6a493d9 Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Thu, 22 Sep 2016 09:13:13 +0200
Subject: [PATCH] ASoC: sun4i-codec: Add custom regmap configs

The A20 has a few extra registers that the A10 doesn't have.
Therefore, use different regmaps for A10 as compared to A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 9d8c027f7c55..eb6808842208 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -680,12 +680,37 @@ static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
+	.max_register	= SUN4I_CODEC_ADC_RXCNT,
+};
+
+static const struct regmap_config sun7i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
 	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
 };
 
+struct sun4i_codec_quirks {
+	const struct regmap_config *regmap_config;
+};
+
+static const struct sun4i_codec_quirks sun4i_codec_quirks = {
+	.regmap_config = &sun4i_codec_regmap_config,
+};
+
+static const struct sun4i_codec_quirks sun7i_codec_quirks = {
+	.regmap_config = &sun7i_codec_regmap_config,
+};
+
 static const struct of_device_id sun4i_codec_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-codec" },
-	{ .compatible = "allwinner,sun7i-a20-codec" },
+	{
+		.compatible = "allwinner,sun4i-a10-codec",
+		.data = &sun4i_codec_quirks,
+	},
+	{
+		.compatible = "allwinner,sun7i-a20-codec",
+		.data = &sun7i_codec_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
@@ -758,6 +783,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
 	struct sun4i_codec *scodec;
+	const struct sun4i_codec_quirks *quirks;
 	struct resource *res;
 	void __iomem *base;
 	int ret;
@@ -775,8 +801,14 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (quirks == NULL) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
+
 	scodec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					     &sun4i_codec_regmap_config);
+					       quirks->regmap_config);
 	if (IS_ERR(scodec->regmap)) {
 		dev_err(&pdev->dev, "Failed to create our regmap\n");
 		return PTR_ERR(scodec->regmap);
-- 
2.9.3
