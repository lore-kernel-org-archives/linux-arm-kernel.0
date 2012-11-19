From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:04:40 +0100
Subject: [PATCH 02/30] dma: mv_xor: do not use pool_size from platform_data
 within the driver
In-Reply-To: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353319508-30566-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353319508-30566-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver currently pokes into the platform_data structure during its
normal operation to get the pool_size value. Poking into the
platform_data structure is not nice when moving to the Device Tree, so
this commit adds a new pool_size field in the mv_xor_device structure,
which gets initialized at ->probe() time. The driver then uses this
field instead of the platform_data.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |   10 ++++------
 drivers/dma/mv_xor.h |    1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 610d0b8..7042772 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -604,9 +604,7 @@ static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
 	int idx;
 	struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
 	struct mv_xor_desc_slot *slot = NULL;
-	struct mv_xor_platform_data *plat_data =
-		mv_chan->device->pdev->dev.platform_data;
-	int num_descs_in_pool = plat_data->pool_size/MV_XOR_SLOT_SIZE;
+	int num_descs_in_pool = mv_chan->device->pool_size/MV_XOR_SLOT_SIZE;
 
 	/* Allocate descriptor slots */
 	idx = mv_chan->slots_allocated;
@@ -1084,11 +1082,10 @@ static int __devexit mv_xor_remove(struct platform_device *dev)
 	struct mv_xor_device *device = platform_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 	struct mv_xor_chan *mv_chan;
-	struct mv_xor_platform_data *plat_data = dev->dev.platform_data;
 
 	dma_async_device_unregister(&device->common);
 
-	dma_free_coherent(&dev->dev, plat_data->pool_size,
+	dma_free_coherent(&dev->dev, device->pool_size,
 			device->dma_desc_pool_virt, device->dma_desc_pool);
 
 	list_for_each_entry_safe(chan, _chan, &device->common.channels,
@@ -1120,8 +1117,9 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 	 * note: writecombine gives slightly better performance, but
 	 * requires that we explicitly flush the writes
 	 */
+	adev->pool_size = plat_data->pool_size;
 	adev->dma_desc_pool_virt = dma_alloc_writecombine(&pdev->dev,
-							  plat_data->pool_size,
+							  adev->pool_size,
 							  &adev->dma_desc_pool,
 							  GFP_KERNEL);
 	if (!adev->dma_desc_pool_virt)
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index a5b422f..a0641ae 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -72,6 +72,7 @@ struct mv_xor_device {
 	int				id;
 	dma_addr_t			dma_desc_pool;
 	void				*dma_desc_pool_virt;
+	size_t                          pool_size;
 	struct dma_device		common;
 	struct mv_xor_shared_private	*shared;
 };
-- 
1.7.9.5
