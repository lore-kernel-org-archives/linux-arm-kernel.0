From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:51:04 +0530
Subject: [PATCH v7 3/6] dmaengine: xilinx_dma: Fix race condition in the
 driver for multiple descriptor scenario
In-Reply-To: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624067-13554-4-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per axi dmaengine spec the software must not move the tail pointer
to a location that has not been updated (next descriptor field of the
h/w descriptor should always point to a valid address).

When user submits multiple descriptors on the recv side, with the
current driver flow the last buffer descriptor next descriptor field
points to a invalid location, resulting the invalid data or errors from the
axidma dmaengine.

This patch fixes this issue by creating a buffer descritpor chain during
channel allocation itself and use those buffer descriptors for the
subsequent dma operations.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v7:
---> None.
Changes for v6:
---> Updated Commit message as suggested by Vinod.
Changes for v5:
---> None.
Changes for v4:
---> None.
Changes for v3:
---> None.
Changes for v2:
---> None.

 drivers/dma/xilinx/xilinx_dma.c | 135 +++++++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 51 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 9063ca0..ab01306 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -165,6 +165,7 @@
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
 #define XILINX_DMA_COALESCE_MAX		255
+#define XILINX_DMA_NUM_DESCS		255
 #define XILINX_DMA_NUM_APP_WORDS	5
 
 /* Multi-Channel DMA Descriptor offsets*/
