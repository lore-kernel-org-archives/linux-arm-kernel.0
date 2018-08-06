From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 17:43:28 +0800
Subject: [PATCH V2 fix] dmaengine: st_fdma: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-4-sjhuang@iluvatar.ai>
References: <20180806085231.4597-4-sjhuang@iluvatar.ai>
Message-ID: <20180806094328.15483-1-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_dma_dev

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
Remove the label err_dma_dev
---
 drivers/dma/st_fdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index bfb79bd0c6de..07c20aa2e955 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -833,7 +833,7 @@ static int st_fdma_probe(struct platform_device *pdev)
 	fdev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	fdev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
-	ret = dma_async_device_register(&fdev->dma_device);
+	ret = dmaenginem_async_device_register(&fdev->dma_device);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Failed to register DMA device (%d)\n", ret);
@@ -844,15 +844,13 @@ static int st_fdma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Failed to register controller (%d)\n", ret);
-		goto err_dma_dev;
+		goto err_rproc;
 	}
 
 	dev_info(&pdev->dev, "ST FDMA engine driver, irq:%d\n", fdev->irq);
 
 	return 0;
 
-err_dma_dev:
-	dma_async_device_unregister(&fdev->dma_device);
 err_rproc:
 	st_fdma_free(fdev);
 	st_slim_rproc_put(fdev->slim_rproc);
@@ -867,7 +865,6 @@ static int st_fdma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, fdev->irq, fdev);
 	st_slim_rproc_put(fdev->slim_rproc);
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&fdev->dma_device);
 
 	return 0;
 }
-- 
2.17.1
