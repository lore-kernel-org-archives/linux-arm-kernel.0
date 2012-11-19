From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:56 +0100
Subject: [PATCH 18/30] dma: mv_xor: get rid of the pdev pointer in
 mv_xor_device
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-19-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was only used in places where we could get the 'struct device *'
pointer through a different way.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    9 ++++-----
 drivers/dma/mv_xor.h |    1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 38dac0d..6e705ea 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -308,8 +308,7 @@ mv_xor_run_tx_complete_actions(struct mv_xor_desc_slot *desc,
 		 */
 		if (desc->group_head && desc->unmap_len) {
 			struct mv_xor_desc_slot *unmap = desc->group_head;
-			struct device *dev =
-				&mv_chan->device->pdev->dev;
+			struct device *dev = mv_chan_to_devp(mv_chan);
 			u32 len = unmap->unmap_len;
 			enum dma_ctrl_flags flags = desc->async_tx.flags;
 			u32 src_cnt;
@@ -1077,10 +1076,11 @@ static int mv_xor_channel_remove(struct mv_xor_device *device)
 {
 	struct dma_chan *chan, *_chan;
 	struct mv_xor_chan *mv_chan;
+	struct device *dev = device->common.dev;
 
 	dma_async_device_unregister(&device->common);
 
-	dma_free_coherent(&device->pdev->dev, device->pool_size,
+	dma_free_coherent(dev, device->pool_size,
 			  device->dma_desc_pool_virt, device->dma_desc_pool);
 
 	list_for_each_entry_safe(chan, _chan, &device->common.channels,
@@ -1123,7 +1123,6 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 
 	/* discover transaction capabilites from the platform data */
 	dma_dev->cap_mask = cap_mask;
-	adev->pdev = pdev;
 	adev->shared = msp;
 
 	INIT_LIST_HEAD(&dma_dev->channels);
@@ -1208,7 +1207,7 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 	return adev;
 
  err_free_dma:
-	dma_free_coherent(&adev->pdev->dev, pool_size,
+	dma_free_coherent(&pdev->dev, pool_size,
 			adev->dma_desc_pool_virt, adev->dma_desc_pool);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 52ca617..05add24 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -70,7 +70,6 @@ struct mv_xor_private {
  * @common: embedded struct dma_device
  */
 struct mv_xor_device {
-	struct platform_device		*pdev;
 	dma_addr_t			dma_desc_pool;
 	void				*dma_desc_pool_virt;
 	size_t                          pool_size;
-- 
1.7.9.5
