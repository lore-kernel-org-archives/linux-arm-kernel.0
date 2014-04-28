From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 12:54:54 +0200
Subject: [PATCH v4 13/17] ASoC: fsl-ssi: remove unnecessary spinlock
In-Reply-To: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1398682498-24357-14-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The baudclock_locked variable is only used in functions which
are serialized anyway from the core. No need to have a lock
around the variable, so remove it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 8ed724c..5c6dc0a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -163,7 +163,6 @@ struct fsl_ssi_private {
 	bool baudclk_locked;
 	bool use_dual_fifo;
 	u8 i2s_mode;
-	spinlock_t baudclk_lock;
 	struct clk *baudclk;
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
@@ -488,13 +487,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	unsigned long flags;
 
-	if (!dai->active && !fsl_ssi_is_ac97(ssi_private)) {
-		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
+	if (!dai->active && !fsl_ssi_is_ac97(ssi_private))
 		ssi_private->baudclk_locked = false;
-		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
-	}
 
 	/* When using dual fifo mode, it is safer to ensure an even period
 	 * size. If appearing to an odd number while DMA always starts its
@@ -524,7 +519,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
-	unsigned long flags, clkrate, baudrate, tmprate;
+	unsigned long clkrate, baudrate, tmprate;
 	u64 sub, savesub = 100000;
 
 	/* Don't apply it to any non-baudclk circumstance */
@@ -588,18 +583,14 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	else
 		write_ssi_mask(&ssi->srccr, mask, stccr);
 
-	spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
 	if (!ssi_private->baudclk_locked) {
 		ret = clk_set_rate(ssi_private->baudclk, baudrate);
 		if (ret) {
-			spin_unlock_irqrestore(&ssi_private->baudclk_lock,
-					flags);
 			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
 			return -EINVAL;
 		}
 		ssi_private->baudclk_locked = true;
 	}
-	spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
 
 	return 0;
 }
@@ -876,7 +867,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-	unsigned long flags;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -895,11 +885,9 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			fsl_ssi_rx_config(ssi_private, false);
 
 		if (!fsl_ssi_is_ac97(ssi_private) && (read_ssi(&ssi->scr) &
-					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0) {
-			spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
+					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
 			ssi_private->baudclk_locked = false;
-			spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
-		}
+
 		break;
 
 	default:
@@ -1231,7 +1219,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ssi_private->fifo_depth = 8;
 
 	ssi_private->baudclk_locked = false;
-	spin_lock_init(&ssi_private->baudclk_lock);
 
 	dev_set_drvdata(&pdev->dev, ssi_private);
 
-- 
1.9.1
