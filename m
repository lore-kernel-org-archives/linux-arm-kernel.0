From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Fri, 29 Apr 2016 21:00:42 +0800
Subject: [alsa-devel] [PATCH 1/7] ASoC: mediatek: Refine mt8173 driver and
 change config option
In-Reply-To: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

move mt8173 driver to another folder and add prefix.
change config option from SND_SOC_MEDIATEK to SND_SOC_MT8173

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/Kconfig                         |  14 +-
 sound/soc/mediatek/Makefile                        |   9 +-
 sound/soc/mediatek/mt8173/Makefile                 |   7 +
 sound/soc/mediatek/mt8173/mt8173-afe-common.h      | 101 +++++
 .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     | 488 ++++++++++-----------
 sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c  |   2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c   |   2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c   |   4 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c    |   2 +-
 sound/soc/mediatek/mtk-afe-common.h                | 101 -----
 10 files changed, 365 insertions(+), 365 deletions(-)
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-afe-common.h
 rename sound/soc/mediatek/{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c} (67%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (99%)
 delete mode 100644 sound/soc/mediatek/mtk-afe-common.h

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 3abf51c..ae9f664 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -1,15 +1,15 @@
-config SND_SOC_MEDIATEK
-	tristate "ASoC support for Mediatek chip"
+config SND_SOC_MT8173
+	tristate "ASoC support for Mediatek MT8173 chip"
 	depends on ARCH_MEDIATEK
 	help
-	  This adds ASoC platform driver support for Mediatek chip
+	  This adds ASoC platform driver support for Mediatek MT8173 chip
 	  that can be used with other codecs.
 	  Select Y if you have such device.
 	  Ex: MT8173
 
 config SND_SOC_MT8173_MAX98090
 	tristate "ASoC Audio driver for MT8173 with MAX98090 codec"
-	depends on SND_SOC_MEDIATEK && I2C
+	depends on SND_SOC_MT8173 && I2C
 	select SND_SOC_MAX98090
 	help
 	  This adds ASoC driver for Mediatek MT8173 boards
@@ -19,7 +19,7 @@ config SND_SOC_MT8173_MAX98090
 
 config SND_SOC_MT8173_RT5650
 	tristate "ASoC Audio driver for MT8173 with RT5650 codec"
-	depends on SND_SOC_MEDIATEK && I2C
+	depends on SND_SOC_MT8173 && I2C
 	select SND_SOC_RT5645
 	help
 	  This adds ASoC driver for Mediatek MT8173 boards
@@ -29,7 +29,7 @@ config SND_SOC_MT8173_RT5650
 
 config SND_SOC_MT8173_RT5650_RT5514
 	tristate "ASoC Audio driver for MT8173 with RT5650 RT5514 codecs"
-	depends on SND_SOC_MEDIATEK && I2C
+	depends on SND_SOC_MT8173 && I2C
 	select SND_SOC_RT5645
 	select SND_SOC_RT5514
 	help
@@ -40,7 +40,7 @@ config SND_SOC_MT8173_RT5650_RT5514
 
 config SND_SOC_MT8173_RT5650_RT5676
 	tristate "ASoC Audio driver for MT8173 with RT5650 RT5676 codecs"
-	depends on SND_SOC_MEDIATEK && I2C
+	depends on SND_SOC_MT8173 && I2C
 	select SND_SOC_RT5645
 	select SND_SOC_RT5677
 	select SND_SOC_HDMI_CODEC
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index d486860..240dfc70 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -1,7 +1,2 @@
-# MTK Platform Support
-obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
-# Machine support
-obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
-obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o
-obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5514) += mt8173-rt5650-rt5514.o
-obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
+# 8173 Machine support
+obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
diff --git a/sound/soc/mediatek/mt8173/Makefile b/sound/soc/mediatek/mt8173/Makefile
new file mode 100644
index 0000000..8158ef2
--- /dev/null
+++ b/sound/soc/mediatek/mt8173/Makefile
@@ -0,0 +1,7 @@
+# MTK Platform Support
+obj-$(CONFIG_SND_SOC_MEDIATEK) += mt8173-afe-pcm.o
+# Machine support
+obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
+obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o
+obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5514) += mt8173-rt5650-rt5514.o
+obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-common.h b/sound/soc/mediatek/mt8173/mt8173-afe-common.h
new file mode 100644
index 0000000..8f2936d
--- /dev/null
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-common.h
@@ -0,0 +1,101 @@
+/*
+ * mt8173_afe_common.h  --  Mediatek 8173 audio driver common definitions
+ *
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Koro Chen <koro.chen@mediatek.com>
+ *             Sascha Hauer <s.hauer@pengutronix.de>
+ *             Hidalgo Huang <hidalgo.huang@mediatek.com>
+ *             Ir Lian <ir.lian@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _MT8173_AFE_COMMON_H_
+#define _MT8173_AFE_COMMON_H_
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+
+enum {
+	MT8173_AFE_MEMIF_DL1,
+	MT8173_AFE_MEMIF_DL2,
+	MT8173_AFE_MEMIF_VUL,
+	MT8173_AFE_MEMIF_DAI,
+	MT8173_AFE_MEMIF_AWB,
+	MT8173_AFE_MEMIF_MOD_DAI,
+	MT8173_AFE_MEMIF_HDMI,
+	MT8173_AFE_MEMIF_NUM,
+	MT8173_AFE_IO_MOD_PCM1 = MT8173_AFE_MEMIF_NUM,
+	MT8173_AFE_IO_MOD_PCM2,
+	MT8173_AFE_IO_PMIC,
+	MT8173_AFE_IO_I2S,
+	MT8173_AFE_IO_2ND_I2S,
+	MT8173_AFE_IO_HW_GAIN1,
+	MT8173_AFE_IO_HW_GAIN2,
+	MT8173_AFE_IO_MRG_O,
+	MT8173_AFE_IO_MRG_I,
+	MT8173_AFE_IO_DAIBT,
+	MT8173_AFE_IO_HDMI,
+};
+
+enum {
+	MT8173_AFE_IRQ_1,
+	MT8173_AFE_IRQ_2,
+	MT8173_AFE_IRQ_3,
+	MT8173_AFE_IRQ_4,
+	MT8173_AFE_IRQ_5,
+	MT8173_AFE_IRQ_6,
+	MT8173_AFE_IRQ_7,
+	MT8173_AFE_IRQ_8,
+	MT8173_AFE_IRQ_NUM,
+};
+
+enum {
+	MT8173_CLK_INFRASYS_AUD,
+	MT8173_CLK_TOP_PDN_AUD,
+	MT8173_CLK_TOP_PDN_AUD_BUS,
+	MT8173_CLK_I2S0_M,
+	MT8173_CLK_I2S1_M,
+	MT8173_CLK_I2S2_M,
+	MT8173_CLK_I2S3_M,
+	MT8173_CLK_I2S3_B,
+	MT8173_CLK_BCK0,
+	MT8173_CLK_BCK1,
+	MT8173_CLK_NUM
+};
+
+struct mt8173_afe;
+struct snd_pcm_substream;
+
+struct mt8173_afe_memif_data {
+	int id;
+	const char *name;
+	int reg_ofs_base;
+	int reg_ofs_cur;
+	int fs_shift;
+	int mono_shift;
+	int enable_shift;
+	int irq_reg_cnt;
+	int irq_cnt_shift;
+	int irq_en_shift;
+	int irq_fs_shift;
+	int irq_clr_shift;
+	int msb_shift;
+};
+
+struct mt8173_afe_memif {
+	unsigned int phys_buf_addr;
+	int buffer_size;
+	struct snd_pcm_substream *substream;
+	const struct mt8173_afe_memif_data *data;
+	const struct mt8173_afe_irq_data *irqdata;
+};
+
+#endif
diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
similarity index 67%
rename from sound/soc/mediatek/mtk-afe-pcm.c
rename to sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 2b5df2e..ba4739c 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1,5 +1,5 @@
 /*
- * Mediatek ALSA SoC AFE platform driver
+ * Mediatek 8173 ALSA SoC AFE platform driver
  *
  * Copyright (c) 2015 MediaTek Inc.
  * Author: Koro Chen <koro.chen@mediatek.com>
@@ -24,7 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <sound/soc.h>
-#include "mtk-afe-common.h"
+#include "mt8173-afe-common.h"
 
 /*****************************************************************************
  *                  R E G I S T E R       D E F I N I T I O N
@@ -135,7 +135,7 @@ enum afe_tdm_ch_start {
 	AFE_TDM_CH_ZERO,
 };
 
-static const unsigned int mtk_afe_backup_list[] = {
+static const unsigned int mt8173_afe_backup_list[] = {
 	AUDIO_TOP_CON0,
 	AFE_CONN1,
 	AFE_CONN2,
@@ -152,18 +152,18 @@ static const unsigned int mtk_afe_backup_list[] = {
 	AFE_DAC_CON0,
 };
 
-struct mtk_afe {
+struct mt8173_afe {
 	/* address for ioremap audio hardware register */
 	void __iomem *base_addr;
 	struct device *dev;
 	struct regmap *regmap;
