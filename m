From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 26 Feb 2014 17:02:11 +0100
Subject: [PATCH 08/15] ASoC: fsl-ssi: Cleanup probe function
In-Reply-To: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1393430538-32333-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reorder the probe function to be able to move the second imx-specific
block to the seperate imx probe function. The patch also removes some
comments/variables/code that are not used anymore or could be simply
replaced by other variables.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 110 +++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 61 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 64d188f..59e35a4 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -149,7 +149,6 @@ struct fsl_ssi_private {
 	bool imx_ac97;
 	bool use_dma;
 	bool baudclk_locked;
-	bool irq_stats;
 	bool offline_config;
 	bool use_dual_fifo;
 	spinlock_t baudclk_lock;
@@ -972,7 +971,7 @@ static void make_lowercase(char *s)
 }
 
 static int fsl_ssi_imx_probe(struct platform_device *pdev,
-		struct fsl_ssi_private *ssi_private)
+		struct fsl_ssi_private *ssi_private, void __iomem *iomem)
 {
 	struct device_node *np = pdev->dev.of_node;
 	u32 dmas[4];
@@ -1028,8 +1027,37 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		ssi_private->dma_params_rx.maxburst &= ~0x1;
 	}
 
+	if (!ssi_private->use_dma) {
+
+		/*
+		 * Some boards use an incompatible codec. To get it
+		 * working, we are using imx-fiq-pcm-audio, that
+		 * can handle those codecs. DMA is not possible in this
+		 * situation.
+		 */
+
+		ssi_private->fiq_params.irq = ssi_private->irq;
+		ssi_private->fiq_params.base = iomem;
+		ssi_private->fiq_params.dma_params_rx =
+			&ssi_private->dma_params_rx;
+		ssi_private->fiq_params.dma_params_tx =
+			&ssi_private->dma_params_tx;
+
+		ret = imx_pcm_fiq_init(pdev, &ssi_private->fiq_params);
+		if (ret)
+			goto error_pcm;
+	} else {
+		ret = imx_pcm_dma_init(pdev);
+		if (ret)
+			goto error_pcm;
+	}
+
 	return 0;
 
+error_pcm:
+	if (!IS_ERR(ssi_private->baudclk))
+		clk_disable_unprepare(ssi_private->baudclk);
+
 error_baud_clk:
 	clk_disable_unprepare(ssi_private->clk);
 
@@ -1039,6 +1067,8 @@ error_baud_clk:
 static void fsl_ssi_imx_clean(struct platform_device *pdev,
 		struct fsl_ssi_private *ssi_private)
 {
+	if (!ssi_private->use_dma)
+		imx_pcm_fiq_exit(pdev);
 	if (!IS_ERR(ssi_private->baudclk))
 		clk_disable_unprepare(ssi_private->baudclk);
 	clk_disable_unprepare(ssi_private->clk);
@@ -1048,7 +1078,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 {
 	struct fsl_ssi_private *ssi_private;
 	int ret = 0;
-	struct device_attribute *dev_attr = NULL;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id;
 	enum fsl_ssi_type hw_type;
@@ -1150,6 +1179,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi_private->baudclk_locked = false;
 	spin_lock_init(&ssi_private->baudclk_lock);
 
+	dev_set_drvdata(&pdev->dev, ssi_private);
+
 	/*
 	 * imx51 and later SoCs have a slightly different IP that allows the
 	 * SSI configuration while the SSI unit is running.
@@ -1180,20 +1211,22 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			hw_type == FSL_SSI_MX35) {
 		ssi_private->ssi_on_imx = true;
 
-		ret = fsl_ssi_imx_probe(pdev, ssi_private);
+		ret = fsl_ssi_imx_probe(pdev, ssi_private, iomem);
 		if (ret)
 			goto error_irqmap;
 	}
 
-	/*
-	 * Enable interrupts only for MCP8610 and MX51. The other MXs have
-	 * different writeable interrupt status registers.
-	 */
+	ret = snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
+					 &ssi_private->cpu_dai_drv, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
+		goto error_asoc_register;
+	}
+
 	if (ssi_private->use_dma) {
 		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
 					fsl_ssi_isr, 0, ssi_private->name,
 					ssi_private);
-		ssi_private->irq_stats = true;
 		if (ret < 0) {
 			dev_err(&pdev->dev, "could not claim irq %u\n",
 					ssi_private->irq);
@@ -1201,47 +1234,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Register with ASoC */
-	dev_set_drvdata(&pdev->dev, ssi_private);
-
-	ret = snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
-					 &ssi_private->cpu_dai_drv, 1);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
-		goto error_dev;
-	}
-
 	ret = fsl_ssi_debugfs_create(&ssi_private->dbg_stats, &pdev->dev);
 	if (ret)
-		goto error_dbgfs;
-
-
-	if (ssi_private->ssi_on_imx) {
-		if (!ssi_private->use_dma) {
-
-			/*
-			 * Some boards use an incompatible codec. To get it
-			 * working, we are using imx-fiq-pcm-audio, that
-			 * can handle those codecs. DMA is not possible in this
-			 * situation.
-			 */
-
-			ssi_private->fiq_params.irq = ssi_private->irq;
-			ssi_private->fiq_params.base = iomem;
-			ssi_private->fiq_params.dma_params_rx =
-				&ssi_private->dma_params_rx;
-			ssi_private->fiq_params.dma_params_tx =
-				&ssi_private->dma_params_tx;
-
-			ret = imx_pcm_fiq_init(pdev, &ssi_private->fiq_params);
-			if (ret)
-				goto error_pcm;
-		} else {
-			ret = imx_pcm_dma_init(pdev);
-			if (ret)
-				goto error_pcm;
-		}
-	}
+		goto error_asoc_register;
 
 	/*
 	 * If codec-handle property is missing from SSI node, we assume
@@ -1271,32 +1266,25 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (IS_ERR(ssi_private->pdev)) {
 		ret = PTR_ERR(ssi_private->pdev);
 		dev_err(&pdev->dev, "failed to register platform: %d\n", ret);
-		goto error_dai;
+		goto error_sound_card;
 	}
 
 done:
 	return 0;
 
-error_dai:
-	if (ssi_private->ssi_on_imx && !ssi_private->use_dma)
-		imx_pcm_fiq_exit(pdev);
-
-error_pcm:
+error_sound_card:
 	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
 
-error_dbgfs:
+error_irq:
 	snd_soc_unregister_component(&pdev->dev);
 
-error_dev:
-	device_remove_file(&pdev->dev, dev_attr);
-
-error_irq:
+error_asoc_register:
 	if (ssi_private->ssi_on_imx) {
 		fsl_ssi_imx_clean(pdev, ssi_private);
 	}
 
 error_irqmap:
-	if (ssi_private->irq_stats)
+	if (ssi_private->use_dma)
 		irq_dispose_mapping(ssi_private->irq);
 
 	return ret;
@@ -1315,7 +1303,7 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->ssi_on_imx)
 		fsl_ssi_imx_clean(pdev, ssi_private);
 
-	if (ssi_private->irq_stats)
+	if (ssi_private->use_dma)
 		irq_dispose_mapping(ssi_private->irq);
 
 	return 0;
-- 
1.8.5.3
