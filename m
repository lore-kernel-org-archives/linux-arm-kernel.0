From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Wed, 13 Dec 2017 13:34:07 +0100
Subject: [PATCH 1/2] ASoC: sun8i-codec: Add ADC support for a33
In-Reply-To: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
References: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
Message-ID: <20171213123408.10422-2-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ADC support for the sun8i-codec driver.

This driver uses microphones widgets and routes provided by the
analog part (sun8i-codec-analog).
Some digital configurations are needed by creating new ADC widgets
and routes.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 sound/soc/sunxi/sun8i-codec.c | 82 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 3dd183be08a4..7a15df924316 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -37,9 +37,11 @@
 #define SUN8I_SYSCLK_CTL_SYSCLK_SRC			0
 #define SUN8I_MOD_CLK_ENA				0x010
 #define SUN8I_MOD_CLK_ENA_AIF1				15
+#define SUN8I_MOD_CLK_ENA_ADC				3
 #define SUN8I_MOD_CLK_ENA_DAC				2
 #define SUN8I_MOD_RST_CTL				0x014
 #define SUN8I_MOD_RST_CTL_AIF1				15
+#define SUN8I_MOD_RST_CTL_ADC				3
 #define SUN8I_MOD_RST_CTL_DAC				2
 #define SUN8I_SYS_SR_CTRL				0x018
 #define SUN8I_SYS_SR_CTRL_AIF1_FS			12
@@ -54,9 +56,25 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
+#define SUN8I_AIF1_ADCDAT_CTRL				0x044
+#define SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0L_ENA		15
+#define SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0R_ENA		14
 #define SUN8I_AIF1_DACDAT_CTRL				0x048
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA		15
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA		14
+#define SUN8I_AIF1_MXR_SRC				0x04c
+#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF1DA0L	15
+#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACL	14
+#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_ADCL		13
+#define SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACR	12
+#define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF1DA0R	11
+#define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACR	10
+#define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_ADCR		9
+#define SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACL	8
+#define SUN8I_ADC_DIG_CTRL				0x100
+#define SUN8I_ADC_DIG_CTRL_ENDA			15
+#define SUN8I_ADC_DIG_CTRL_ADOUT_DTS			2
+#define SUN8I_ADC_DIG_CTRL_ADOUT_DLY			1
 #define SUN8I_DAC_DIG_CTRL				0x120
 #define SUN8I_DAC_DIG_CTRL_ENDA			15
 #define SUN8I_DAC_MXR_SRC				0x130
@@ -338,10 +356,30 @@ static const struct snd_kcontrol_new sun8i_dac_mixer_controls[] = {
 			SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR, 1, 0),
 };
 
+static const struct snd_kcontrol_new sun8i_input_mixer_controls[] = {
+	SOC_DAPM_DOUBLE("AIF1 Slot 0 Digital ADC Capture Switch",
+			SUN8I_AIF1_MXR_SRC,
+			SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF1DA0L,
+			SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF1DA0R, 1, 0),
+	SOC_DAPM_DOUBLE("AIF2 Digital ADC Capture Switch", SUN8I_AIF1_MXR_SRC,
+			SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACL,
+			SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACR, 1, 0),
+	SOC_DAPM_DOUBLE("AIF1 Data Digital ADC Capture Switch",
+			SUN8I_AIF1_MXR_SRC,
+			SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_ADCL,
+			SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_ADCR, 1, 0),
+	SOC_DAPM_DOUBLE("AIF2 Inv Digital ADC Capture Switch",
+			SUN8I_AIF1_MXR_SRC,
+			SUN8I_AIF1_MXR_SRC_AD0L_MXL_SRC_AIF2DACR,
+			SUN8I_AIF1_MXR_SRC_AD0R_MXR_SRC_AIF2DACL, 1, 0),
+};
+
 static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
-	/* Digital parts of the DACs */
+	/* Digital parts of the DACs and ADC */
 	SND_SOC_DAPM_SUPPLY("DAC", SUN8I_DAC_DIG_CTRL, SUN8I_DAC_DIG_CTRL_ENDA,
 			    0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC", SUN8I_ADC_DIG_CTRL, SUN8I_ADC_DIG_CTRL_ENDA,
+			    0, NULL, 0),
 
 	/* Analog DAC AIF */
 	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Left", "Playback", 0,
