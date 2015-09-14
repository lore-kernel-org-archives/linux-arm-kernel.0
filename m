From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 14 Sep 2015 14:51:17 +0800
Subject: [PATCH] ASoC: mediatek: Increase periods_min in capture
Message-ID: <1442213477-63721-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In capture, there is chance that hw_ptr reported at IRQ is
a little smaller than period_size due to internal AFE buffer.
In the case of ping-pong buffer:

|xxxxxxxxxxxxxxxxxxxxxxxxxxxx--|-----------------------------|
                            hw_ptr < period_size

This available buffer will not be read since its size is smaller than
avail_min (which is period_size by default), and read thread continues
to sleep. If the next hw_ptr is just a little larger than buffer_size,
overrun occurs. One more period can hold the possible unread buffer.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-pcm.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index d190fe0..f5baf3c 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -549,6 +549,23 @@ static int mtk_afe_dais_startup(struct snd_pcm_substream *substream,
 	memif->substream = substream;
 
 	snd_soc_set_runtime_hwparams(substream, &mtk_afe_hardware);
+
+	/*
+	 * Capture cannot use ping-pong buffer since hw_ptr at IRQ may be
+	 * smaller than period_size due to AFE's internal buffer.
+	 * This easily leads to overrun when avail_min is period_size.
+	 * One more period can hold the possible unread buffer.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		ret = snd_pcm_hw_constraint_minmax(runtime,
+						   SNDRV_PCM_HW_PARAM_PERIODS,
+						   3,
+						   mtk_afe_hardware.periods_max);
+		if (ret < 0) {
+			dev_err(afe->dev, "hw_constraint_minmax failed\n");
+			return ret;
+		}
+	}
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0)
-- 
1.7.9.5
