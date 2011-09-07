From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 7 Sep 2011 20:51:50 +0800
Subject: [PATCH v3 1/1] ASoC: mxs-saif: add record function
Message-ID: <1315399910-6525-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. add different clkmux mode handling
SAIF can use two instances to implement full duplex (playback &
recording) and record saif may work on EXTMASTER mode which is
using other saif's BITCLK&LRCLK.

The clkmux mode could be set in pdata->init() in mach-specific code.
For generic saif driver, it only needs to know who is his master
and the master id is also provided in mach-specific code.

2. support playback and capture simutaneously however the sample
rates can not be different due to hw limitation.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>

---
Changes since v2:
 * remove mach-specific code(clkmux in DIGCTL) out of saif driver
 For supporting EXTMASTER mode, SAIF only nees to know who's
 its master and the master id is provided by mach layer according
 to different clkmux setting.
 So we need to add a pdata->get_master_id();

Changes since v1:
 * calc the delay based on the rate
  * change the saif.h #ifndef micro to match the directory
---
 include/sound/saif.h     |   16 +++++
 sound/soc/mxs/mxs-saif.c |  145 +++++++++++++++++++++++++++++++++++++++++-----
 sound/soc/mxs/mxs-saif.h |    4 +
 3 files changed, 151 insertions(+), 14 deletions(-)

diff --git a/include/sound/saif.h b/include/sound/saif.h
new file mode 100644
index 0000000..d0e0de7
--- /dev/null
+++ b/include/sound/saif.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOUND_SAIF_H__
+#define __SOUND_SAIF_H__
+
+struct mxs_saif_platform_data {
+	int (*init) (void);
+	int (*get_master_id) (unsigned int saif_id);
+};
+#endif
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index af5734f..401944c 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -23,10 +23,12 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/time.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/saif.h>
 #include <mach/dma.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
@@ -36,6 +38,24 @@
 
 static struct mxs_saif *mxs_saif[2];
 
