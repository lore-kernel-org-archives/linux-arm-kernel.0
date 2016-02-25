From: pc.liao@mediatek.com (PC Liao)
Date: Thu, 25 Feb 2016 15:12:33 +0800
Subject: [PATCH] ASoC: mediatek: Add I03/I04 widgets and corresponding routes
Message-ID: <1456384353-13041-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Koro Chen <koro.chen@mediatek.com>

Add these widgets to allow another path from I2S input.

Change-Id: Ib6804bbbde388830d8359245fe13bbb0f2bb36ba
Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-pcm.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 689c51f..5de878f 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -40,6 +40,7 @@
 
 #define AFE_CONN1		0x0024
 #define AFE_CONN2		0x0028
+#define AFE_CONN3		0x002c
 #define AFE_CONN7		0x0460
 #define AFE_CONN8		0x0464
 #define AFE_HDMI_CONN0		0x0390
@@ -63,6 +64,7 @@
 #define AFE_HDMI_OUT_CUR	0x0378
 #define AFE_HDMI_OUT_END	0x037c
 
+#define AFE_ADDA_TOP_CON0	0x0120
 #define AFE_ADDA2_TOP_CON0	0x0600
 
 #define AFE_HDMI_OUT_CON0	0x0370
@@ -259,6 +261,7 @@ static int mtk_afe_set_i2s(struct mtk_afe *afe, unsigned int rate)
 		return -EINVAL;
 
 	/* from external ADC */
+	regmap_update_bits(afe->regmap, AFE_ADDA_TOP_CON0, 0x1, 0x1);
 	regmap_update_bits(afe->regmap, AFE_ADDA2_TOP_CON0, 0x1, 0x1);
 
 	/* set input */
@@ -903,15 +906,19 @@ static const struct snd_kcontrol_new mtk_afe_o04_mix[] = {
 };
 
 static const struct snd_kcontrol_new mtk_afe_o09_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I03 Switch", AFE_CONN3, 0, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I17 Switch", AFE_CONN7, 30, 1, 0),
 };
 
 static const struct snd_kcontrol_new mtk_afe_o10_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I04 Switch", AFE_CONN3, 3, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I18 Switch", AFE_CONN8, 0, 1, 0),
 };
 
 static const struct snd_soc_dapm_widget mtk_afe_pcm_widgets[] = {
 	/* inter-connections */
+	SND_SOC_DAPM_MIXER("I03", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I04", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I05", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I06", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I17", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -934,12 +941,16 @@ static const struct snd_soc_dapm_route mtk_afe_pcm_routes[] = {
 	{"I2S Playback", NULL, "O04"},
 	{"VUL", NULL, "O09"},
 	{"VUL", NULL, "O10"},
+	{"I03", NULL, "I2S Capture"},
+	{"I04", NULL, "I2S Capture"},
 	{"I17", NULL, "I2S Capture"},
 	{"I18", NULL, "I2S Capture"},
 	{ "O03", "I05 Switch", "I05" },
 	{ "O04", "I06 Switch", "I06" },
 	{ "O09", "I17 Switch", "I17" },
+	{ "O09", "I03 Switch", "I03" },
 	{ "O10", "I18 Switch", "I18" },
+	{ "O10", "I04 Switch", "I04" },
 };
 
 static const struct snd_soc_dapm_route mtk_afe_hdmi_routes[] = {
-- 
1.7.9.5
