From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:26 +0800
Subject: [PATCH v2 4/9] dmaengine: mmp_tdma: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180806085231.4597-5-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dmaenginem_async_device_register to simplify the code:
	remove dma_async_device_unregister.
	return error if it fails.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 drivers/dma/mmp_tdma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 13c68b6434ce..9f5869e1a017 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -530,9 +530,6 @@ static void mmp_tdma_issue_pending(struct dma_chan *chan)
 
 static int mmp_tdma_remove(struct platform_device *pdev)
 {
-	struct mmp_tdma_device *tdev = platform_get_drvdata(pdev);
-
-	dma_async_device_unregister(&tdev->device);
 	return 0;
 }
 
@@ -696,7 +693,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	platform_set_drvdata(pdev, tdev);
 
-	ret = dma_async_device_register(&tdev->device);
+	ret = dmaenginem_async_device_register(&tdev->device);
 	if (ret) {
 		dev_err(tdev->device.dev, "unable to register\n");
 		return ret;
@@ -708,7 +705,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(tdev->device.dev,
 				"failed to register controller\n");
-			dma_async_device_unregister(&tdev->device);
+			return ret;
 		}
 	}
 
-- 
2.17.1