@@ -312,6 +313,7 @@ struct xilinx_dma_tx_descriptor {
  * @pending_list: Descriptors waiting
  * @active_list: Descriptors ready to submit
  * @done_list: Complete descriptors
+ * @free_seg_list: Free descriptors
  * @common: DMA common channel
  * @desc_pool: Descriptors pool
  * @dev: The dma device
@@ -332,7 +334,9 @@ struct xilinx_dma_tx_descriptor {
  * @desc_submitcount: Descriptor h/w submitted count
  * @residue: Residue for AXI DMA
  * @seg_v: Statically allocated segments base
+ * @seg_p: Physical allocated segments base
  * @cyclic_seg_v: Statically allocated segment base for cyclic transfers
+ * @cyclic_seg_p: Physical allocated segments base for cyclic dma
  * @start_transfer: Differentiate b/w DMA IP's transfer
  * @stop_transfer: Differentiate b/w DMA IP's quiesce
  */
@@ -344,6 +348,7 @@ struct xilinx_dma_chan {
 	struct list_head pending_list;
 	struct list_head active_list;
 	struct list_head done_list;
+	struct list_head free_seg_list;
 	struct dma_chan common;
 	struct dma_pool *desc_pool;
 	struct device *dev;
@@ -364,7 +369,9 @@ struct xilinx_dma_chan {
 	u32 desc_submitcount;
 	u32 residue;
 	struct xilinx_axidma_tx_segment *seg_v;
+	dma_addr_t seg_p;
 	struct xilinx_axidma_tx_segment *cyclic_seg_v;
+	dma_addr_t cyclic_seg_p;
 	void (*start_transfer)(struct xilinx_dma_chan *chan);
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
 	u16 tdest;
@@ -584,18 +591,32 @@ xilinx_cdma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 static struct xilinx_axidma_tx_segment *
 xilinx_axidma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 {
-	struct xilinx_axidma_tx_segment *segment;
-	dma_addr_t phys;
-
-	segment = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC, &phys);
-	if (!segment)
-		return NULL;
+	struct xilinx_axidma_tx_segment *segment = NULL;
+	unsigned long flags;
 
-	segment->phys = phys;
+	spin_lock_irqsave(&chan->lock, flags);
+	if (!list_empty(&chan->free_seg_list)) {
+		segment = list_first_entry(&chan->free_seg_list,
+					   struct xilinx_axidma_tx_segment,
+					   node);
+		list_del(&segment->node);
+	}
+	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return segment;
 }
 
+static void xilinx_dma_clean_hw_desc(struct xilinx_axidma_desc_hw *hw)
+{
+	u32 next_desc = hw->next_desc;
+	u32 next_desc_msb = hw->next_desc_msb;
+
+	memset(hw, 0, sizeof(struct xilinx_axidma_desc_hw));
+
+	hw->next_desc = next_desc;
+	hw->next_desc_msb = next_desc_msb;
+}
+
 /**
  * xilinx_dma_free_tx_segment - Free transaction segment
  * @chan: Driver specific DMA channel
@@ -604,7 +625,9 @@ xilinx_axidma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 static void xilinx_dma_free_tx_segment(struct xilinx_dma_chan *chan,
 				struct xilinx_axidma_tx_segment *segment)
 {
-	dma_pool_free(chan->desc_pool, segment, segment->phys);
+	xilinx_dma_clean_hw_desc(&segment->hw);
+
+	list_add_tail(&segment->node, &chan->free_seg_list);
 }
 
 /**
@@ -729,16 +752,26 @@ static void xilinx_dma_free_descriptors(struct xilinx_dma_chan *chan)
 static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
 {
 	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	unsigned long flags;
 
 	dev_dbg(chan->dev, "Free all channel resources.\n");
 
 	xilinx_dma_free_descriptors(chan);
+
 	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-		xilinx_dma_free_tx_segment(chan, chan->cyclic_seg_v);
-		xilinx_dma_free_tx_segment(chan, chan->seg_v);
+		spin_lock_irqsave(&chan->lock, flags);
+		INIT_LIST_HEAD(&chan->free_seg_list);
+		spin_unlock_irqrestore(&chan->lock, flags);
+
+		/* Free Memory that is allocated for cyclic DMA Mode */
+		dma_free_coherent(chan->dev, sizeof(*chan->cyclic_seg_v),
+				  chan->cyclic_seg_v, chan->cyclic_seg_p);
+	}
+
+	if (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA) {
+		dma_pool_destroy(chan->desc_pool);
+		chan->desc_pool = NULL;
 	}
-	dma_pool_destroy(chan->desc_pool);
-	chan->desc_pool = NULL;
 }
 
 /**
@@ -821,6 +854,7 @@ static void xilinx_dma_do_tasklet(unsigned long data)
 static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	int i;
 
 	/* Has this channel already been allocated? */
 	if (chan->desc_pool)
@@ -831,11 +865,30 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 	 * for meeting Xilinx VDMA specification requirement.
 	 */
 	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-		chan->desc_pool = dma_pool_create("xilinx_dma_desc_pool",
-				   chan->dev,
-				   sizeof(struct xilinx_axidma_tx_segment),
-				   __alignof__(struct xilinx_axidma_tx_segment),
-				   0);
+		/* Allocate the buffer descriptors. */
+		chan->seg_v = dma_zalloc_coherent(chan->dev,
+						  sizeof(*chan->seg_v) *
+						  XILINX_DMA_NUM_DESCS,
+						  &chan->seg_p, GFP_KERNEL);
+		if (!chan->seg_v) {
+			dev_err(chan->dev,
+				"unable to allocate channel %d descriptors\n",
+				chan->id);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
+			chan->seg_v[i].hw.next_desc =
+			lower_32_bits(chan->seg_p + sizeof(*chan->seg_v) *
+				((i + 1) % XILINX_DMA_NUM_DESCS));
+			chan->seg_v[i].hw.next_desc_msb =
+			upper_32_bits(chan->seg_p + sizeof(*chan->seg_v) *
+				((i + 1) % XILINX_DMA_NUM_DESCS));
+			chan->seg_v[i].phys = chan->seg_p +
+				sizeof(*chan->seg_v) * i;
+			list_add_tail(&chan->seg_v[i].node,
+				      &chan->free_seg_list);
+		}
 	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		chan->desc_pool = dma_pool_create("xilinx_cdma_desc_pool",
 				   chan->dev,
@@ -850,7 +903,8 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 				     0);
 	}
 
