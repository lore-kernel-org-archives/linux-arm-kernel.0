From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 16:42:09 +0800
Subject: [PATCH 2/6] ASoC: mxs: use devm_clk_get for mxs_saif_probe
In-Reply-To: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_clk_get for mxs_saif_probe to ease the cleanup.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |   20 +++++++-------------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 40d0775..5192db6 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -658,7 +658,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	saif->clk = clk_get(&pdev->dev, NULL);
+	saif->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(saif->clk)) {
 		ret = PTR_ERR(saif->clk);
 		dev_err(&pdev->dev, "Cannot get the clock: %d\n",
@@ -671,25 +671,22 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 	saif->base = devm_request_and_ioremap(&pdev->dev, iores);
 	if (!saif->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENODEV;
-		goto failed_get_resource;
+		return -ENODEV;
 	}
 
 	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!dmares) {
-		ret = -ENODEV;
 		dev_err(&pdev->dev, "failed to get dma resource: %d\n",
 			ret);
-		goto failed_get_resource;
+		return -ENODEV;
 	}
 	saif->dma_param.chan_num = dmares->start;
 
 	saif->irq = platform_get_irq(pdev, 0);
 	if (saif->irq < 0) {
-		ret = saif->irq;
 		dev_err(&pdev->dev, "failed to get irq resource: %d\n",
 			ret);
-		goto failed_get_resource;
+		return saif->irq;
 	}
 
 	saif->dev = &pdev->dev;
@@ -697,7 +694,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 			       "mxs-saif", saif);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		goto failed_get_resource;
+		return ret;
 	}
 
 	saif->dma_param.chan_irq = platform_get_irq(pdev, 1);
@@ -705,7 +702,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 		ret = saif->dma_param.chan_irq;
 		dev_err(&pdev->dev, "failed to get dma irq resource: %d\n",
 			ret);
-		goto failed_get_resource;
+		return saif->dma_param.chan_irq;
 	}
 
 	platform_set_drvdata(pdev, saif);
@@ -713,7 +710,7 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
 	ret = snd_soc_register_dai(&pdev->dev, &mxs_saif_dai);
 	if (ret) {
 		dev_err(&pdev->dev, "register DAI failed\n");
-		goto failed_get_resource;
+		return ret;
 	}
 
 	saif->soc_platform_pdev = platform_device_alloc(
@@ -736,8 +733,6 @@ failed_pdev_add:
 	platform_device_put(saif->soc_platform_pdev);
 failed_pdev_alloc:
 	snd_soc_unregister_dai(&pdev->dev);
-failed_get_resource:
-	clk_put(saif->clk);
 
 	return ret;
 }
@@ -748,7 +743,6 @@ static int __devexit mxs_saif_remove(struct platform_device *pdev)
 
 	platform_device_unregister(saif->soc_platform_pdev);
 	snd_soc_unregister_dai(&pdev->dev);
-	clk_put(saif->clk);
 
 	return 0;
 }
-- 
1.7.5.4
