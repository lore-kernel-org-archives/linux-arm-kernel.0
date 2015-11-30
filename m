From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Nov 2015 16:37:47 +0100
Subject: [PATCH] ASoC: sun4i: Implement MIC1 capture
Message-ID: <1448897867-22320-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the input path used in the Allwinner codec is the MIC1. Add support
for it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun4i-codec.c | 228 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 197 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index bcbf4da168b6..30c9e9260491 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -69,6 +69,7 @@
 
 /* Codec ADC register offsets and bit fields */
 #define SUN4I_CODEC_ADC_FIFOC			(0x1c)
+#define SUN4I_CODEC_ADC_FIFOC_ADC_FS			(29)
 #define SUN4I_CODEC_ADC_FIFOC_EN_AD			(28)
 #define SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE		(24)
 #define SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL		(8)
@@ -102,6 +103,7 @@ struct sun4i_codec {
 	struct clk	*clk_apb;
 	struct clk	*clk_module;
 
+	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 };
 
@@ -136,26 +138,54 @@ static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 			   0);
 }
 
+static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
+{
+	/*
+	 * FIXME: according to the BSP, we might need to drive a PA
+	 *        GPIO high here on some boards
+	 */
+
+	/* Enable ADC DRQ */
+	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN),
+			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
+}
+
+static void sun4i_codec_stop_capture(struct sun4i_codec *scodec)
+{
+	/*
+	 * FIXME: according to the BSP, we might need to drive a PA
+	 *        GPIO low here on some boards
+	 */
+
+	/* Disable ADC DRQ */
+	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN), 0);
+}
+
 static int sun4i_codec_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
 
-	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
-		return -ENOTSUPP;
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		sun4i_codec_start_playback(scodec);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			sun4i_codec_start_playback(scodec);
+		else
+			sun4i_codec_start_capture(scodec);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		sun4i_codec_stop_playback(scodec);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			sun4i_codec_stop_playback(scodec);
+		else
+			sun4i_codec_stop_capture(scodec);
 		break;
 
 	default:
@@ -165,15 +195,54 @@ static int sun4i_codec_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int sun4i_codec_prepare(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
+static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
+				       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
-	u32 val;
 
-	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
-		return -ENOTSUPP;
+
+	/* Flush RX FIFO */
+	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+			   BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH),
+			   BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH));
+
+
+	/* Set RX FIFO trigger level */
+	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+			   0xf << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
+			   0x7 << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL);
+
+	/*
+	 * FIXME: Undocumented in the datasheet, but
+	 *        Allwinner's code mentions that it is related
+	 *        related to microphone gain
+	 */
+	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_ACTL,
+			   0x3 << 25,
+			   0x1 << 25);
+
+	if (of_device_is_compatible(scodec->dev->of_node,
+				    "allwinner,sun7i-a20-codec"))
+		/* FIXME: Undocumented bits */
+		regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_TUNE,
+				   0x3 << 8,
+				   0x1 << 8);
+
+	/* Fill most significant bits with valid data MSB */
+	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+			   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
+			   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
+
+	return 0;
+}
+
+static int sun4i_codec_prepare_playback(struct snd_pcm_substream *substream,
+					struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
+	u32 val;
 
 	/* Flush the TX FIFO */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
@@ -202,6 +271,15 @@ static int sun4i_codec_prepare(struct snd_pcm_substream *substream,
 			   0);
 
 	return 0;
+};
+
+static int sun4i_codec_prepare(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return sun4i_codec_prepare_playback(substream, dai);
+
+	return sun4i_codec_prepare_capture(substream, dai);
 }
 
 static unsigned long sun4i_codec_get_mod_freq(struct snd_pcm_hw_params *params)
@@ -276,30 +354,34 @@ static int sun4i_codec_get_hw_rate(struct snd_pcm_hw_params *params)
 	}
 }
 
-static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
-				 struct snd_pcm_hw_params *params,
-				 struct snd_soc_dai *dai)
+static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
+					 struct snd_pcm_hw_params *params,
+					 unsigned int hwrate)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
-	unsigned long clk_freq;
-	int ret, hwrate;
 	u32 val;
 
-	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
-		return -ENOTSUPP;
+	/* Set ADC sample rate */
+	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+			   7 << SUN4I_CODEC_ADC_FIFOC_ADC_FS,
+			   hwrate << SUN4I_CODEC_ADC_FIFOC_ADC_FS);
 
-	clk_freq = sun4i_codec_get_mod_freq(params);
-	if (!clk_freq)
-		return -EINVAL;
+	/* Set the number of channels we want to use */
+	if (params_channels(params) == 1)
+		regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
+				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
+	else
+		regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN), 0);
 
-	ret = clk_set_rate(scodec->clk_module, clk_freq);
-	if (ret)
-		return ret;
+	return 0;
+}
 
-	hwrate = sun4i_codec_get_hw_rate(params);
-	if (hwrate < 0)
-		return hwrate;
+static int sun4i_codec_hw_params_playback(struct sun4i_codec *scodec,
+					  struct snd_pcm_hw_params *params,
+					  unsigned int hwrate)
+{
+	u32 val;
 
 	/* Set DAC sample rate */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
@@ -344,6 +426,34 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long clk_freq;
+	int hwrate;
+
+	clk_freq = sun4i_codec_get_mod_freq(params);
+	if (!clk_freq)
+		return -EINVAL;
+
+	if (clk_set_rate(scodec->clk_module, clk_freq))
+		return -EINVAL;
+
+	hwrate = sun4i_codec_get_hw_rate(params);
+	if (hwrate < 0)
+		return hwrate;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return sun4i_codec_hw_params_playback(scodec, params,
+						      hwrate);
+
+	return sun4i_codec_hw_params_capture(scodec, params,
+					     hwrate);
+}
+
 static int sun4i_codec_startup(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
@@ -394,6 +504,20 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.sig_bits	= 24,
 	},