-	if (!chan->desc_pool) {
+	if (!chan->desc_pool &&
+	    (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA)) {
 		dev_err(chan->dev,
 			"unable to allocate channel %d descriptor pool\n",
 			chan->id);
@@ -859,22 +913,20 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 
 	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		/*
-		 * For AXI DMA case after submitting a pending_list, keep
-		 * an extra segment allocated so that the "next descriptor"
-		 * pointer on the tail descriptor always points to a
-		 * valid descriptor, even when paused after reaching taildesc.
-		 * This way, it is possible to issue additional
-		 * transfers without halting and restarting the channel.
-		 */
-		chan->seg_v = xilinx_axidma_alloc_tx_segment(chan);
-
-		/*
 		 * For cyclic DMA mode we need to program the tail Descriptor
 		 * register with a value which is not a part of the BD chain
 		 * so allocating a desc segment during channel allocation for
 		 * programming tail descriptor.
 		 */
-		chan->cyclic_seg_v = xilinx_axidma_alloc_tx_segment(chan);
+		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
+					sizeof(*chan->cyclic_seg_v),
+					&chan->cyclic_seg_p, GFP_KERNEL);
+		if (!chan->cyclic_seg_v) {
+			dev_err(chan->dev,
+				"unable to allocate desc segment for cyclic DMA\n");
+			return -ENOMEM;
+		}
+		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
 	}
 
 	dma_cookie_init(dchan);
@@ -1184,7 +1236,7 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 {
 	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
-	struct xilinx_axidma_tx_segment *tail_segment, *old_head, *new_head;
+	struct xilinx_axidma_tx_segment *tail_segment;
 	u32 reg;
 
 	if (chan->err)
@@ -1203,21 +1255,6 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	tail_segment = list_last_entry(&tail_desc->segments,
 				       struct xilinx_axidma_tx_segment, node);
 
-	if (chan->has_sg && !chan->xdev->mcdma) {
-		old_head = list_first_entry(&head_desc->segments,
-					struct xilinx_axidma_tx_segment, node);
-		new_head = chan->seg_v;
-		/* Copy Buffer Descriptor fields. */
-		new_head->hw = old_head->hw;
-
-		/* Swap and save new reserve */
-		list_replace_init(&old_head->node, &new_head->node);
-		chan->seg_v = old_head;
-
-		tail_segment->hw.next_desc = chan->seg_v->phys;
-		head_desc->async_tx.phys = new_head->phys;
-	}
-
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
 	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
@@ -1705,7 +1742,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 {
 	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
 	struct xilinx_dma_tx_descriptor *desc;
-	struct xilinx_axidma_tx_segment *segment = NULL, *prev = NULL;
+	struct xilinx_axidma_tx_segment *segment = NULL;
 	u32 *app_w = (u32 *)context;
 	struct scatterlist *sg;
 	size_t copy;
@@ -1756,10 +1793,6 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 					       XILINX_DMA_NUM_APP_WORDS);
 			}
 
-			if (prev)
-				prev->hw.next_desc = segment->phys;
-
-			prev = segment;
 			sg_used += copy;
 
 			/*
@@ -1773,7 +1806,6 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 	segment = list_first_entry(&desc->segments,
 				   struct xilinx_axidma_tx_segment, node);
 	desc->async_tx.phys = segment->phys;
-	prev->hw.next_desc = segment->phys;
 
 	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
 	if (chan->direction == DMA_MEM_TO_DEV) {
@@ -2328,6 +2360,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	INIT_LIST_HEAD(&chan->pending_list);
 	INIT_LIST_HEAD(&chan->done_list);
 	INIT_LIST_HEAD(&chan->active_list);
+	INIT_LIST_HEAD(&chan->free_seg_list);
 
 	/* Retrieve the channel properties from the device tree */
 	has_dre = of_property_read_bool(node, "xlnx,include-dre");
-- 
2.7.4
