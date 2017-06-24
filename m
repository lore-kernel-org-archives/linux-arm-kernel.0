From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 24 Jun 2017 08:24:17 +0200
Subject: [PATCH v13 12/14] ASoC: sun4i-codec: Add Differential Line Source.
In-Reply-To: <20170624062419.23778-1-dannym@scratchpost.org>
References: <20170624062419.23778-1-dannym@scratchpost.org>
Message-ID: <20170624062419.23778-13-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Differential Line Source for Allwinner A10 and Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index bcd665d..085a603 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -110,6 +110,7 @@
 #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
 #define SUN4I_CODEC_ADC_ACTL_LNPREG			(13)
+#define SUN4I_CODEC_ADC_ACTL_LNRDF			(16)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
@@ -675,6 +676,20 @@ static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
 			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
+static const char * const sun4i_codec_difflinein_source[] = {
+	"Stereo",
+	"Differential",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_difflinein_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_LNRDF,
+			    sun4i_codec_difflinein_source);
+
+static const struct snd_kcontrol_new sun4i_codec_difflinein_source_controls =
+	SOC_DAPM_ENUM("Differential Line Source",
+		      sun4i_codec_enum_difflinein_source);
+
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
@@ -792,6 +807,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	/* MUX */
+	SND_SOC_DAPM_MUX("Differential Line Source", SND_SOC_NOPM,
+			 0, 0,
+			 &sun4i_codec_difflinein_source_controls),
+
 	SND_SOC_DAPM_INPUT("Line Right"),
 	SND_SOC_DAPM_INPUT("Line Left"),
 	SND_SOC_DAPM_INPUT("FM Right"),
@@ -851,6 +871,10 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "MIC2 Pre-Amplifier" },
 	{ "MIC2 Pre-Amplifier", NULL, "Mic2"},
 	{ "Mic2", NULL, "VMIC" },
+
+	/* LNRDF Routes */
+	{ "Differential Line Source", "Differential", "Line Left" },
+	{ "Differential Line Source", "Differential", "Line Right" },
 };
 
 struct sun4i_codec_quirks {
-- 
2.1.4
