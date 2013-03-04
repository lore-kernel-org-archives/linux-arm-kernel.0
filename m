From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 04 Mar 2013 10:59:03 +0530
Subject: [PATCH] DMA: PL330: Add check if device tree compatible
Message-ID: <1362374943-29312-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch register the dma controller with generic dma helpers only
in DT case. This also adds some extra error handling in the driver.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Reported-by: Sachin Kamat <sachin.kamat@linaro.org>
---

Based on Vinod Koul next branch

 drivers/dma/pl330.c |   41 ++++++++++++++++++++++++++++++-----------
 1 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 7181531..bdad8de 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2882,7 +2882,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct dma_pl330_platdata *pdat;
 	struct dma_pl330_dmac *pdmac;
-	struct dma_pl330_chan *pch;
+	struct dma_pl330_chan *pch, *_p;
 	struct pl330_info *pi;
 	struct dma_device *pd;
 	struct resource *res;
@@ -2984,7 +2984,17 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	ret = dma_async_device_register(pd);
 	if (ret) {
 		dev_err(&adev->dev, "unable to register DMAC\n");
-		goto probe_err2;
+		goto probe_err3;
+	}
+
+	if (adev->dev.of_node) {
+		ret = of_dma_controller_register(adev->dev.of_node,
+					 of_dma_pl330_xlate, pdmac);
+		if (ret) {
+			dev_err(&adev->dev,
+			"unable to register DMA to the generic DT DMA helpers\n");
+			goto probe_err4;
+		}
 	}
 
 	dev_info(&adev->dev,
@@ -2995,16 +3005,23 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		pi->pcfg.data_bus_width / 8, pi->pcfg.num_chan,
 		pi->pcfg.num_peri, pi->pcfg.num_events);
 
-	ret = of_dma_controller_register(adev->dev.of_node,
-					 of_dma_pl330_xlate, pdmac);
-	if (ret) {
-		dev_err(&adev->dev,
-		"unable to register DMA to the generic DT DMA helpers\n");
-		goto probe_err2;
-	}
-
 	return 0;
+probe_err4:
+	dma_async_device_unregister(pd);
+probe_err3:
+	amba_set_drvdata(adev, NULL);
 
+	/* Idle the DMAC */
+	list_for_each_entry_safe(pch, _p, &pdmac->ddma.channels,
+			chan.device_node) {
+
+		/* Remove the channel */
+		list_del(&pch->chan.device_node);
+
+		/* Flush the channel */
+		pl330_control(&pch->chan, DMA_TERMINATE_ALL, 0);
+		pl330_free_chan_resources(&pch->chan);
+	}
 probe_err2:
 	pl330_del(pi);
 probe_err1:
@@ -3023,8 +3040,10 @@ static int pl330_remove(struct amba_device *adev)
 	if (!pdmac)
 		return 0;
 
-	of_dma_controller_free(adev->dev.of_node);
+	if (adev->dev.of_node)
+		of_dma_controller_free(adev->dev.of_node);
 
+	dma_async_device_unregister(&pdmac->ddma);
 	amba_set_drvdata(adev, NULL);
 
 	/* Idle the DMAC */
-- 
1.7.4.4
