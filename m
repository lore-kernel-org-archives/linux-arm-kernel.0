From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 26 Feb 2014 17:02:08 +0100
Subject: [PATCH 05/15] ASoC: fsl-ssi: Move imx-specific probe to seperate
 function
In-Reply-To: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1393430538-32333-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move imx specific probe code to a seperate function. It reduces the
size of the probe() function and makes the code and error handling
easier to understand.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 183 ++++++++++++++++++++++++++----------------------
 1 file changed, 101 insertions(+), 82 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b3e3758..054813d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -973,6 +973,98 @@ static void make_lowercase(char *s)
 	}
 }
 
+static int fsl_ssi_imx_probe(struct platform_device *pdev,
+		struct fsl_ssi_private *ssi_private)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 dma_events[2], dmas[4];
+	bool shared;
+	int ret;
+
+	ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssi_private->clk)) {
+		ret = PTR_ERR(ssi_private->clk);
+		dev_err(&pdev->dev, "could not get clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(ssi_private->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "clk_prepare_enable failed: %d\n", ret);
+		return ret;
+	}
+
+	/* For those SLAVE implementations, we ingore non-baudclk cases
+	 * and, instead, abandon MASTER mode that needs baud clock.
+	 */
+	ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
+	if (IS_ERR(ssi_private->baudclk))
+		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
+			 PTR_ERR(ssi_private->baudclk));
+	else
+		clk_prepare_enable(ssi_private->baudclk);
+
+	/*
+	 * We have burstsize be "fifo_depth - 2" to match the SSI
+	 * watermark setting in fsl_ssi_startup().
+	 */
+	ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth - 2;
+	ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
+	ssi_private->dma_params_tx.addr = ssi_private->ssi_phys + CCSR_SSI_STX0;
+	ssi_private->dma_params_rx.addr = ssi_private->ssi_phys + CCSR_SSI_SRX0;
+	ssi_private->dma_params_tx.filter_data = &ssi_private->filter_data_tx;
+	ssi_private->dma_params_rx.filter_data = &ssi_private->filter_data_rx;
+
+	if (!of_property_read_bool(pdev->dev.of_node, "dmas") &&
+			ssi_private->use_dma) {
+		/*
+		 * FIXME: This is a temporary solution until all
+		 * necessary dma drivers support the generic dma
+		 * bindings.
+		 */
+		ret = of_property_read_u32_array(pdev->dev.of_node,
+				"fsl,ssi-dma-events", dma_events, 2);
+		if (ret && ssi_private->use_dma) {
+			dev_err(&pdev->dev, "could not get dma events but fsl-ssi is configured to use DMA\n");
+			goto error_dma_events;
+		}
+	}
+	/* Should this be merge with the above? */
+	if (!of_property_read_u32_array(pdev->dev.of_node, "dmas", dmas, 4)
+			&& dmas[2] == IMX_DMATYPE_SSI_DUAL) {
+		ssi_private->use_dual_fifo = true;
+		/* When using dual fifo mode, we need to keep watermark
+		 * as even numbers due to dma script limitation.
+		 */
+		ssi_private->dma_params_tx.maxburst &= ~0x1;
+		ssi_private->dma_params_rx.maxburst &= ~0x1;
+	}
+
+	shared = of_device_is_compatible(of_get_parent(np), "fsl,spba-bus");
+
+	imx_pcm_dma_params_init_data(&ssi_private->filter_data_tx,
+		dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
+	imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
+		dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
+
+	return 0;
+
+error_dma_events:
+	if (!IS_ERR(ssi_private->baudclk))
+		clk_disable_unprepare(ssi_private->baudclk);
+	clk_disable_unprepare(ssi_private->clk);
+
+	return ret;
+}
+
+static void fsl_ssi_imx_clean(struct platform_device *pdev,
+		struct fsl_ssi_private *ssi_private)
+{
+	if (!IS_ERR(ssi_private->baudclk))
+		clk_disable_unprepare(ssi_private->baudclk);
+	clk_disable_unprepare(ssi_private->clk);
+}
+
 static int fsl_ssi_probe(struct platform_device *pdev)
 {
 	struct fsl_ssi_private *ssi_private;
@@ -986,7 +1078,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct resource res;
 	void __iomem *iomem;
 	char name[64];
-	bool shared;
 	bool ac97 = false;
 
 	/* SSIs that are not connected on the board should have a
@@ -1108,80 +1199,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	if (hw_type == FSL_SSI_MX21 || hw_type == FSL_SSI_MX51 ||
 			hw_type == FSL_SSI_MX35) {
-		u32 dma_events[2], dmas[4];
 		ssi_private->ssi_on_imx = true;
 
-		ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
-		if (IS_ERR(ssi_private->clk)) {
-			ret = PTR_ERR(ssi_private->clk);
-			dev_err(&pdev->dev, "could not get clock: %d\n", ret);
+		ret = fsl_ssi_imx_probe(pdev, ssi_private);
+		if (ret)
 			goto error_irqmap;
-		}
-		ret = clk_prepare_enable(ssi_private->clk);
-		if (ret) {
-			dev_err(&pdev->dev, "clk_prepare_enable failed: %d\n",
-				ret);
-			goto error_irqmap;
-		}
-
-		/* For those SLAVE implementations, we ingore non-baudclk cases
-		 * and, instead, abandon MASTER mode that needs baud clock.
-		 */
-		ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
-		if (IS_ERR(ssi_private->baudclk))
-			dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
-				 PTR_ERR(ssi_private->baudclk));
-		else
-			clk_prepare_enable(ssi_private->baudclk);
-
-		/*
-		 * We have burstsize be "fifo_depth - 2" to match the SSI
-		 * watermark setting in fsl_ssi_startup().
-		 */
-		ssi_private->dma_params_tx.maxburst =
-			ssi_private->fifo_depth - 2;
-		ssi_private->dma_params_rx.maxburst =
-			ssi_private->fifo_depth - 2;
-		ssi_private->dma_params_tx.addr =
-			ssi_private->ssi_phys + CCSR_SSI_STX0;
-		ssi_private->dma_params_rx.addr =
-			ssi_private->ssi_phys + CCSR_SSI_SRX0;
-		ssi_private->dma_params_tx.filter_data =
-			&ssi_private->filter_data_tx;
-		ssi_private->dma_params_rx.filter_data =
-			&ssi_private->filter_data_rx;
-		if (!of_property_read_bool(pdev->dev.of_node, "dmas") &&
-				ssi_private->use_dma) {
-			/*
-			 * FIXME: This is a temporary solution until all
-			 * necessary dma drivers support the generic dma
-			 * bindings.
-			 */
-			ret = of_property_read_u32_array(pdev->dev.of_node,
-					"fsl,ssi-dma-events", dma_events, 2);
-			if (ret && ssi_private->use_dma) {
-				dev_err(&pdev->dev, "could not get dma events but fsl-ssi is configured to use DMA\n");
-				goto error_clk;
-			}
-		}
-		/* Should this be merge with the above? */
-		if (!of_property_read_u32_array(pdev->dev.of_node, "dmas", dmas, 4)
-				&& dmas[2] == IMX_DMATYPE_SSI_DUAL) {
-			ssi_private->use_dual_fifo = true;
-			/* When using dual fifo mode, we need to keep watermark
-			 * as even numbers due to dma script limitation.
-			 */
-			ssi_private->dma_params_tx.maxburst &= ~0x1;
-			ssi_private->dma_params_rx.maxburst &= ~0x1;
-		}
-
-		shared = of_device_is_compatible(of_get_parent(np),
-			    "fsl,spba-bus");
-
-		imx_pcm_dma_params_init_data(&ssi_private->filter_data_tx,
-			dma_events[0], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
-		imx_pcm_dma_params_init_data(&ssi_private->filter_data_rx,
-			dma_events[1], shared ? IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI);
 	}
 
 	/*
@@ -1196,7 +1218,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(&pdev->dev, "could not claim irq %u\n",
 					ssi_private->irq);
-			goto error_clk;
+			goto error_irq;
 		}
 	}
 
@@ -1289,11 +1311,9 @@ error_dbgfs:
 error_dev:
 	device_remove_file(&pdev->dev, dev_attr);
 
-error_clk:
+error_irq:
 	if (ssi_private->ssi_on_imx) {
-		if (!IS_ERR(ssi_private->baudclk))
-			clk_disable_unprepare(ssi_private->baudclk);
-		clk_disable_unprepare(ssi_private->clk);
+		fsl_ssi_imx_clean(pdev, ssi_private);
 	}
 
 error_irqmap:
@@ -1312,11 +1332,10 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (!ssi_private->new_binding)
 		platform_device_unregister(ssi_private->pdev);
 	snd_soc_unregister_component(&pdev->dev);
-	if (ssi_private->ssi_on_imx) {
-		if (!IS_ERR(ssi_private->baudclk))
-			clk_disable_unprepare(ssi_private->baudclk);
-		clk_disable_unprepare(ssi_private->clk);
-	}
+
+	if (ssi_private->ssi_on_imx)
+		fsl_ssi_imx_clean(pdev, ssi_private);
+
 	if (ssi_private->irq_stats)
 		irq_dispose_mapping(ssi_private->irq);
 
-- 
1.8.5.3