+	.capture = {
+		.stream_name	= "Codec Capture",
+		.channels_min	= 1,
+		.channels_max	= 2,
+		.rate_min	= 8000,
+		.rate_max	= 192000,
+		.rates		= SNDRV_PCM_RATE_8000_48000 |
+				  SNDRV_PCM_RATE_96000 |
+				  SNDRV_PCM_RATE_192000 |
+				  SNDRV_PCM_RATE_KNOT,
+		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
+				  SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits	= 24,
+	},
 };
 
 /*** Codec ***/
@@ -429,11 +553,22 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mixer_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
+	/* Digital parts of the ADCs */
+	SND_SOC_DAPM_SUPPLY("ADC", SUN4I_CODEC_ADC_FIFOC,
+			    SUN4I_CODEC_ADC_FIFOC_EN_AD, 0,
+			    NULL, 0),
+
 	/* Digital parts of the DACs */
 	SND_SOC_DAPM_SUPPLY("DAC", SUN4I_CODEC_DAC_DPC,
 			    SUN4I_CODEC_DAC_DPC_EN_DA, 0,
 			    NULL, 0),
 
+	/* Analog parts of the ADCs */
+	SND_SOC_DAPM_ADC("Left ADC", "Codec Capture", SUN4I_CODEC_ADC_ACTL,
+			 SUN4I_CODEC_ADC_ACTL_ADC_L_EN, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Codec Capture", SUN4I_CODEC_ADC_ACTL,
+			 SUN4I_CODEC_ADC_ACTL_ADC_R_EN, 0),
+
 	/* Analog parts of the DACs */
 	SND_SOC_DAPM_DAC("Left DAC", "Codec Playback", SUN4I_CODEC_DAC_ACTL,
 			 SUN4I_CODEC_DAC_ACTL_DACAENL, 0),
@@ -452,6 +587,14 @@ static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
 			    SUN4I_CODEC_DAC_ACTL_MIXEN, 0, NULL, 0),
 
+	/* VMIC */
+	SND_SOC_DAPM_SUPPLY("VMIC", SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_VMICEN, 0, NULL, 0),
+
+	/* Mic Pre-Amplifiers */
+	SND_SOC_DAPM_PGA("MIC1 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+			 SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),
+
 	/* Pre-Amplifier */
 	SND_SOC_DAPM_MIXER("Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
 			   SUN4I_CODEC_ADC_ACTL_PA_EN, 0,
@@ -460,15 +603,19 @@ static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Pre-Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	SND_SOC_DAPM_INPUT("Mic1"),
+
 	SND_SOC_DAPM_OUTPUT("HP Right"),
 	SND_SOC_DAPM_OUTPUT("HP Left"),
 };
 
 static const struct snd_soc_dapm_route sun4i_codec_dapm_routes[] = {
-	/* Left DAC Routes */
+	/* Left ADC / DAC Routes */
+	{ "Left ADC", NULL, "ADC" },
 	{ "Left DAC", NULL, "DAC" },
 
-	/* Right DAC Routes */
+	/* Right ADC / DAC Routes */
+	{ "Right ADC", NULL, "ADC" },
 	{ "Right DAC", NULL, "DAC" },
 
 	/* Right Mixer Routes */
@@ -490,6 +637,12 @@ static const struct snd_soc_dapm_route sun4i_codec_dapm_routes[] = {
 	{ "Pre-Amplifier Mute", "Switch", "Pre-Amplifier" },
 	{ "HP Right", NULL, "Pre-Amplifier Mute" },
 	{ "HP Left", NULL, "Pre-Amplifier Mute" },
+
+	/* Mic1 Routes */
+	{ "Left ADC", NULL, "MIC1 Pre-Amplifier" },
+	{ "Right ADC", NULL, "MIC1 Pre-Amplifier" },
+	{ "MIC1 Pre-Amplifier", NULL, "Mic1"},
+	{ "Mic1", NULL, "VMIC" },
 };
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
@@ -515,7 +668,7 @@ static int sun4i_codec_dai_probe(struct snd_soc_dai *dai)
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(card);
 
 	snd_soc_dai_init_dma_data(dai, &scodec->playback_dma_data,
-				  NULL);
+				  &scodec->capture_dma_data);
 
 	return 0;
 }
@@ -531,6 +684,14 @@ static struct snd_soc_dai_driver dummy_cpu_dai = {
 		.formats	= SUN4I_CODEC_FORMATS,
 		.sig_bits	= 24,
 	},
+	.capture = {
+		.stream_name	= "Capture",
+		.channels_min	= 1,
+		.channels_max	= 2,
+		.rates 		= SUN4I_CODEC_RATES,
+		.formats 	= SUN4I_CODEC_FORMATS,
+		.sig_bits	= 24,
+	 },
 };
 
 static const struct regmap_config sun4i_codec_regmap_config = {
@@ -638,6 +799,11 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	scodec->playback_dma_data.maxburst = 4;
 	scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
+	/* DMA configuration for RX FIFO */
+	scodec->capture_dma_data.addr = res->start + SUN4I_CODEC_ADC_RXDATA;
+	scodec->capture_dma_data.maxburst = 4;
+	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+
 	ret = snd_soc_register_codec(&pdev->dev, &sun4i_codec_codec,
 				     &sun4i_codec_dai, 1);
 	if (ret) {
-- 
2.6.3
