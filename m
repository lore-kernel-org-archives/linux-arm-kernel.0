From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 19 Dec 2015 03:57:14 +0100
Subject: [linux-sunxi] [PATCH v7 1/2] sun4i-codec: Add FM, Line and Mic inputs
In-Reply-To: <20151219034511.372575d3@dayas>
References: <20151219034511.372575d3@dayas>
Message-ID: <20151219035714.295a969b@dayas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first part:

   sun4i-codec: make it possible to use different codec_widgets for A10 and A20.

Signed-off-by: Danny Milosavljevic <dannym+a@scratchpost.org>
---
  b/sound/soc/sunxi/sun4i-codec.c |   45 ++++++++++++++++++++++++++++++----------
  1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index e6cc6a1..6628e6e 100644
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
@@ -509,10 +510,13 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 
-static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
-	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
-		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
-		       sun4i_codec_pa_volume_scale),
+#define SUN4I_COMMON_CODEC_WIDGETS \
+	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
+		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
+		       sun4i_codec_pa_volume_scale)
+
+static const struct snd_kcontrol_new sun4i_codec_widgets_a10[] = {
+	SUN4I_COMMON_CODEC_WIDGETS,
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
@@ -627,9 +631,9 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Mic1", NULL, "VMIC" },
 };
 
-static struct snd_soc_codec_driver sun4i_codec_codec = {
-	.controls		= sun4i_codec_widgets,
-	.num_controls		= ARRAY_SIZE(sun4i_codec_widgets),
+static struct snd_soc_codec_driver sun4i_codec_codec_a10 = {
+	.controls		= sun4i_codec_widgets_a10,
+	.num_controls		= ARRAY_SIZE(sun4i_codec_widgets_a10),
 	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
 	.dapm_routes		= sun4i_codec_codec_dapm_routes,
@@ -680,7 +684,7 @@ static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-	.max_register	= SUN4I_CODEC_AC_MIC_PHONE_CAL,
+	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
 };
 
 static const struct of_device_id sun4i_codec_of_match[] = {
@@ -753,10 +757,24 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	return card;
 };
 
+static const struct snd_kcontrol_new sun7i_codec_widgets[] = {
+	SUN4I_COMMON_CODEC_WIDGETS,
+};
+
+static struct snd_soc_codec_driver sun7i_codec_codec = {
+	.controls		= sun7i_codec_widgets,
+	.num_controls		= ARRAY_SIZE(sun7i_codec_widgets),
+	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+	.dapm_routes		= sun4i_codec_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+};
+
 static int sun4i_codec_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
 	struct sun4i_codec *scodec;
+	struct snd_soc_codec_driver *codec;
 	struct resource *res;
 	void __iomem *base;
 	int ret;
@@ -819,7 +837,12 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	scodec->capture_dma_data.maxburst = 4;
 	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
-	ret = snd_soc_register_codec(&pdev->dev, &sun4i_codec_codec,
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun7i-a20-codec"))
+		codec = &sun7i_codec_codec;
+	else
+		codec = &sun4i_codec_codec_a10;
+	ret = snd_soc_register_codec(&pdev->dev, codec,
 				     &sun4i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our codec\n");
