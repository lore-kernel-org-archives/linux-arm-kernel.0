From: broonie@kernel.org (Mark Brown)
Date: Thu, 03 Nov 2016 11:26:21 -0600
Subject: Applied "ASoC: sun4i-codec: Move data structures to add create_card
 call to quirks" to the asoc tree
In-Reply-To: <20161103075556.29018-2-wens@csie.org>
Message-ID: <E1c2LmP-0002ac-DL@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Move data structures to add create_card call to quirks

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

>From 2f2a3462bc15e9613412ca186bf8a6611afa66c7 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Nov 2016 15:55:43 +0800
Subject: [PATCH] ASoC: sun4i-codec: Move data structures to add create_card
 call to quirks

The audio codec on later Allwinner SoCs have a different layout and
audio path compared to the A10/A20. However the PCM parts are still
the same.

The different layout and audio paths mean we need a different
create_card function for different families, so they can create
DAPM endpoint widgets and routes.

This patch moves the regmap configs, quirks and of_device_id
structures to just before the probe function, so we can, among other
things, include a pointer for the create_card function. None of the
lines of code were changed.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 78 +++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index a60707761abf..7b78f4045d38 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -678,45 +678,6 @@ static struct snd_soc_dai_driver dummy_cpu_dai = {
 	 },
 };
 
-static const struct regmap_config sun4i_codec_regmap_config = {
-	.reg_bits	= 32,
-	.reg_stride	= 4,
-	.val_bits	= 32,
-	.max_register	= SUN4I_CODEC_ADC_RXCNT,
-};
-
-static const struct regmap_config sun7i_codec_regmap_config = {
-	.reg_bits	= 32,
-	.reg_stride	= 4,
-	.val_bits	= 32,
-	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
-};
-
-struct sun4i_codec_quirks {
-	const struct regmap_config *regmap_config;
-};
-
-static const struct sun4i_codec_quirks sun4i_codec_quirks = {
-	.regmap_config = &sun4i_codec_regmap_config,
-};
-
-static const struct sun4i_codec_quirks sun7i_codec_quirks = {
-	.regmap_config = &sun7i_codec_regmap_config,
-};
-
-static const struct of_device_id sun4i_codec_of_match[] = {
-	{
-		.compatible = "allwinner,sun4i-a10-codec",
-		.data = &sun4i_codec_quirks,
-	},
-	{
-		.compatible = "allwinner,sun7i-a20-codec",
-		.data = &sun7i_codec_quirks,
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
-
 static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 							int *num_links)
 {
@@ -781,6 +742,45 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	return card;
 };
 
+static const struct regmap_config sun4i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN4I_CODEC_ADC_RXCNT,
+};
+
+static const struct regmap_config sun7i_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
+};
+
+struct sun4i_codec_quirks {
+	const struct regmap_config *regmap_config;
+};
+
+static const struct sun4i_codec_quirks sun4i_codec_quirks = {
+	.regmap_config	= &sun4i_codec_regmap_config,
+};
+
+static const struct sun4i_codec_quirks sun7i_codec_quirks = {
+	.regmap_config	= &sun7i_codec_regmap_config,
+};
+
+static const struct of_device_id sun4i_codec_of_match[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-codec",
+		.data = &sun4i_codec_quirks,
+	},
+	{
+		.compatible = "allwinner,sun7i-a20-codec",
+		.data = &sun7i_codec_quirks,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
+
 static int sun4i_codec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
-- 
2.10.1
