From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:05:58 +0200
Subject: [PATCH v11 5/8] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376924761-4054-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds ac97-slave support.

For ac97, the registers have to be setup earlier than for other ssi
modes because there is some communication with the external device
before streaming. So this patch introduces a fsl_ssi_setup function to
setup the registers for different ssi operation modes seperately.

This patch was tested with imx27-pca100.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/sound/fsl,ssi.txt          |   4 +
 sound/soc/fsl/fsl_ssi.c                            | 346 ++++++++++++++++-----
 2 files changed, 280 insertions(+), 70 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 088a2c0..4303b6a 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -43,6 +43,10 @@ Required properties:
                     together.  This would still allow different sample sizes,
                     but not different sample rates.
 
+Required are also ac97 link bindings if ac97 is used. See
+Documentation/devicetree/bindings/sound/soc-ac97link.txt for the necessary
+bindings.
+
 Optional properties:
 - codec-handle:     Phandle to a 'codec' node that defines an audio
                     codec connected to this SSI.  This node is typically
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0c072ff..827af75 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -141,6 +141,7 @@ struct fsl_ssi_private {
 
 	bool new_binding;
 	bool ssi_on_imx;
+	bool imx_ac97;
 	bool use_dma;
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
@@ -320,6 +321,124 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	return ret;
 }
 
