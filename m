From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 15 Mar 2014 13:44:17 +0100
Subject: [PATCH v2 09/16] ASoC: fsl-ssi: Remove unnecessary variables from
 ssi_private
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1394887464-969-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some variables defined in struct fsl_ssi_private that describe
states that are also described by other variables.

This patch adds some helper functions that return exactly the same
information based on available variables. This helps to clean up struct
fsl_ssi_private and remove them from the probe function.

It also removes some not really used variables (new_binding, name).

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 117 ++++++++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 53 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b0c04ef..126f277 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -143,7 +143,6 @@ struct fsl_ssi_rxtx_reg_val {
  * @cpu_dai: the CPU DAI for this device
  * @dev_attr: the sysfs device attribute structure
  * @stats: SSI statistics
- * @name: name for this device
  */
 struct fsl_ssi_private {
 	struct ccsr_ssi __iomem *ssi;
@@ -152,14 +151,11 @@ struct fsl_ssi_private {
 	unsigned int fifo_depth;
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct platform_device *pdev;
+	unsigned int dai_fmt;
 
 	enum fsl_ssi_type hw_type;
-	bool new_binding;
-	bool ssi_on_imx;
-	bool imx_ac97;
 	bool use_dma;
 	bool baudclk_locked;
-	bool offline_config;
 	bool use_dual_fifo;
 	u8 i2s_mode;
 	spinlock_t baudclk_lock;
@@ -172,8 +168,6 @@ struct fsl_ssi_private {
 	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
 
 	struct fsl_ssi_dbg dbg_stats;
-
-	char name[1];
 };
 
 static const struct of_device_id fsl_ssi_ids[] = {
@@ -185,6 +179,54 @@ static const struct of_device_id fsl_ssi_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
 
+static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
+{
+	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
+}
+
+static bool fsl_ssi_on_imx(struct fsl_ssi_private *ssi_private)
+{
+	switch (ssi_private->hw_type) {
+	case FSL_SSI_MX21:
+	case FSL_SSI_MX35:
+	case FSL_SSI_MX51:
+		return true;
+	case FSL_SSI_MCP8610:
+		return false;
+	}
+
+	return false;
+}
+
+/*
+ * imx51 and later SoCs have a slightly different IP that allows the
+ * SSI configuration while the SSI unit is running.
+ *
+ * More important, it is necessary on those SoCs to configure the
+ * sperate TX/RX DMA bits just before starting the stream
+ * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
+ * sends any DMA requests to the SDMA unit, otherwise it is not defined
+ * how the SDMA unit handles the DMA request.
+ *
+ * SDMA units are present on devices starting at imx35 but the imx35
+ * reference manual states that the DMA bits should not be changed
+ * while the SSI unit is running (SSIEN). So we support the necessary
+ * online configuration of fsl-ssi starting at imx51.
+ */
+static bool fsl_ssi_offline_config(struct fsl_ssi_private *ssi_private)
+{
+	switch (ssi_private->hw_type) {
+	case FSL_SSI_MCP8610:
+	case FSL_SSI_MX21:
+	case FSL_SSI_MX35:
+		return true;
+	case FSL_SSI_MX51:
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -290,7 +332,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * reconfiguration, so we have to enable all necessary flags at once
 	 * even if we do not use them later (capture and playback configuration)
 	 */
-	if (ssi_private->offline_config) {
+	if (fsl_ssi_offline_config(ssi_private)) {
 		if ((enable && !nr_active_streams) ||
 				(!enable && nr_active_streams == 1))
 			fsl_ssi_rxtx_config(ssi_private, enable);
@@ -363,7 +405,7 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
 	reg->tx.stcr = CCSR_SSI_STCR_TFEN0;
 	reg->tx.scr = 0;
 
-	if (!ssi_private->imx_ac97) {
+	if (!fsl_ssi_is_ac97(ssi_private)) {
 		reg->rx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
 		reg->rx.sier |= CCSR_SSI_SIER_RFF0_EN;
 		reg->tx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
@@ -428,7 +470,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	unsigned long flags;
 
-	if (!dai->active && !ssi_private->imx_ac97) {
+	if (!dai->active && !fsl_ssi_is_ac97(ssi_private)) {
 		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
 		ssi_private->baudclk_locked = false;
 		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
@@ -494,7 +536,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	else
 		write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
 
-	if (!ssi_private->imx_ac97)
+	if (!fsl_ssi_is_ac97(ssi_private))
 		write_ssi_mask(&ssi->scr,
 				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
 				channels == 1 ? 0 : ssi_private->i2s_mode);
@@ -512,6 +554,8 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	u32 strcr = 0, stcr, srcr, scr, mask;
 	u8 wm;
 
+	ssi_private->dai_fmt = fmt;
+
 	fsl_ssi_setup_reg_vals(ssi_private);
 
 	scr = read_ssi(&ssi->scr) & ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
@@ -810,7 +854,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		else
 			fsl_ssi_rx_config(ssi_private, false);
 
-		if (!ssi_private->imx_ac97 && (read_ssi(&ssi->scr) &
+		if (!fsl_ssi_is_ac97(ssi_private) && (read_ssi(&ssi->scr) &
 					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0) {
 			spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
 			ssi_private->baudclk_locked = false;
@@ -822,7 +866,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
-	if (ssi_private->imx_ac97) {
+	if (fsl_ssi_is_ac97(ssi_private)) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
 		else
@@ -836,7 +880,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(dai);
 
-	if (ssi_private->ssi_on_imx && ssi_private->use_dma) {
+	if (fsl_ssi_on_imx(ssi_private) && ssi_private->use_dma) {
 		dai->playback_dma_data = &ssi_private->dma_params_tx;
 		dai->capture_dma_data = &ssi_private->dma_params_rx;
 	}
@@ -1114,7 +1158,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 				sizeof(fsl_ssi_ac97_dai));
 
 		fsl_ac97_data = ssi_private;
-		ssi_private->imx_ac97 = true;
 
 		snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
 	} else {
@@ -1163,36 +1206,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, ssi_private);
 
-	/*
-	 * imx51 and later SoCs have a slightly different IP that allows the
-	 * SSI configuration while the SSI unit is running.
-	 *
-	 * More important, it is necessary on those SoCs to configure the
-	 * sperate TX/RX DMA bits just before starting the stream
-	 * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
-	 * sends any DMA requests to the SDMA unit, otherwise it is not defined
-	 * how the SDMA unit handles the DMA request.
-	 *
-	 * SDMA units are present on devices starting at imx35 but the imx35
-	 * reference manual states that the DMA bits should not be changed
-	 * while the SSI unit is running (SSIEN). So we support the necessary
-	 * online configuration of fsl-ssi starting at imx51.
-	 */
-	switch (hw_type) {
-	case FSL_SSI_MCP8610:
-	case FSL_SSI_MX21:
-	case FSL_SSI_MX35:
-		ssi_private->offline_config = true;
-		break;
-	case FSL_SSI_MX51:
-		ssi_private->offline_config = false;
-		break;
-	}
-
-	if (hw_type == FSL_SSI_MX21 || hw_type == FSL_SSI_MX51 ||
-			hw_type == FSL_SSI_MX35) {
-		ssi_private->ssi_on_imx = true;
-
+	if (fsl_ssi_on_imx(ssi_private)) {
 		ret = fsl_ssi_imx_probe(pdev, ssi_private, ssi_private->ssi);
 		if (ret)
 			goto error_irqmap;
@@ -1207,7 +1221,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	if (ssi_private->use_dma) {
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
-					fsl_ssi_isr, 0, ssi_private->name,
+					fsl_ssi_isr, 0, dev_name(&pdev->dev),
 					ssi_private);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "could not claim irq %u\n",
@@ -1225,10 +1239,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	 * that the machine driver uses new binding which does not require
 	 * SSI driver to trigger machine driver's probe.
 	 */
-	if (!of_get_property(np, "codec-handle", NULL)) {
-		ssi_private->new_binding = true;
+	if (!of_get_property(np, "codec-handle", NULL))
 		goto done;
-	}
 
 	/* Trigger the machine driver's probe function.  The platform driver
 	 * name of the machine driver is taken from /compatible property of the
@@ -1261,9 +1273,8 @@ error_irq:
 	snd_soc_unregister_component(&pdev->dev);
 
 error_asoc_register:
-	if (ssi_private->ssi_on_imx) {
+	if (fsl_ssi_on_imx(ssi_private))
 		fsl_ssi_imx_clean(pdev, ssi_private);
-	}
 
 error_irqmap:
 	if (ssi_private->use_dma)
@@ -1278,11 +1289,11 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 
 	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
 
-	if (!ssi_private->new_binding)
+	if (ssi_private->pdev)
 		platform_device_unregister(ssi_private->pdev);
 	snd_soc_unregister_component(&pdev->dev);
 
-	if (ssi_private->ssi_on_imx)
+	if (fsl_ssi_on_imx(ssi_private))
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
 	if (ssi_private->use_dma)
-- 
1.9.0
