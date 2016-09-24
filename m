From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 24 Sep 2016 22:05:03 +0200
Subject: [PATCH v6 3/3] ASoC: sun4i-codec: Add custom regmap configs
In-Reply-To: <20160924200503.10728-1-dannym@scratchpost.org>
References: <20160924200503.10728-1-dannym@scratchpost.org>
Message-ID: <20160924200503.10728-4-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 has a few extra registers that the A10 doesn't have.
Therefore, use different regmaps for A10 as compared to A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 3b53b78..e047ec0 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -682,12 +682,37 @@ static const struct regmap_config sun4i_codec_regmap_config = {
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
@@ -760,6 +785,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
 	struct sun4i_codec *scodec;
+	const struct sun4i_codec_quirks *quirks;
 	struct resource *res;
 	void __iomem *base;
 	int ret;
@@ -777,8 +803,14 @@ static int sun4i_codec_probe(struct platform_device *pdev)
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