+static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
+{
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	u8 i2s_mode;
+	u8 wm;
+	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
+
+	if (ssi_private->imx_ac97)
+		i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL | CCSR_SSI_SCR_NET;
+	else
+		i2s_mode = CCSR_SSI_SCR_I2S_MODE_SLAVE;
+
+	/*
+	 * Section 16.5 of the MPC8610 reference manual says that the SSI needs
+	 * to be disabled before updating the registers we set here.
+	 */
+	write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
+
+	/*
+	 * Program the SSI into I2S Slave Non-Network Synchronous mode. Also
+	 * enable the transmit and receive FIFO.
+	 *
+	 * FIXME: Little-endian samples require a different shift dir
+	 */
+	write_ssi_mask(&ssi->scr,
+		CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
+		CCSR_SSI_SCR_TFR_CLK_DIS |
+		i2s_mode |
+		(synchronous ? CCSR_SSI_SCR_SYN : 0));
+
+	write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
+		 CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
+		 CCSR_SSI_STCR_TSCKP, &ssi->stcr);
+
+	write_ssi(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
+		 CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
+		 CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
+	/*
+	 * The DC and PM bits are only used if the SSI is the clock master.
+	 */
+
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
+	write_ssi(CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
+		CCSR_SSI_SFCSR_TFWM1(wm) | CCSR_SSI_SFCSR_RFWM1(wm),
+		&ssi->sfcsr);
+
+	/*
+	 * For non-ac97 setups, we keep the SSI disabled because if we enable
+	 * it, then the DMA controller will start. It's not supposed to start
+	 * until the SCR.TE (or SCR.RE) bit is set, but it does anyway. The DMA
+	 * controller will transfer one "BWC" of data (i.e. the amount of data
+	 * that the MR.BWC bits are set to). The reason this is bad is because
+	 * at this point, the PCM driver has not finished initializing the DMA
+	 * controller.
+	 */
+
+
+	/*
+	 * For ac97 interrupts are enabled with the startup of the substream
+	 * because it is also running without an active substream. Normally SSI
+	 * is only enabled when there is a substream.
+	 */
+	if (!ssi_private->imx_ac97) {
+		/* Enable the interrupts and DMA requests */
+		if (ssi_private->use_dma)
+			write_ssi(SIER_FLAGS, &ssi->sier);
+		else
+			write_ssi(CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN |
+					CCSR_SSI_SIER_RIE |
+					CCSR_SSI_SIER_RFF0_EN, &ssi->sier);
+	} else {
+		/*
+		 * Setup the clock control register
+		 */
+		write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
+				&ssi->stccr);
+		write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
+				&ssi->srccr);
+
+		/*
+		 * Enable AC97 mode and startup the SSI
+		 */
+		write_ssi(CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV,
+				&ssi->sacnt);
+		write_ssi(0xff, &ssi->saccdis);
+		write_ssi(0x300, &ssi->saccen);
+
+		/*
+		 * Enable SSI
+		 */
+		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN);
+		write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
+
+		/*
+		 * Enable Transmit and Receive
+		 */
+		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
+	}
+
+	return 0;
+}
+
+
 /**
  * fsl_ssi_startup: create a new substream
  *
@@ -341,75 +460,14 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	 * and initialize the SSI registers.
 	 */
 	if (!ssi_private->first_stream) {
-		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-
 		ssi_private->first_stream = substream;
 
 		/*
-		 * Section 16.5 of the MPC8610 reference manual says that the
-		 * SSI needs to be disabled before updating the registers we set
-		 * here.
-		 */
-		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
-
-		/*
-		 * Program the SSI into I2S Slave Non-Network Synchronous mode.
-		 * Also enable the transmit and receive FIFO.
-		 *
-		 * FIXME: Little-endian samples require a different shift dir
-		 */
-		write_ssi_mask(&ssi->scr,
-			CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
-			CCSR_SSI_SCR_TFR_CLK_DIS | CCSR_SSI_SCR_I2S_MODE_SLAVE
-			| (synchronous ? CCSR_SSI_SCR_SYN : 0));
-
-		write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
-			 CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
-			 CCSR_SSI_STCR_TSCKP, &ssi->stcr);
-
-		write_ssi(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
-			 CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
-			 CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
-
-		/*
-		 * The DC and PM bits are only used if the SSI is the clock
-		 * master.
-		 */
-
-		/* Enable the interrupts and DMA requests */
-		if (ssi_private->use_dma)
-			write_ssi(SIER_FLAGS, &ssi->sier);
-		else
-			write_ssi(CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN |
-					CCSR_SSI_SIER_RIE |
-					CCSR_SSI_SIER_RFF0_EN, &ssi->sier);
-
-		/*
-		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
-		 * don't use FIFO 1.  We program the transmit water to signal a
-		 * DMA transfer if there are only two (or fewer) elements left
-		 * in the FIFO.  Two elements equals one frame (left channel,
-		 * right channel).  This value, however, depends on the depth of
-		 * the transmit buffer.
-		 *
-		 * We program the receive FIFO to notify us if at least two
-		 * elements (one frame) have been written to the FIFO.  We could
-		 * make this value larger (and maybe we should), but this way
-		 * data will be written to memory as soon as it's available.
-		 */
-		write_ssi(CCSR_SSI_SFCSR_TFWM0(ssi_private->fifo_depth - 2) |
-			CCSR_SSI_SFCSR_RFWM0(ssi_private->fifo_depth - 2),
-			&ssi->sfcsr);
-
-		/*
-		 * We keep the SSI disabled because if we enable it, then the
-		 * DMA controller will start.  It's not supposed to start until
-		 * the SCR.TE (or SCR.RE) bit is set, but it does anyway.  The
-		 * DMA controller will transfer one "BWC" of data (i.e. the
-		 * amount of data that the MR.BWC bits are set to).  The reason
-		 * this is bad is because at this point, the PCM driver has not
-		 * finished initializing the DMA controller.
+		 * fsl_ssi_setup was already called by ac97_init earlier if
+		 * the driver is in ac97 mode.
 		 */
+		if (!ssi_private->imx_ac97)
+			fsl_ssi_setup(ssi_private);
 	} else {
 		if (synchronous) {
 			struct snd_pcm_runtime *first_runtime =
@@ -538,7 +596,8 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		else
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
 
-		if ((read_ssi(&ssi->scr) & (CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
+		if (!ssi_private->imx_ac97 && (read_ssi(&ssi->scr) &
+					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
 		break;
 
@@ -608,6 +667,133 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 	.name		= "fsl-ssi",
 };
 
+/**
+ * fsl_ssi_ac97_trigger: start and stop the AC97 receive/transmit.
+ *
+ * This function is called by ALSA to start, stop, pause, and resume the
+ * transfer of data.
+ */
+static int fsl_ssi_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(
+			rtd->cpu_dai);
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_TIE |
+					CCSR_SSI_SIER_TFE0_EN);
+		else
+			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_RIE |
+					CCSR_SSI_SIER_RFF0_EN);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_TIE |
+					CCSR_SSI_SIER_TFE0_EN, 0);
+		else
+			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_RIE |
+					CCSR_SSI_SIER_RFF0_EN, 0);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
+	else
+		write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops fsl_ssi_ac97_dai_ops = {
+	.startup	= fsl_ssi_startup,
+	.shutdown	= fsl_ssi_shutdown,
+	.trigger	= fsl_ssi_ac97_trigger,
+};
+
+static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
+	.ac97_control = 1,
+	.playback = {
+		.stream_name = "AC97 Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "AC97 Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &fsl_ssi_ac97_dai_ops,
+};
+
+
+static struct fsl_ssi_private *fsl_ac97_data;
+
+static void fsl_ssi_ac97_init(void)
+{
+	fsl_ssi_setup(fsl_ac97_data);
+}
+
+void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+		unsigned short val)
+{
+	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
+	unsigned int lreg;
+	unsigned int lval;
+
+	if (reg > 0x7f)
+		return;
+
+
+	lreg = reg <<  12;
+	write_ssi(lreg, &ssi->sacadd);
+
+	lval = val << 4;
+	write_ssi(lval , &ssi->sacdat);
+
+	write_ssi_mask(&ssi->sacnt, CCSR_SSI_SACNT_RDWR_MASK,
+			CCSR_SSI_SACNT_WR);
+	udelay(100);
+}
+
+unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
+		unsigned short reg)
+{
+	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
+
+	unsigned short val = -1;
+	unsigned int lreg;
+
+	lreg = (reg & 0x7f) <<  12;
+	write_ssi(lreg, &ssi->sacadd);
+	write_ssi_mask(&ssi->sacnt, CCSR_SSI_SACNT_RDWR_MASK,
+			CCSR_SSI_SACNT_RD);
+
+	udelay(100);
+
+	val = (read_ssi(&ssi->sacdat) >> 4) & 0xffff;
+
+	return val;
+}
+
+static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
+	.read		= fsl_ssi_ac97_read,
+	.write		= fsl_ssi_ac97_write,
+};
+
 /* Show the statistics of a flag only if its interrupt is enabled.  The
  * compiler will optimze this code to a no-op if the interrupt is not
  * enabled.
@@ -684,6 +870,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct resource res;
 	char name[64];
 	bool shared;
+	bool ac97 = false;
 
 	/* SSIs that are not connected on the board should have a
 	 *      status = "disabled"
@@ -694,7 +881,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
-	if (!sprop || strcmp(sprop, "i2s-slave")) {
+	if (!sprop) {
+		dev_err(&pdev->dev, "fsl,mode property is necessary\n");
+		return -EINVAL;
+	}
+	if (!strcmp(sprop, "ac97-slave")) {
+		ac97 = true;
+	} else if (strcmp(sprop, "i2s-slave")) {
 		dev_notice(&pdev->dev, "mode %s is unsupported\n", sprop);
 		return -ENODEV;
 	}
@@ -713,9 +906,19 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi_private->use_dma = !of_property_read_bool(np,
 			"fsl,fiq-stream-filter");
 
-	/* Initialize this copy of the CPU DAI driver structure */
-	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
-	       sizeof(fsl_ssi_dai_template));
+	if (ac97) {
+		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_ac97_dai,
+				sizeof(fsl_ssi_ac97_dai));
+
+		fsl_ac97_data = ssi_private;
+		ssi_private->imx_ac97 = true;
+
+		snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
+	} else {
+		/* Initialize this copy of the CPU DAI driver structure */
+		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
+		       sizeof(fsl_ssi_dai_template));
+	}
 	ssi_private->cpu_dai_drv.name = ssi_private->name;
 
 	/* Get the addresses and IRQ */
@@ -901,6 +1104,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
+	if (ssi_private->imx_ac97)
+		fsl_ssi_ac97_init();
+
 	return 0;
 
 error_dai:
-- 
1.8.4.rc3
