From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 23 Feb 2012 22:48:39 +0800
Subject: [PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330008519-3584-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change PowerPC dependent IO accessors to architecture independent
ones, so that fsl_ssi driver can be built on both PowerPC and ARM/IMX.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c |   75 ++++++++++++++++++++++++++++------------------
 1 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3e06696..32fc84b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -11,11 +11,14 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
 #include <sound/core.h>
@@ -145,7 +148,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	   were interrupted for.  We mask it with the Interrupt Enable register
 	   so that we only check for events that we're interested in.
 	 */
-	sisr = in_be32(&ssi->sisr) & SIER_FLAGS;
+	sisr = readl(&ssi->sisr) & SIER_FLAGS;
 
 	if (sisr & CCSR_SSI_SISR_RFRC) {
 		ssi_private->stats.rfrc++;
@@ -260,7 +263,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 
 	/* Clear the bits that we set */
 	if (sisr2)
-		out_be32(&ssi->sisr, sisr2);
+		writel(sisr2, &ssi->sisr);
 
 	return ret;
 }
@@ -280,6 +283,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
+	u32 val;
 
 	/*
 	 * If this is the first stream opened, then request the IRQ
@@ -295,7 +299,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 * SSI needs to be disabled before updating the registers we set
 		 * here.
 		 */
-		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+		val = readl(&ssi->scr);
+		val &= ~CCSR_SSI_SCR_SSIEN;
+		writel(val, &ssi->scr);
 
 		/*
 		 * Program the SSI into I2S Slave Non-Network Synchronous mode.
@@ -303,20 +309,19 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 *
 		 * FIXME: Little-endian samples require a different shift dir
 		 */
-		clrsetbits_be32(&ssi->scr,
-			CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
-			CCSR_SSI_SCR_TFR_CLK_DIS | CCSR_SSI_SCR_I2S_MODE_SLAVE
-			| (synchronous ? CCSR_SSI_SCR_SYN : 0));
+		val = readl(&ssi->scr);
+		val &= ~(CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN);
+		val |= CCSR_SSI_SCR_TFR_CLK_DIS | CCSR_SSI_SCR_I2S_MODE_SLAVE |
+		       (synchronous ? CCSR_SSI_SCR_SYN : 0);
+		writel(val, &ssi->scr);
 
-		out_be32(&ssi->stcr,
-			 CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
+		writel(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
 			 CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
-			 CCSR_SSI_STCR_TSCKP);
+			 CCSR_SSI_STCR_TSCKP, &ssi->stcr);
 
-		out_be32(&ssi->srcr,
-			 CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
+		writel(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
 			 CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
-			 CCSR_SSI_SRCR_RSCKP);
+			 CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
 
 		/*
 		 * The DC and PM bits are only used if the SSI is the clock
@@ -324,7 +329,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 */
 
 		/* Enable the interrupts and DMA requests */
-		out_be32(&ssi->sier, SIER_FLAGS);
+		writel(SIER_FLAGS, &ssi->sier);
 
 		/*
 		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
@@ -339,9 +344,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 * make this value larger (and maybe we should), but this way
 		 * data will be written to memory as soon as it's available.
 		 */
-		out_be32(&ssi->sfcsr,
-			CCSR_SSI_SFCSR_TFWM0(ssi_private->fifo_depth - 2) |
-			CCSR_SSI_SFCSR_RFWM0(ssi_private->fifo_depth - 2));
+		writel(CCSR_SSI_SFCSR_TFWM0(ssi_private->fifo_depth - 2) |
+			CCSR_SSI_SFCSR_RFWM0(ssi_private->fifo_depth - 2),
+			&ssi->sfcsr);
 
 		/*
 		 * We keep the SSI disabled because if we enable it, then the
@@ -417,7 +422,8 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	unsigned int sample_size =
 		snd_pcm_format_width(params_format(hw_params));
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
-	int enabled = in_be32(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
+	int enabled = readl(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
+	u32 val;
 
 	/*
 	 * If we're in synchronous mode, and the SSI is already enabled,
@@ -438,10 +444,17 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
 	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
-	    ssi_private->cpu_dai_drv.symmetric_rates)
-		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
-	else
-		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+	    ssi_private->cpu_dai_drv.symmetric_rates) {
+		val = readl(&ssi->stccr);
+		val &= CCSR_SSI_SxCCR_WL_MASK;
+		val |= wl;
+		writel(val, &ssi->stccr);
+	} else {
+		val = readl(&ssi->srccr);
+		val &= CCSR_SSI_SxCCR_WL_MASK;
+		val |= wl;
+		writel(val, &ssi->srccr);
+	}
 
 	return 0;
 }
@@ -461,29 +474,30 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	u32 val;
 
+	val = readl(&ssi->scr);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			setbits32(&ssi->scr,
-				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
+			val |= CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
 		else
-			setbits32(&ssi->scr,
-				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
+			val |= CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			clrbits32(&ssi->scr, CCSR_SSI_SCR_TE);
+			val &= ~CCSR_SSI_SCR_TE;
 		else
-			clrbits32(&ssi->scr, CCSR_SSI_SCR_RE);
+			val &= ~CCSR_SSI_SCR_RE;
 		break;
 
 	default:
 		return -EINVAL;
 	}
+	writel(val, &ssi->scr);
 
 	return 0;
 }
@@ -498,6 +512,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	u32 val;
 
 	if (ssi_private->first_stream == substream)
 		ssi_private->first_stream = ssi_private->second_stream;
@@ -510,7 +525,9 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	if (!ssi_private->first_stream) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
-		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+		val = readl(&ssi->scr);
+		val &= ~CCSR_SSI_SCR_SSIEN;
+		writel(val, &ssi->scr);
 	}
 }
 
-- 
1.7.5.4