-	struct mtk_afe_memif memif[MTK_AFE_MEMIF_NUM];
-	struct clk *clocks[MTK_CLK_NUM];
-	unsigned int backup_regs[ARRAY_SIZE(mtk_afe_backup_list)];
+	struct mt8173_afe_memif memif[MT8173_AFE_MEMIF_NUM];
+	struct clk *clocks[MT8173_CLK_NUM];
+	unsigned int backup_regs[ARRAY_SIZE(mt8173_afe_backup_list)];
 	bool suspended;
 };
 
-static const struct snd_pcm_hardware mtk_afe_hardware = {
+static const struct snd_pcm_hardware mt8173_afe_hardware = {
 	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_MMAP_VALID),
 	.buffer_bytes_max = 256 * 1024,
@@ -174,12 +174,12 @@ static const struct snd_pcm_hardware mtk_afe_hardware = {
 	.fifo_size = 0,
 };
 
-static snd_pcm_uframes_t mtk_afe_pcm_pointer
+static snd_pcm_uframes_t mt8173_afe_pcm_pointer
 			 (struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct mtk_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	unsigned int hw_ptr;
 	int ret;
 
@@ -193,40 +193,40 @@ static snd_pcm_uframes_t mtk_afe_pcm_pointer
 			       hw_ptr - memif->phys_buf_addr);
 }
 
-static const struct snd_pcm_ops mtk_afe_pcm_ops = {
+static const struct snd_pcm_ops mt8173_afe_pcm_ops = {
 	.ioctl = snd_pcm_lib_ioctl,
-	.pointer = mtk_afe_pcm_pointer,
+	.pointer = mt8173_afe_pcm_pointer,
 };
 
-static int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
+static int mt8173_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	size_t size;
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_pcm *pcm = rtd->pcm;
 
-	size = mtk_afe_hardware.buffer_bytes_max;
+	size = mt8173_afe_hardware.buffer_bytes_max;
 
 	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 						     card->dev, size, size);
 }
 
-static void mtk_afe_pcm_free(struct snd_pcm *pcm)
+static void mt8173_afe_pcm_free(struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
-static const struct snd_soc_platform_driver mtk_afe_pcm_platform = {
-	.ops = &mtk_afe_pcm_ops,
-	.pcm_new = mtk_afe_pcm_new,
-	.pcm_free = mtk_afe_pcm_free,
+static const struct snd_soc_platform_driver mt8173_afe_pcm_platform = {
+	.ops = &mt8173_afe_pcm_ops,
+	.pcm_new = mt8173_afe_pcm_new,
+	.pcm_free = mt8173_afe_pcm_free,
 };
 
-struct mtk_afe_rate {
+struct mt8173_afe_rate {
 	unsigned int rate;
 	unsigned int regvalue;
 };
 
-static const struct mtk_afe_rate mtk_afe_i2s_rates[] = {
+static const struct mt8173_afe_rate mt8173_afe_i2s_rates[] = {
 	{ .rate = 8000, .regvalue = 0 },
 	{ .rate = 11025, .regvalue = 1 },
 	{ .rate = 12000, .regvalue = 2 },
@@ -242,21 +242,21 @@ static const struct mtk_afe_rate mtk_afe_i2s_rates[] = {
 	{ .rate = 192000, .regvalue = 14 },
 };
 
-static int mtk_afe_i2s_fs(unsigned int sample_rate)
+static int mt8173_afe_i2s_fs(unsigned int sample_rate)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mtk_afe_i2s_rates); i++)
-		if (mtk_afe_i2s_rates[i].rate == sample_rate)
-			return mtk_afe_i2s_rates[i].regvalue;
+	for (i = 0; i < ARRAY_SIZE(mt8173_afe_i2s_rates); i++)
+		if (mt8173_afe_i2s_rates[i].rate == sample_rate)
+			return mt8173_afe_i2s_rates[i].regvalue;
 
 	return -EINVAL;
 }
 
-static int mtk_afe_set_i2s(struct mtk_afe *afe, unsigned int rate)
+static int mt8173_afe_set_i2s(struct mt8173_afe *afe, unsigned int rate)
 {
 	unsigned int val;
-	int fs = mtk_afe_i2s_fs(rate);
+	int fs = mt8173_afe_i2s_fs(rate);
 
 	if (fs < 0)
 		return -EINVAL;
@@ -281,7 +281,7 @@ static int mtk_afe_set_i2s(struct mtk_afe *afe, unsigned int rate)
 	return 0;
 }
 
-static void mtk_afe_set_i2s_enable(struct mtk_afe *afe, bool enable)
+static void mt8173_afe_set_i2s_enable(struct mt8173_afe *afe, bool enable)
 {
 	unsigned int val;
 
@@ -296,8 +296,8 @@ static void mtk_afe_set_i2s_enable(struct mtk_afe *afe, bool enable)
 	regmap_update_bits(afe->regmap, AFE_I2S_CON1, 0x1, enable);
 }
 
-static int mtk_afe_dais_enable_clks(struct mtk_afe *afe,
-				    struct clk *m_ck, struct clk *b_ck)
+static int mt8173_afe_dais_enable_clks(struct mt8173_afe *afe,
+				       struct clk *m_ck, struct clk *b_ck)
 {
 	int ret;
 
@@ -319,9 +319,9 @@ static int mtk_afe_dais_enable_clks(struct mtk_afe *afe,
 	return 0;
 }
 
-static int mtk_afe_dais_set_clks(struct mtk_afe *afe,
-				 struct clk *m_ck, unsigned int mck_rate,
-				 struct clk *b_ck, unsigned int bck_rate)
+static int mt8173_afe_dais_set_clks(struct mt8173_afe *afe,
+				    struct clk *m_ck, unsigned int mck_rate,
+				    struct clk *b_ck, unsigned int bck_rate)
 {
 	int ret;
 
@@ -343,8 +343,8 @@ static int mtk_afe_dais_set_clks(struct mtk_afe *afe,
 	return 0;
 }
 
-static void mtk_afe_dais_disable_clks(struct mtk_afe *afe,
-				      struct clk *m_ck, struct clk *b_ck)
+static void mt8173_afe_dais_disable_clks(struct mt8173_afe *afe,
+					 struct clk *m_ck, struct clk *b_ck)
 {
 	if (m_ck)
 		clk_disable_unprepare(m_ck);
@@ -352,102 +352,100 @@ static void mtk_afe_dais_disable_clks(struct mtk_afe *afe,
 		clk_disable_unprepare(b_ck);
 }
 
-static int mtk_afe_i2s_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
+static int mt8173_afe_i2s_startup(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 
 	if (dai->active)
 		return 0;
 
-	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
-	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S2_M], NULL);
+	mt8173_afe_dais_enable_clks(afe, afe->clocks[MT8173_CLK_I2S1_M], NULL);
+	mt8173_afe_dais_enable_clks(afe, afe->clocks[MT8173_CLK_I2S2_M], NULL);
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M, 0);
 	return 0;
 }
 
-static void mtk_afe_i2s_shutdown(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
+static void mt8173_afe_i2s_shutdown(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 
 	if (dai->active)
 		return;
 
-	mtk_afe_set_i2s_enable(afe, false);
+	mt8173_afe_set_i2s_enable(afe, false);
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M,
 			   AUD_TCON0_PDN_22M | AUD_TCON0_PDN_24M);
-	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S1_M], NULL);
-	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S2_M], NULL);
+	mt8173_afe_dais_disable_clks(afe, afe->clocks[MT8173_CLK_I2S1_M], NULL);
+	mt8173_afe_dais_disable_clks(afe, afe->clocks[MT8173_CLK_I2S2_M], NULL);
 }
 
