From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:25 +0800
Subject: [PATCH v2 3/9] dmaengine: st_fdma: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-4-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/st_fdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index bfb79bd0c6de..7eafccd4f7f5 100644
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
@@ -852,7 +852,6 @@ static int st_fdma_probe(struct platform_device *pdev)
 	return 0;
 
 err_dma_dev:
-	dma_async_device_unregister(&fdev->dma_device);
 err_rproc:
 	st_fdma_free(fdev);
 	st_slim_rproc_put(fdev->slim_rproc);
@@ -867,7 +866,6 @@ static int st_fdma_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, fdev->irq, fdev);
 	st_slim_rproc_put(fdev->slim_rproc);
 	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&fdev->dma_device);
 
 	return 0;
 }
-- 
2.17.1
