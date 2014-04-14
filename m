From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Apr 2014 15:35:39 +0200
Subject: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable baudclk when used
In-Reply-To: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Enable baudclk only when it is used. The baudclock is only needed in master
mode and only when thr driver is active, so move enabling to fsl_ssi_startup
and disabling to fsl_ssi_shutdown.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f2255cb..d6d3f0a3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -236,6 +236,12 @@ static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
 	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
 }
 
+static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
+{
+	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
+		SND_SOC_DAIFMT_CBS_CFS;
+}
+
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -489,6 +495,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	unsigned long flags;
+	int ret;
 
 	if (!dai->active && !fsl_ssi_is_ac97(ssi_private)) {
 		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
@@ -496,6 +503,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
 	}
 
+	if (fsl_ssi_is_i2s_master(ssi_private)) {
+		ret = clk_prepare_enable(ssi_private->baudclk);
+		if (ret)
+			return ret;
+	}
+
 	/* When using dual fifo mode, it is safer to ensure an even period
 	 * size. If appearing to an odd number while DMA always starts its
 	 * task from fifo0, fifo1 would be neglected at the end of each
@@ -508,6 +521,17 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private =
+		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	if (fsl_ssi_is_i2s_master(ssi_private))
+		clk_disable_unprepare(ssi_private->baudclk);
+}
+
 /**
  * fsl_ssi_hw_params - program the sample size
  *
@@ -576,6 +600,11 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	ssi_private->dai_fmt = fmt;
 
+	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
+		dev_err(cpu_dai->dev, "no baudclk needed for master mode\n");
+		return -EINVAL;
+	}
+
 	fsl_ssi_setup_reg_vals(ssi_private);
 
 	scr = read_ssi(&ssi->scr) & ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
@@ -910,6 +939,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
+	.shutdown	= fsl_ssi_shutdown,
 	.hw_params	= fsl_ssi_hw_params,
 	.set_fmt	= fsl_ssi_set_dai_fmt,
 	.set_sysclk	= fsl_ssi_set_dai_sysclk,
@@ -1050,8 +1080,6 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	if (IS_ERR(ssi_private->baudclk))
 		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
 			 PTR_ERR(ssi_private->baudclk));
-	else
-		clk_prepare_enable(ssi_private->baudclk);
 
 	/*
 	 * We have burstsize be "fifo_depth - 2" to match the SSI
@@ -1102,9 +1130,6 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	return 0;
 
 error_pcm:
-	if (!IS_ERR(ssi_private->baudclk))
-		clk_disable_unprepare(ssi_private->baudclk);
-
 	clk_disable_unprepare(ssi_private->clk);
 
 	return ret;
@@ -1115,8 +1140,6 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev,
 {
 	if (!ssi_private->use_dma)
 		imx_pcm_fiq_exit(pdev);
-	if (!IS_ERR(ssi_private->baudclk))
-		clk_disable_unprepare(ssi_private->baudclk);
 	clk_disable_unprepare(ssi_private->clk);
 }
 
-- 
1.9.1
