From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 12:54:56 +0200
Subject: [PATCH v4 15/17] ASoC: fsl-ssi: Fix baudclock handling
In-Reply-To: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1398682498-24357-16-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The baudclock may be used and set by different streams.

Allow only the first stream to set the bitclock rate. Other streams have
to try to get to the correct rate without modifying the bitclock rate
using the SSI internal clock modifiers.

The variable baudclk_streams is introduced to keep track of the active
streams that are using the baudclock. This way we know if the baudclock
may be set and whether we may enable/disable the clock.

baudclock enable/disable is moved to hw_params()/hw_free(). This way we can
keep track of the baudclock in those two functions and avoid a running
clock while it is not used. As hw_params()/hw_free() may be called
multiple times for the same stream, we have to use baudclk_streams
variable to know whether we may enable/disable the clock.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 68 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 01d97e2..755e3ef 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -160,11 +160,11 @@ struct fsl_ssi_private {
 	unsigned int dai_fmt;
 
 	bool use_dma;
-	bool baudclk_locked;
 	bool use_dual_fifo;
 	u8 i2s_mode;
 	struct clk *baudclk;
 	struct clk *clk;
+	unsigned int baudclk_streams;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct imx_pcm_fiq_params fiq_params;
@@ -235,6 +235,12 @@ static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
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
@@ -488,9 +494,6 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
-	if (!dai->active && !fsl_ssi_is_ac97(ssi_private))
-		ssi_private->baudclk_locked = false;
-
 	/* When using dual fifo mode, it is safer to ensure an even period
 	 * size. If appearing to an odd number while DMA always starts its
 	 * task from fifo0, fifo1 would be neglected at the end of each
@@ -521,11 +524,14 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
 	unsigned long clkrate, baudrate, tmprate;
 	u64 sub, savesub = 100000;
+	bool baudclk_is_used;
 
 	/* Don't apply it to any non-baudclk circumstance */
 	if (IS_ERR(ssi_private->baudclk))
 		return -EINVAL;
 
+	baudclk_is_used = ssi_private->baudclk_streams & ~(BIT(substream->stream));
+
 	/* It should be already enough to divide clock by setting pm alone */
 	psr = 0;
 	div2 = 0;
@@ -538,7 +544,11 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 			continue;
 
 		tmprate = freq * factor * (i + 2);
-		clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
+
+		if (baudclk_is_used)
+			clkrate = clk_get_rate(ssi_private->baudclk);
+		else
+			clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
 
 		do_div(clkrate, factor);
 		afreq = (u32)clkrate / (i + 1);
@@ -583,13 +593,12 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	else
 		write_ssi_mask(&ssi->srccr, mask, stccr);
 
-	if (!ssi_private->baudclk_locked) {
+	if (!baudclk_is_used) {
 		ret = clk_set_rate(ssi_private->baudclk, baudrate);
 		if (ret) {
 			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
 			return -EINVAL;
 		}
-		ssi_private->baudclk_locked = true;
 	}
 
 	return 0;
@@ -633,6 +642,15 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 				params_rate(hw_params));
 		if (ret)
 			return ret;
+
+		/* Do not enable the clock if it is already enabled */
+		if (!(ssi_private->baudclk_streams & BIT(substream->stream))) {
+			ret = clk_prepare_enable(ssi_private->baudclk);
+			if (ret)
+				return ret;
+
+			ssi_private->baudclk_streams |= BIT(substream->stream);
+		}
 	}
 
 	/*
@@ -660,6 +678,22 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *cpu_dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private =
+		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	if (fsl_ssi_is_i2s_master(ssi_private) &&
+			ssi_private->baudclk_streams & BIT(substream->stream)) {
+		clk_disable_unprepare(ssi_private->baudclk);
+		ssi_private->baudclk_streams &= ~BIT(substream->stream);
+	}
+
+	return 0;
+}
+
 static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 		unsigned int fmt)
 {
@@ -669,6 +703,11 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 
 	ssi_private->dai_fmt = fmt;
 
+	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
+		dev_err(&ssi_private->pdev->dev, "no baudclk needed for master mode\n");
+		return -EINVAL;
+	}
+
 	fsl_ssi_setup_reg_vals(ssi_private);
 
 	scr = read_ssi(&ssi->scr) & ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
@@ -887,11 +926,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			fsl_ssi_tx_config(ssi_private, false);
 		else
 			fsl_ssi_rx_config(ssi_private, false);
-
-		if (!fsl_ssi_is_ac97(ssi_private) && (read_ssi(&ssi->scr) &
-					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
-			ssi_private->baudclk_locked = false;
-
 		break;
 
 	default:
@@ -923,6 +957,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.startup	= fsl_ssi_startup,
 	.hw_params	= fsl_ssi_hw_params,
+	.hw_free	= fsl_ssi_hw_free,
 	.set_fmt	= fsl_ssi_set_dai_fmt,
 	.set_tdm_slot	= fsl_ssi_set_dai_tdm_slot,
 	.trigger	= fsl_ssi_trigger,
@@ -1061,8 +1096,6 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	if (IS_ERR(ssi_private->baudclk))
 		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
 			 PTR_ERR(ssi_private->baudclk));
-	else
-		clk_prepare_enable(ssi_private->baudclk);
 
 	/*
 	 * We have burstsize be "fifo_depth - 2" to match the SSI
@@ -1113,9 +1146,6 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	return 0;
 
 error_pcm:
-	if (!IS_ERR(ssi_private->baudclk))
-		clk_disable_unprepare(ssi_private->baudclk);
-
 	clk_disable_unprepare(ssi_private->clk);
 
 	return ret;
@@ -1126,8 +1156,6 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev,
 {
 	if (!ssi_private->use_dma)
 		imx_pcm_fiq_exit(pdev);
-	if (!IS_ERR(ssi_private->baudclk))
-		clk_disable_unprepare(ssi_private->baudclk);
 	clk_disable_unprepare(ssi_private->clk);
 }
 
@@ -1222,8 +1250,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
-	ssi_private->baudclk_locked = false;
-
 	dev_set_drvdata(&pdev->dev, ssi_private);
 
 	if (ssi_private->soc->imx) {
-- 
1.9.1
