From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 21 Dec 2017 15:41:37 +0530
Subject: [LINUX PATCH 3/4] dmaengine: xilinx_dma: Fix compilation warning
In-Reply-To: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
References: <1513851098-15787-1-git-send-email-appanad@xilinx.com>
Message-ID: <1513851098-15787-4-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the below sparse warning in the driver
drivers/dma/xilinx/xilinx_dma.c: In function ?xilinx_vdma_dma_prep_interleaved?:
drivers/dma/xilinx/xilinx_dma.c:1614:43: warning: variable ?prev? set but not used [-Wunused-but-set-variable]
  struct xilinx_vdma_tx_segment *segment, *prev = NULL;

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8467671..845e638 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1611,7 +1611,7 @@ xilinx_vdma_dma_prep_interleaved(struct dma_chan *dchan,
 {
 	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
 	struct xilinx_dma_tx_descriptor *desc;
-	struct xilinx_vdma_tx_segment *segment, *prev = NULL;
+	struct xilinx_vdma_tx_segment *segment;
 	struct xilinx_vdma_desc_hw *hw;
 
 	if (!is_slave_direction(xt->dir))
@@ -1665,8 +1665,6 @@ xilinx_vdma_dma_prep_interleaved(struct dma_chan *dchan,
 	/* Insert the segment into the descriptor segments list. */
 	list_add_tail(&segment->node, &desc->segments);
 
-	prev = segment;
-
 	/* Link the last hardware descriptor with the first. */
 	segment = list_first_entry(&desc->segments,
 				   struct xilinx_vdma_tx_segment, node);
-- 
2.7.4
