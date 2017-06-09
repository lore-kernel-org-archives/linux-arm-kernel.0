From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 22:49:32 +0200
Subject: [PATCH v12 03/14] sun4i-codec: Add support for extra controls to
 struct sun4i_codec_quirks and use them.
In-Reply-To: <20170609204943.29116-1-dannym@scratchpost.org>
References: <20170609204943.29116-1-dannym@scratchpost.org>
Message-ID: <20170609204943.29116-4-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controls use different registers depending on which Allwinner chip it is.
Provide a means of specifying and adding those controls.
---
 sound/soc/sunxi/sun4i-codec.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 49b9cd1..42952af 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -777,7 +777,30 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Mic2", NULL, "VMIC" },
 };
 
+struct sun4i_codec_quirks {
+	const struct regmap_config *regmap_config;
+	const struct snd_soc_codec_driver *codec;
+	struct snd_soc_card * (*create_card)(struct device *dev);
+	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
+	bool has_reset;
+	const struct snd_kcontrol_new *controls;
+	unsigned int num_controls;
+};
+
+static int sun4i_codec_codec_probe(struct snd_soc_codec *scodec)
+{
+	const struct sun4i_codec_quirks *quirks;
+
+	quirks = of_device_get_match_data(scodec->dev);
+	return snd_soc_add_codec_controls(scodec,
+					  quirks->controls,
+					  quirks->num_controls);
+}
+
 static struct snd_soc_codec_driver sun4i_codec_codec = {
+	.probe = sun4i_codec_codec_probe,
 	.component_driver = {
 		.controls		= sun4i_codec_controls,
 		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
@@ -1434,16 +1457,6 @@ static const struct regmap_config sun8i_v3s_codec_regmap_config = {
 	.max_register	= SUN8I_H3_CODEC_ADC_DBG,
 };
 
-struct sun4i_codec_quirks {
-	const struct regmap_config *regmap_config;
-	const struct snd_soc_codec_driver *codec;
-	struct snd_soc_card * (*create_card)(struct device *dev);
-	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
-	bool has_reset;
-};
-
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.regmap_config	= &sun4i_codec_regmap_config,
 	.codec		= &sun4i_codec_codec,
-- 
2.1.4
