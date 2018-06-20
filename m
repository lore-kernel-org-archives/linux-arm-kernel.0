From: andrea.merello@gmail.com (Andrea Merello)
Date: Wed, 20 Jun 2018 10:36:49 +0200
Subject: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is not
 invoked for each DMA operation
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Message-ID: <20180620083653.17010-2-andrea.merello@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

API specification says: "On completion of each DMA operation, the next in
queue is started and a tasklet triggered. The tasklet will then call the
client driver completion callback routine for notification, if set."

Currently the driver keeps a "desc_pendingcount" counter of the total
descriptor pending, and it uses as IRQ coalesce threshold, as result it
only calls the CBs after ALL pending operations are completed, which is
wrong.

This patch uses disable IRQ coalesce and checks for the completion flag
for the descriptors (which is further divided in segments).

Possibly a better optimization could be using proper IRQ coalesce
threshold to get an IRQ after all segments of the descriptors are done.
But we don't do that yet..

NOTE: for now we do this only for AXI DMA, other DMA flavors are
untested/untouched.
This is loosely based on
commit 65df81a6dc74 ("xilinx_dma: IrqThreshold set incorrectly, unreliable.")
in my linux-4.6-zynq tree

From: Jeremy Trimble [original patch]
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 39 +++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a516e7ffef21..cf12f7147f07 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -164,6 +164,7 @@
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
+#define XILINX_DMA_BD_CMPLT		BIT(31)
 #define XILINX_DMA_COALESCE_MAX		255
 #define XILINX_DMA_NUM_DESCS		255
 #define XILINX_DMA_NUM_APP_WORDS	5
@@ -1274,12 +1275,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
-	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
-		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
-		reg |= chan->desc_pendingcount <<
-				  XILINX_DMA_CR_COALESCE_SHIFT;
-		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
-	}
+	reg &= ~XILINX_DMA_CR_COALESCE_MAX;
+	reg |= 1 << XILINX_DMA_CR_COALESCE_SHIFT;
+	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	if (chan->has_sg && !chan->xdev->mcdma)
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
@@ -1378,6 +1376,20 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+			/*
+			 * Check whether the last segment in this descriptor
+			 * has been completed.
+			 */
+			const struct xilinx_axidma_tx_segment *const tail_seg =
+				list_last_entry(&desc->segments,
+						struct xilinx_axidma_tx_segment,
+						node);
+
+			/* we've processed all the completed descriptors */
+			if (!(tail_seg->hw.status & XILINX_DMA_BD_CMPLT))
+				break;
+		}
 		list_del(&desc->node);
 		if (!desc->cyclic)
 			dma_cookie_complete(&desc->async_tx);
@@ -1826,14 +1838,13 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 				   struct xilinx_axidma_tx_segment, node);
 	desc->async_tx.phys = segment->phys;
 
-	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
-	if (chan->direction == DMA_MEM_TO_DEV) {
-		segment->hw.control |= XILINX_DMA_BD_SOP;
-		segment = list_last_entry(&desc->segments,
-					  struct xilinx_axidma_tx_segment,
-					  node);
-		segment->hw.control |= XILINX_DMA_BD_EOP;
-	}
+	/* For the first transfer, set SOP */
+	segment->hw.control |= XILINX_DMA_BD_SOP;
+	/* For the last transfer, set EOP */
+	segment = list_last_entry(&desc->segments,
+				  struct xilinx_axidma_tx_segment,
+				  node);
+	segment->hw.control |= XILINX_DMA_BD_EOP;
 
 	return &desc->async_tx;
 
-- 
2.17.1
