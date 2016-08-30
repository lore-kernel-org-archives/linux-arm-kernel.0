From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Tue, 30 Aug 2016 07:44:02 +0200
Subject: [PATCH v9 1/2] ASoC: sun4i-codec: Distinguish sun4i from sun7i
In-Reply-To: <20160830054403.7878-1-dannym@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
Message-ID: <20160830054403.7878-2-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This distinguishes sun4i from sun7i. It is necessary because they use
different registers for the audio mixer.
---
 sound/soc/sunxi/sun4i-codec.c | 44 +++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 0e19c50..30f4ea2 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -96,8 +96,9 @@
 /* Other various ADC registers */
 #define SUN4I_CODEC_DAC_TXCNT			(0x30)
 #define SUN4I_CODEC_ADC_RXCNT			(0x34)
-#define SUN4I_CODEC_AC_SYS_VERI			(0x38)
-#define SUN4I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
+
+#define SUN7I_CODEC_AC_DAC_CAL			(0x38)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
 struct sun4i_codec {
 	struct device	*dev;
@@ -509,10 +510,17 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 
-static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
-	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
-		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
-		       sun4i_codec_pa_volume_scale),
+#define SUN4I_COMMON_CODEC_CONTROLS \
+	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
+		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
+		       sun4i_codec_pa_volume_scale)
+
+static const struct snd_kcontrol_new sun4i_codec_controls[] = {
+	SUN4I_COMMON_CODEC_CONTROLS,
+};
+
+static const struct snd_kcontrol_new sun7i_codec_controls[] = {
+	SUN4I_COMMON_CODEC_CONTROLS,
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
@@ -629,8 +637,18 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
 	.component_driver = {
-		.controls		= sun4i_codec_widgets,
-		.num_controls		= ARRAY_SIZE(sun4i_codec_widgets),
+		.controls		= sun4i_codec_controls,
+		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
+		.dapm_widgets           = sun4i_codec_codec_dapm_widgets,
+		.num_dapm_widgets       = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+		.dapm_routes            = sun4i_codec_codec_dapm_routes,
+		.num_dapm_routes        = ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+	},
+};
+static struct snd_soc_codec_driver sun7i_codec_codec = {
+	.component_driver = {
+		.controls               = sun7i_codec_controls,
+		.num_controls           = ARRAY_SIZE(sun7i_codec_controls),
 		.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
 		.dapm_routes		= sun4i_codec_codec_dapm_routes,
@@ -682,7 +700,7 @@ static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-	.max_register	= SUN4I_CODEC_AC_MIC_PHONE_CAL,
+	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
 };
 
 static const struct of_device_id sun4i_codec_of_match[] = {
@@ -760,6 +778,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
 	struct sun4i_codec *scodec;
+	struct snd_soc_codec_driver *codec;
 	struct resource *res;
 	void __iomem *base;
 	int ret;
@@ -822,7 +841,12 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	scodec->capture_dma_data.maxburst = 4;
 	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
-	ret = snd_soc_register_codec(&pdev->dev, &sun4i_codec_codec,
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun7i-a20-codec"))
+		codec = &sun7i_codec_codec;
+	else
+		codec = &sun4i_codec_codec;
+	ret = snd_soc_register_codec(&pdev->dev, codec,
 				     &sun4i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our codec\n");
