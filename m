From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Fri, 3 Jun 2016 12:56:18 +0800
Subject: [alsa-devel] [PATCH v2 3/9] ASoC: mediatek: let mt8173 use mediatek
 common structure
In-Reply-To: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1464929784-5489-4-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify mt8173 driver implementation to use common structure.

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/Kconfig                    |  11 +
 sound/soc/mediatek/Makefile                   |   3 +-
 sound/soc/mediatek/common/Makefile            |  17 +
 sound/soc/mediatek/mt8173/mt8173-afe-common.h |  42 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    | 681 +++++++++++---------------
 5 files changed, 328 insertions(+), 426 deletions(-)
 create mode 100644 sound/soc/mediatek/common/Makefile

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index ae9f664..ff1a419 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -1,6 +1,16 @@
+config SND_SOC_MEDIATEK
+	tristate "SND_SOC_MEDIATEK"
+	depends on ARCH_MEDIATEK
+	help
+	  This adds ASoC driver for Mediatek boards
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT8173
 	tristate "ASoC support for Mediatek MT8173 chip"
 	depends on ARCH_MEDIATEK
+	select SND_SOC_MEDIATEK
 	help
 	  This adds ASoC platform driver support for Mediatek MT8173 chip
 	  that can be used with other codecs.
@@ -49,3 +59,4 @@ config SND_SOC_MT8173_RT5650_RT5676
 	  with the RT5650 and RT5676 codecs.
 	  Select Y if you have such device.
 	  If unsure select "N".
+
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 240dfc70..3d893be 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -1,2 +1,3 @@
-# 8173 Machine support
+obj-$(CONFIG_SND_SOC_MEDIATEK) += common/
 obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
+
diff --git a/sound/soc/mediatek/common/Makefile b/sound/soc/mediatek/common/Makefile
new file mode 100644
index 0000000..0fcd921
--- /dev/null
+++ b/sound/soc/mediatek/common/Makefile
@@ -0,0 +1,17 @@
+#
+# Copyright (C) 2015 MediaTek Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+# GNU General Public License for more details.
+#
+
+# platform driver
+snd-soc-mtk-common-objs := mtk-afe-platform-driver.o mtk-afe-fe-dai.o
+obj-$(CONFIG_SND_SOC_MEDIATEK) += snd-soc-mtk-common.o
+
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-common.h b/sound/soc/mediatek/mt8173/mt8173-afe-common.h
index 8f2936d..9a4837c 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-common.h
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-common.h
@@ -46,14 +46,13 @@ enum {
 };
 
 enum {
-	MT8173_AFE_IRQ_1,
-	MT8173_AFE_IRQ_2,
-	MT8173_AFE_IRQ_3,
-	MT8173_AFE_IRQ_4,
-	MT8173_AFE_IRQ_5,
-	MT8173_AFE_IRQ_6,
-	MT8173_AFE_IRQ_7,
-	MT8173_AFE_IRQ_8,
+	MT8173_AFE_IRQ_DL1,
+	MT8173_AFE_IRQ_DL2,
+	MT8173_AFE_IRQ_VUL,
+	MT8173_AFE_IRQ_DAI,
+	MT8173_AFE_IRQ_AWB,
+	MT8173_AFE_IRQ_MOD_DAI,
+	MT8173_AFE_IRQ_HDMI,
 	MT8173_AFE_IRQ_NUM,
 };
 
@@ -71,31 +70,4 @@ enum {
 	MT8173_CLK_NUM
 };
 
-struct mt8173_afe;
-struct snd_pcm_substream;
-
-struct mt8173_afe_memif_data {
-	int id;
-	const char *name;
-	int reg_ofs_base;
-	int reg_ofs_cur;
-	int fs_shift;
-	int mono_shift;
-	int enable_shift;
-	int irq_reg_cnt;
-	int irq_cnt_shift;
-	int irq_en_shift;
-	int irq_fs_shift;
-	int irq_clr_shift;
-	int msb_shift;
-};
-
-struct mt8173_afe_memif {
-	unsigned int phys_buf_addr;
-	int buffer_size;
-	struct snd_pcm_substream *substream;
-	const struct mt8173_afe_memif_data *data;
-	const struct mt8173_afe_irq_data *irqdata;
-};
-
 #endif
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 4fc52bc..d58bac4b 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -25,6 +25,9 @@
 #include <linux/pm_runtime.h>
 #include <sound/soc.h>
 #include "mt8173-afe-common.h"
+#include "../common/mtk-base-afe.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-afe-fe-dai.h"
 
 /*****************************************************************************
  *                  R E G I S T E R       D E F I N I T I O N
@@ -81,7 +84,6 @@
 #define AFE_TDM_CON1		0x0548
 #define AFE_TDM_CON2		0x054c
 
-#define AFE_BASE_END_OFFSET	8
 #define AFE_IRQ_STATUS_BITS	0xff
 
 /* AUDIO_TOP_CON0 (0x0000) */
@@ -152,15 +154,8 @@ static const unsigned int mt8173_afe_backup_list[] = {
 	AFE_DAC_CON0,
 };
 
