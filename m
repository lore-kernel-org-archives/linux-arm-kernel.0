From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 08:22:14 +0200
Subject: [PATCH v11 10/12] sun4i-codec: Add Left Capture Select,
 Right Capture Select.
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <20170609062216.26807-11-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 21ece880..730f6151 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -685,6 +685,25 @@ static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
 			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
 			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
+static const char * const sun4i_codec_capture_source[] = {
+	"Line",
+	"FM",
+	"Mic1",
+	"Mic2",
+	"Mic1,Mic2",
+	"Mic1+Mic2",
+	"Output Mixer",
+	"Line,Mic1",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_ADCIS,
+			    sun4i_codec_capture_source);
+
+static const struct snd_kcontrol_new sun4i_codec_capture_source_controls =
+	SOC_DAPM_ENUM("Capture Source", sun4i_codec_enum_capture_source);
+
 static const char * const sun4i_codec_difflinein_capture_source[] = {
 	"Stereo",
 	"Differential",
@@ -851,6 +870,10 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 			    &sun4i_codec_pa_mute),
 
 	/* MUX */
+	SND_SOC_DAPM_MUX("Left Capture Select", SND_SOC_NOPM, 0, 0,
+			 &sun4i_codec_capture_source_controls),
+	SND_SOC_DAPM_MUX("Right Capture Select", SND_SOC_NOPM, 0, 0,
+			 &sun4i_codec_capture_source_controls),
 	SND_SOC_DAPM_MUX("Differential Line Capture Switch", SND_SOC_NOPM,
 			 0,
 			 0,
