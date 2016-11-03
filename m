From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  3 Nov 2016 17:27:05 +0100
Subject: [PATCH v2] ASoC: sun4i-i2s: Implement capture support
Message-ID: <20161103162705.28940-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2s driver was only implementing playback for now. Implement capture to
make sure that's not a limitation anymore.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Changes from v1:
   - Rebased on top of asoc's topic/sunxi branch

 sound/soc/sunxi/sun4i-i2s.c | 52 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 687a8f83dbe5..a7653114e895 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -93,6 +93,7 @@ struct sun4i_i2s {
 	struct clk	*mod_clk;
 	struct regmap	*regmap;
 
+	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 };
 
@@ -341,6 +342,27 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
+{
+	/* Flush RX FIFO */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
+			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
+			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
+
+	/* Clear RX counter */
+	regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
+
+	/* Enable RX Block */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_RX_EN,
+			   SUN4I_I2S_CTRL_RX_EN);
+
+	/* Enable RX DRQ */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_DMA_INT_CTRL_REG,
+			   SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN,
+			   SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN);
+}
+
 static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
 {
 	/* Flush TX FIFO */
@@ -362,6 +384,18 @@ static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
 			   SUN4I_I2S_DMA_INT_CTRL_TX_DRQ_EN);
 }
 
+static void sun4i_i2s_stop_capture(struct sun4i_i2s *i2s)
+{
+	/* Disable RX Block */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_RX_EN,
+			   0);
+
+	/* Disable RX DRQ */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_DMA_INT_CTRL_REG,
+			   SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN,
+			   0);
+}
 
 static void sun4i_i2s_stop_playback(struct sun4i_i2s *i2s)
 {
@@ -388,7 +422,7 @@ static int sun4i_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			sun4i_i2s_start_playback(i2s);
 		else
-			return -EINVAL;
+			sun4i_i2s_start_capture(i2s);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -397,7 +431,7 @@ static int sun4i_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			sun4i_i2s_stop_playback(i2s);
 		else
-			return -EINVAL;
+			sun4i_i2s_stop_capture(i2s);
 		break;
 
 	default:
@@ -459,7 +493,9 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
-	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data, NULL);
+	snd_soc_dai_init_dma_data(dai,
+				  &i2s->playback_dma_data,
+				  &i2s->capture_dma_data);
 
 	snd_soc_dai_set_drvdata(dai, i2s);
 
@@ -468,6 +504,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -630,6 +673,9 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	i2s->playback_dma_data.addr = res->start + SUN4I_I2S_FIFO_TX_REG;
 	i2s->playback_dma_data.maxburst = 4;
 
+	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
+	i2s->capture_dma_data.maxburst = 4;
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
-- 
2.10.1
