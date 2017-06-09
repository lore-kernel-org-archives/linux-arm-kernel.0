From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 08:22:06 +0200
Subject: [PATCH v11 02/12] sun4i-codec: Add Differential Line Capture Switch
 and its routes
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <20170609062216.26807-3-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 2f65aa72..a2435c6e 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -96,6 +96,7 @@
 #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
 #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
+#define SUN4I_CODEC_ADC_ACTL_LNRDF			(16)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
@@ -644,6 +645,20 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 
+static const char * const sun4i_codec_difflinein_capture_source[] = {
+	"Stereo",
+	"Differential",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_difflinein_capture_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_LNRDF,
+			    sun4i_codec_difflinein_capture_source);
+
+static const struct snd_kcontrol_new sun4i_codec_difflinein_capture_source_controls =
+	SOC_DAPM_ENUM("Differential Line Capture Switch",
+	sun4i_codec_enum_difflinein_capture_source);
+
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
@@ -720,6 +735,12 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	/* MUX */
+	SND_SOC_DAPM_MUX("Differential Line Capture Switch", SND_SOC_NOPM,
+			 0,
+			 0,
+			 &sun4i_codec_difflinein_capture_source_controls),
+
 	/* Inputs */
 	SND_SOC_DAPM_INPUT("Mic1"),
 	SND_SOC_DAPM_INPUT("Mic2"),
@@ -767,6 +788,11 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "MIC1 Pre-Amplifier" },
 	{ "MIC1 Pre-Amplifier", NULL, "Mic1"},
 	{ "Mic1", NULL, "VMIC" },
+
+	/* LNRDF Routes */
+	{ "Differential Line Capture Switch", "Differential", "Line Left" },
+	{ "Differential Line Capture Switch", "Differential", "Line Right" },
+
 };
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
