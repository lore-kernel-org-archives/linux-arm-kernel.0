From: jay.xu@rock-chips.com (Jianqun)
Date: Sat, 13 Sep 2014 08:41:38 +0800
Subject: [PATCH 3/5] ASoC: rockchip-i2s: add dma data to snd_soc_dai
In-Reply-To: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1410568898-21773-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add playback/capture dma data to snd_soc_dai.
Test on RK3288 with max98090.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 870a664..1b9b404 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -244,16 +244,6 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_update_bits(i2s->regmap, I2S_TXCR, I2S_TXCR_VDW_MASK, val);
 	regmap_update_bits(i2s->regmap, I2S_RXCR, I2S_RXCR_VDW_MASK, val);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		dai->playback_dma_data = &i2s->playback_dma_data;
-		regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,
-				   I2S_DMACR_TDL(1) | I2S_DMACR_TDE_ENABLE);
-	} else {
-		dai->capture_dma_data = &i2s->capture_dma_data;
-		regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
-				   I2S_DMACR_RDL(1) | I2S_DMACR_RDE_ENABLE);
-	}
-
 	return 0;
 }
 
@@ -301,6 +291,16 @@ static int rockchip_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
 	return ret;
 }
 
+static int rockchip_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct rk_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+
+	dai->capture_dma_data = &i2s->capture_dma_data;
+	dai->playback_dma_data = &i2s->playback_dma_data;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops rockchip_i2s_dai_ops = {
 	.hw_params = rockchip_i2s_hw_params,
 	.set_sysclk = rockchip_i2s_set_sysclk,
@@ -309,7 +309,9 @@ static const struct snd_soc_dai_ops rockchip_i2s_dai_ops = {
 };
 
 static struct snd_soc_dai_driver rockchip_i2s_dai = {
+	.probe = rockchip_i2s_dai_probe,
 	.playback = {
+		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
@@ -319,6 +321,7 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 			    SNDRV_PCM_FMTBIT_S24_LE),
 	},
 	.capture = {
+		.stream_name = "Capture",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-- 
1.9.1
