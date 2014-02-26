From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 26 Feb 2014 17:02:05 +0100
Subject: [PATCH 02/15] ASoC: fsl-ssi: Remove fsl_ssi_setup
In-Reply-To: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1393430538-32333-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fsl_ssi_set_dai_fmt() manages most of the register setup routines now.
fsl_ssi_setup() makes the same as fsl_ssi_set_dai_fmt() but it relies on
DT properties.

In most cases the settings of fsl_ssi_setup() are already overwritten by
fsl_ssi_set_dai_fmt() when it is called by the soc-core when a sound
card is added. As these settings depend on the combination of codec and
cpu DAI, this should really be done by sound cards.

This patch removes fsl_ssi_setup() and adds the missing register setups
to fsl_ssi_set_dai_fmt(). It also removes all calls to fsl_ssi_setup().

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 158 ++++++++++++------------------------------------
 1 file changed, 40 insertions(+), 118 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a77daa5..1407085 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -155,7 +155,6 @@ struct fsl_ssi_private {
 	bool irq_stats;
 	bool offline_config;
 	bool use_dual_fifo;
-	u8 i2s_mode;
 	spinlock_t baudclk_lock;
 	struct clk *baudclk;
 	struct clk *clk;
@@ -646,101 +645,6 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 	regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_WAIT(3));
 }
 
-static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
-{
-	struct regmap *regs = ssi_private->regs;
-	u8 wm;
-	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
-
-	fsl_ssi_setup_reg_vals(ssi_private);
-
-	if (ssi_private->imx_ac97)
-		ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL | CCSR_SSI_SCR_NET;
-	else
-		ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_SLAVE;
-
-	/*
-	 * Section 16.5 of the MPC8610 reference manual says that the SSI needs
-	 * to be disabled before updating the registers we set here.
-	 */
-	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, 0);
-
-	/*
-	 * Program the SSI into I2S Slave Non-Network Synchronous mode. Also
-	 * enable the transmit and receive FIFO.
-	 *
-	 * FIXME: Little-endian samples require a different shift dir
-	 */
-	regmap_update_bits(regs, CCSR_SSI_SCR,
-			CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN |
-			CCSR_SSI_SCR_TFR_CLK_DIS,
-			CCSR_SSI_SCR_TFR_CLK_DIS | ssi_private->i2s_mode |
-			(synchronous ? CCSR_SSI_SCR_SYN : 0));
-
-	regmap_write(regs, CCSR_SSI_STCR, CCSR_SSI_STCR_TXBIT0 |
-			CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
-			CCSR_SSI_STCR_TSCKP);
-
-	regmap_write(regs, CCSR_SSI_SRCR, CCSR_SSI_SRCR_RXBIT0 |
-			CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
-			CCSR_SSI_SRCR_RSCKP);
-
-	/*
-	 * The DC and PM bits are only used if the SSI is the clock master.
-	 */
-
-	/*
-	 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We don't
-	 * use FIFO 1. We program the transmit water to signal a DMA transfer
-	 * if there are only two (or fewer) elements left in the FIFO. Two
-	 * elements equals one frame (left channel, right channel). This value,
-	 * however, depends on the depth of the transmit buffer.
-	 *
-	 * We set the watermark on the same level as the DMA burstsize.  For
-	 * fiq it is probably better to use the biggest possible watermark
-	 * size.
-	 */
-	if (ssi_private->use_dma)
-		wm = ssi_private->fifo_depth - 2;
-	else
-		wm = ssi_private->fifo_depth;
-
-	regmap_write(regs, CCSR_SSI_SFCSR, CCSR_SSI_SFCSR_TFWM0(wm) |
-			CCSR_SSI_SFCSR_RFWM0(wm) | CCSR_SSI_SFCSR_TFWM1(wm) |
-			CCSR_SSI_SFCSR_RFWM1(wm));
-
-	/*
-	 * For ac97 interrupts are enabled with the startup of the substream
-	 * because it is also running without an active substream. Normally SSI
-	 * is only enabled when there is a substream.
-	 */
-	if (ssi_private->imx_ac97)
-		fsl_ssi_setup_ac97(ssi_private);
-
-	/*
-	 * Set a default slot number so that there is no need for those common
-	 * cases like I2S mode to call the extra set_tdm_slot() any more.
-	 */
-	if (!ssi_private->imx_ac97) {
-		regmap_update_bits(regs, CCSR_SSI_STCCR, CCSR_SSI_SxCCR_DC_MASK,
-				CCSR_SSI_SxCCR_DC(2));
-		regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_DC_MASK,
-				CCSR_SSI_SxCCR_DC(2));
-	}
-
-	if (ssi_private->use_dual_fifo) {
-		regmap_update_bits(regs, CCSR_SSI_SRCR, CCSR_SSI_SRCR_RFEN1,
-				CCSR_SSI_SRCR_RFEN1);
-		regmap_update_bits(regs, CCSR_SSI_STCR, CCSR_SSI_STCR_TFEN1,
-				CCSR_SSI_STCR_TFEN1);
-		regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_TCH_EN,
-				CCSR_SSI_SCR_TCH_EN);
-	}
-
-	return 0;
-}
-
-
 /**
  * fsl_ssi_startup: create a new substream
  *
@@ -757,12 +661,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	unsigned long flags;
 
-	/* First, we only do fsl_ssi_setup() when SSI is going to be active.
-	 * Second, fsl_ssi_setup was already called by ac97_init earlier if
-	 * the driver is in ac97 mode.
-	 */
 	if (!dai->active && !ssi_private->imx_ac97) {
-		fsl_ssi_setup(ssi_private);
 		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
 		ssi_private->baudclk_locked = false;
 		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
@@ -798,7 +697,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct regmap *regs = ssi_private->regs;
-	unsigned int channels = params_channels(hw_params);
 	unsigned int sample_size =
 		snd_pcm_format_width(params_format(hw_params));
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
@@ -834,11 +732,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_WL_MASK,
 				wl);
 
