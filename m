From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:58 +0100
Subject: [PATCH 20/30] dma: mv_xor: in mv_xor_device,
 rename 'common' to 'dmadev'
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-21-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv_xor_device structure embeds a 'struct dma_device', which is
named 'common', a not very meaningful name. Rename it to 'dmadev',
which will help avoid confusions later as we merge the mv_xor_device
and mv_xor_chan structures together.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   14 +++++++-------
 drivers/dma/mv_xor.h |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 491f506..a64e30e 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -40,7 +40,7 @@ static void mv_xor_issue_pending(struct dma_chan *chan);
 	container_of(tx, struct mv_xor_desc_slot, async_tx)
 
 #define mv_chan_to_devp(chan)           \
-	((chan)->device->common.dev)
+	((chan)->device->dmadev.dev)
 
 static void mv_desc_init(struct mv_xor_desc_slot *desc, unsigned long flags)
 {
@@ -923,7 +923,7 @@ static int __devinit mv_xor_memcpy_self_test(struct mv_xor_device *device)
 		((u8 *) src)[i] = (u8)i;
 
 	/* Start copy, using first DMA channel */
-	dma_chan = container_of(device->common.channels.next,
+	dma_chan = container_of(device->dmadev.channels.next,
 				struct dma_chan,
 				device_node);
 	if (mv_xor_alloc_chan_resources(dma_chan) < 1) {
@@ -1016,7 +1016,7 @@ mv_xor_xor_self_test(struct mv_xor_device *device)
 
 	memset(page_address(dest), 0, PAGE_SIZE);
 
-	dma_chan = container_of(device->common.channels.next,
+	dma_chan = container_of(device->dmadev.channels.next,
 				struct dma_chan,
 				device_node);
 	if (mv_xor_alloc_chan_resources(dma_chan) < 1) {
@@ -1076,14 +1076,14 @@ static int mv_xor_channel_remove(struct mv_xor_device *device)
 {
 	struct dma_chan *chan, *_chan;
 	struct mv_xor_chan *mv_chan;
-	struct device *dev = device->common.dev;
+	struct device *dev = device->dmadev.dev;
 
-	dma_async_device_unregister(&device->common);
+	dma_async_device_unregister(&device->dmadev);
 
 	dma_free_coherent(dev, device->pool_size,
 			  device->dma_desc_pool_virt, device->dma_desc_pool);
 
-	list_for_each_entry_safe(chan, _chan, &device->common.channels,
+	list_for_each_entry_safe(chan, _chan, &device->dmadev.channels,
 				 device_node) {
 		mv_chan = to_mv_xor_chan(chan);
 		list_del(&chan->device_node);
@@ -1107,7 +1107,7 @@ mv_xor_channel_add(struct mv_xor_private *msp,
 	if (!adev)
 		return ERR_PTR(-ENOMEM);
 
-	dma_dev = &adev->common;
+	dma_dev = &adev->dmadev;
 
 	/* allocate coherent memory for hardware descriptors
 	 * note: writecombine gives slightly better performance, but
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index ad18f64..84255e6 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -73,7 +73,7 @@ struct mv_xor_device {
 	dma_addr_t			dma_desc_pool;
 	void				*dma_desc_pool_virt;
 	size_t                          pool_size;
-	struct dma_device		common;
+	struct dma_device		dmadev;
 	struct mv_xor_private	        *shared;
 };
 
-- 
1.7.9.5
