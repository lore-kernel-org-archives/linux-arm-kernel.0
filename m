From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:25:18 +0200
Subject: [PATCH v2 08/11] ASoC: fsl-ssi: imx ac97 support
In-Reply-To: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365362721-3731-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch copies some parts from imx-ssi to support AC97 on
imx27-pca100 and imx27-pcm043. It is activated with a new fsl,imx-ac97
bool property. It was tested on imx27-pca100.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 360 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 279 insertions(+), 81 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index bb9a1e0..06f52ce 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -120,6 +120,7 @@ struct fsl_ssi_private {
 
 	bool new_binding;
 	bool ssi_on_imx;
+	bool imx_ac97;
 	bool dma;
 	struct clk *clk;
 	struct platform_device *imx_pcm_pdev;
@@ -127,6 +128,9 @@ struct fsl_ssi_private {
 	struct imx_pcm_dma_params dma_params_rx;
 	struct imx_pcm_fiq_params fiq_params;
 
+	void (*ac97_reset) (struct snd_ac97 *ac97);
+	void (*ac97_warm_reset)(struct snd_ac97 *ac97);
+
 	struct {
 		unsigned int rfrc;
 		unsigned int tfrc;
@@ -323,67 +327,76 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 
 		ssi_private->first_stream = substream;
 
-		/*
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
+		/* If we use AC97, the registers are already setup correctly */
+		if (!ssi_private->imx_ac97) {
+			/*
+			 * Section 16.5 of the MPC8610 reference manual says
+			 * that the SSI needs to be disabled before updating
+			 * the registers we set here.
+			 */
+			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
 
-		write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
-			 CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
-			 CCSR_SSI_STCR_TSCKP, &ssi->stcr);
+			/*
+			 * Program the SSI into I2S Slave Non-Network
+			 * Synchronous mode. Also enable the transmit and
+			 * receive FIFO.
+			 *
+			 * FIXME: Little-endian samples require a different
+			 * shift dir
+			 */
+			write_ssi_mask(&ssi->scr,
+				CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
+				CCSR_SSI_SCR_TFR_CLK_DIS |
+				CCSR_SSI_SCR_I2S_MODE_SLAVE |
+				(synchronous ? CCSR_SSI_SCR_SYN : 0));
+
+			write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
+				 CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
+				 CCSR_SSI_STCR_TSCKP, &ssi->stcr);
+
+			write_ssi(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
+				 CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
+				 CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
+			/*
+			 * The DC and PM bits are only used if the SSI is the
+			 * clock master.
+			 */
 
-		write_ssi(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
-			 CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
-			 CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
+			/*
+			 * Set the watermark for transmit FIFI 0 and receive
+			 * FIFO 0. We don't use FIFO 1. We program the
+			 * transmit water to signal a DMA transfer if there are
+			 * only two (or fewer) elements left in the FIFO. Two
+			 * elements equals one frame (left channel, right
+			 * channel). This value, however, depends on the depth
+			 * of the transmit buffer.
+			 *
+			 * We program the receive FIFO to notify us if at least
+			 * two elements (one frame) have been written to the
+			 * FIFO. We could make this value larger (and maybe we
+			 * should), but this way data will be written to memory
+			 * as soon as it's available.
+			 */
+			write_ssi(CCSR_SSI_SFCSR_TFWM0(ssi_private->fifo_depth - 2) |
+				CCSR_SSI_SFCSR_RFWM0(ssi_private->fifo_depth - 2),
+				&ssi->sfcsr);
 
-		/*
-		 * The DC and PM bits are only used if the SSI is the clock
-		 * master.
-		 */
+			/*
+			 * We keep the SSI disabled because if we enable it,
+			 * then the DMA controller will start. It's not
+			 * supposed to start until the SCR.TE (or SCR.RE) bit
+			 * is set, but it does anyway. The DMA controller will
+			 * transfer one "BWC" of data (i.e. the amount of data
+			 * that the MR.BWC bits are set to). The reason this
+			 * is bad is because at this point, the PCM driver has
+			 * not finished initializing the DMA controller.
+			 */
+		}
 
 		/* Enable the interrupts and DMA requests */
 		if (ssi_private->dma)
 			write_ssi(SIER_FLAGS, &ssi->sier);
 
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
-		 */
 	} else {
 		if (synchronous) {
 			struct snd_pcm_runtime *first_runtime =
@@ -500,27 +513,29 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi_mask(&ssi->scr, 0,
-				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
-		else
-			write_ssi_mask(&ssi->scr, 0,
-				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
-		else
-			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
-		break;
-
-	default:
-		return -EINVAL;
+	if (!ssi_private->imx_ac97) {
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+				write_ssi_mask(&ssi->scr, 0,
+					CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
+			else
+				write_ssi_mask(&ssi->scr, 0,
+					CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
+			break;
+
+		case SNDRV_PCM_TRIGGER_STOP:
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+				write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
+			else
+				write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
+			break;
+
+		default:
+			return -EINVAL;
+		}
 	}
 
 	if (!ssi_private->dma) {
@@ -556,8 +571,9 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 
 	/*
 	 * If this is the last active substream, disable the SSI.
+	 * If AC97 is active, we don't want to disable SSI.
 	 */
-	if (!ssi_private->first_stream) {
+	if (!ssi_private->first_stream && !ssi_private->imx_ac97) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
 		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
@@ -589,6 +605,152 @@ static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.ops = &fsl_ssi_dai_ops,
 };
 
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
+	.ops = &fsl_ssi_dai_ops,
+};
+
+
+static struct fsl_ssi_private *fsl_ac97_data;
+
+static void fsl_ssi_ac97_setup(struct ccsr_ssi *ssi)
+{
+	write_ssi(0x0, &ssi->scr);
+	write_ssi(0x0, &ssi->stcr);
+	write_ssi(0x0, &ssi->srcr);
+
+	write_ssi(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_NET, &ssi->scr);
+
+	write_ssi(CCSR_SSI_SFCSR_RFWM0(8) | CCSR_SSI_SFCSR_TFWM0(8) |
+			CCSR_SSI_SFCSR_RFWM1(8) | CCSR_SSI_SFCSR_TFWM1(8),
+			&ssi->sfcsr);
+
+	write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
+			&ssi->stccr);
+	write_ssi(CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13),
+			&ssi->srccr);
+
+	write_ssi(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_NET |
+			CCSR_SSI_SCR_SSIEN, &ssi->scr);
+	write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
+
+	write_ssi(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_NET |
+			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE |
+			CCSR_SSI_SCR_RE, &ssi->scr);
+
+	write_ssi(CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV,
+			&ssi->sacnt);
+	write_ssi(0xff, &ssi->saccdis);
+	write_ssi(0x300, &ssi->saccen);
+
+	write_ssi(0x0, &ssi->sier);
+}
+
+static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
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
+static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
+		unsigned short reg)
+{
+	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
+
+	unsigned short val = -1;
+	unsigned int lreg;
+
+	lreg = (reg & 0x7f) <<  12 ;
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
+static void fsl_ssi_ac97_reset(struct snd_ac97 *ac97)
+{
+	struct fsl_ssi_private *ssi_private = fsl_ac97_data;
+
+	if (ssi_private->ac97_reset)
+		ssi_private->ac97_reset(ac97);
+	/* First read sometimes fails, do a dummy read */
+	fsl_ssi_ac97_read(ac97, 0);
+}
+
+static void fsl_ssi_ac97_warm_reset(struct snd_ac97 *ac97)
+{
+	struct fsl_ssi_private *ssi_private = fsl_ac97_data;
+
+	if (ssi_private->ac97_warm_reset)
+		ssi_private->ac97_warm_reset(ac97);
+
+	/* First read sometimes fails, do a dummy read */
+	fsl_ssi_ac97_read(ac97, 0);
+}
+
+struct snd_ac97_bus_ops soc_ac97_ops = {
+	.read		= fsl_ssi_ac97_read,
+	.write		= fsl_ssi_ac97_write,
+	.reset		= fsl_ssi_ac97_reset,
+	.warm_reset	= fsl_ssi_ac97_warm_reset
+};
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+/*
+ * Pointer to AC97 reset functions for specific boards
+ */
+#if IS_ENABLED(CONFIG_MACH_PCA100)
+extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
+extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
+#else
+void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
+void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
+#endif
+
+#if IS_ENABLED(CONFIG_MACH_PCM043)
+extern void pcm043_ac97_cold_reset(struct snd_ac97 *ac97);
+extern void pcm043_ac97_warm_reset(struct snd_ac97 *ac97);
+#else
+void pcm043_ac97_cold_reset(struct snd_ac97 *ac97) { }
+void pcm043_ac97_warm_reset(struct snd_ac97 *ac97) { }
+#endif
+
+
 /* Show the statistics of a flag only if its interrupt is enabled.  The
  * compiler will optimze this code to a no-op if the interrupt is not
  * enabled.
@@ -664,6 +826,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	const uint32_t *iprop;
 	struct resource res;
 	char name[64];
+	bool ac97 = false;
 
 	/* SSIs that are not connected on the board should have a
 	 *      status = "disabled"
@@ -674,7 +837,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
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
@@ -690,13 +859,39 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	strcpy(ssi_private->name, p);
 
-	/* Initialize this copy of the CPU DAI driver structure */
-	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
-	       sizeof(fsl_ssi_dai_template));
-	ssi_private->cpu_dai_drv.name = ssi_private->name;
-
 	ssi_private->dma = !of_property_read_bool(np, "fsl,imx-fiq");
 
+	if (ac97) {
+		sprop = of_get_property(of_find_node_by_path("/"), "compatible",
+				NULL);
+		p = strrchr(sprop, ',');
+		if (p)
+			sprop = p + 1;
+
+		if (!strcmp(sprop, "imx27-pca100")) {
+			ssi_private->ac97_reset = pca100_ac97_cold_reset;
+			ssi_private->ac97_warm_reset = pca100_ac97_warm_reset;
+		} else if (!strcmp(sprop, "imx27-pcm043")) {
+			ssi_private->ac97_reset = pcm043_ac97_cold_reset;
+			ssi_private->ac97_warm_reset = pcm043_ac97_warm_reset;
+		} else {
+			dev_err(&pdev->dev, "Failed to enable ssi AC97 mode, unknown board.\n");
+			ret = -EINVAL;
+			goto error_kmalloc;
+		}
+
+		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_ac97_dai,
+				sizeof(fsl_ssi_ac97_dai));
+
+		fsl_ac97_data = ssi_private;
+		ssi_private->imx_ac97 = true;
+	} else {
+		/* Initialize this copy of the CPU DAI driver structure */
+		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
+		       sizeof(fsl_ssi_dai_template));
+	}
+	ssi_private->cpu_dai_drv.name = ssi_private->name;
+
 	/* Get the addresses and IRQ */
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
@@ -729,6 +924,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (ssi_private->imx_ac97)
+		fsl_ssi_ac97_setup(ssi_private->ssi);
+
 	/* Are the RX and the TX clocks locked? */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL))
 		ssi_private->cpu_dai_drv.symmetric_rates = 1;
-- 
1.8.1.5
