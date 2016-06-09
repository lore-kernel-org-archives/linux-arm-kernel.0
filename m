From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 9 Jun 2016 11:32:12 +0530
Subject: [PATCH] dmaengine: vdma: Fix compilation warning in cyclic dma mode
Message-ID: <1465452132-13512-1-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below compilation warining.
drivers/dma/xilinx/xilinx_vdma.c: In function 'xilinx_dma_prep_dma_cyclic':
drivers/dma/xilinx/xilinx_vdma.c:1808:23: warning: 'segment' may be used
uninitialized in this function [-Wmaybe-uninitialized]
   segment->hw.control |= XILINX_DMA_BD_SOP;

The start of packet (SOP) should be set to the first segment in the desc
chain not for the last segment of the desc chain.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_vdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index cbcf595..20fe5ea 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -1840,7 +1840,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 
 	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
 	if (direction == DMA_MEM_TO_DEV) {
-		segment->hw.control |= XILINX_DMA_BD_SOP;
+		head_segment->hw.control |= XILINX_DMA_BD_SOP;
 		segment = list_last_entry(&desc->segments,
 					  struct xilinx_axidma_tx_segment,
 					  node);
-- 
1.7.1
