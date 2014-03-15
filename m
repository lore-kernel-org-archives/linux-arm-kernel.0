From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 15 Mar 2014 13:44:14 +0100
Subject: [PATCH v2 06/16] ASoC: fsl-ssi: Remove useless DMA code
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1394887464-969-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify dma DT property handling. fsl,ssi-dma-events is not used
anymore. It passes invalid data to imx_pcm_dma_params_init_data() which
copies some data into an imx dma struct. This struct is never used in
imx-dma or imx-sdma because of generic OF DMA handling. The
"fsl,ssi-dma-events" is not used anywhere in dts files.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b28f874..fcc73d3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -168,8 +168,6 @@ struct fsl_ssi_private {
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	struct imx_dma_data filter_data_tx;
-	struct imx_dma_data filter_data_rx;
 	struct imx_pcm_fiq_params fiq_params;
 	/* Register values for rx/tx configuration */
 	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
@@ -966,8 +964,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		struct fsl_ssi_private *ssi_private)
 {
 	struct device_node *np = pdev->dev.of_node;
-	u32 dma_events[2], dmas[4];
-	bool shared;
+	u32 dmas[4];
 	int ret;
 
 	ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
@@ -1003,26 +1000,9 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 			offsetof(struct ccsr_ssi, stx0);
 	ssi_private->dma_params_rx.addr = ssi_private->ssi_phys +
 			offsetof(struct ccsr_ssi, srx0);
-	ssi_private->dma_params_tx.filter_data = &ssi_private->filter_data_tx;
-	ssi_private->dma_params_rx.filter_data = &ssi_private->filter_data_rx;
 
-	if (!of_property_read_bool(pdev->dev.of_node, "dmas") &&
-			ssi_private->use_dma) {
-		/*
-		 * FIXME: This is a temporary solution until all
-		 * necessary dma drivers support the generic dma
-		 * bindings.
-		 */
-		ret = of_property_read_u32_array(pdev->dev.of_node,
-				"fsl,ssi-dma-events", dma_events, 2);
-		if (ret && ssi_private->use_dma) {
-			dev_err(&pdev->dev, "could not get dma events but fsl-ssi is configured to use DMA\n");
-			goto error_dma_events;
-		}
-	}
-	/* Should this be merge with the above? */
-	if (!of_property_read_u32_array(pdev->dev.of_node, "dmas", dmas, 4)
-			&& dmas[2] == IMX_DMATYPE_SSI_DUAL) {
+	ret = !of_property_read_u32_array(np, "dmas", dmas, 4);
+	if (ssi_private->use_dma && !ret && dmas[2] == IMX_DMATYPE_SSI_DUAL) {
 		ssi_private->use_dual_fifo = true;
 		/* When using dual fifo mode, we need to keep watermark
 		 * as even numbers due to dma script limitation.
@@ -1031,21 +1011,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		ssi_private->dma_params_rx.maxburst &= ~0x1;
 	}
 
-	shared = of_device_is_compatible(of_get_parent(np), "fsl,spba-bus");
-
-	imx_pcm_dma_params_init_data(&ssi_private->filter_data_tx,
-		dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
-	imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
-		dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
-
 	return 0;
-
-error_dma_events:
-	if (!IS_ERR(ssi_private->baudclk))
-		clk_disable_unprepare(ssi_private->baudclk);
-	clk_disable_unprepare(ssi_private->clk);
-
-	return ret;
 }
 
 static void fsl_ssi_imx_clean(struct platform_device *pdev,
-- 
1.9.0
