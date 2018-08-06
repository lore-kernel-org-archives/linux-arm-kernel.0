From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:28 +0800
Subject: [PATCH v2 6/9] dmaengine: dma-jz4780: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-7-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	remove label err_unregister_dev

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/dma-jz4780.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 85820a2d69d4..b2a244902bc5 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -847,7 +847,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 		jzchan->vchan.desc_free = jz4780_dma_desc_free;
 	}
 
-	ret = dma_async_device_register(dd);
+	ret = dmaenginem_async_device_register(dd);
 	if (ret) {
 		dev_err(dev, "failed to register device\n");
 		goto err_disable_clk;
@@ -858,15 +858,12 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 					 jzdma);
 	if (ret) {
 		dev_err(dev, "failed to register OF DMA controller\n");
-		goto err_unregister_dev;
+		goto err_disable_clk;
 	}
 
 	dev_info(dev, "JZ4780 DMA controller initialised\n");
 	return 0;
 
-err_unregister_dev:
-	dma_async_device_unregister(dd);
-
 err_disable_clk:
 	clk_disable_unprepare(jzdma->clk);
 
@@ -887,7 +884,6 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 	for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
 		tasklet_kill(&jzdma->chan[i].vchan.task);
 
-	dma_async_device_unregister(&jzdma->dma_device);
 	return 0;
 }
 
-- 
2.17.1
