From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 12:57:40 +0100
Subject: [PATCH v3 4/9] ASoC: fsl-ssi: Fix interrupt mapping and release
In-Reply-To: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387367865-26391-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

irqs should only be requested/released with enabled DMA and not on MX21.
MX21 has some special register write configurations, so we do not add
support for statistics on mx21 for the moment.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a889df5..c361730 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -150,6 +150,7 @@ struct fsl_ssi_private {
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct platform_device *pdev;
 
+	enum fsl_ssi_type hw_type;
 	bool new_binding;
 	bool ssi_on_imx;
 	bool imx_ac97;
@@ -227,13 +228,15 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 
 	if (sisr & CCSR_SSI_SISR_RFRC) {
 		ssi_private->stats.rfrc++;
-		sisr2 |= CCSR_SSI_SISR_RFRC;
+		if (ssi_private->hw_type != FSL_SSI_MX51)
+			sisr2 |= CCSR_SSI_SISR_RFRC;
 		ret = IRQ_HANDLED;
 	}
 
 	if (sisr & CCSR_SSI_SISR_TFRC) {
 		ssi_private->stats.tfrc++;
-		sisr2 |= CCSR_SSI_SISR_TFRC;
+		if (ssi_private->hw_type != FSL_SSI_MX51)
+			sisr2 |= CCSR_SSI_SISR_TFRC;
 		ret = IRQ_HANDLED;
 	}
 
@@ -925,6 +928,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ssi_private->use_dma = !of_property_read_bool(np,
 			"fsl,fiq-stream-filter");
+	ssi_private->hw_type = hw_type;
 
 	if (ac97) {
 		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_ac97_dai,
@@ -1030,7 +1034,14 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
 			dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
-	} else if (ssi_private->use_dma) {
+	}
+
+	/*
+	 * Enable interrupts only for MCP8610 and MX51. The other MXs have
+	 * different writeable interrupt status registers.
+	 */
+	if (ssi_private->use_dma &&
+			(hw_type == FSL_SSI_MCP8610 || hw_type == FSL_SSI_MX51)) {
 		/* The 'name' should not have any slashes in it. */
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
 					fsl_ssi_isr, 0, ssi_private->name,
@@ -1138,8 +1149,8 @@ error_clk:
 		clk_disable_unprepare(ssi_private->clk);
 
 error_irqmap:
-	if (ssi_private->use_dma && !of_device_is_compatible(pdev->dev.of_node,
-				"fsl,imx21-ssi"))
+	if (ssi_private->use_dma &&
+			(hw_type == FSL_SSI_MCP8610 || hw_type == FSL_SSI_MX51))
 		irq_dispose_mapping(ssi_private->irq);
 
 	return ret;
@@ -1156,7 +1167,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	snd_soc_unregister_component(&pdev->dev);
 	if (ssi_private->ssi_on_imx)
 		clk_disable_unprepare(ssi_private->clk);
-	irq_dispose_mapping(ssi_private->irq);
+	if (ssi_private->use_dma)
+		irq_dispose_mapping(ssi_private->irq);
 
 	return 0;
 }
-- 
1.8.5.1
