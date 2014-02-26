From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 26 Feb 2014 17:02:09 +0100
Subject: [PATCH 06/15] ASoC: fsl-ssi: Remove useless DMA code
In-Reply-To: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1393430538-32333-7-git-send-email-mpa@pengutronix.de>
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
index 054813d..43d4342 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -157,8 +157,6 @@ struct fsl_ssi_private {
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	struct imx_dma_data filter_data_tx;
-	struct imx_dma_data filter_data_rx;
 	struct imx_pcm_fiq_params fiq_params;
 	/* Register values for rx/tx configuration */
 	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
@@ -977,8 +975,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		struct fsl_ssi_private *ssi_private)
 {
 	struct device_node *np = pdev->dev.of_node;
-	u32 dma_events[2], dmas[4];
-	bool shared;
+	u32 dmas[4];
 	int ret;
 
 	ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
@@ -1012,26 +1009,9 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
 	ssi_private->dma_params_tx.addr = ssi_private->ssi_phys + CCSR_SSI_STX0;
 	ssi_private->dma_params_rx.addr = ssi_private->ssi_phys + CCSR_SSI_SRX0;
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
@@ -1040,21 +1020,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
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
1.8.5.3
