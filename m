From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 20:34:36 +0800
Subject: [PATCH v2 2/8] ASoC: sun4i-codec: Add support for A23 codec
In-Reply-To: <20161125123442.28410-1-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
Message-ID: <20161125123442.28410-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The codec in the A23 is similar to the one found on the A31. One key
difference is the analog path controls are routed through the PRCM
block. This is supported by the sun8i-codec-analog driver, and tied
into this codec driver with the audio card's aux_dev.

In addition, the A23 does not have LINEOUT, and it does not support
headset jack detection or buttons.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      |  11 ++-
 sound/soc/sunxi/sun4i-codec.c                      | 108 +++++++++++++++++++++
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index d91a95377f49..f7a548b604fc 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -5,6 +5,7 @@ Required properties:
 		- "allwinner,sun4i-a10-codec"
 		- "allwinner,sun6i-a31-codec"
 		- "allwinner,sun7i-a20-codec"
+		- "allwinner,sun8i-a23-codec"
 - reg: must contain the registers location and length
 - interrupts: must contain the codec interrupt
 - dmas: DMA channels for tx and rx dma. See the DMA client binding,
@@ -21,6 +22,7 @@ Optional properties:
 
 Required properties for the following compatibles:
 		- "allwinner,sun6i-a31-codec"
+		- "allwinner,sun8i-a23-codec"
 - resets: phandle to the reset control for this device
 - allwinner,audio-routing: A list of the connections between audio components.
 			   Each entry is a pair of strings, the first being the
@@ -31,10 +33,10 @@ Required properties for the following compatibles:
 			   "HP"
 			   "HPCOM"
 			   "LINEIN"
-			   "LINEOUT"
+			   "LINEOUT"	(not on sun8i-a23)
 			   "MIC1"
 			   "MIC2"
-			   "MIC3"
+			   "MIC3"	(sun6i-a31 only)
 
 			   Microphone biases from the SoC:
 			   "HBIAS"
@@ -48,6 +50,11 @@ Required properties for the following compatibles:
 			   "Mic"
 			   "Speaker"
 
+Required properties for the following compatibles:
+		- "allwinner,sun8i-a23-codec"
+- allwinner,codec-analog-controls: A phandle to the codec analog controls
+				   block in the PRCM.
+
 Example:
 codec: codec at 01c22c00 {
 	#sound-dai-cells = <0>;
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 092fdcf6de95..ada5fa055950 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -213,6 +213,10 @@
 
 /* TODO sun6i DAP (Digital Audio Processing) bits */
 
+/* FIFO counters moved on A23 */
+#define SUN8I_A23_CODEC_DAC_TXCNT		(0x1c)
+#define SUN8I_A23_CODEC_ADC_RXCNT		(0x20)
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -1067,6 +1071,32 @@ static struct snd_soc_codec_driver sun6i_codec_codec = {
 	},
 };
 
+/* sun8i A23 codec */
+static const struct snd_kcontrol_new sun8i_a23_codec_codec_controls[] = {
+	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
+		       SUN4I_CODEC_DAC_DPC_DVOL, 0x3f, 1,
+		       sun6i_codec_dvol_scale),
+};
+
+static const struct snd_soc_dapm_widget sun8i_a23_codec_codec_widgets[] = {
+	/* Digital parts of the ADCs */
+	SND_SOC_DAPM_SUPPLY("ADC Enable", SUN6I_CODEC_ADC_FIFOC,
+			    SUN6I_CODEC_ADC_FIFOC_EN_AD, 0, NULL, 0),
+	/* Digital parts of the DACs */
+	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
+			    SUN4I_CODEC_DAC_DPC_EN_DA, 0, NULL, 0),
+
+};
+
+static struct snd_soc_codec_driver sun8i_a23_codec_codec = {
+	.component_driver = {
+		.controls		= sun8i_a23_codec_codec_controls,
+		.num_controls		= ARRAY_SIZE(sun8i_a23_codec_codec_controls),
+		.dapm_widgets		= sun8i_a23_codec_codec_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(sun8i_a23_codec_codec_widgets),
+	},
+};
+
 static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name = "sun4i-codec",
 };
@@ -1206,6 +1236,63 @@ static struct snd_soc_card *sun6i_codec_create_card(struct device *dev)
 	return card;
 };
 
+/* Connect digital side enables to analog side widgets */
+static const struct snd_soc_dapm_route sun8i_codec_card_routes[] = {
+	/* ADC Routes */
+	{ "Left ADC", NULL, "ADC Enable" },
+	{ "Right ADC", NULL, "ADC Enable" },
+	{ "Codec Capture", NULL, "Left ADC" },
+	{ "Codec Capture", NULL, "Right ADC" },
+
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+	{ "Left DAC", NULL, "Codec Playback" },
+	{ "Right DAC", NULL, "Codec Playback" },
+};
+
+static struct snd_soc_aux_dev aux_dev = {
+	.name = "Codec Analog Controls",
+};
+
+static struct snd_soc_card *sun8i_a23_codec_create_card(struct device *dev)
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
+	card->name		= "A23 Audio Codec";
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
@@ -1227,6 +1314,13 @@ static const struct regmap_config sun7i_codec_regmap_config = {
 	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
 };
 
+static const struct regmap_config sun8i_a23_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN8I_A23_CODEC_ADC_RXCNT,
+};
+
 struct sun4i_codec_quirks {
 	const struct regmap_config *regmap_config;
 	const struct snd_soc_codec_driver *codec;
@@ -1265,6 +1359,16 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
 };
 
+static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
+	.regmap_config	= &sun8i_a23_codec_regmap_config,
+	.codec		= &sun8i_a23_codec_codec,
+	.create_card	= sun8i_a23_codec_create_card,
+	.reg_adc_fifoc	= REG_FIELD(SUN6I_CODEC_ADC_FIFOC, 0, 31),
+	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
+	.has_reset	= true,
+};
+
 static const struct of_device_id sun4i_codec_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-codec",
@@ -1278,6 +1382,10 @@ static const struct of_device_id sun4i_codec_of_match[] = {
 		.compatible = "allwinner,sun7i-a20-codec",
 		.data = &sun7i_codec_quirks,
 	},
+	{
+		.compatible = "allwinner,sun8i-a23-codec",
+		.data = &sun8i_a23_codec_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
-- 
2.10.2