-static int mtk_afe_i2s_prepare(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
+static int mt8173_afe_i2s_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 	int ret;
 
-	mtk_afe_dais_set_clks(afe,
-			      afe->clocks[MTK_CLK_I2S1_M], runtime->rate * 256,
-			      NULL, 0);
-	mtk_afe_dais_set_clks(afe,
-			      afe->clocks[MTK_CLK_I2S2_M], runtime->rate * 256,
-			      NULL, 0);
+	mt8173_afe_dais_set_clks(afe, afe->clocks[MT8173_CLK_I2S1_M],
+				 runtime->rate * 256, NULL, 0);
+	mt8173_afe_dais_set_clks(afe, afe->clocks[MT8173_CLK_I2S2_M],
+				 runtime->rate * 256, NULL, 0);
 	/* config I2S */
-	ret = mtk_afe_set_i2s(afe, substream->runtime->rate);
+	ret = mt8173_afe_set_i2s(afe, substream->runtime->rate);
 	if (ret)
 		return ret;
 
-	mtk_afe_set_i2s_enable(afe, true);
+	mt8173_afe_set_i2s_enable(afe, true);
 
 	return 0;
 }
 
-static int mtk_afe_hdmi_startup(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
+static int mt8173_afe_hdmi_startup(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 
 	if (dai->active)
 		return 0;
 
-	mtk_afe_dais_enable_clks(afe, afe->clocks[MTK_CLK_I2S3_M],
-				 afe->clocks[MTK_CLK_I2S3_B]);
+	mt8173_afe_dais_enable_clks(afe, afe->clocks[MT8173_CLK_I2S3_M],
+				    afe->clocks[MT8173_CLK_I2S3_B]);
 	return 0;
 }
 
-static void mtk_afe_hdmi_shutdown(struct snd_pcm_substream *substream,
-				  struct snd_soc_dai *dai)
+static void mt8173_afe_hdmi_shutdown(struct snd_pcm_substream *substream,
+				     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 
 	if (dai->active)
 		return;
 
-	mtk_afe_dais_disable_clks(afe, afe->clocks[MTK_CLK_I2S3_M],
-				  afe->clocks[MTK_CLK_I2S3_B]);
+	mt8173_afe_dais_disable_clks(afe, afe->clocks[MT8173_CLK_I2S3_M],
+				     afe->clocks[MT8173_CLK_I2S3_B]);
 }
 
-static int mtk_afe_hdmi_prepare(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
+static int mt8173_afe_hdmi_prepare(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 	unsigned int val;
 
-	mtk_afe_dais_set_clks(afe,
-			      afe->clocks[MTK_CLK_I2S3_M], runtime->rate * 128,
-			      afe->clocks[MTK_CLK_I2S3_B],
-			      runtime->rate * runtime->channels * 32);
+	mt8173_afe_dais_set_clks(afe, afe->clocks[MT8173_CLK_I2S3_M],
+				 runtime->rate * 128,
+				 afe->clocks[MT8173_CLK_I2S3_B],
+				 runtime->rate * runtime->channels * 32);
 
 	val = AFE_TDM_CON1_BCK_INV |
 	      AFE_TDM_CON1_LRCK_INV |
@@ -498,11 +496,11 @@ static int mtk_afe_hdmi_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int mtk_afe_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
+static int mt8173_afe_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
+				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 
 	dev_info(afe->dev, "%s cmd=%d %s\n", __func__, cmd, dai->name);
 
@@ -544,18 +542,18 @@ static int mtk_afe_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 	}
 }
 
-static int mtk_afe_dais_startup(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
+static int mt8173_afe_dais_startup(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct mtk_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	int ret;
 
 	memif->substream = substream;
 
-	snd_soc_set_runtime_hwparams(substream, &mtk_afe_hardware);
+	snd_soc_set_runtime_hwparams(substream, &mt8173_afe_hardware);
 
 	/*
 	 * Capture cannot use ping-pong buffer since hw_ptr at IRQ may be
@@ -567,7 +565,7 @@ static int mtk_afe_dais_startup(struct snd_pcm_substream *substream,
 		ret = snd_pcm_hw_constraint_minmax(runtime,
 						   SNDRV_PCM_HW_PARAM_PERIODS,
 						   3,
-						   mtk_afe_hardware.periods_max);
+						   mt8173_afe_hardware.periods_max);
 		if (ret < 0) {
 			dev_err(afe->dev, "hw_constraint_minmax failed\n");
 			return ret;
@@ -580,23 +578,23 @@ static int mtk_afe_dais_startup(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static void mtk_afe_dais_shutdown(struct snd_pcm_substream *substream,
-				  struct snd_soc_dai *dai)
+static void mt8173_afe_dais_shutdown(struct snd_pcm_substream *substream,
+				     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct mtk_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 
 	memif->substream = NULL;
 }
 
-static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
-				  struct snd_pcm_hw_params *params,
-				  struct snd_soc_dai *dai)
+static int mt8173_afe_dais_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params,
+				     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct mtk_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	int msb_at_bit33 = 0;
 	int ret;
 
@@ -638,8 +636,8 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 	/* set rate */
 	if (memif->data->fs_shift < 0)
 		return 0;
-	if (memif->data->id == MTK_AFE_MEMIF_DAI ||
-	    memif->data->id == MTK_AFE_MEMIF_MOD_DAI) {
+	if (memif->data->id == MT8173_AFE_MEMIF_DAI ||
+	    memif->data->id == MT8173_AFE_MEMIF_MOD_DAI) {
 		unsigned int val;
 
 		switch (params_rate(params)) {
@@ -656,7 +654,7 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 
-		if (memif->data->id == MTK_AFE_MEMIF_DAI)
+		if (memif->data->id == MT8173_AFE_MEMIF_DAI)
 			regmap_update_bits(afe->regmap, AFE_DAC_CON0,
 					   0x3 << memif->data->fs_shift,
 					   val << memif->data->fs_shift);
@@ -666,7 +664,7 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 					   val << memif->data->fs_shift);
 
 	} else {
-		int fs = mtk_afe_i2s_fs(params_rate(params));
+		int fs = mt8173_afe_i2s_fs(params_rate(params));
 
 		if (fs < 0)
 			return -EINVAL;
@@ -679,19 +677,19 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int mtk_afe_dais_hw_free(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
+static int mt8173_afe_dais_hw_free(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
 {
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static int mtk_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
+static int mt8173_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
+				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime * const runtime = substream->runtime;
-	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
-	struct mtk_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	struct mt8173_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
+	struct mt8173_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	unsigned int counter = runtime->period_size;
 
 	dev_info(afe->dev, "%s %s cmd=%d\n", __func__, memif->data->name, cmd);
@@ -712,7 +710,7 @@ static int mtk_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		/* set irq fs */
 		if (memif->data->irq_fs_shift >= 0) {
-			int fs = mtk_afe_i2s_fs(runtime->rate);
+			int fs = mt8173_afe_i2s_fs(runtime->rate);
 
 			if (fs < 0)
 				return -EINVAL;
@@ -747,76 +745,76 @@ static int mtk_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
 }
 
 /* FE DAIs */
-static const struct snd_soc_dai_ops mtk_afe_dai_ops = {
-	.startup	= mtk_afe_dais_startup,
-	.shutdown	= mtk_afe_dais_shutdown,
-	.hw_params	= mtk_afe_dais_hw_params,
-	.hw_free	= mtk_afe_dais_hw_free,
-	.trigger	= mtk_afe_dais_trigger,
+static const struct snd_soc_dai_ops mt8173_afe_dai_ops = {
+	.startup	= mt8173_afe_dais_startup,
+	.shutdown	= mt8173_afe_dais_shutdown,
+	.hw_params	= mt8173_afe_dais_hw_params,
+	.hw_free	= mt8173_afe_dais_hw_free,
+	.trigger	= mt8173_afe_dais_trigger,
 };
 
 /* BE DAIs */
-static const struct snd_soc_dai_ops mtk_afe_i2s_ops = {
-	.startup	= mtk_afe_i2s_startup,
-	.shutdown	= mtk_afe_i2s_shutdown,
-	.prepare	= mtk_afe_i2s_prepare,
+static const struct snd_soc_dai_ops mt8173_afe_i2s_ops = {
+	.startup	= mt8173_afe_i2s_startup,
+	.shutdown	= mt8173_afe_i2s_shutdown,
+	.prepare	= mt8173_afe_i2s_prepare,
 };
 
-static const struct snd_soc_dai_ops mtk_afe_hdmi_ops = {
-	.startup	= mtk_afe_hdmi_startup,
-	.shutdown	= mtk_afe_hdmi_shutdown,
-	.prepare	= mtk_afe_hdmi_prepare,
-	.trigger	= mtk_afe_hdmi_trigger,
+static const struct snd_soc_dai_ops mt8173_afe_hdmi_ops = {
+	.startup	= mt8173_afe_hdmi_startup,
+	.shutdown	= mt8173_afe_hdmi_shutdown,
+	.prepare	= mt8173_afe_hdmi_prepare,
+	.trigger	= mt8173_afe_hdmi_trigger,
 
 };
 
-static int mtk_afe_runtime_suspend(struct device *dev);
-static int mtk_afe_runtime_resume(struct device *dev);
+static int mt8173_afe_runtime_suspend(struct device *dev);
+static int mt8173_afe_runtime_resume(struct device *dev);
 
-static int mtk_afe_dai_suspend(struct snd_soc_dai *dai)
+static int mt8173_afe_dai_suspend(struct snd_soc_dai *dai)
 {
-	struct mtk_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8173_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int i;
 
 	dev_dbg(afe->dev, "%s\n", __func__);
 	if (pm_runtime_status_suspended(afe->dev) || afe->suspended)
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(mtk_afe_backup_list); i++)
-		regmap_read(afe->regmap, mtk_afe_backup_list[i],
+	for (i = 0; i < ARRAY_SIZE(mt8173_afe_backup_list); i++)
+		regmap_read(afe->regmap, mt8173_afe_backup_list[i],
 			    &afe->backup_regs[i]);
 
 	afe->suspended = true;
-	mtk_afe_runtime_suspend(afe->dev);
+	mt8173_afe_runtime_suspend(afe->dev);
 	return 0;
 }
 
-static int mtk_afe_dai_resume(struct snd_soc_dai *dai)
+static int mt8173_afe_dai_resume(struct snd_soc_dai *dai)
 {
-	struct mtk_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8173_afe *afe = snd_soc_dai_get_drvdata(dai);
 	int i = 0;
 
 	dev_dbg(afe->dev, "%s\n", __func__);
 	if (pm_runtime_status_suspended(afe->dev) || !afe->suspended)
 		return 0;
 
-	mtk_afe_runtime_resume(afe->dev);
+	mt8173_afe_runtime_resume(afe->dev);
 
-	for (i = 0; i < ARRAY_SIZE(mtk_afe_backup_list); i++)
-		regmap_write(afe->regmap, mtk_afe_backup_list[i],
+	for (i = 0; i < ARRAY_SIZE(mt8173_afe_backup_list); i++)
+		regmap_write(afe->regmap, mt8173_afe_backup_list[i],
 			     afe->backup_regs[i]);
 
 	afe->suspended = false;
 	return 0;
 }
 
-static struct snd_soc_dai_driver mtk_afe_pcm_dais[] = {
+static struct snd_soc_dai_driver mt8173_afe_pcm_dais[] = {
 	/* FE DAIs: memory intefaces to CPU */
 	{
 		.name = "DL1", /* downlink 1 */
-		.id = MTK_AFE_MEMIF_DL1,
-		.suspend = mtk_afe_dai_suspend,
-		.resume = mtk_afe_dai_resume,
+		.id = MT8173_AFE_MEMIF_DL1,
+		.suspend = mt8173_afe_dai_suspend,
+		.resume = mt8173_afe_dai_resume,
 		.playback = {
 			.stream_name = "DL1",
 			.channels_min = 1,
@@ -824,12 +822,12 @@ static struct snd_soc_dai_driver mtk_afe_pcm_dais[] = {
 			.rates = SNDRV_PCM_RATE_8000_48000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.ops = &mtk_afe_dai_ops,
+		.ops = &mt8173_afe_dai_ops,
 	}, {
 		.name = "VUL", /* voice uplink */
-		.id = MTK_AFE_MEMIF_VUL,
-		.suspend = mtk_afe_dai_suspend,
-		.resume = mtk_afe_dai_resume,
+		.id = MT8173_AFE_MEMIF_VUL,
+		.suspend = mt8173_afe_dai_suspend,
+		.resume = mt8173_afe_dai_resume,
 		.capture = {
 			.stream_name = "VUL",
 			.channels_min = 1,
@@ -837,11 +835,11 @@ static struct snd_soc_dai_driver mtk_afe_pcm_dais[] = {
 			.rates = SNDRV_PCM_RATE_8000_48000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.ops = &mtk_afe_dai_ops,
+		.ops = &mt8173_afe_dai_ops,
 	}, {
 	/* BE DAIs */
 		.name = "I2S",
-		.id = MTK_AFE_IO_I2S,
+		.id = MT8173_AFE_IO_I2S,
 		.playback = {
 			.stream_name = "I2S Playback",
 			.channels_min = 1,
@@ -856,18 +854,18 @@ static struct snd_soc_dai_driver mtk_afe_pcm_dais[] = {
 			.rates = SNDRV_PCM_RATE_8000_48000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.ops = &mtk_afe_i2s_ops,
+		.ops = &mt8173_afe_i2s_ops,
 		.symmetric_rates = 1,
 	},
 };
 
-static struct snd_soc_dai_driver mtk_afe_hdmi_dais[] = {
+static struct snd_soc_dai_driver mt8173_afe_hdmi_dais[] = {
 	/* FE DAIs */
 	{
 		.name = "HDMI",
-		.id = MTK_AFE_MEMIF_HDMI,
-		.suspend = mtk_afe_dai_suspend,
-		.resume = mtk_afe_dai_resume,
+		.id = MT8173_AFE_MEMIF_HDMI,
+		.suspend = mt8173_afe_dai_suspend,
+		.resume = mt8173_afe_dai_resume,
 		.playback = {
 			.stream_name = "HDMI",
 			.channels_min = 2,
@@ -878,11 +876,11 @@ static struct snd_soc_dai_driver mtk_afe_hdmi_dais[] = {
 				SNDRV_PCM_RATE_192000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.ops = &mtk_afe_dai_ops,
+		.ops = &mt8173_afe_dai_ops,
 	}, {
 	/* BE DAIs */
 		.name = "HDMIO",
-		.id = MTK_AFE_IO_HDMI,
+		.id = MT8173_AFE_IO_HDMI,
 		.playback = {
 			.stream_name = "HDMIO Playback",
 			.channels_min = 2,
@@ -893,29 +891,29 @@ static struct snd_soc_dai_driver mtk_afe_hdmi_dais[] = {
 				SNDRV_PCM_RATE_192000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
-		.ops = &mtk_afe_hdmi_ops,
+		.ops = &mt8173_afe_hdmi_ops,
 	},
 };
 
-static const struct snd_kcontrol_new mtk_afe_o03_mix[] = {
+static const struct snd_kcontrol_new mt8173_afe_o03_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I05 Switch", AFE_CONN1, 21, 1, 0),
 };
 
-static const struct snd_kcontrol_new mtk_afe_o04_mix[] = {
+static const struct snd_kcontrol_new mt8173_afe_o04_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I06 Switch", AFE_CONN2, 6, 1, 0),
 };
 
-static const struct snd_kcontrol_new mtk_afe_o09_mix[] = {
+static const struct snd_kcontrol_new mt8173_afe_o09_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I03 Switch", AFE_CONN3, 0, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I17 Switch", AFE_CONN7, 30, 1, 0),
 };
 
-static const struct snd_kcontrol_new mtk_afe_o10_mix[] = {
+static const struct snd_kcontrol_new mt8173_afe_o10_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I04 Switch", AFE_CONN3, 3, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I18 Switch", AFE_CONN8, 0, 1, 0),
 };
 
-static const struct snd_soc_dapm_widget mtk_afe_pcm_widgets[] = {
+static const struct snd_soc_dapm_widget mt8173_afe_pcm_widgets[] = {
 	/* inter-connections */
 	SND_SOC_DAPM_MIXER("I03", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I04", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -925,16 +923,16 @@ static const struct snd_soc_dapm_widget mtk_afe_pcm_widgets[] = {
 	SND_SOC_DAPM_MIXER("I18", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	SND_SOC_DAPM_MIXER("O03", SND_SOC_NOPM, 0, 0,
-			   mtk_afe_o03_mix, ARRAY_SIZE(mtk_afe_o03_mix)),
+			   mt8173_afe_o03_mix, ARRAY_SIZE(mt8173_afe_o03_mix)),
 	SND_SOC_DAPM_MIXER("O04", SND_SOC_NOPM, 0, 0,
-			   mtk_afe_o04_mix, ARRAY_SIZE(mtk_afe_o04_mix)),
+			   mt8173_afe_o04_mix, ARRAY_SIZE(mt8173_afe_o04_mix)),
 	SND_SOC_DAPM_MIXER("O09", SND_SOC_NOPM, 0, 0,
-			   mtk_afe_o09_mix, ARRAY_SIZE(mtk_afe_o09_mix)),
+			   mt8173_afe_o09_mix, ARRAY_SIZE(mt8173_afe_o09_mix)),
 	SND_SOC_DAPM_MIXER("O10", SND_SOC_NOPM, 0, 0,
-			   mtk_afe_o10_mix, ARRAY_SIZE(mtk_afe_o10_mix)),
+			   mt8173_afe_o10_mix, ARRAY_SIZE(mt8173_afe_o10_mix)),
 };
 
-static const struct snd_soc_dapm_route mtk_afe_pcm_routes[] = {
+static const struct snd_soc_dapm_route mt8173_afe_pcm_routes[] = {
 	{"I05", NULL, "DL1"},
 	{"I06", NULL, "DL1"},
 	{"I2S Playback", NULL, "O03"},
@@ -953,41 +951,41 @@ static const struct snd_soc_dapm_route mtk_afe_pcm_routes[] = {
 	{ "O10", "I04 Switch", "I04" },
 };
 
-static const struct snd_soc_dapm_route mtk_afe_hdmi_routes[] = {
+static const struct snd_soc_dapm_route mt8173_afe_hdmi_routes[] = {
 	{"HDMIO Playback", NULL, "HDMI"},
 };
 
-static const struct snd_soc_component_driver mtk_afe_pcm_dai_component = {
-	.name = "mtk-afe-pcm-dai",
-	.dapm_widgets = mtk_afe_pcm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(mtk_afe_pcm_widgets),
-	.dapm_routes = mtk_afe_pcm_routes,
-	.num_dapm_routes = ARRAY_SIZE(mtk_afe_pcm_routes),
+static const struct snd_soc_component_driver mt8173_afe_pcm_dai_component = {
+	.name = "mt8173-afe-pcm-dai",
+	.dapm_widgets = mt8173_afe_pcm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8173_afe_pcm_widgets),
+	.dapm_routes = mt8173_afe_pcm_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8173_afe_pcm_routes),
 };
 
-static const struct snd_soc_component_driver mtk_afe_hdmi_dai_component = {
-	.name = "mtk-afe-hdmi-dai",
-	.dapm_routes = mtk_afe_hdmi_routes,
-	.num_dapm_routes = ARRAY_SIZE(mtk_afe_hdmi_routes),
+static const struct snd_soc_component_driver mt8173_afe_hdmi_dai_component = {
+	.name = "mt8173-afe-hdmi-dai",
+	.dapm_routes = mt8173_afe_hdmi_routes,
+	.num_dapm_routes = ARRAY_SIZE(mt8173_afe_hdmi_routes),
 };
 
-static const char *aud_clks[MTK_CLK_NUM] = {
-	[MTK_CLK_INFRASYS_AUD] = "infra_sys_audio_clk",
-	[MTK_CLK_TOP_PDN_AUD] = "top_pdn_audio",
-	[MTK_CLK_TOP_PDN_AUD_BUS] = "top_pdn_aud_intbus",
-	[MTK_CLK_I2S0_M] =  "i2s0_m",
-	[MTK_CLK_I2S1_M] =  "i2s1_m",
-	[MTK_CLK_I2S2_M] =  "i2s2_m",
-	[MTK_CLK_I2S3_M] =  "i2s3_m",
-	[MTK_CLK_I2S3_B] =  "i2s3_b",
-	[MTK_CLK_BCK0] =  "bck0",
-	[MTK_CLK_BCK1] =  "bck1",
+static const char *aud_clks[MT8173_CLK_NUM] = {
+	[MT8173_CLK_INFRASYS_AUD] = "infra_sys_audio_clk",
+	[MT8173_CLK_TOP_PDN_AUD] = "top_pdn_audio",
+	[MT8173_CLK_TOP_PDN_AUD_BUS] = "top_pdn_aud_intbus",
+	[MT8173_CLK_I2S0_M] =  "i2s0_m",
+	[MT8173_CLK_I2S1_M] =  "i2s1_m",
+	[MT8173_CLK_I2S2_M] =  "i2s2_m",
+	[MT8173_CLK_I2S3_M] =  "i2s3_m",
+	[MT8173_CLK_I2S3_B] =  "i2s3_b",
+	[MT8173_CLK_BCK0] =  "bck0",
+	[MT8173_CLK_BCK1] =  "bck1",
 };
 
-static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
+static const struct mt8173_afe_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 	{
 		.name = "DL1",
-		.id = MTK_AFE_MEMIF_DL1,
+		.id = MT8173_AFE_MEMIF_DL1,
 		.reg_ofs_base = AFE_DL1_BASE,
 		.reg_ofs_cur = AFE_DL1_CUR,
 		.fs_shift = 0,
@@ -1001,7 +999,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.msb_shift = 0,
 	}, {
 		.name = "DL2",
-		.id = MTK_AFE_MEMIF_DL2,
+		.id = MT8173_AFE_MEMIF_DL2,
 		.reg_ofs_base = AFE_DL2_BASE,
 		.reg_ofs_cur = AFE_DL2_CUR,
 		.fs_shift = 4,
@@ -1015,7 +1013,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.msb_shift = 1,
 	}, {
 		.name = "VUL",
-		.id = MTK_AFE_MEMIF_VUL,
+		.id = MT8173_AFE_MEMIF_VUL,
 		.reg_ofs_base = AFE_VUL_BASE,
 		.reg_ofs_cur = AFE_VUL_CUR,
 		.fs_shift = 16,
@@ -1029,7 +1027,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.msb_shift = 6,
 	}, {
 		.name = "DAI",
-		.id = MTK_AFE_MEMIF_DAI,
+		.id = MT8173_AFE_MEMIF_DAI,
 		.reg_ofs_base = AFE_DAI_BASE,
 		.reg_ofs_cur = AFE_DAI_CUR,
 		.fs_shift = 24,
@@ -1043,7 +1041,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.msb_shift = 5,
 	}, {
 		.name = "AWB",
-		.id = MTK_AFE_MEMIF_AWB,
+		.id = MT8173_AFE_MEMIF_AWB,
 		.reg_ofs_base = AFE_AWB_BASE,
 		.reg_ofs_cur = AFE_AWB_CUR,
 		.fs_shift = 12,
@@ -1057,7 +1055,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.msb_shift = 3,
 	}, {
 		.name = "MOD_DAI",
-		.id = MTK_AFE_MEMIF_MOD_DAI,
+		.id = MT8173_AFE_MEMIF_MOD_DAI,
 		.reg_ofs_base = AFE_MOD_PCM_BASE,
 		.reg_ofs_cur = AFE_MOD_PCM_CUR,
 		.fs_shift = 30,
@@ -1071,7 +1069,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 		.msb_shift = 4,
 	}, {
 		.name = "HDMI",
-		.id = MTK_AFE_MEMIF_HDMI,
+		.id = MT8173_AFE_MEMIF_HDMI,
 		.reg_ofs_base = AFE_HDMI_OUT_BASE,
 		.reg_ofs_cur = AFE_HDMI_OUT_CUR,
 		.fs_shift = -1,
@@ -1086,7 +1084,7 @@ static const struct mtk_afe_memif_data memif_data[MTK_AFE_MEMIF_NUM] = {
 	},
 };
 
-static const struct regmap_config mtk_afe_regmap_config = {
+static const struct regmap_config mt8173_afe_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1094,9 +1092,9 @@ static const struct regmap_config mtk_afe_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
-static irqreturn_t mtk_afe_irq_handler(int irq, void *dev_id)
+static irqreturn_t mt8173_afe_irq_handler(int irq, void *dev_id)
 {
-	struct mtk_afe *afe = dev_id;
+	struct mt8173_afe *afe = dev_id;
 	unsigned int reg_value;
 	int i, ret;
 
@@ -1107,8 +1105,8 @@ static irqreturn_t mtk_afe_irq_handler(int irq, void *dev_id)
 		goto err_irq;
 	}
 
-	for (i = 0; i < MTK_AFE_MEMIF_NUM; i++) {
-		struct mtk_afe_memif *memif = &afe->memif[i];
+	for (i = 0; i < MT8173_AFE_MEMIF_NUM; i++) {
+		struct mt8173_afe_memif *memif = &afe->memif[i];
 
 		if (!(reg_value & (1 << memif->data->irq_clr_shift)))
 			continue;
@@ -1123,9 +1121,9 @@ err_irq:
 	return IRQ_HANDLED;
 }
 
-static int mtk_afe_runtime_suspend(struct device *dev)
+static int mt8173_afe_runtime_suspend(struct device *dev)
 {
-	struct mtk_afe *afe = dev_get_drvdata(dev);
+	struct mt8173_afe *afe = dev_get_drvdata(dev);
 
 	/* disable AFE */
 	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0);
@@ -1134,36 +1132,36 @@ static int mtk_afe_runtime_suspend(struct device *dev)
 	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
 			   AUD_TCON0_PDN_AFE, AUD_TCON0_PDN_AFE);
 
-	clk_disable_unprepare(afe->clocks[MTK_CLK_BCK0]);
-	clk_disable_unprepare(afe->clocks[MTK_CLK_BCK1]);
-	clk_disable_unprepare(afe->clocks[MTK_CLK_TOP_PDN_AUD]);
-	clk_disable_unprepare(afe->clocks[MTK_CLK_TOP_PDN_AUD_BUS]);
-	clk_disable_unprepare(afe->clocks[MTK_CLK_INFRASYS_AUD]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_BCK0]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_BCK1]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_TOP_PDN_AUD]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_INFRASYS_AUD]);
 	return 0;
 }
 
-static int mtk_afe_runtime_resume(struct device *dev)
+static int mt8173_afe_runtime_resume(struct device *dev)
 {
-	struct mtk_afe *afe = dev_get_drvdata(dev);
+	struct mt8173_afe *afe = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare_enable(afe->clocks[MTK_CLK_INFRASYS_AUD]);
+	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_INFRASYS_AUD]);
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(afe->clocks[MTK_CLK_TOP_PDN_AUD_BUS]);
+	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
 	if (ret)
 		goto err_infra;
 
-	ret = clk_prepare_enable(afe->clocks[MTK_CLK_TOP_PDN_AUD]);
+	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_TOP_PDN_AUD]);
 	if (ret)
 		goto err_top_aud_bus;
 
-	ret = clk_prepare_enable(afe->clocks[MTK_CLK_BCK0]);
+	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_BCK0]);
 	if (ret)
 		goto err_top_aud;
 
-	ret = clk_prepare_enable(afe->clocks[MTK_CLK_BCK1]);
+	ret = clk_prepare_enable(afe->clocks[MT8173_CLK_BCK1]);
 	if (ret)
 		goto err_bck0;
 
@@ -1182,17 +1180,17 @@ static int mtk_afe_runtime_resume(struct device *dev)
 	return 0;
 
 err_bck0:
-	clk_disable_unprepare(afe->clocks[MTK_CLK_BCK0]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_BCK0]);
 err_top_aud:
-	clk_disable_unprepare(afe->clocks[MTK_CLK_TOP_PDN_AUD]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_TOP_PDN_AUD]);
 err_top_aud_bus:
-	clk_disable_unprepare(afe->clocks[MTK_CLK_TOP_PDN_AUD_BUS]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_TOP_PDN_AUD_BUS]);
 err_infra:
-	clk_disable_unprepare(afe->clocks[MTK_CLK_INFRASYS_AUD]);
+	clk_disable_unprepare(afe->clocks[MT8173_CLK_INFRASYS_AUD]);
 	return ret;
 }
 
-static int mtk_afe_init_audio_clk(struct mtk_afe *afe)
+static int mt8173_afe_init_audio_clk(struct mt8173_afe *afe)
 {
 	size_t i;
 
@@ -1204,16 +1202,16 @@ static int mtk_afe_init_audio_clk(struct mtk_afe *afe)
 			return PTR_ERR(afe->clocks[i]);
 		}
 	}
-	clk_set_rate(afe->clocks[MTK_CLK_BCK0], 22579200); /* 22M */
-	clk_set_rate(afe->clocks[MTK_CLK_BCK1], 24576000); /* 24M */
+	clk_set_rate(afe->clocks[MT8173_CLK_BCK0], 22579200); /* 22M */
+	clk_set_rate(afe->clocks[MT8173_CLK_BCK1], 24576000); /* 24M */
 	return 0;
 }
 
-static int mtk_afe_pcm_dev_probe(struct platform_device *pdev)
+static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	int ret, i;
 	unsigned int irq_id;
-	struct mtk_afe *afe;
+	struct mt8173_afe *afe;
 	struct resource *res;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(33));
@@ -1231,7 +1229,7 @@ static int mtk_afe_pcm_dev_probe(struct platform_device *pdev)
 		dev_err(afe->dev, "np %s no irq\n", afe->dev->of_node->name);
 		return -ENXIO;
 	}
-	ret = devm_request_irq(afe->dev, irq_id, mtk_afe_irq_handler,
+	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
 	if (ret) {
 		dev_err(afe->dev, "could not request_irq\n");
@@ -1244,48 +1242,48 @@ static int mtk_afe_pcm_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(afe->base_addr);
 
 	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
-		&mtk_afe_regmap_config);
+		&mt8173_afe_regmap_config);
 	if (IS_ERR(afe->regmap))
 		return PTR_ERR(afe->regmap);
 
 	/* initial audio related clock */
-	ret = mtk_afe_init_audio_clk(afe);
+	ret = mt8173_afe_init_audio_clk(afe);
 	if (ret) {
-		dev_err(afe->dev, "mtk_afe_init_audio_clk fail\n");
+		dev_err(afe->dev, "mt8173_afe_init_audio_clk fail\n");
 		return ret;
 	}
 
-	for (i = 0; i < MTK_AFE_MEMIF_NUM; i++)
+	for (i = 0; i < MT8173_AFE_MEMIF_NUM; i++)
 		afe->memif[i].data = &memif_data[i];
 
 	platform_set_drvdata(pdev, afe);
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = mtk_afe_runtime_resume(&pdev->dev);
+		ret = mt8173_afe_runtime_resume(&pdev->dev);
 		if (ret)
 			goto err_pm_disable;
 	}
 
-	ret = snd_soc_register_platform(&pdev->dev, &mtk_afe_pcm_platform);
+	ret = snd_soc_register_platform(&pdev->dev, &mt8173_afe_pcm_platform);
 	if (ret)
 		goto err_pm_disable;
 
 	ret = snd_soc_register_component(&pdev->dev,
-					 &mtk_afe_pcm_dai_component,
-					 mtk_afe_pcm_dais,
-					 ARRAY_SIZE(mtk_afe_pcm_dais));
+					 &mt8173_afe_pcm_dai_component,
+					 mt8173_afe_pcm_dais,
+					 ARRAY_SIZE(mt8173_afe_pcm_dais));
 	if (ret)
 		goto err_platform;
 
 	ret = snd_soc_register_component(&pdev->dev,
-					 &mtk_afe_hdmi_dai_component,
-					 mtk_afe_hdmi_dais,
-					 ARRAY_SIZE(mtk_afe_hdmi_dais));
+					 &mt8173_afe_hdmi_dai_component,
+					 mt8173_afe_hdmi_dais,
+					 ARRAY_SIZE(mt8173_afe_hdmi_dais));
 	if (ret)
 		goto err_comp;
 
-	dev_info(&pdev->dev, "MTK AFE driver initialized.\n");
+	dev_info(&pdev->dev, "MT8173 AFE driver initialized.\n");
 	return 0;
 
 err_comp:
@@ -1297,38 +1295,38 @@ err_pm_disable:
 	return ret;
 }
 
-static int mtk_afe_pcm_dev_remove(struct platform_device *pdev)
+static int mt8173_afe_pcm_dev_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
-		mtk_afe_runtime_suspend(&pdev->dev);
+		mt8173_afe_runtime_suspend(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
 }
 
-static const struct of_device_id mtk_afe_pcm_dt_match[] = {
+static const struct of_device_id mt8173_afe_pcm_dt_match[] = {
 	{ .compatible = "mediatek,mt8173-afe-pcm", },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, mtk_afe_pcm_dt_match);
+MODULE_DEVICE_TABLE(of, mt8173_afe_pcm_dt_match);
 
-static const struct dev_pm_ops mtk_afe_pm_ops = {
-	SET_RUNTIME_PM_OPS(mtk_afe_runtime_suspend, mtk_afe_runtime_resume,
-			   NULL)
+static const struct dev_pm_ops mt8173_afe_pm_ops = {
+	SET_RUNTIME_PM_OPS(mt8173_afe_runtime_suspend,
+			   mt8173_afe_runtime_resume, NULL)
 };
 
-static struct platform_driver mtk_afe_pcm_driver = {
+static struct platform_driver mt8173_afe_pcm_driver = {
 	.driver = {
-		   .name = "mtk-afe-pcm",
-		   .of_match_table = mtk_afe_pcm_dt_match,
-		   .pm = &mtk_afe_pm_ops,
+		   .name = "mt8173-afe-pcm",
+		   .of_match_table = mt8173_afe_pcm_dt_match,
+		   .pm = &mt8173_afe_pm_ops,
 	},
-	.probe = mtk_afe_pcm_dev_probe,
-	.remove = mtk_afe_pcm_dev_remove,
+	.probe = mt8173_afe_pcm_dev_probe,
+	.remove = mt8173_afe_pcm_dev_remove,
 };
 
-module_platform_driver(mtk_afe_pcm_driver);
+module_platform_driver(mt8173_afe_pcm_driver);
 
 MODULE_DESCRIPTION("Mediatek ALSA SoC AFE platform driver");
 MODULE_AUTHOR("Koro Chen <koro.chen@mediatek.com>");
diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
similarity index 99%
rename from sound/soc/mediatek/mt8173-max98090.c
rename to sound/soc/mediatek/mt8173/mt8173-max98090.c
index 71a1a35..5524a2c 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -18,7 +18,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include <linux/gpio.h>
-#include "../codecs/max98090.h"
+#include "../../codecs/max98090.h"
 
 static struct snd_soc_jack mt8173_max98090_jack;
 
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
similarity index 99%
rename from sound/soc/mediatek/mt8173-rt5650-rt5514.c
rename to sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 58e0836..467f704 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -19,7 +19,7 @@
 #include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/rt5645.h"
+#include "../../codecs/rt5645.h"
 
 #define MCLK_FOR_CODECS		12288000
 
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
similarity index 99%
rename from sound/soc/mediatek/mt8173-rt5650-rt5676.c
rename to sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index bb59392..1b8b2a7 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -19,8 +19,8 @@
 #include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/rt5645.h"
-#include "../codecs/rt5677.h"
+#include "../../codecs/rt5645.h"
+#include "../../codecs/rt5677.h"
 
 #define MCLK_FOR_CODECS		12288000
 
diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
similarity index 99%
rename from sound/soc/mediatek/mt8173-rt5650.c
rename to sound/soc/mediatek/mt8173/mt8173-rt5650.c
index a27a667..400dabf 100644
--- a/sound/soc/mediatek/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -19,7 +19,7 @@
 #include <linux/of_gpio.h>
 #include <sound/soc.h>
 #include <sound/jack.h>
-#include "../codecs/rt5645.h"
+#include "../../codecs/rt5645.h"
 
 #define MCLK_FOR_CODECS		12288000
 
diff --git a/sound/soc/mediatek/mtk-afe-common.h b/sound/soc/mediatek/mtk-afe-common.h
deleted file mode 100644
index f341f62..0000000
--- a/sound/soc/mediatek/mtk-afe-common.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * mtk_afe_common.h  --  Mediatek audio driver common definitions
- *
- * Copyright (c) 2015 MediaTek Inc.
- * Author: Koro Chen <koro.chen@mediatek.com>
- *             Sascha Hauer <s.hauer@pengutronix.de>
- *             Hidalgo Huang <hidalgo.huang@mediatek.com>
- *             Ir Lian <ir.lian@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _MTK_AFE_COMMON_H_
-#define _MTK_AFE_COMMON_H_
-
-#include <linux/clk.h>
-#include <linux/regmap.h>
-
-enum {
-	MTK_AFE_MEMIF_DL1,
-	MTK_AFE_MEMIF_DL2,
-	MTK_AFE_MEMIF_VUL,
-	MTK_AFE_MEMIF_DAI,
-	MTK_AFE_MEMIF_AWB,
-	MTK_AFE_MEMIF_MOD_DAI,
-	MTK_AFE_MEMIF_HDMI,
-	MTK_AFE_MEMIF_NUM,
-	MTK_AFE_IO_MOD_PCM1 = MTK_AFE_MEMIF_NUM,
-	MTK_AFE_IO_MOD_PCM2,
-	MTK_AFE_IO_PMIC,
-	MTK_AFE_IO_I2S,
-	MTK_AFE_IO_2ND_I2S,
-	MTK_AFE_IO_HW_GAIN1,
-	MTK_AFE_IO_HW_GAIN2,
-	MTK_AFE_IO_MRG_O,
-	MTK_AFE_IO_MRG_I,
-	MTK_AFE_IO_DAIBT,
-	MTK_AFE_IO_HDMI,
-};
-
-enum {
-	MTK_AFE_IRQ_1,
-	MTK_AFE_IRQ_2,
-	MTK_AFE_IRQ_3,
-	MTK_AFE_IRQ_4,
-	MTK_AFE_IRQ_5,
-	MTK_AFE_IRQ_6,
-	MTK_AFE_IRQ_7,
-	MTK_AFE_IRQ_8,
-	MTK_AFE_IRQ_NUM,
-};
-
-enum {
-	MTK_CLK_INFRASYS_AUD,
-	MTK_CLK_TOP_PDN_AUD,
-	MTK_CLK_TOP_PDN_AUD_BUS,
-	MTK_CLK_I2S0_M,
-	MTK_CLK_I2S1_M,
-	MTK_CLK_I2S2_M,
-	MTK_CLK_I2S3_M,
-	MTK_CLK_I2S3_B,
-	MTK_CLK_BCK0,
-	MTK_CLK_BCK1,
-	MTK_CLK_NUM
-};
-
-struct mtk_afe;
-struct snd_pcm_substream;
-
-struct mtk_afe_memif_data {
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
-struct mtk_afe_memif {
-	unsigned int phys_buf_addr;
-	int buffer_size;
-	struct snd_pcm_substream *substream;
-	const struct mtk_afe_memif_data *data;
-	const struct mtk_afe_irq_data *irqdata;
-};
-
-#endif
-- 
1.9.1
