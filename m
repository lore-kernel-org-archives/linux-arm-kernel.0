From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 08:22:08 +0200
Subject: [PATCH v11 04/12] sun4i-codec: Add Mic1 Capture Volume,
 Mic2 Capture Volume.
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <20170609062216.26807-5-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index b5a3b5b3..25870a64 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -97,6 +97,8 @@
 #define SUN4I_CODEC_ADC_ACTL_PREG1EN			(29)
 #define SUN4I_CODEC_ADC_ACTL_PREG2EN			(28)
 #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
+#define SUN4I_CODEC_ADC_ACTL_PREG1			(25)
+#define SUN4I_CODEC_ADC_ACTL_PREG2			(23)
 #define SUN4I_CODEC_ADC_ACTL_ADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
 #define SUN4I_CODEC_ADC_ACTL_LNRDF			(16)
@@ -115,6 +117,9 @@
 /* Microphone controls (sun7i only) */
 #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1		(29)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2		(26)
+
 /*
  * sun6i specific registers
  *
@@ -665,6 +670,12 @@ static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale,
 			    150,
 			    0);
 static DECLARE_TLV_DB_SCALE(sun4i_codec_adc_gain_scale, -450, 150, 0);
+static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
+			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+			    1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));
+static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
+			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
 static const char * const sun4i_codec_difflinein_capture_source[] = {
 	"Stereo",
@@ -718,6 +729,36 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 		       sun4i_codec_adc_gain_scale),
 };
 
+static const struct snd_kcontrol_new sun4i_codec_extra_controls[] = {
+	SOC_SINGLE_TLV("Mic1 Capture Volume",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG1,
+		       3,
+		       0,
+		       sun4i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Capture Volume",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG2,
+		       3,
+		       0,
+		       sun4i_codec_micin_preamp_gain_scale),
+};
+
+static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
+	SOC_SINGLE_TLV("Mic1 Capture Volume",
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1,
+		       7,
+		       0,
+		       sun7i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Capture Volume",
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2,
+		       7,
+		       0,
+		       sun7i_codec_micin_preamp_gain_scale),
+};
+
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