-struct mt8173_afe {
-	/* address for ioremap audio hardware register */
-	void __iomem *base_addr;
-	struct device *dev;
-	struct regmap *regmap;
-	struct mt8173_afe_memif memif[MT8173_AFE_MEMIF_NUM];
+struct mt8173_afe_private {
 	struct clk *clocks[MT8173_CLK_NUM];
-	unsigned int backup_regs[ARRAY_SIZE(mt8173_afe_backup_list)];
-	bool suspended;
 };
 
 static const struct snd_pcm_hardware mt8173_afe_hardware = {
@@ -174,53 +169,6 @@ static const struct snd_pcm_hardware mt8173_afe_hardware = {
 	.fifo_size = 0,
 };
 
-static snd_pcm_uframes_t mt8173_afe_pcm_pointer
-			 (struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
-	unsigned int hw_ptr;
-	int ret;
-
-	ret = regmap_read(afe->regmap, memif->data->reg_ofs_cur, &hw_ptr);
-	if (ret || hw_ptr == 0) {
-		dev_err(afe->dev, "%s hw_ptr err\n", __func__);
-		hw_ptr = memif->phys_buf_addr;
-	}
-
-	return bytes_to_frames(substream->runtime,
-			       hw_ptr - memif->phys_buf_addr);
-}
-
-static const struct snd_pcm_ops mt8173_afe_pcm_ops = {
-	.ioctl = snd_pcm_lib_ioctl,
-	.pointer = mt8173_afe_pcm_pointer,
-};
-
-static int mt8173_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	size_t size;
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-
-	size = mt8173_afe_hardware.buffer_bytes_max;
-
-	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						     card->dev, size, size);
-}
-
-static void mt8173_afe_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
-static const struct snd_soc_platform_driver mt8173_afe_pcm_platform = {
-	.ops = &mt8173_afe_pcm_ops,
-	.pcm_new = mt8173_afe_pcm_new,
-	.pcm_free = mt8173_afe_pcm_free,
-};
-
 struct mt8173_afe_rate {
 	unsigned int rate;
 	unsigned int regvalue;
@@ -253,7 +201,7 @@ static int mt8173_afe_i2s_fs(unsigned int sample_rate)
 	return -EINVAL;
 }
 
-static int mt8173_afe_set_i2s(struct mt8173_afe *afe, unsigned int rate)
+static int mt8173_afe_set_i2s(struct mtk_base_afe *afe, unsigned int rate)
 {
 	unsigned int val;
 	int fs = mt8173_afe_i2s_fs(rate);
@@ -281,7 +229,7 @@ static int mt8173_afe_set_i2s(struct mt8173_afe *afe, unsigned int rate)
 	return 0;
 }
 
-static void mt8173_afe_set_i2s_enable(struct mt8173_afe *afe, bool enable)
+static void mt8173_afe_set_i2s_enable(struct mtk_base_afe *afe, bool enable)
 {
 	unsigned int val;
 
@@ -296,7 +244,7 @@ static void mt8173_afe_set_i2s_enable(struct mt8173_afe *afe, bool enable)
 	regmap_update_bits(afe->regmap, AFE_I2S_CON1, 0x1, enable);
 }
 
