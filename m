From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 22 Aug 2011 00:02:25 +0800
Subject: [PATCH 1/2] ASoC: mxs-saif: add record function
Message-ID: <1313942545-21403-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. add different clkmux mode handling for record.
SAIF can use two instances to implement full duplex (playback &
recording) and record saif may work on EXTMASTER mode that is
using other saif's BITCLK&LRCLK.
The clkmux mode is determined by saif's platform data and machine
specific clkmux setting is done in pdata->init().
2. support playback and capture simutaneously however the sample
rates can not be different due to hw limitation.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 include/sound/saif.h     |   16 +++++
 sound/soc/mxs/mxs-saif.c |  162 ++++++++++++++++++++++++++++++++++++++++++----
 sound/soc/mxs/mxs-saif.h |    4 +
 3 files changed, 168 insertions(+), 14 deletions(-)

diff --git a/include/sound/saif.h b/include/sound/saif.h
new file mode 100644
index 0000000..7a98d9b
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
+#ifndef __MACH_MXS_SAIF_H__
+#define __MACH_MXS_SAIF_H__
+
+struct mxs_saif_platform_data {
+	unsigned int clkmux;
+	int (*init) (void);
+};
+#endif
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 530017f..eb8ba79 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -27,15 +27,39 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/saif.h>
 #include <mach/dma.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/mxs.h>
+#include <mach/digctl.h>
 
 #include "mxs-saif.h"
 
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
+ * Following are the valid configurations for SAIF1 and SAIF2 on the i.MX28
+ *
+ * HW_SAIF_CLKMUX_SEL:
+ *  DIRECT(0x0): SAIF0 clock pins selected for SAIF0 input clocks, and SAIF1
+ *		clock pins selected for SAIF1 input clocks.
+ *  CROSSINPUT(0x1): SAIF1 clock inputs selected for SAIF0 input clocks, and
+ *		SAIF0 clock inputs selected for SAIF1 input clocks.
+ *  EXTMSTR0(0x2): SAIF0 clock pin selected for both SAIF0 and SAIF1 input
+ *		clocks.
+ *  EXTMSTR1(0x3): SAIF1 clock pin selected for both SAIF0 and SAIF1 input
+ *		clocks.
+ */
+
 static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			int clk_id, unsigned int freq, int dir)
 {
@@ -52,6 +76,36 @@ static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 }
 
 /*
+ * Since SAIF may work on EXTMASTER mode, IOW, it's working BITCLK&LRCLK
+ * is provided by other SAIF, we provide a interface here to get its master.
+ * Note that for DIRECT mode, it's master is itself.
+ */
+static struct mxs_saif *mxs_saif_get_master(struct mxs_saif * saif)
+{
+	struct mxs_saif *master_saif;
+
+	/* get master saif according to different clkmux setting */
+	switch (saif->clkmux) {
+	case MXS_DIGCTL_SAIF_CLKMUX_DIRECT:
+		master_saif = saif;
+		break;
+	case MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT:
+		master_saif = saif->id ? mxs_saif[1] : mxs_saif[0];
+		break;
+	case MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0:
+		master_saif = mxs_saif[0];
+		break;
+	case MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1:
+		master_saif = mxs_saif[1];
+		break;
+	default:
+		return NULL;
+	}
+
+	return master_saif;
+}
+
+/*
  * Set SAIF clock and MCLK
  */
 static int mxs_saif_set_clk(struct mxs_saif *saif,
@@ -60,8 +114,27 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
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
+	dev_dbg(saif->dev, "master saif%d clkmux 0x%x\n",
+		master_saif->id, saif->clkmux);
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
 
@@ -75,27 +148,29 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
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
 
@@ -137,7 +212,7 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
 		return -EINVAL;
 	}
 
-	__raw_writel(scr, saif->base + SAIF_CTRL);
+	__raw_writel(scr, master_saif->base + SAIF_CTRL);
 
 	return 0;
 }
@@ -183,6 +258,7 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
 	struct mxs_saif *saif = mxs_saif[saif_id];
 	u32 stat;
 	int ret;
+	struct mxs_saif *master_saif;
 
 	if (!saif)
 		return -EINVAL;
@@ -195,6 +271,12 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
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
@@ -278,10 +360,21 @@ static int mxs_saif_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
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
+		if (saif->clkmux == MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0)
+			scr = saif->id ? scr | BM_SAIF_CTRL_SLAVE_MODE :
+					scr & ~BM_SAIF_CTRL_SLAVE_MODE;
+		else if (saif->clkmux == MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR1)
+			scr = saif->id ? scr & ~BM_SAIF_CTRL_SLAVE_MODE :
+					scr | BM_SAIF_CTRL_SLAVE_MODE;
+		else
+			scr &= ~BM_SAIF_CTRL_SLAVE_MODE;
+
 		__raw_writel(scr | scr0, saif->base + SAIF_CTRL);
 		break;
 	default:
@@ -396,6 +489,11 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 				struct snd_soc_dai *cpu_dai)
 {
 	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
+	struct mxs_saif *master_saif;
+
+	master_saif = mxs_saif_get_master(saif);
+	if (!master_saif)
+		return -EINVAL;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -403,10 +501,20 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -422,20 +530,37 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
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
+		if (!master_saif->mclk_in_use) {
+			__raw_writel(BM_SAIF_CTRL_RUN,
+				master_saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+			udelay(100);
+		}
+		clk_disable(master_saif->clk);
+
+		if (saif != master_saif) {
 			__raw_writel(BM_SAIF_CTRL_RUN,
 				saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+			/* wait a while for the current sample to complete */
+			udelay(100);
+			clk_disable(saif->clk);
+		}
+
+		master_saif->ongoing = 0;
 
 		break;
 	default:
@@ -519,15 +644,24 @@ static int mxs_saif_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct mxs_saif *saif;
+	struct mxs_saif_platform_data *pdata;
 	int ret = 0;
 
+	pdata = pdev->dev.platform_data;
+	if (pdata && pdata->init())
+		return -EINVAL;
+
 	saif = kzalloc(sizeof(*saif), GFP_KERNEL);
 	if (!saif)
 		return -ENOMEM;
 
+	if (pdata)
+		saif->clkmux  = pdata->clkmux;
+
 	if (pdev->id >= ARRAY_SIZE(mxs_saif))
 		return -EINVAL;
 	mxs_saif[pdev->id] = saif;
+	saif->id = pdev->id;
 
 	saif->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(saif->clk)) {
diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
index 0e2ff8c..2a6aec1 100644
--- a/sound/soc/mxs/mxs-saif.h
+++ b/sound/soc/mxs/mxs-saif.h
@@ -118,6 +118,10 @@ struct mxs_saif {
 	void __iomem *base;
 	int irq;
 	struct mxs_pcm_dma_params dma_param;
+	unsigned int id;
+	unsigned int clkmux;
+	unsigned int cur_rate;
+	unsigned int ongoing;
 
 	struct platform_device *soc_platform_pdev;
 	u32 fifo_underrun;
-- 
1.7.0.4
