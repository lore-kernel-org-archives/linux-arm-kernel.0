From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 15:20:25 +0200
Subject: [PATCH v9 06/10] ASoC: fsl-ssi: imx ac97 support
In-Reply-To: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371734429-6081-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch copies some parts from imx-ssi to support AC97 on
imx27-pca100 and imx35-pcm043. This is a implementation of the
ac97-slave mode.

For ac97, the registers have to be setup earlier than for other ssi
modes because there is some communication with the external device
before actual streaming. So this patch introduces a fsl_ssi_setup
function to setup the registers at different times.

To seperate board specific ac97 reset functions, ac97 read/write
functions are exported. The reset functions are set by other drivers.

This patch was tested with imx27-pca100.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---

Notes:
    Changes in v9:
     - Minor style fixes.
    
    Changes in v7:
     - ac97 ops are now assigned to soc_ac97_ops to allow enabled imx-ssi and
       fsl-ssi at the same time.
    
    Changes in v6:
     - ac97 reset functions are not provided by fsl-ssi code anymore. They were
       moved to board specific code like phycore-ac97. Therefore ac97 read/write
       functions are exported and a helper function to set the soc_ac97_ops reset
       functions was created.
    
    Changes in v3:
     - Cleanup ac97 code by adding a fsl_ssi_setup function for initial register
       setup. For ac97 the registers have to be setup earlier than in normal
       mode.

 sound/soc/fsl/fsl_ssi.c | 364 ++++++++++++++++++++++++++++++++++++++----------
 sound/soc/fsl/fsl_ssi.h |   7 +
 2 files changed, 299 insertions(+), 72 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ed1fbbb..34cc1c8 100644
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
@@ -564,8 +622,9 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 
 	/*
 	 * If this is the last active substream, disable the SSI.
+	 * If AC97 is active, we don't want to disable SSI.
 	 */
-	if (!ssi_private->first_stream) {
+	if (!ssi_private->first_stream && !ssi_private->imx_ac97) {
 		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 
 		write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
@@ -614,6 +673,130 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
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
+EXPORT_SYMBOL(fsl_ssi_ac97_write);
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
+EXPORT_SYMBOL(fsl_ssi_ac97_read);
+
 /*
  * FIXME: As soon as all boards using imx-ssi AC97 mode are able to use
  * fsl-ssi, soc_ac97_ops can be used exclusively in this driver without copying
@@ -622,6 +805,23 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 struct snd_ac97_bus_ops soc_ac97_ops;
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
+static struct snd_ac97_bus_ops fsl_ssi_soc_ac97_ops = {
+	.read		= fsl_ssi_ac97_read,
+	.write		= fsl_ssi_ac97_write,
+};
+
+/*
+ * ac97 reset and warm_reset functions are setup by board specific drivers.
+ * ssi does not have any knowledge about the used board.
+ */
+void fsl_ssi_ac97_set_reset(void (*ac97_reset)(struct snd_ac97 *ac97),
+		void (*ac97_warm_reset)(struct snd_ac97 *ac97))
+{
+	soc_ac97_ops.reset = ac97_reset;
+	soc_ac97_ops.warm_reset = ac97_warm_reset;
+}
+EXPORT_SYMBOL(fsl_ssi_ac97_set_reset);
+
 /* Show the statistics of a flag only if its interrupt is enabled.  The
  * compiler will optimze this code to a no-op if the interrupt is not
  * enabled.
@@ -698,6 +898,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct resource res;
 	char name[64];
 	bool shared;
+	bool ac97 = false;
 
 	/* SSIs that are not connected on the board should have a
 	 *      status = "disabled"
@@ -708,7 +909,13 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
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
@@ -724,13 +931,23 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	strcpy(ssi_private->name, p);
 
-	/* Initialize this copy of the CPU DAI driver structure */
-	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
-	       sizeof(fsl_ssi_dai_template));
-	ssi_private->cpu_dai_drv.name = ssi_private->name;
-
 	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
 
+	if (ac97) {
+		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_ac97_dai,
+				sizeof(fsl_ssi_ac97_dai));
+		memcpy(&soc_ac97_ops, &fsl_ssi_soc_ac97_ops,
+				sizeof(soc_ac97_ops));
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
@@ -910,6 +1127,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
+	if (ssi_private->imx_ac97)
+		fsl_ssi_ac97_init();
+
 	return 0;
 
 error_dai:
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index e6b9a69..87004ae 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -206,3 +206,10 @@ struct ccsr_ssi {
 
 #endif
 
+
+void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+		unsigned short val);
+unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
+		unsigned short reg);
+void fsl_ssi_ac97_set_reset(void (*ac97_reset)(struct snd_ac97 *ac97),
+		void (*ac97_warm_reset)(struct snd_ac97 *ac97));
-- 
1.8.2.1