-static int mt8173_afe_dais_enable_clks(struct mt8173_afe *afe,
+static int mt8173_afe_dais_enable_clks(struct mtk_base_afe *afe,
 				       struct clk *m_ck, struct clk *b_ck)
 {
 	int ret;
@@ -319,7 +267,7 @@ static int mt8173_afe_dais_enable_clks(struct mt8173_afe *afe,
 	return 0;
 }
 
-static int mt8173_afe_dais_set_clks(struct mt8173_afe *afe,
+static int mt8173_afe_dais_set_clks(struct mtk_base_afe *afe,
 				    struct clk *m_ck, unsigned int mck_rate,
 				    struct clk *b_ck, unsigned int bck_rate)
 {
@@ -343,7 +291,7 @@ static int mt8173_afe_dais_set_clks(struct mt8173_afe *afe,
 	return 0;
 }
 
-static void mt8173_afe_dais_disable_clks(struct mt8173_afe *afe,
+static void mt8173_afe_dais_disable_clks(struct mtk_base_afe *afe,
 					 struct clk *m_ck, struct clk *b_ck)
 {
 	if (m_ck)
@@ -356,7 +304,7 @@ static int mt8173_afe_i2s_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 
 	if (dai->active)
 		return 0;
@@ -370,7 +318,7 @@ static void mt8173_afe_i2s_shutdown(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 
 	if (dai->active)
 		return;
@@ -386,12 +334,13 @@ static int mt8173_afe_i2s_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
-	mt8173_afe_dais_set_clks(afe, afe->clocks[MT8173_CLK_I2S1_M],
+	mt8173_afe_dais_set_clks(afe, afe_priv->clocks[MT8173_CLK_I2S1_M],
 				 runtime->rate * 256, NULL, 0);
-	mt8173_afe_dais_set_clks(afe, afe->clocks[MT8173_CLK_I2S2_M],
+	mt8173_afe_dais_set_clks(afe, afe_priv->clocks[MT8173_CLK_I2S2_M],
 				 runtime->rate * 256, NULL, 0);
 	/* config I2S */
 	ret = mt8173_afe_set_i2s(afe, substream->runtime->rate);
@@ -407,13 +356,14 @@ static int mt8173_afe_hdmi_startup(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 
 	if (dai->active)
 		return 0;
 
-	mt8173_afe_dais_enable_clks(afe, afe->clocks[MT8173_CLK_I2S3_M],
-				    afe->clocks[MT8173_CLK_I2S3_B]);
+	mt8173_afe_dais_enable_clks(afe, afe_priv->clocks[MT8173_CLK_I2S3_M],
+				    afe_priv->clocks[MT8173_CLK_I2S3_B]);
 	return 0;
 }
 
@@ -421,13 +371,14 @@ static void mt8173_afe_hdmi_shutdown(struct snd_pcm_substream *substream,
 				     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 
 	if (dai->active)
 		return;
 
-	mt8173_afe_dais_disable_clks(afe, afe->clocks[MT8173_CLK_I2S3_M],
-				     afe->clocks[MT8173_CLK_I2S3_B]);
+	mt8173_afe_dais_disable_clks(afe, afe_priv->clocks[MT8173_CLK_I2S3_M],
+				     afe_priv->clocks[MT8173_CLK_I2S3_B]);
 }
 
 static int mt8173_afe_hdmi_prepare(struct snd_pcm_substream *substream,
@@ -435,12 +386,14 @@ static int mt8173_afe_hdmi_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe_private *afe_priv = afe->platform_priv;
+
 	unsigned int val;
 
-	mt8173_afe_dais_set_clks(afe, afe->clocks[MT8173_CLK_I2S3_M],
+	mt8173_afe_dais_set_clks(afe, afe_priv->clocks[MT8173_CLK_I2S3_M],
 				 runtime->rate * 128,
-				 afe->clocks[MT8173_CLK_I2S3_B],
+				 afe_priv->clocks[MT8173_CLK_I2S3_B],
 				 runtime->rate * runtime->channels * 32);
 
 	val = AFE_TDM_CON1_BCK_INV |
@@ -496,7 +449,7 @@ static int mt8173_afe_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 
 	dev_info(afe->dev, "%s cmd=%d %s\n", __func__, cmd, dai->name);
 
@@ -508,10 +461,14 @@ static int mt8173_afe_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		/* set connections:  O30~O37: L/R/LS/RS/C/LFE/CH7/CH8 */
 		regmap_write(afe->regmap, AFE_HDMI_CONN0,
-			     AFE_HDMI_CONN0_O30_I30 | AFE_HDMI_CONN0_O31_I31 |
-			     AFE_HDMI_CONN0_O32_I34 | AFE_HDMI_CONN0_O33_I35 |
-			     AFE_HDMI_CONN0_O34_I32 | AFE_HDMI_CONN0_O35_I33 |
-			     AFE_HDMI_CONN0_O36_I36 | AFE_HDMI_CONN0_O37_I37);
+				 AFE_HDMI_CONN0_O30_I30 |
+				 AFE_HDMI_CONN0_O31_I31 |
+				 AFE_HDMI_CONN0_O32_I34 |
+				 AFE_HDMI_CONN0_O33_I35 |
+				 AFE_HDMI_CONN0_O34_I32 |
+				 AFE_HDMI_CONN0_O35_I33 |
+				 AFE_HDMI_CONN0_O36_I36 |
+				 AFE_HDMI_CONN0_O37_I37);
 
 		/* enable Out control */
 		regmap_update_bits(afe->regmap, AFE_HDMI_OUT_CON0, 0x1, 0x1);
@@ -531,224 +488,46 @@ static int mt8173_afe_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 				   AUD_TCON0_PDN_HDMI | AUD_TCON0_PDN_SPDF,
 				   AUD_TCON0_PDN_HDMI | AUD_TCON0_PDN_SPDF);
-
 		return 0;
 	default:
 		return -EINVAL;
 	}
 }
 
-static int mt8173_afe_dais_startup(struct snd_pcm_substream *substream,
-				   struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
-	int ret;
-
-	memif->substream = substream;
-
-	snd_soc_set_runtime_hwparams(substream, &mt8173_afe_hardware);
-
-	/*
-	 * Capture cannot use ping-pong buffer since hw_ptr at IRQ may be
-	 * smaller than period_size due to AFE's internal buffer.
-	 * This easily leads to overrun when avail_min is period_size.
-	 * One more period can hold the possible unread buffer.
-	 */
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		ret = snd_pcm_hw_constraint_minmax(runtime,
-						   SNDRV_PCM_HW_PARAM_PERIODS,
-						   3,
-						   mt8173_afe_hardware.periods_max);
-		if (ret < 0) {
-			dev_err(afe->dev, "hw_constraint_minmax failed\n");
-			return ret;
-		}
-	}
-	ret = snd_pcm_hw_constraint_integer(runtime,
-					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0)
-		dev_err(afe->dev, "snd_pcm_hw_constraint_integer failed\n");
-	return ret;
-}
-
-static void mt8173_afe_dais_shutdown(struct snd_pcm_substream *substream,
-				     struct snd_soc_dai *dai)
+static int mt8173_memif_fs(struct snd_pcm_substream *substream,
+			   unsigned int rate)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
-
-	memif->substream = NULL;
-}
-
-static int mt8173_afe_dais_hw_params(struct snd_pcm_substream *substream,
-				     struct snd_pcm_hw_params *params,
-				     struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
-	int msb_at_bit33 = 0;
-	int ret;
-
-	dev_dbg(afe->dev,
-		"%s period = %u, rate= %u, channels=%u\n",
-		__func__, params_period_size(params), params_rate(params),
-		params_channels(params));
-
-	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
-	if (ret < 0)
-		return ret;
+	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	int fs;
 
-	msb_at_bit33 = upper_32_bits(substream->runtime->dma_addr) ? 1 : 0;
-	memif->phys_buf_addr = lower_32_bits(substream->runtime->dma_addr);
-	memif->buffer_size = substream->runtime->dma_bytes;
-
-	/* start */
-	regmap_write(afe->regmap,
-		     memif->data->reg_ofs_base, memif->phys_buf_addr);
-	/* end */
-	regmap_write(afe->regmap,
-		     memif->data->reg_ofs_base + AFE_BASE_END_OFFSET,
-		     memif->phys_buf_addr + memif->buffer_size - 1);
-
-	/* set MSB to 33-bit */
-	regmap_update_bits(afe->regmap, AFE_MEMIF_MSB,
-			   1 << memif->data->msb_shift,
-			   msb_at_bit33 << memif->data->msb_shift);
-
-	/* set channel */
-	if (memif->data->mono_shift >= 0) {
-		unsigned int mono = (params_channels(params) == 1) ? 1 : 0;
-
-		regmap_update_bits(afe->regmap, AFE_DAC_CON1,
-				   1 << memif->data->mono_shift,
-				   mono << memif->data->mono_shift);
-	}
-
-	/* set rate */
-	if (memif->data->fs_shift < 0)
-		return 0;
 	if (memif->data->id == MT8173_AFE_MEMIF_DAI ||
 	    memif->data->id == MT8173_AFE_MEMIF_MOD_DAI) {
-		unsigned int val;
-
-		switch (params_rate(params)) {
+		switch (rate) {
 		case 8000:
-			val = 0;
+			fs = 0;
 			break;
 		case 16000:
-			val = 1;
+			fs = 1;
 			break;
 		case 32000:
-			val = 2;
+			fs = 2;
 			break;
 		default:
 			return -EINVAL;
 		}
-
-		if (memif->data->id == MT8173_AFE_MEMIF_DAI)
-			regmap_update_bits(afe->regmap, AFE_DAC_CON0,
-					   0x3 << memif->data->fs_shift,
-					   val << memif->data->fs_shift);
-		else
-			regmap_update_bits(afe->regmap, AFE_DAC_CON1,
-					   0x3 << memif->data->fs_shift,
-					   val << memif->data->fs_shift);
-
 	} else {
-		int fs = mt8173_afe_i2s_fs(params_rate(params));
-
-		if (fs < 0)
-			return -EINVAL;
-
-		regmap_update_bits(afe->regmap, AFE_DAC_CON1,
-				   0xf << memif->data->fs_shift,
-				   fs << memif->data->fs_shift);
+		fs = mt8173_afe_i2s_fs(rate);
 	}
-
-	return 0;
+	return fs;
 }
 
-static int mt8173_afe_dais_hw_free(struct snd_pcm_substream *substream,
-				   struct snd_soc_dai *dai)
+static int mt8173_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 {
-	return snd_pcm_lib_free_pages(substream);
+	return mt8173_afe_i2s_fs(rate);
 }
 
-static int mt8173_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
-				   struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
-	unsigned int counter = runtime->period_size;
-
-	dev_info(afe->dev, "%s %s cmd=%d\n", __func__, memif->data->name, cmd);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-		if (memif->data->enable_shift >= 0)
-			regmap_update_bits(afe->regmap, AFE_DAC_CON0,
-					   1 << memif->data->enable_shift,
-					   1 << memif->data->enable_shift);
-
-		/* set irq counter */
-		regmap_update_bits(afe->regmap,
-				   memif->data->irq_reg_cnt,
-				   0x3ffff << memif->data->irq_cnt_shift,
-				   counter << memif->data->irq_cnt_shift);
-
-		/* set irq fs */
-		if (memif->data->irq_fs_shift >= 0) {
-			int fs = mt8173_afe_i2s_fs(runtime->rate);
-
-			if (fs < 0)
-				return -EINVAL;
-
-			regmap_update_bits(afe->regmap,
-					   AFE_IRQ_MCU_CON,
-					   0xf << memif->data->irq_fs_shift,
-					   fs << memif->data->irq_fs_shift);
-		}
-		/* enable interrupt */
-		regmap_update_bits(afe->regmap, AFE_IRQ_MCU_CON,
-				   1 << memif->data->irq_en_shift,
-				   1 << memif->data->irq_en_shift);
-
-		return 0;
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-		if (memif->data->enable_shift >= 0)
-			regmap_update_bits(afe->regmap, AFE_DAC_CON0,
-					   1 << memif->data->enable_shift, 0);
-		/* disable interrupt */
-		regmap_update_bits(afe->regmap, AFE_IRQ_MCU_CON,
-				   1 << memif->data->irq_en_shift,
-				   0 << memif->data->irq_en_shift);
-		/* and clear pending IRQ */
-		regmap_write(afe->regmap, AFE_IRQ_CLR,
-			     1 << memif->data->irq_clr_shift);
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-/* FE DAIs */
-static const struct snd_soc_dai_ops mt8173_afe_dai_ops = {
-	.startup	= mt8173_afe_dais_startup,
-	.shutdown	= mt8173_afe_dais_shutdown,
-	.hw_params	= mt8173_afe_dais_hw_params,
-	.hw_free	= mt8173_afe_dais_hw_free,
-	.trigger	= mt8173_afe_dais_trigger,
-};
-
 /* BE DAIs */
 static const struct snd_soc_dai_ops mt8173_afe_i2s_ops = {
 	.startup	= mt8173_afe_i2s_startup,
@@ -761,56 +540,15 @@ static const struct snd_soc_dai_ops mt8173_afe_hdmi_ops = {
 	.shutdown	= mt8173_afe_hdmi_shutdown,
 	.prepare	= mt8173_afe_hdmi_prepare,
 	.trigger	= mt8173_afe_hdmi_trigger,
-
 };
 
-static int mt8173_afe_runtime_suspend(struct device *dev);
-static int mt8173_afe_runtime_resume(struct device *dev);
-
-static int mt8173_afe_dai_suspend(struct snd_soc_dai *dai)
-{
-	struct mt8173_afe *afe = snd_soc_dai_get_drvdata(dai);
-	int i;
-
-	dev_dbg(afe->dev, "%s\n", __func__);
-	if (pm_runtime_status_suspended(afe->dev) || afe->suspended)
-		return 0;
-
-	for (i = 0; i < ARRAY_SIZE(mt8173_afe_backup_list); i++)
-		regmap_read(afe->regmap, mt8173_afe_backup_list[i],
-			    &afe->backup_regs[i]);
-
-	afe->suspended = true;
-	mt8173_afe_runtime_suspend(afe->dev);
-	return 0;
-}
-
-static int mt8173_afe_dai_resume(struct snd_soc_dai *dai)
-{
-	struct mt8173_afe *afe = snd_soc_dai_get_drvdata(dai);
-	int i = 0;
-
-	dev_dbg(afe->dev, "%s\n", __func__);
-	if (pm_runtime_status_suspended(afe->dev) || !afe->suspended)
-		return 0;
-
-	mt8173_afe_runtime_resume(afe->dev);
-
-	for (i = 0; i < ARRAY_SIZE(mt8173_afe_backup_list); i++)
-		regmap_write(afe->regmap, mt8173_afe_backup_list[i],
-			     afe->backup_regs[i]);
-
-	afe->suspended = false;
-	return 0;
-}
-
 static struct snd_soc_dai_driver mt8173_afe_pcm_dais[] = {
 	/* FE DAIs: memory intefaces to CPU */
 	{
 		.name = "DL1", /* downlink 1 */
 		.id = MT8173_AFE_MEMIF_DL1,
-		.suspend = mt8173_afe_dai_suspend,
-		.resume = mt8173_afe_dai_resume,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
 		.playback = {
 			.stream_name = "DL1",
 			.channels_min = 1,
@@ -818,12 +556,12 @@ static struct snd_soc_dai_driver mt8173_afe_pcm_dais[] = {
 			.rates = SNDRV_PCM_RATE_8000_48000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.ops = &mt8173_afe_dai_ops,
+		.ops = &mtk_afe_fe_ops,
 	}, {
 		.name = "VUL", /* voice uplink */
 		.id = MT8173_AFE_MEMIF_VUL,
-		.suspend = mt8173_afe_dai_suspend,
-		.resume = mt8173_afe_dai_resume,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
 		.capture = {
 			.stream_name = "VUL",
 			.channels_min = 1,
@@ -831,7 +569,7 @@ static struct snd_soc_dai_driver mt8173_afe_pcm_dais[] = {
 			.rates = SNDRV_PCM_RATE_8000_48000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.ops = &mt8173_afe_dai_ops,
+		.ops = &mtk_afe_fe_ops,
 	}, {
 	/* BE DAIs */
 		.name = "I2S",
@@ -860,8 +598,8 @@ static struct snd_soc_dai_driver mt8173_afe_hdmi_dais[] = {
 	{
 		.name = "HDMI",
 		.id = MT8173_AFE_MEMIF_HDMI,
-		.suspend = mt8173_afe_dai_suspend,
-		.resume = mt8173_afe_dai_resume,
+		.suspend = mtk_afe_dai_suspend,
+		.resume = mtk_afe_dai_resume,
 		.playback = {
 			.stream_name = "HDMI",
 			.channels_min = 2,
@@ -872,7 +610,7 @@ static struct snd_soc_dai_driver mt8173_afe_hdmi_dais[] = {
 				SNDRV_PCM_RATE_192000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.ops = &mt8173_afe_dai_ops,
+		.ops = &mtk_afe_fe_ops,
 	}, {
 	/* BE DAIs */
 		.name = "HDMIO",
@@ -978,105 +716,222 @@ static const char *aud_clks[MT8173_CLK_NUM] = {
 	[MT8173_CLK_BCK1] =  "bck1",
 };
 
-static const struct mt8173_afe_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
+static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 	{
 		.name = "DL1",
 		.id = MT8173_AFE_MEMIF_DL1,
 		.reg_ofs_base = AFE_DL1_BASE,
 		.reg_ofs_cur = AFE_DL1_CUR,
+		.fs_reg = AFE_DAC_CON1,
 		.fs_shift = 0,
+		.fs_maskbit = 0xf,
+		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 21,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 1,
-		.irq_reg_cnt = AFE_IRQ_CNT1,
-		.irq_cnt_shift = 0,
-		.irq_en_shift = 0,
-		.irq_fs_shift = 4,
-		.irq_clr_shift = 0,
+		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 0,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 	}, {
 		.name = "DL2",
 		.id = MT8173_AFE_MEMIF_DL2,
 		.reg_ofs_base = AFE_DL2_BASE,
 		.reg_ofs_cur = AFE_DL2_CUR,
+		.fs_reg = AFE_DAC_CON1,
 		.fs_shift = 4,
+		.fs_maskbit = 0xf,
+		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 22,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 2,
-		.irq_reg_cnt = AFE_IRQ_CNT1,
-		.irq_cnt_shift = 20,
-		.irq_en_shift = 2,
-		.irq_fs_shift = 16,
-		.irq_clr_shift = 2,
+		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 1,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 	}, {
 		.name = "VUL",
 		.id = MT8173_AFE_MEMIF_VUL,
 		.reg_ofs_base = AFE_VUL_BASE,
 		.reg_ofs_cur = AFE_VUL_CUR,
+		.fs_reg = AFE_DAC_CON1,
 		.fs_shift = 16,
+		.fs_maskbit = 0xf,
+		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 27,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 3,
-		.irq_reg_cnt = AFE_IRQ_CNT2,
-		.irq_cnt_shift = 0,
-		.irq_en_shift = 1,
-		.irq_fs_shift = 8,
-		.irq_clr_shift = 1,
+		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 6,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 	}, {
 		.name = "DAI",
 		.id = MT8173_AFE_MEMIF_DAI,
 		.reg_ofs_base = AFE_DAI_BASE,
 		.reg_ofs_cur = AFE_DAI_CUR,
+		.fs_reg = AFE_DAC_CON0,
 		.fs_shift = 24,
+		.fs_maskbit = 0x3,
+		.mono_reg = -1,
 		.mono_shift = -1,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 4,
-		.irq_reg_cnt = AFE_IRQ_CNT2,
-		.irq_cnt_shift = 20,
-		.irq_en_shift = 3,
-		.irq_fs_shift = 20,
-		.irq_clr_shift = 3,
+		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 5,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 	}, {
 		.name = "AWB",
 		.id = MT8173_AFE_MEMIF_AWB,
 		.reg_ofs_base = AFE_AWB_BASE,
 		.reg_ofs_cur = AFE_AWB_CUR,
+		.fs_reg = AFE_DAC_CON1,
 		.fs_shift = 12,
+		.fs_maskbit = 0xf,
+		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 24,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 6,
-		.irq_reg_cnt = AFE_IRQ_CNT7,
-		.irq_cnt_shift = 0,
-		.irq_en_shift = 14,
-		.irq_fs_shift = 24,
-		.irq_clr_shift = 6,
+		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 3,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 	}, {
 		.name = "MOD_DAI",
 		.id = MT8173_AFE_MEMIF_MOD_DAI,
 		.reg_ofs_base = AFE_MOD_PCM_BASE,
 		.reg_ofs_cur = AFE_MOD_PCM_CUR,
+		.fs_reg = AFE_DAC_CON1,
 		.fs_shift = 30,
+		.fs_maskbit = 0x3,
+		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 30,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 7,
-		.irq_reg_cnt = AFE_IRQ_CNT2,
-		.irq_cnt_shift = 20,
-		.irq_en_shift = 3,
-		.irq_fs_shift = 20,
-		.irq_clr_shift = 3,
+		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 4,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 	}, {
 		.name = "HDMI",
 		.id = MT8173_AFE_MEMIF_HDMI,
 		.reg_ofs_base = AFE_HDMI_OUT_BASE,
 		.reg_ofs_cur = AFE_HDMI_OUT_CUR,
+		.fs_reg = -1,
 		.fs_shift = -1,
+		.fs_maskbit = -1,
+		.mono_reg = -1,
 		.mono_shift = -1,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = -1,
 		.enable_shift = -1,
-		.irq_reg_cnt = AFE_IRQ_CNT5,
+		.msb_reg = AFE_MEMIF_MSB,
+		.msb_shift = 8,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+	},
+};
+
+static const struct mtk_base_irq_data irq_data[MT8173_AFE_IRQ_NUM] = {
+	{
+		.id = MT8173_AFE_IRQ_DL1,
+		.irq_cnt_reg = AFE_IRQ_CNT1,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_en_reg = AFE_IRQ_MCU_CON,
+		.irq_en_shift = 0,
+		.irq_fs_reg = AFE_IRQ_MCU_CON,
+		.irq_fs_shift = 4,
+		.irq_fs_maskbit = 0xf,
+		.irq_clr_reg = AFE_IRQ_CLR,
+		.irq_clr_shift = 0,
+	}, {
+		.id = MT8173_AFE_IRQ_DL2,
+		.irq_cnt_reg = AFE_IRQ_CNT1,
+		.irq_cnt_shift = 20,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_en_reg = AFE_IRQ_MCU_CON,
+		.irq_en_shift = 2,
+		.irq_fs_reg = AFE_IRQ_MCU_CON,
+		.irq_fs_shift = 16,
+		.irq_fs_maskbit = 0xf,
+		.irq_clr_reg = AFE_IRQ_CLR,
+		.irq_clr_shift = 2,
+
+	}, {
+		.id = MT8173_AFE_IRQ_VUL,
+		.irq_cnt_reg = AFE_IRQ_CNT2,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_en_reg = AFE_IRQ_MCU_CON,
+		.irq_en_shift = 1,
+		.irq_fs_reg = AFE_IRQ_MCU_CON,
+		.irq_fs_shift = 8,
+		.irq_fs_maskbit = 0xf,
+		.irq_clr_reg = AFE_IRQ_CLR,
+		.irq_clr_shift = 1,
+	}, {
+		.id = MT8173_AFE_IRQ_DAI,
+		.irq_cnt_reg = AFE_IRQ_CNT2,
+		.irq_cnt_shift = 20,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_en_reg = AFE_IRQ_MCU_CON,
+		.irq_en_shift = 3,
+		.irq_fs_reg = AFE_IRQ_MCU_CON,
+		.irq_fs_shift = 20,
+		.irq_fs_maskbit = 0xf,
+		.irq_clr_reg = AFE_IRQ_CLR,
+		.irq_clr_shift = 3,
+	}, {
+		.id = MT8173_AFE_IRQ_AWB,
+		.irq_cnt_reg = AFE_IRQ_CNT7,
 		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_en_reg = AFE_IRQ_MCU_CON,
+		.irq_en_shift = 14,
+		.irq_fs_reg = AFE_IRQ_MCU_CON,
+		.irq_fs_shift = 24,
+		.irq_fs_maskbit = 0xf,
+		.irq_clr_reg = AFE_IRQ_CLR,
+		.irq_clr_shift = 6,
+	}, {
+		.id = MT8173_AFE_IRQ_DAI,
+		.irq_cnt_reg = AFE_IRQ_CNT2,
+		.irq_cnt_shift = 20,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_en_reg = AFE_IRQ_MCU_CON,
+		.irq_en_shift = 3,
+		.irq_fs_reg = AFE_IRQ_MCU_CON,
+		.irq_fs_shift = 20,
+		.irq_fs_maskbit = 0xf,
+		.irq_clr_reg = AFE_IRQ_CLR,
+		.irq_clr_shift = 3,
+	}, {
+		.id = MT8173_AFE_IRQ_HDMI,
+		.irq_cnt_reg = AFE_IRQ_CNT5,
+		.irq_cnt_shift = 0,
+		.irq_cnt_maskbit = 0x3ffff,
+		.irq_en_reg = AFE_IRQ_MCU_CON,
 		.irq_en_shift = 12,
+		.irq_fs_reg = -1,
 		.irq_fs_shift = -1,
+		.irq_fs_maskbit = -1,
+		.irq_clr_reg = AFE_IRQ_CLR,
 		.irq_clr_shift = 4,
-		.msb_shift = 8,
 	},
 };
 
@@ -1090,7 +945,7 @@ static const struct regmap_config mt8173_afe_regmap_config = {
 
 static irqreturn_t mt8173_afe_irq_handler(int irq, void *dev_id)
 {
-	struct mt8173_afe *afe = dev_id;
+	struct mtk_base_afe *afe = dev_id;
 	unsigned int reg_value;
 	int i, ret;
 
@@ -1102,24 +957,32 @@ static irqreturn_t mt8173_afe_irq_handler(int irq, void *dev_id)
 	}
 
 	for (i = 0; i < MT8173_AFE_MEMIF_NUM; i++) {
-		struct mt8173_afe_memif *memif = &afe->memif[i];
+		struct mtk_base_afe_memif *memif = &afe->memif[i];
+		struct mtk_base_afe_irq *irq;
 
-		if (!(reg_value & (1 << memif->data->irq_clr_shift)))
+		if (memif->irq_usage < 0)
 			continue;
 
-		snd_pcm_period_elapsed(memif->substream);
+		irq = &afe->irqs[memif->irq_usage];
+
+		if (!(reg_value & (1 << irq->irq_data->irq_clr_shift)))
+			continue;
+
+		mtk_simple_isr(afe, memif);
 	}
 
 err_irq:
 	/* clear irq */
-	regmap_write(afe->regmap, AFE_IRQ_CLR, reg_value & AFE_IRQ_STATUS_BITS);
+	regmap_write(afe->regmap, AFE_IRQ_CLR,
+		     reg_value & AFE_IRQ_STATUS_BITS);
 
 	return IRQ_HANDLED;
 }
 
 static int mt8173_afe_runtime_suspend(struct device *dev)
 {
-	struct mt8173_afe *afe = dev_get_drvdata(dev);
+	struct mtk_base_afe *afe = dev_get_drvdata(dev);
+	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 
 	/* disable AFE */
 	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0);
@@ -1127,44 +990,46 @@ static int mt8173_afe_runtime_suspend(struct device *dev)
 	/* disable AFE clk */
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_AFE, AUD_TCON0_PDN_AFE);
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_I2S1_M]);
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_I2S2_M]);
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_BCK0]);
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_BCK1]);
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_TOP_PDN_AUD]);
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_INFRASYS_AUD]);
+
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_I2S1_M]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_I2S2_M]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_BCK0]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_BCK1]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_TOP_PDN_AUD]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_INFRASYS_AUD]);
 	return 0;
 }
 
 static int mt8173_afe_runtime_resume(struct device *dev)
 {
-	struct mt8173_afe *afe = dev_get_drvdata(dev);
+	struct mtk_base_afe *afe = dev_get_drvdata(dev);
+	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 	int ret;
 
-	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_INFRASYS_AUD]);
+	ret = clk_prepare_enable(afe_priv->clocks[MT8173_CLK_INFRASYS_AUD]);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
+	ret = clk_prepare_enable(afe_priv->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
 	if (ret)
 		goto err_infra;
 
-	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_TOP_PDN_AUD]);
+	ret = clk_prepare_enable(afe_priv->clocks[MT8173_CLK_TOP_PDN_AUD]);
 	if (ret)
 		goto err_top_aud_bus;
 
