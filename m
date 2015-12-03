From: koro.chen@mediatek.com (Koro Chen)
Date: Thu, 3 Dec 2015 15:53:28 +0800
Subject: [PATCH] ASoC: mediatek: Use current HW pointer for pointer callback
Message-ID: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously we recorded "last interrupt position" and used it in
pointer callback. This is not correct implementation, and it causes
underruns when user space monitors buffer level to decide when to
send next data chunk in low latency application.

Remove position recording in IRQ handler and also hw_ptr in
struct mtk_afe_memif used to record that, and let pointer callback
reports current HW pointer instead.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-common.h |    1 -
 sound/soc/mediatek/mtk-afe-pcm.c    |   22 +++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-common.h b/sound/soc/mediatek/mtk-afe-common.h
index cc4393c..9b1af1a 100644
--- a/sound/soc/mediatek/mtk-afe-common.h
+++ b/sound/soc/mediatek/mtk-afe-common.h
@@ -92,7 +92,6 @@ struct mtk_afe_memif_data {
 struct mtk_afe_memif {
 	unsigned int phys_buf_addr;
 	int buffer_size;
-	unsigned int hw_ptr;		/* Previous IRQ's HW ptr */
 	struct snd_pcm_substream *substream;
 	const struct mtk_afe_memif_data *data;
 	const struct mtk_afe_irq_data *irqdata;
diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 7f71343..5399a0e 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -175,8 +175,17 @@ static snd_pcm_uframes_t mtk_afe_pcm_pointer
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 	struct mtk_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	unsigned int hw_ptr;
+	int ret;
+
+	ret = regmap_read(afe->regmap, memif->data->reg_ofs_cur, &hw_ptr);
+	if (ret || hw_ptr == 0) {
+		dev_err(afe->dev, "%s hw_ptr err\n", __func__);
+		hw_ptr = memif->phys_buf_addr;
+	}
 
-	return bytes_to_frames(substream->runtime, memif->hw_ptr);
+	return bytes_to_frames(substream->runtime,
+			       hw_ptr - memif->phys_buf_addr);
 }
 
 static const struct snd_pcm_ops mtk_afe_pcm_ops = {
@@ -602,7 +611,6 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 
 	memif->phys_buf_addr = substream->runtime->dma_addr;
 	memif->buffer_size = substream->runtime->dma_bytes;
-	memif->hw_ptr = 0;
 
 	/* start */
 	regmap_write(afe->regmap,
@@ -737,7 +745,6 @@ static int mtk_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
 		/* and clear pending IRQ */
 		regmap_write(afe->regmap, AFE_IRQ_CLR,
 			     1 << memif->data->irq_clr_shift);
-		memif->hw_ptr = 0;
 		return 0;
 	default:
 		return -EINVAL;
@@ -1081,7 +1088,7 @@ static const struct regmap_config mtk_afe_regmap_config = {
 static irqreturn_t mtk_afe_irq_handler(int irq, void *dev_id)
 {
 	struct mtk_afe *afe = dev_id;
-	unsigned int reg_value, hw_ptr;
+	unsigned int reg_value;
 	int i, ret;
 
 	ret = regmap_read(afe->regmap, AFE_IRQ_STATUS, &reg_value);
@@ -1097,13 +1104,6 @@ static irqreturn_t mtk_afe_irq_handler(int irq, void *dev_id)
 		if (!(reg_value & (1 << memif->data->irq_clr_shift)))
 			continue;
 
-		ret = regmap_read(afe->regmap, memif->data->reg_ofs_cur,
-				  &hw_ptr);
-		if (ret || hw_ptr == 0) {
-			dev_err(afe->dev, "%s hw_ptr err\n", __func__);
-			hw_ptr = memif->phys_buf_addr;
-		}
-		memif->hw_ptr = hw_ptr - memif->phys_buf_addr;
 		snd_pcm_period_elapsed(memif->substream);
 	}
 
-- 
1.7.9.5
