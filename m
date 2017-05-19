From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 19 May 2017 15:06:44 +0100
Subject: [PATCH] dmaengine: pl330: Add IOMMU support to slave tranfers
Message-ID: <c10016eb9d96d80afcacf547b8a9ec47c6a4cb21.1495202642.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire up dma_map_resource() for slave transfers, so that we can let the
PL330 use IOMMU-backed DMA mapping ops on systems with an appropriate
IOMMU and RAM above 4GB, to avoid CPU bounce buffering.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/dma/pl330.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 8b0da7fa520d..a9451a14ad07 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -443,7 +443,10 @@ struct dma_pl330_chan {
 	/* For D-to-M and M-to-D channels */
 	int burst_sz; /* the peripheral fifo width */
 	int burst_len; /* the number of burst */
-	dma_addr_t fifo_addr;
+	phys_addr_t fifo_addr;
+	/* DMA-mapped view of the FIFO; may differ if an IOMMU is present */
+	dma_addr_t fifo_dma;
+	enum dma_data_direction dir;
 
 	/* for cyclic capability */
 	bool cyclic;
@@ -2120,11 +2123,60 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 	return 1;
 }
 
+/*
+ * We need the data direction between the DMAC (the dma-mapping "device") and
+ * the FIFO (the dmaengine "dev"), from the FIFO's point of view. Confusing!
+ */
+static enum dma_data_direction
+pl330_dma_slave_map_dir(enum dma_transfer_direction dir)
+{
+	switch (dir) {
+	case DMA_MEM_TO_DEV:
+		return DMA_FROM_DEVICE;
+	case DMA_DEV_TO_MEM:
+		return DMA_TO_DEVICE;
+	case DMA_DEV_TO_DEV:
+		return DMA_BIDIRECTIONAL;
+	default:
+		return DMA_NONE;
+	}
+}
+
+static void pl330_unprep_slave_fifo(struct dma_pl330_chan *pch)
+{
+	if (pch->dir != DMA_NONE)
+		dma_unmap_resource(pch->chan.device->dev, pch->fifo_dma,
+				   1 << pch->burst_sz, pch->dir, 0);
+	pch->dir = DMA_NONE;
+}
+
+
+static bool pl330_prep_slave_fifo(struct dma_pl330_chan *pch,
+				  enum dma_transfer_direction dir)
+{
+	struct device *dev = pch->chan.device->dev;
+	enum dma_data_direction dma_dir = pl330_dma_slave_map_dir(dir);
+
+	/* Already mapped for this config? */
+	if (pch->dir == dma_dir)
+		return true;
+
+	pl330_unprep_slave_fifo(pch);
+	pch->fifo_dma = dma_map_resource(dev, pch->fifo_addr,
+					 1 << pch->burst_sz, dma_dir, 0);
+	if (dma_mapping_error(dev, pch->fifo_dma))
+		return false;
+
+	pch->dir = dma_dir;
+	return true;
+}
+
 static int pl330_config(struct dma_chan *chan,
 			struct dma_slave_config *slave_config)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 
+	pl330_unprep_slave_fifo(pch);
 	if (slave_config->direction == DMA_MEM_TO_DEV) {
 		if (slave_config->dst_addr)
 			pch->fifo_addr = slave_config->dst_addr;
@@ -2235,6 +2287,7 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	spin_unlock_irqrestore(&pl330->lock, flags);
 	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
 	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
+	pl330_unprep_slave_fifo(pch);
 }
 
 static int pl330_get_current_xferred_count(struct dma_pl330_chan *pch,
@@ -2564,6 +2617,9 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 		return NULL;
 	}
 
+	if (!pl330_prep_slave_fifo(pch, direction))
+		return NULL;
+
 	for (i = 0; i < len / period_len; i++) {
 		desc = pl330_get_desc(pch);
 		if (!desc) {
@@ -2593,12 +2649,12 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 			desc->rqcfg.src_inc = 1;
 			desc->rqcfg.dst_inc = 0;
 			src = dma_addr;
-			dst = pch->fifo_addr;
+			dst = pch->fifo_dma;
 			break;
 		case DMA_DEV_TO_MEM:
 			desc->rqcfg.src_inc = 0;
 			desc->rqcfg.dst_inc = 1;
-			src = pch->fifo_addr;
+			src = pch->fifo_dma;
 			dst = dma_addr;
 			break;
 		default:
@@ -2711,12 +2767,12 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct scatterlist *sg;
 	int i;
-	dma_addr_t addr;
 
 	if (unlikely(!pch || !sgl || !sg_len))
 		return NULL;
 
-	addr = pch->fifo_addr;
+	if (!pl330_prep_slave_fifo(pch, direction))
+		return NULL;
 
 	first = NULL;
 
@@ -2742,13 +2798,13 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (direction == DMA_MEM_TO_DEV) {
 			desc->rqcfg.src_inc = 1;
 			desc->rqcfg.dst_inc = 0;
-			fill_px(&desc->px,
-				addr, sg_dma_address(sg), sg_dma_len(sg));
+			fill_px(&desc->px, pch->fifo_dma, sg_dma_address(sg),
+				sg_dma_len(sg));
 		} else {
 			desc->rqcfg.src_inc = 0;
 			desc->rqcfg.dst_inc = 1;
-			fill_px(&desc->px,
-				sg_dma_address(sg), addr, sg_dma_len(sg));
+			fill_px(&desc->px, sg_dma_address(sg), pch->fifo_dma,
+				sg_dma_len(sg));
 		}
 
 		desc->rqcfg.brst_size = pch->burst_sz;
@@ -2906,6 +2962,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		pch->thread = NULL;
 		pch->chan.device = pd;
 		pch->dmac = pl330;
+		pch->dir = DMA_NONE;
 
 		/* Add the channel to the DMAC list */
 		list_add_tail(&pch->chan.device_node, &pd->channels);
-- 
2.12.2.dirty