-	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_BCK0]);
+	ret = clk_prepare_enable(afe_priv->clocks[MT8173_CLK_BCK0]);
 	if (ret)
 		goto err_top_aud;
 
-	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_BCK1]);
+	ret = clk_prepare_enable(afe_priv->clocks[MT8173_CLK_BCK1]);
 	if (ret)
 		goto err_bck0;
-	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_I2S1_M]);
+	ret = clk_prepare_enable(afe_priv->clocks[MT8173_CLK_I2S1_M]);
 	if (ret)
 		goto err_i2s1_m;
-	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_I2S2_M]);
+	ret = clk_prepare_enable(afe_priv->clocks[MT8173_CLK_I2S2_M]);
 	if (ret)
 		goto err_i2s2_m;
 
@@ -1181,35 +1046,37 @@ static int mt8173_afe_runtime_resume(struct device *dev)
 	/* enable AFE */
 	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x1);
 	return 0;
+
 err_i2s1_m:
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_I2S1_M]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_I2S1_M]);
 err_i2s2_m:
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_I2S2_M]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_I2S2_M]);
 err_bck0:
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_BCK0]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_BCK0]);
 err_top_aud:
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_TOP_PDN_AUD]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_TOP_PDN_AUD]);
 err_top_aud_bus:
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
 err_infra:
-	clk_disable_unprepare(afe->clocks[MT8173_CLK_INFRASYS_AUD]);
+	clk_disable_unprepare(afe_priv->clocks[MT8173_CLK_INFRASYS_AUD]);
 	return ret;
 }
 
-static int mt8173_afe_init_audio_clk(struct mt8173_afe *afe)
+static int mt8173_afe_init_audio_clk(struct mtk_base_afe *afe)
 {
 	size_t i;
+	struct mt8173_afe_private *afe_priv = afe->platform_priv;
 
 	for (i = 0; i < ARRAY_SIZE(aud_clks); i++) {
-		afe->clocks[i] = devm_clk_get(afe->dev, aud_clks[i]);
-		if (IS_ERR(afe->clocks[i])) {
+		afe_priv->clocks[i] = devm_clk_get(afe->dev, aud_clks[i]);
+		if (IS_ERR(afe_priv->clocks[i])) {
 			dev_err(afe->dev, "%s devm_clk_get %s fail\n",
 				__func__, aud_clks[i]);
-			return PTR_ERR(afe->clocks[i]);
+			return PTR_ERR(afe_priv->clocks[i]);
 		}
 	}
-	clk_set_rate(afe->clocks[MT8173_CLK_BCK0], 22579200); /* 22M */
-	clk_set_rate(afe->clocks[MT8173_CLK_BCK1], 24576000); /* 24M */
+	clk_set_rate(afe_priv->clocks[MT8173_CLK_BCK0], 22579200); /* 22M */
+	clk_set_rate(afe_priv->clocks[MT8173_CLK_BCK1], 24576000); /* 24M */
 	return 0;
 }
 
@@ -1217,7 +1084,8 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	int ret, i;
 	unsigned int irq_id;
-	struct mt8173_afe *afe;
+	struct mtk_base_afe *afe;
+	struct mt8173_afe_private *afe_priv;
 	struct resource *res;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(33));