+/*
+ * SAIF is a little different with other normal SOC DAIs on clock using.
+ *
+ * For MXS, two SAIF modules are instantiated on-chip.
+ * Each SAIF has a set of clock pins and can be operating in master
+ * mode simultaneously if they are connected to different off-chip codecs.
+ * Also, one of the two SAIFs can master or drive the clock pins while the
+ * other SAIF, in slave mode, receives clocking from the master SAIF.
+ * This also means that both SAIFs must operate at the same sample rate.
+ *
+ * We abstract this as each saif has a master, the master could be
+ * himself or other saifs. In the generic saif driver, saif does not need
+ * to know the different clkmux. Saif only needs to know who is his master
+ * and operating his master to generate the proper clock rate for him.
+ * The master id is provided in mach-specific layer according to different
+ * clkmux setting.
+ */
+
 static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			int clk_id, unsigned int freq, int dir)
 {
@@ -52,6 +72,17 @@ static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 }
 
 /*
+ * Since SAIF may work on EXTMASTER mode, IOW, it's working BITCLK&LRCLK
+ * is provided by other SAIF, we provide a interface here to get its master
+ * from its master_id.
+ * Note that the master could be himself.
+ */
+static inline struct mxs_saif *mxs_saif_get_master(struct mxs_saif * saif)
+{
+	return mxs_saif[saif->master_id];
+}
+
+/*
  * Set SAIF clock and MCLK
  */
 static int mxs_saif_set_clk(struct mxs_saif *saif,
@@ -60,8 +91,26 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
 {
 	u32 scr;
 	int ret;
+	struct mxs_saif *master_saif;
 
-	scr = __raw_readl(saif->base + SAIF_CTRL);
+	dev_dbg(saif->dev, "mclk %d rate %d\n", mclk, rate);
+
+	/* Set master saif to generate proper clock */
+	master_saif = mxs_saif_get_master(saif);
+	if (!master_saif)
+		return -EINVAL;
+
+	dev_dbg(saif->dev, "master saif%d\n", master_saif->id);
+
+	/* Checking if can playback and capture simutaneously */
+	if (master_saif->ongoing && rate != master_saif->cur_rate) {
+		dev_err(saif->dev,
+			"can not change clock, master saif%d(rate %d) is ongoing\n",
+			master_saif->id, master_saif->cur_rate);
+		return -EINVAL;
+	}
+
+	scr = __raw_readl(master_saif->base + SAIF_CTRL);
 	scr &= ~BM_SAIF_CTRL_BITCLK_MULT_RATE;
 	scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
 
@@ -75,27 +124,29 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
 	 *
 	 * If MCLK is not used, we just set saif clk to 512*fs.
 	 */
-	if (saif->mclk_in_use) {
+	if (master_saif->mclk_in_use) {
 		if (mclk % 32 == 0) {
 			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
-			ret = clk_set_rate(saif->clk, 512 * rate);
+			ret = clk_set_rate(master_saif->clk, 512 * rate);
 		} else if (mclk % 48 == 0) {
 			scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
-			ret = clk_set_rate(saif->clk, 384 * rate);
+			ret = clk_set_rate(master_saif->clk, 384 * rate);
 		} else {
 			/* SAIF MCLK should be either 32x or 48x */
 			return -EINVAL;
 		}
 	} else {
-		ret = clk_set_rate(saif->clk, 512 * rate);
+		ret = clk_set_rate(master_saif->clk, 512 * rate);
 		scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
 	}
 
 	if (ret)
 		return ret;
 
-	if (!saif->mclk_in_use) {
-		__raw_writel(scr, saif->base + SAIF_CTRL);
+	master_saif->cur_rate = rate;
+
+	if (!master_saif->mclk_in_use) {
+		__raw_writel(scr, master_saif->base + SAIF_CTRL);
 		return 0;
 	}
 
@@ -137,7 +188,7 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
 		return -EINVAL;
 	}
 
-	__raw_writel(scr, saif->base + SAIF_CTRL);
+	__raw_writel(scr, master_saif->base + SAIF_CTRL);
 
 	return 0;
 }
@@ -183,6 +234,7 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
 	struct mxs_saif *saif = mxs_saif[saif_id];
 	u32 stat;
 	int ret;
+	struct mxs_saif *master_saif;
 
 	if (!saif)
 		return -EINVAL;
@@ -195,6 +247,12 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
 	__raw_writel(BM_SAIF_CTRL_CLKGATE,
 		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
 
+	master_saif = mxs_saif_get_master(saif);
+	if (saif != master_saif) {
+		dev_err(saif->dev, "can not get mclk from a non-master saif\n");
+		return -EINVAL;
+	}
+
 	stat = __raw_readl(saif->base + SAIF_STAT);
 	if (stat & BM_SAIF_STAT_BUSY) {
 		dev_err(saif->dev, "error: busy\n");
@@ -278,10 +336,17 @@ static int mxs_saif_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	/*
 	 * Note: We simply just support master mode since SAIF TX can only
 	 * work as master.
+	 * Here the master is relative to codec side.
+	 * Saif internally could be slave when working on EXTMASTER mode.
+	 * We just hide this to machine driver.
 	 */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
-		scr &= ~BM_SAIF_CTRL_SLAVE_MODE;
+		if (saif->id == saif->master_id)
+			scr &= ~BM_SAIF_CTRL_SLAVE_MODE;
+		else
+			scr |= BM_SAIF_CTRL_SLAVE_MODE;
+
 		__raw_writel(scr | scr0, saif->base + SAIF_CTRL);
 		break;
 	default:
@@ -396,6 +461,12 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *cpu_dai)
 {
 	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
+	struct mxs_saif *master_saif;
+	u32 delay;
+
+	master_saif = mxs_saif_get_master(saif);
+	if (!master_saif)
+		return -EINVAL;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -403,10 +474,20 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		dev_dbg(cpu_dai->dev, "start\n");
 
-		clk_enable(saif->clk);
-		if (!saif->mclk_in_use)
+		clk_enable(master_saif->clk);
+		if (!master_saif->mclk_in_use)
+			__raw_writel(BM_SAIF_CTRL_RUN,
+				master_saif->base + SAIF_CTRL + MXS_SET_ADDR);
+
+		/*
+		 * If the saif's master is not himself, we also need to enable
+		 * itself clk for its internal basic logic to work.
+		 */
+		if (saif != master_saif) {
+			clk_enable(saif->clk);
 			__raw_writel(BM_SAIF_CTRL_RUN,
 				saif->base + SAIF_CTRL + MXS_SET_ADDR);
+		}
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			/*
@@ -422,20 +503,39 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 			__raw_readl(saif->base + SAIF_DATA);
 		}
 
-		dev_dbg(cpu_dai->dev, "CTRL 0x%x STAT 0x%x\n",
+		master_saif->ongoing = 1;
+
+		dev_dbg(saif->dev, "CTRL 0x%x STAT 0x%x\n",
 			__raw_readl(saif->base + SAIF_CTRL),
 			__raw_readl(saif->base + SAIF_STAT));
 
+		dev_dbg(master_saif->dev, "CTRL 0x%x STAT 0x%x\n",
+			__raw_readl(master_saif->base + SAIF_CTRL),
+			__raw_readl(master_saif->base + SAIF_STAT));
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		dev_dbg(cpu_dai->dev, "stop\n");
 
-		clk_disable(saif->clk);
-		if (!saif->mclk_in_use)
+		/* wait a while for the current sample to complete */
+		delay = USEC_PER_SEC / master_saif->cur_rate;
+
+		if (!master_saif->mclk_in_use) {
+			__raw_writel(BM_SAIF_CTRL_RUN,
+				master_saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+			udelay(delay);
+		}
+		clk_disable(master_saif->clk);
+
+		if (saif != master_saif) {
 			__raw_writel(BM_SAIF_CTRL_RUN,
 				saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+			udelay(delay);
+			clk_disable(saif->clk);
+		}
+
+		master_saif->ongoing = 0;
 
 		break;
 	default:
@@ -519,16 +619,33 @@ static int mxs_saif_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct mxs_saif *saif;
+	struct mxs_saif_platform_data *pdata;
 	int ret = 0;
 
 	if (pdev->id >= ARRAY_SIZE(mxs_saif))
 		return -EINVAL;
 
+	pdata = pdev->dev.platform_data;
+	if (pdata && pdata->init) {
+		ret = pdata->init();
+		if (ret)
+			return ret;
+	}
+
 	saif = kzalloc(sizeof(*saif), GFP_KERNEL);
 	if (!saif)
 		return -ENOMEM;
 
 	mxs_saif[pdev->id] = saif;
+	saif->id = pdev->id;
+
+	saif->master_id = saif->id;
+	if (pdata && pdata->get_master_id) {
+		saif->master_id = pdata->get_master_id(saif->id);
+		if (saif->master_id < 0 ||
+			saif->master_id >= ARRAY_SIZE(mxs_saif))
+			return -EINVAL;
+	}
 
 	saif->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(saif->clk)) {
diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
index 0e2ff8c..12c91e4 100644
--- a/sound/soc/mxs/mxs-saif.h
+++ b/sound/soc/mxs/mxs-saif.h
@@ -118,6 +118,10 @@ struct mxs_saif {
 	void __iomem *base;
 	int irq;
 	struct mxs_pcm_dma_params dma_param;
+	unsigned int id;
+	unsigned int master_id;
+	unsigned int cur_rate;
+	unsigned int ongoing;
 
 	struct platform_device *soc_platform_pdev;
 	u32 fifo_underrun;
-- 
1.7.0.4
