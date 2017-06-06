From: broonie@kernel.org (Mark Brown)
Date: Tue, 06 Jun 2017 20:06:08 +0100
Subject: Applied "ASoC: sun4i-codec: Add support for V3s codec" to the asoc
 tree
In-Reply-To: <20170524100607.29790-5-icenowy@aosc.io>
Message-ID: <E1dIJns-0007Di-By@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Add support for V3s codec

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

>From 8b2840b6daca728cecfa925b50bf638189e2fbca Mon Sep 17 00:00:00 2001
From: Icenowy Zheng <icenowy@aosc.xyz>
Date: Mon, 5 Jun 2017 21:27:22 +0800
Subject: [PATCH] ASoC: sun4i-codec: Add support for V3s codec

The codec in the V3s is similar to the one found on the A31. One key
difference is the analog path controls are routed through the PRCM
block. This is supported by the sun8i-codec-analog driver, and tied
into this codec driver with the audio card's aux_dev.

In addition, the V3s does not have LINEIN, LINEOUT, MBIAS and MIC2,
MIC3, and the FIFO related registers are like H3.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      | 11 ++--
 sound/soc/sunxi/sun4i-codec.c                      | 63 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 3863531d1e6d..2d4e10deb6f4 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -7,6 +7,7 @@ Required properties:
 		- "allwinner,sun7i-a20-codec"
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
+		- "allwinner,sun8i-v3s-codec"
 - reg: must contain the registers location and length
 - interrupts: must contain the codec interrupt
 - dmas: DMA channels for tx and rx dma. See the DMA client binding,
@@ -25,6 +26,7 @@ Required properties for the following compatibles:
 		- "allwinner,sun6i-a31-codec"
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
+		- "allwinner,sun8i-v3s-codec"
 - resets: phandle to the reset control for this device
 - allwinner,audio-routing: A list of the connections between audio components.
 			   Each entry is a pair of strings, the first being the
@@ -34,15 +36,15 @@ Required properties for the following compatibles:
 			   Audio pins on the SoC:
 			   "HP"
 			   "HPCOM"
-			   "LINEIN"
-			   "LINEOUT"	(not on sun8i-a23)
+			   "LINEIN"	(not on sun8i-v3s)
+			   "LINEOUT"	(not on sun8i-a23 or sun8i-v3s)
 			   "MIC1"
-			   "MIC2"
+			   "MIC2"	(not on sun8i-v3s)
 			   "MIC3"	(sun6i-a31 only)
 
 			   Microphone biases from the SoC:
 			   "HBIAS"
-			   "MBIAS"
+			   "MBIAS"	(not on sun8i-v3s)
 
 			   Board connectors:
 			   "Headphone"
@@ -55,6 +57,7 @@ Required properties for the following compatibles:
 Required properties for the following compatibles:
 		- "allwinner,sun8i-a23-codec"
 		- "allwinner,sun8i-h3-codec"
+		- "allwinner,sun8i-v3s-codec"
 - allwinner,codec-analog-controls: A phandle to the codec analog controls
 				   block in the PRCM.
 
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index c3aab10fa085..150069987c0c 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1339,6 +1339,44 @@ static struct snd_soc_card *sun8i_h3_codec_create_card(struct device *dev)
 	return card;
 };
 
+static struct snd_soc_card *sun8i_v3s_codec_create_card(struct device *dev)
+{
+	struct snd_soc_card *card;
+	int ret;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return ERR_PTR(-ENOMEM);
+
+	aux_dev.codec_of_node = of_parse_phandle(dev->of_node,
+						 "allwinner,codec-analog-controls",
+						 0);
+	if (!aux_dev.codec_of_node) {
+		dev_err(dev, "Can't find analog controls for codec.\n");
+		return ERR_PTR(-EINVAL);
+	};
+
+	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
+	if (!card->dai_link)
+		return ERR_PTR(-ENOMEM);
+
+	card->dev		= dev;
+	card->name		= "V3s Audio Codec";
+	card->dapm_widgets	= sun6i_codec_card_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(sun6i_codec_card_dapm_widgets);
+	card->dapm_routes	= sun8i_codec_card_routes;
+	card->num_dapm_routes	= ARRAY_SIZE(sun8i_codec_card_routes);
+	card->aux_dev		= &aux_dev;
+	card->num_aux_devs	= 1;
+	card->fully_routed	= true;
+
+	ret = snd_soc_of_parse_audio_routing(card, "allwinner,audio-routing");
+	if (ret)
+		dev_warn(dev, "failed to parse audio-routing: %d\n", ret);
+
+	return card;
+};
+
 static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1374,6 +1412,13 @@ static const struct regmap_config sun8i_h3_codec_regmap_config = {
 	.max_register	= SUN8I_H3_CODEC_ADC_DBG,
 };
 
+static const struct regmap_config sun8i_v3s_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN8I_H3_CODEC_ADC_DBG,
+};
+
 struct sun4i_codec_quirks {
 	const struct regmap_config *regmap_config;
 	const struct snd_soc_codec_driver *codec;
@@ -1437,6 +1482,20 @@ static const struct sun4i_codec_quirks sun8i_h3_codec_quirks = {
 	.has_reset	= true,
 };
 
+static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
+	.regmap_config	= &sun8i_v3s_codec_regmap_config,
+	/*
+	 * TODO The codec structure should be split out, like
+	 * H3, when adding digital audio processing support.
+	 */
+	.codec		= &sun8i_a23_codec_codec,
+	.create_card	= sun8i_v3s_codec_create_card,
+	.reg_adc_fifoc	= REG_FIELD(SUN6I_CODEC_ADC_FIFOC, 0, 31),
+	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
+	.has_reset	= true,
+};
+
 static const struct of_device_id sun4i_codec_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-codec",
@@ -1458,6 +1517,10 @@ static const struct of_device_id sun4i_codec_of_match[] = {
 		.compatible = "allwinner,sun8i-h3-codec",
 		.data = &sun8i_h3_codec_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-v3s-codec",
+		.data = &sun8i_v3s_codec_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
-- 
2.11.0