@@ -351,17 +389,31 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			    SUN8I_AIF1_DACDAT_CTRL,
 			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
 
-	/* DAC Mixers */
+	/* Analog ADC AIF */
+	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Left ADC", "Capture", 0,
+			    SUN8I_AIF1_ADCDAT_CTRL,
+			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0L_ENA, 0),
+	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Right ADC", "Capture", 0,
+			    SUN8I_AIF1_ADCDAT_CTRL,
+			    SUN8I_AIF1_ADCDAT_CTRL_AIF1_DA0R_ENA, 0),
+
+	/* DAC and ADC Mixers */
 	SOC_MIXER_ARRAY("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_dac_mixer_controls),
 	SOC_MIXER_ARRAY("Right Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
 			sun8i_dac_mixer_controls),
+	SOC_MIXER_ARRAY("Left Digital ADC Mixer", SND_SOC_NOPM, 0, 0,
+			sun8i_input_mixer_controls),
+	SOC_MIXER_ARRAY("Right Digital ADC Mixer", SND_SOC_NOPM, 0, 0,
+			sun8i_input_mixer_controls),
 
 	/* Clocks */
 	SND_SOC_DAPM_SUPPLY("MODCLK AFI1", SUN8I_MOD_CLK_ENA,
 			    SUN8I_MOD_CLK_ENA_AIF1, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MODCLK DAC", SUN8I_MOD_CLK_ENA,
 			    SUN8I_MOD_CLK_ENA_DAC, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MODCLK ADC", SUN8I_MOD_CLK_ENA,
+			    SUN8I_MOD_CLK_ENA_ADC, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("AIF1", SUN8I_SYSCLK_CTL,
 			    SUN8I_SYSCLK_CTL_AIF1CLK_ENA, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("SYSCLK", SUN8I_SYSCLK_CTL,
@@ -378,6 +430,12 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 			    SUN8I_MOD_RST_CTL_AIF1, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("RST DAC", SUN8I_MOD_RST_CTL,
 			    SUN8I_MOD_RST_CTL_DAC, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("RST ADC", SUN8I_MOD_RST_CTL,
+			    SUN8I_MOD_RST_CTL_ADC, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+
 };
 
 static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
@@ -387,11 +445,16 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "RST AIF1", NULL, "AIF1 PLL" },
 	{ "MODCLK AFI1", NULL, "RST AIF1" },
 	{ "DAC", NULL, "MODCLK AFI1" },
+	{ "ADC", NULL, "MODCLK AFI1" },
 
 	{ "RST DAC", NULL, "SYSCLK" },
 	{ "MODCLK DAC", NULL, "RST DAC" },
 	{ "DAC", NULL, "MODCLK DAC" },
 
+	{ "RST ADC", NULL, "SYSCLK" },
+	{ "MODCLK ADC", NULL, "RST ADC" },
+	{ "ADC", NULL, "MODCLK ADC" },
+
 	/* DAC Routes */
 	{ "AIF1 Slot 0 Right", NULL, "DAC" },
 	{ "AIF1 Slot 0 Left", NULL, "DAC" },
@@ -401,6 +464,12 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	  "AIF1 Slot 0 Left"},
 	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
 	  "AIF1 Slot 0 Right"},
+
+	/* ADC routes */
+	{ "Left Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch",
+	  "AIF1 Slot 0 Left ADC" },
+	{ "Right Digital ADC Mixer", "AIF1 Data Digital ADC Capture Switch",
+	  "AIF1 Slot 0 Right ADC" },
 };
 
 static const struct snd_soc_dai_ops sun8i_codec_dai_ops = {
@@ -418,6 +487,15 @@ static struct snd_soc_dai_driver sun8i_codec_dai = {
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
+	/* capture capabilities */
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.sig_bits = 24,
+	},
 	/* pcm operations */
 	.ops = &sun8i_codec_dai_ops,
 };
-- 
2.11.0
