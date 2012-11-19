From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:41 +0100
Subject: [PATCH 03/30] dma: mv_xor: split initialization/cleanup of XOR
 channels
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of doing the initialization/cleanup of the XOR channels
directly in the ->probe() and ->remove() hooks, we create separate
utility functions mv_xor_channel_add() and mv_xor_channel_remove().

This will allow to easily introduce in a future patch a different way
of registering XOR channels: instead of having one platform_device per
channel, we'll trigger the registration of all XOR channels of a given
XOR engine directly from the XOR engine ->probe() function.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   75 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 7042772..f7b9919 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1077,19 +1077,18 @@ out:
 	return err;
 }
 
-static int __devexit mv_xor_remove(struct platform_device *dev)
+static int mv_xor_channel_remove(struct mv_xor_device *device)
 {
-	struct mv_xor_device *device = platform_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 	struct mv_xor_chan *mv_chan;
 
 	dma_async_device_unregister(&device->common);
 
-	dma_free_coherent(&dev->dev, device->pool_size,
-			device->dma_desc_pool_virt, device->dma_desc_pool);
+	dma_free_coherent(&device->pdev->dev, device->pool_size,
+			  device->dma_desc_pool_virt, device->dma_desc_pool);
 
 	list_for_each_entry_safe(chan, _chan, &device->common.channels,
-				device_node) {
+				 device_node) {
 		mv_chan = to_mv_xor_chan(chan);
 		list_del(&chan->device_node);
 	}
@@ -1097,19 +1096,20 @@ static int __devexit mv_xor_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int __devinit mv_xor_probe(struct platform_device *pdev)
+static struct mv_xor_device *
+mv_xor_channel_add(struct mv_xor_shared_private *msp,
+		   struct platform_device *pdev,
+		   int hw_id, dma_cap_mask_t cap_mask,
+		   size_t pool_size, int irq)
 {
 	int ret = 0;
-	int irq;
 	struct mv_xor_device *adev;
 	struct mv_xor_chan *mv_chan;
 	struct dma_device *dma_dev;
-	struct mv_xor_platform_data *plat_data = pdev->dev.platform_data;
-
 
 	adev = devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
 	if (!adev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dma_dev = &adev->common;
 
@@ -1117,22 +1117,20 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 	 * note: writecombine gives slightly better performance, but
 	 * requires that we explicitly flush the writes
 	 */
-	adev->pool_size = plat_data->pool_size;
+	adev->pool_size = pool_size;
 	adev->dma_desc_pool_virt = dma_alloc_writecombine(&pdev->dev,
 							  adev->pool_size,
 							  &adev->dma_desc_pool,
 							  GFP_KERNEL);
 	if (!adev->dma_desc_pool_virt)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	adev->id = plat_data->hw_id;
+	adev->id = hw_id;
 
 	/* discover transaction capabilites from the platform data */
-	dma_dev->cap_mask = plat_data->cap_mask;
+	dma_dev->cap_mask = cap_mask;
 	adev->pdev = pdev;
-	platform_set_drvdata(pdev, adev);
-
-	adev->shared = platform_get_drvdata(plat_data->shared);
+	adev->shared = msp;
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
@@ -1159,7 +1157,7 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 		goto err_free_dma;
 	}
 	mv_chan->device = adev;
-	mv_chan->idx = plat_data->hw_id;
+	mv_chan->idx = hw_id;
 	mv_chan->mmr_base = adev->shared->xor_base;
 
 	if (!mv_chan->mmr_base) {
@@ -1172,11 +1170,6 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 	/* clear errors before enabling interrupts */
 	mv_xor_device_clear_err_status(mv_chan);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_free_dma;
-	}
 	ret = devm_request_irq(&pdev->dev, irq,
 			       mv_xor_interrupt_handler,
 			       0, dev_name(&pdev->dev), mv_chan);
@@ -1218,13 +1211,41 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 	  dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
 
 	dma_async_device_register(dma_dev);
-	goto out;
+	return adev;
 
  err_free_dma:
-	dma_free_coherent(&adev->pdev->dev, plat_data->pool_size,
+	dma_free_coherent(&adev->pdev->dev, pool_size,
 			adev->dma_desc_pool_virt, adev->dma_desc_pool);
- out:
-	return ret;
+	return ERR_PTR(ret);
+}
+
+static int __devexit mv_xor_remove(struct platform_device *pdev)
+{
+	struct mv_xor_device *device = platform_get_drvdata(pdev);
+	return mv_xor_channel_remove(device);
+}
+
+static int __devinit mv_xor_probe(struct platform_device *pdev)
+{
+	struct mv_xor_platform_data *plat_data = pdev->dev.platform_data;
+	struct mv_xor_shared_private *msp =
+		platform_get_drvdata(plat_data->shared);
+	struct mv_xor_device *mv_xor_device;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	mv_xor_device = mv_xor_channel_add(msp, pdev, plat_data->hw_id,
+					   plat_data->cap_mask,
+					   plat_data->pool_size, irq);
+	if (IS_ERR(mv_xor_device))
+		return PTR_ERR(mv_xor_device);
+
+	platform_set_drvdata(pdev, mv_xor_device);
+
+	return 0;
 }
 
 static void
-- 
1.7.9.5
