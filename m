From: ats@offog.org (Adam Sampson)
Date: Tue, 27 Oct 2015 21:00:45 +0000
Subject: [PATCH v2] ASoC: sun4i-codec: use consistent names for PA controls
Message-ID: <1445979645-1664-1-git-send-email-ats@offog.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power amplifier for the headphone output is called "the PA" and "the
headphone amplifier" in Allwinner's documentation for the A10 and A20.
sun4i-codec calls it "PA" in some places and "Pre-Amplifier" (which
isn't really accurate) in others, leading to user-visible controls with
different names referring to the same device.

When this driver implements audio input, it'll also need to expose
controls for the line and mic input preamps, so just referring to "the
Pre-Amplifier" will be ambiguous.

Change it to use "Power Amplifier" consistently for the power
amplifier's controls.

Signed-off-by: Adam Sampson <ats@offog.org>
---
Changes in v2:
- use "Power Amplifier" rather than "PA"
---
 sound/soc/sunxi/sun4i-codec.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index bcbf4da..1bb896d 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -2,6 +2,7 @@
  * Copyright 2014 Emilio L?pez <emilio@elopez.com.ar>
  * Copyright 2014 Jon Smirl <jonsmirl@gmail.com>
  * Copyright 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
+ * Copyright 2015 Adam Sampson <ats@offog.org>
  *
  * Based on the Allwinner SDK driver, released under the GPL.
  *
@@ -404,7 +405,7 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 
 static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
-	SOC_SINGLE_TLV("PA Volume", SUN4I_CODEC_DAC_ACTL,
+	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
 };
@@ -452,12 +453,12 @@ static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
 			    SUN4I_CODEC_DAC_ACTL_MIXEN, 0, NULL, 0),
 
-	/* Pre-Amplifier */
-	SND_SOC_DAPM_MIXER("Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+	/* Power Amplifier */
+	SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
 			   SUN4I_CODEC_ADC_ACTL_PA_EN, 0,
 			   sun4i_codec_pa_mixer_controls,
 			   ARRAY_SIZE(sun4i_codec_pa_mixer_controls)),
-	SND_SOC_DAPM_SWITCH("Pre-Amplifier Mute", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
 	SND_SOC_DAPM_OUTPUT("HP Right"),
@@ -480,16 +481,16 @@ static const struct snd_soc_dapm_route sun4i_codec_dapm_routes[] = {
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
 
-	/* Pre-Amplifier Mixer Routes */
-	{ "Pre-Amplifier", "Mixer Playback Switch", "Left Mixer" },
-	{ "Pre-Amplifier", "Mixer Playback Switch", "Right Mixer" },
-	{ "Pre-Amplifier", "DAC Playback Switch", "Left DAC" },
-	{ "Pre-Amplifier", "DAC Playback Switch", "Right DAC" },
+	/* Power Amplifier Routes */
+	{ "Power Amplifier", "Mixer Playback Switch", "Left Mixer" },
+	{ "Power Amplifier", "Mixer Playback Switch", "Right Mixer" },
+	{ "Power Amplifier", "DAC Playback Switch", "Left DAC" },
+	{ "Power Amplifier", "DAC Playback Switch", "Right DAC" },
 
-	/* PA -> HP path */
-	{ "Pre-Amplifier Mute", "Switch", "Pre-Amplifier" },
-	{ "HP Right", NULL, "Pre-Amplifier Mute" },
-	{ "HP Left", NULL, "Pre-Amplifier Mute" },
+	/* Headphone Output Routes */
+	{ "Power Amplifier Mute", "Switch", "Power Amplifier" },
+	{ "HP Right", NULL, "Power Amplifier Mute" },
+	{ "HP Left", NULL, "Power Amplifier Mute" },
 };
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
-- 
2.1.4
