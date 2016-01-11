From: pc.liao@mediatek.com (PC Liao)
Date: Mon, 11 Jan 2016 16:00:50 +0800
Subject: [PATCH] ASoC: mediatek: Enable 33bit memory address to support 4GB
 DRAM
Message-ID: <1452499250-5202-1-git-send-email-pc.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If platform is embedded with memory more than 3GB, the address will
go out of the scope that 32-bit can handle with. This patch sets the
dma_mask and MSB properly to describe its address to 33-bit.

Signed-off-by: Hidalgo Huang <hidalgo.huang@mediatek.com>
Signed-off-by: PC Liao <pc.liao@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-common.h |    1 +
 sound/soc/mediatek/mtk-afe-pcm.c    |   24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mtk-afe-common.h b/sound/soc/mediatek/mtk-afe-common.h
index 9b1af1a..f341f62 100644
--- a/sound/soc/mediatek/mtk-afe-common.h
+++ b/sound/soc/mediatek/mtk-afe-common.h
@@ -87,6 +87,7 @@ struct mtk_afe_memif_data {
 	int irq_en_shift;
 	int irq_fs_shift;
 	int irq_clr_shift;
+	int msb_shift;
 };
 
 struct mtk_afe_memif {
diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 08af9f5..60c38db 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <sound/soc.h>
 #include "mtk-afe-common.h"
@@ -35,6 +36,7 @@
 #define AFE_I2S_CON1		0x0034
 #define AFE_I2S_CON2		0x0038
 #define AFE_CONN_24BIT		0x006c
+#define AFE_MEMIF_MSB		0x00cc
 
 #define AFE_CONN1		0x0024
 #define AFE_CONN2		0x0028
@@ -592,6 +594,7 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 	struct mtk_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	int msb_at_bit33 = 0;
 	int ret;
 
 	dev_dbg(afe->dev,
@@ -603,7 +606,10 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	memif->phys_buf_addr = substream->runtime->dma_addr;
+	if (sizeof(dma_addr_t) > 4)
+		msb_at_bit33 = (substream->runtime->dma_addr & 0x100000000) ? 1 : 0;
+
+	memif->phys_buf_addr = substream->runtime->dma_addr & 0xffffffff;
 	memif->buffer_size = substream->runtime->dma_bytes;
 
 	/* start */
@@ -614,6 +620,11 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 		     memif->data->reg_ofs_base + AFE_BASE_END_OFFSET,
 		     memif->phys_buf_addr + memif->buffer_size - 1);
 
+	/* set MSB to 33-bit */
+	regmap_update_bits(afe->regmap, AFE_MEMIF_MSB,
+			   1 << memif->data->msb_shift,
+			   msb_at_bit33 << memif->data->msb_shift);
+
 	/* set channel */
 	if (memif->data->mono_shift >= 0) {
 		unsigned int mono = (params_channels(params) == 1) ? 1 : 0;
@@ -978,6 +989,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.irq_en_shift = 0,
 		.irq_fs_shift = 4,
 		.irq_clr_shift = 0,
+		.msb_shift = 0,
 	}, {
 		.name = "DL2",
 		.id = MTK_AFE_MEMIF_DL2,
@@ -991,6 +1003,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.irq_en_shift = 2,
 		.irq_fs_shift = 16,
 		.irq_clr_shift = 2,
+		.msb_shift = 1,
 	}, {
 		.name = "VUL",
 		.id = MTK_AFE_MEMIF_VUL,
@@ -1004,6 +1017,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.irq_en_shift = 1,
 		.irq_fs_shift = 8,
 		.irq_clr_shift = 1,
+		.msb_shift = 6,
 	}, {
 		.name = "DAI",
 		.id = MTK_AFE_MEMIF_DAI,
@@ -1017,6 +1031,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.irq_en_shift = 3,
 		.irq_fs_shift = 20,
 		.irq_clr_shift = 3,
+		.msb_shift = 5,
 	}, {
 		.name = "AWB",
 		.id = MTK_AFE_MEMIF_AWB,
@@ -1030,6 +1045,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.irq_en_shift = 14,
 		.irq_fs_shift = 24,
 		.irq_clr_shift = 6,
+		.msb_shift = 3,
 	}, {
 		.name = "MOD_DAI",
 		.id = MTK_AFE_MEMIF_MOD_DAI,
@@ -1043,6 +1059,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.irq_en_shift = 3,
 		.irq_fs_shift = 20,
 		.irq_clr_shift = 3,
+		.msb_shift = 4,
 	}, {
 		.name = "HDMI",
 		.id = MTK_AFE_MEMIF_HDMI,
@@ -1056,6 +1073,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.irq_en_shift = 12,
 		.irq_fs_shift = -1,
 		.irq_clr_shift = 4,
+		.msb_shift = 8,
 	},
 };
 
@@ -1189,6 +1207,10 @@ static int mtk_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct mtk_afe *afe;
 	struct resource *res;
 
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(33));
+	if (ret)
+		return ret;
+
 	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
 		return -ENOMEM;
-- 
1.7.9.5
