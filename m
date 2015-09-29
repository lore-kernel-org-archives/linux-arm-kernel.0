From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Sep 2015 21:43:17 +0200
Subject: [PATCH 1/2] ASoC: sun4i-codec: pass through clk_set_rate error
Message-ID: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code, disregarding the clk_set_rate error code, was always
returning -EINVAL. Fix that and return the code in order to have more clue
about what's going on.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun4i-codec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 6e83e62ef039..28834129bea3 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -283,7 +283,7 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
 	unsigned long clk_freq;
-	int hwrate;
+	int ret, hwrate;
 	u32 val;
 
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
@@ -293,8 +293,9 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 	if (!clk_freq)
 		return -EINVAL;
 
-	if (clk_set_rate(scodec->clk_module, clk_freq))
-		return -EINVAL;
+	ret = clk_set_rate(scodec->clk_module, clk_freq);
+	if (ret)
+		return ret;
 
 	hwrate = sun4i_codec_get_hw_rate(params);
 	if (hwrate < 0)
-- 
2.5.3
