From: ats@offog.org (Adam Sampson)
Date: Sat, 24 Oct 2015 13:11:52 +0100
Subject: [PATCH] ASoC: sun4i-codec: use consistent names for PA controls
Message-ID: <1445688712-31951-1-git-send-email-ats@offog.org>
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

Change it to use "PA" consistently for the power amplifier.

Signed-off-by: Adam Sampson <ats@offog.org>
---
 sound/soc/sunxi/sun4i-codec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index bcbf4da..ff3304d 100644
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
@@ -452,12 +453,12 @@ static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
 			    SUN4I_CODEC_DAC_ACTL_MIXEN, 0, NULL, 0),
 
-	/* Pre-Amplifier */
-	SND_SOC_DAPM_MIXER("Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+	/* Headphone output power amplifier */
+	SND_SOC_DAPM_MIXER("PA", SUN4I_CODEC_ADC_ACTL,
 			   SUN4I_CODEC_ADC_ACTL_PA_EN, 0,
 			   sun4i_codec_pa_mixer_controls,
 			   ARRAY_SIZE(sun4i_codec_pa_mixer_controls)),
-	SND_SOC_DAPM_SWITCH("Pre-Amplifier Mute", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SWITCH("PA Mute", SND_SOC_NOPM, 0, 0,
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
+	/* PA Mixer Routes */
+	{ "PA", "Mixer Playback Switch", "Left Mixer" },
+	{ "PA", "Mixer Playback Switch", "Right Mixer" },
+	{ "PA", "DAC Playback Switch", "Left DAC" },
+	{ "PA", "DAC Playback Switch", "Right DAC" },
 
 	/* PA -> HP path */
-	{ "Pre-Amplifier Mute", "Switch", "Pre-Amplifier" },
-	{ "HP Right", NULL, "Pre-Amplifier Mute" },
-	{ "HP Left", NULL, "Pre-Amplifier Mute" },
+	{ "PA Mute", "Switch", "PA" },
+	{ "HP Right", NULL, "PA Mute" },
+	{ "HP Left", NULL, "PA Mute" },
 };
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
-- 
2.1.4