-	if (!ssi_private->imx_ac97)
-		regmap_update_bits(regs, CCSR_SSI_SCR,
-				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
-				channels == 1 ? 0 : ssi_private->i2s_mode);
-
 	return 0;
 }
 
@@ -850,6 +743,9 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
 	struct regmap *regs = ssi_private->regs;
 	u32 strcr = 0, stcr, srcr, scr, mask;
+	u8 wm;
+
+	fsl_ssi_setup_reg_vals(ssi_private);
 
 	regmap_read(regs, CCSR_SSI_SCR, &scr);
 	scr &= ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
@@ -867,15 +763,14 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_I2S:
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBS_CFS:
-			ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_MASTER;
+			scr |= CCSR_SSI_SCR_I2S_MODE_MASTER;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
-			ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_SLAVE;
+			scr |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
 			break;
 		default:
 			return -EINVAL;
 		}
-		scr |= ssi_private->i2s_mode;
 
 		/* Data on rising edge of bclk, frame low, 1clk before data */
 		strcr |= CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TSCKP |
@@ -895,6 +790,9 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		strcr |= CCSR_SSI_STCR_TFSL | CCSR_SSI_STCR_TSCKP |
 			CCSR_SSI_STCR_TXBIT0;
 		break;
+	case SND_SOC_DAIFMT_AC97:
+		scr |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -947,6 +845,38 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	regmap_write(regs, CCSR_SSI_SRCR, srcr);
 	regmap_write(regs, CCSR_SSI_SCR, scr);
 
+	/*
+	 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We don't
+	 * use FIFO 1. We program the transmit water to signal a DMA transfer
+	 * if there are only two (or fewer) elements left in the FIFO. Two
+	 * elements equals one frame (left channel, right channel). This value,
+	 * however, depends on the depth of the transmit buffer.
+	 *
+	 * We set the watermark on the same level as the DMA burstsize.  For
+	 * fiq it is probably better to use the biggest possible watermark
+	 * size.
+	 */
+	if (ssi_private->use_dma)
+		wm = ssi_private->fifo_depth - 2;
+	else
+		wm = ssi_private->fifo_depth;
+
+	regmap_write(regs, CCSR_SSI_SFCSR,
+			CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
+			CCSR_SSI_SFCSR_TFWM1(wm) | CCSR_SSI_SFCSR_RFWM1(wm));
+
+	if (ssi_private->use_dual_fifo) {
+		regmap_update_bits(regs, CCSR_SSI_SRCR, CCSR_SSI_SRCR_RFEN1,
+				CCSR_SSI_SRCR_RFEN1);
+		regmap_update_bits(regs, CCSR_SSI_STCR, CCSR_SSI_STCR_TFEN1,
+				CCSR_SSI_STCR_TFEN1);
+		regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_TCH_EN,
+				CCSR_SSI_SCR_TCH_EN);
+	}
+
+	if (fmt & SND_SOC_DAIFMT_AC97)
+		fsl_ssi_setup_ac97(ssi_private);
+
 	return 0;
 }
 
@@ -1207,11 +1137,6 @@ static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 
 static struct fsl_ssi_private *fsl_ac97_data;
 
-static void fsl_ssi_ac97_init(void)
-{
-	fsl_ssi_setup(fsl_ac97_data);
-}
-
 static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 		unsigned short val)
 {
@@ -1582,9 +1507,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
-	if (ssi_private->imx_ac97)
-		fsl_ssi_ac97_init();
-
 	return 0;
 
 error_dai:
-- 
1.8.5.3