@@ -1228,6 +1096,12 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (!afe)
 		return -ENOMEM;
 
+	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
+					  GFP_KERNEL);
+	afe_priv = afe->platform_priv;
+	if (!afe_priv)
+		return -ENOMEM;
+
 	afe->dev = &pdev->dev;
 
 	irq_id = platform_get_irq(pdev, 0);
@@ -1259,8 +1133,30 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	for (i = 0; i < MT8173_AFE_MEMIF_NUM; i++)
+	/*memif % irq initialize*/
+	afe->memif_size = MT8173_AFE_MEMIF_NUM;
+	afe->memif = devm_kcalloc(afe->dev, afe->memif_size,
+				  sizeof(*afe->memif), GFP_KERNEL);
+	if (!afe->memif)
+		return -ENOMEM;
+
+	afe->irqs_size = MT8173_AFE_IRQ_NUM;
+	afe->irqs = devm_kcalloc(afe->dev, afe->irqs_size,
+				 sizeof(*afe->irqs), GFP_KERNEL);
+	if (!afe->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->irqs_size; i++) {
 		afe->memif[i].data = &memif_data[i];
+		afe->irqs[i].irq_data = &irq_data[i];
+		afe->irqs[i].irq_occupyed = true;
+		afe->memif[i].irq_usage = i;
+		afe->memif[i].const_irq = 1;
+	}
+
+	afe->mtk_afe_hardware = &mt8173_afe_hardware;
+	afe->memif_fs = mt8173_memif_fs;
+	afe->irq_fs = mt8173_irq_fs;
 
 	platform_set_drvdata(pdev, afe);
 
@@ -1271,7 +1167,12 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = snd_soc_register_platform(&pdev->dev, &mt8173_afe_pcm_platform);
+	afe->reg_back_up_list = mt8173_afe_backup_list;
+	afe->reg_back_up_list_num = ARRAY_SIZE(mt8173_afe_backup_list);
+	afe->runtime_resume = mt8173_afe_runtime_resume;
+	afe->runtime_suspend = mt8173_afe_runtime_suspend;
+
+	ret = snd_soc_register_platform(&pdev->dev, &mtk_afe_pcm_platform);
 	if (ret)
 		goto err_pm_disable;
 
-- 
1.9.1
