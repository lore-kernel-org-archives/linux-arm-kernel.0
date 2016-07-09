From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Sat, 9 Jul 2016 14:09:48 +0530
Subject: [PATCH] dmaengine: xilinx: Fix race condition in axi dma cyclic dma
 mode
Message-ID: <1468053588-18357-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In cyclic DMA mode need to link the tail bd segment
with the head bd segment to process bd's in cyclic.

Current driver is doing this only for tx channel
needs to update the same for rx channel case also.

This patch fixes the same.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cf47347..4e223d0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1895,14 +1895,15 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 	reg |= XILINX_DMA_CR_CYCLIC_BD_EN_MASK;
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
+	segment = list_last_entry(&desc->segments,
+				  struct xilinx_axidma_tx_segment,
+				  node);
+	segment->hw.next_desc = (u32) head_segment->phys;
+
 	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
 	if (direction == DMA_MEM_TO_DEV) {
 		head_segment->hw.control |= XILINX_DMA_BD_SOP;
-		segment = list_last_entry(&desc->segments,
-					  struct xilinx_axidma_tx_segment,
-					  node);
 		segment->hw.control |= XILINX_DMA_BD_EOP;
-		segment->hw.next_desc = (u32) head_segment->phys;
 	}
 
 	return &desc->async_tx;
-- 
1.7.1
