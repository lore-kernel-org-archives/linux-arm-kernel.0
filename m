From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 17 Aug 2015 19:16:51 +0800
Subject: [PATCH] ASoC: mediatek: Remove AIF widgets for backend DAIs
Message-ID: <1439810211-45518-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DAPM core already creates widgets for DAIs. It is not necessary
to declare them by SND_SOC_DAPM_AIF_IN/SND_SOC_DAPM_AIF_OUT.
Furthermore, original codes use backend DAI's stream name to be the AIF
widget name. It causes the same widget to be created twice, and after
commit 92fa12426741 ("ASoC: dapm: Add new widgets to the end of the
widget list") the first created widget (by snd_soc_dapm_new_controls)
is used, not the 2nd created one (by snd_soc_dapm_new_dai_widgets),
so audio path is broken.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-pcm.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 55471ee..d190fe0 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -897,10 +897,6 @@ static const struct snd_kcontrol_new mtk_afe_o10_mix[] = {
 };
 
 static const struct snd_soc_dapm_widget mtk_afe_pcm_widgets[] = {
-	/* Backend DAIs  */
-	SND_SOC_DAPM_AIF_IN("I2S Capture", NULL, 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("I2S Playback", NULL, 0, SND_SOC_NOPM, 0, 0),
-
 	/* inter-connections */
 	SND_SOC_DAPM_MIXER("I05", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I06", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -932,11 +928,6 @@ static const struct snd_soc_dapm_route mtk_afe_pcm_routes[] = {
 	{ "O10", "I18 Switch", "I18" },
 };
 
-static const struct snd_soc_dapm_widget mtk_afe_hdmi_widgets[] = {
-	/* Backend DAIs  */
-	SND_SOC_DAPM_AIF_OUT("HDMIO Playback", NULL, 0, SND_SOC_NOPM, 0, 0),
-};
-
 static const struct snd_soc_dapm_route mtk_afe_hdmi_routes[] = {
 	{"HDMIO Playback", NULL, "HDMI"},
 };
@@ -951,8 +942,6 @@ static const struct snd_soc_component_driver mtk_afe_pcm_dai_component = {
 
 static const struct snd_soc_component_driver mtk_afe_hdmi_dai_component = {
 	.name = "mtk-afe-hdmi-dai",
-	.dapm_widgets = mtk_afe_hdmi_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(mtk_afe_hdmi_widgets),
 	.dapm_routes = mtk_afe_hdmi_routes,
 	.num_dapm_routes = ARRAY_SIZE(mtk_afe_hdmi_routes),
 };
-- 
1.7.9.5
