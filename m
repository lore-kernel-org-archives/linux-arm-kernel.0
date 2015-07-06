From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 6 Jul 2015 10:02:10 +0800
Subject: [PATCH] ASoC: dpcm: Add checks of playback/capture before dpcm_get_be
Message-ID: <1436148130-22739-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In dpcm_get_be(), it looks for a BE rtd that has the DAI widget
according to current stream type. Only playback_widgets are searched
in the case of playback stream and vice versa. However, the DAI widget
itself can be playback or capture.

If the DAI widget is capture, but current stream type is playback,
dpcm_get_be() will always fail to find a rtd, print error messages,
and continue to the next DAI widget in list. We can just skip this
DAI widget to further suppress error messages. This happens in a
special case when 2 codecs are inter-connected, and the 1st codec's
"capture" widget is used to send data to the 2nd codec during "playback":

mtk-rt5650-rt5676 sound: ASoC: can't get playback BE for Sub AIF2 Capture
rt5650_rt5676 Playback: ASoC: no BE found for Sub AIF2 Capture

Add checks to continue to next DAI widget if current DAI widget's
direction does not match the stream type.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 256b9c9..a6d3313 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1306,7 +1306,12 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 
 		switch (list->widgets[i]->id) {
 		case snd_soc_dapm_dai_in:
+			if (stream != SNDRV_PCM_STREAM_PLAYBACK)
+				continue;
+			break;
 		case snd_soc_dapm_dai_out:
+			if (stream != SNDRV_PCM_STREAM_CAPTURE)
+				continue;
 			break;
 		default:
 			continue;
-- 
1.8.1.1.dirty
