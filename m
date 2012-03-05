From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Mar 2012 22:31:01 +0800
Subject: [PATCH v2 13/17] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330957865-19085-14-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide different pair of accessors for accessing SSI registers on
PowerPC and ARM/IMX, so that fsl_ssi driver can be built on both
architectures.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c |   60 +++++++++++++++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2eb407f..d31d1ba 100644
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
@@ -26,6 +29,21 @@
 
 #include "fsl_ssi.h"
 
+#ifdef PPC
+#define read_ssi(addr)			 in_be32(addr)
+#define write_ssi(val, addr)		 out_be32(addr, val)
+#define write_ssi_mask(addr, clear, set) clrsetbits_be32(addr, clear, set)
+#elif defined ARM
+#define read_ssi(addr)			 readl(addr)
+#define write_ssi(val, addr)		 writel(val, addr)
+static inline void write_ssi_mask(void __iomem *addr, u32 clear, u32 set)
+{
+	u32 val = readl(addr);
+	val = (val & ~clear) | set;
+	writel(val, addr);
+}
+#endif
+
 /**
  * FSLSSI_I2S_RATES: sample rates supported by the I2S
  *
@@ -145,7 +163,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	   were interrupted for.  We mask it with the Interrupt Enable register
 	   so that we only check for events that we're interested in.
 	 */
-	sisr = in_be32(&ssi->sisr) & SIER_FLAGS;
+	sisr = read_ssi(&ssi->sisr) & SIER_FLAGS;
 
 	if (sisr & CCSR_SSI_SISR_RFRC) {
 		ssi_private->stats.rfrc++;
@@ -260,7 +278,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 
 	/* Clear the bits that we set */
 	if (sisr2)
-		out_be32(&ssi->sisr, sisr2);
+		write_ssi(sisr2, &ssi->sisr);
 
 	return ret;
 }
@@ -295,7 +313,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 * SSI needs to be disabled before updating the registers we set
 		 * here.
 		 */
-		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
 
 		/*
 		 * Program the SSI into I2S Slave Non-Network Synchronous mode.
@@ -303,20 +321,18 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 *
 		 * FIXME: Little-endian samples require a different shift dir
 		 */
-		clrsetbits_be32(&ssi->scr,
+		write_ssi_mask(&ssi->scr,
 			CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
 			CCSR_SSI_SCR_TFR_CLK_DIS | CCSR_SSI_SCR_I2S_MODE_SLAVE
 			| (synchronous ? CCSR_SSI_SCR_SYN : 0));
 
-		out_be32(&ssi->stcr,
-			 CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
+		write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
 			 CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
-			 CCSR_SSI_STCR_TSCKP);
+			 CCSR_SSI_STCR_TSCKP, &ssi->stcr);
 
-		out_be32(&ssi->srcr,
-			 CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
+		write_ssi(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
 			 CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
-			 CCSR_SSI_SRCR_RSCKP);
+			 CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
 
 		/*
 		 * The DC and PM bits are only used if the SSI is the clock
@@ -324,7 +340,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 */
 
 		/* Enable the interrupts and DMA requests */
-		out_be32(&ssi->sier, SIER_FLAGS);
+		write_ssi(SIER_FLAGS, &ssi->sier);
 
 		/*
 		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
@@ -339,9 +355,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 * make this value larger (and maybe we should), but this way
 		 * data will be written to memory as soon as it's available.
 		 */
-		out_be32(&ssi->sfcsr,
-			CCSR_SSI_SFCSR_TFWM0(ssi_private->fifo_depth - 2) |
-			CCSR_SSI_SFCSR_RFWM0(ssi_private->fifo_depth - 2));
+		write_ssi(CCSR_SSI_SFCSR_TFWM0(ssi_private->fifo_depth - 2) |
+			CCSR_SSI_SFCSR_RFWM0(ssi_private->fifo_depth - 2),
+			&ssi->sfcsr);
 
 		/*
 		 * We keep the SSI disabled because if we enable it, then the
@@ -417,7 +433,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	unsigned int sample_size =
 		snd_pcm_format_width(params_format(hw_params));
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
-	int enabled = in_be32(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
+	int enabled = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
 
 	/*
 	 * If we're in synchronous mode, and the SSI is already enabled,
@@ -439,9 +455,9 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	/* In synchronous mode, the SSI uses STCCR for capture */
 	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
 	    ssi_private->cpu_dai_drv.symmetric_rates)
-		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+		write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 	else
-		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 
 	return 0;
 }
@@ -466,19 +482,19 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			setbits32(&ssi->scr,
+			write_ssi_mask(&ssi->scr, 0,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
 		else
-			setbits32(&ssi->scr,
+			write_ssi_mask(&ssi->scr, 0,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			clrbits32(&ssi->scr, CCSR_SSI_SCR_TE);
+			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
 		else
-			clrbits32(&ssi->scr, CCSR_SSI_SCR_RE);
+			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
 		break;
 
 	default:
@@ -510,7 +526,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 	if (!ssi_private->first_stream) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
-		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
 	}
 }
 
-- 
1.7.5.4
