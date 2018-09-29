From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Sat, 29 Sep 2018 11:17:57 -0600
Subject: [PATCH v2 1/4] dmaengine: xilinx_dma: Refactor axidma channel
 allocation
In-Reply-To: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1538241480-13844-2-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In axidma alloc_chan_resources merge BD and cyclic BD allocation.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes for v2:
None
---
 drivers/dma/xilinx/xilinx_dma.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index c124423..06d1632 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -887,6 +887,24 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 				chan->id);
 			return -ENOMEM;
 		}
+		/*
+		 * For cyclic DMA mode we need to program the tail Descriptor
+		 * register with a value which is not a part of the BD chain
+		 * so allocating a desc segment during channel allocation for
+		 * programming tail descriptor.
+		 */
+		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
+					sizeof(*chan->cyclic_seg_v),
+					&chan->cyclic_seg_p, GFP_KERNEL);
+		if (!chan->cyclic_seg_v) {
+			dev_err(chan->dev,
+				"unable to allocate desc segment for cyclic DMA\n");
+			dma_free_coherent(chan->dev, sizeof(*chan->seg_v) *
+				XILINX_DMA_NUM_DESCS, chan->seg_v,
+				chan->seg_p);
+			return -ENOMEM;
+		}
+		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
 
 		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
 			chan->seg_v[i].hw.next_desc =
@@ -922,24 +940,6 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 		return -ENOMEM;
 	}
 
-	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-		/*
-		 * For cyclic DMA mode we need to program the tail Descriptor
-		 * register with a value which is not a part of the BD chain
-		 * so allocating a desc segment during channel allocation for
-		 * programming tail descriptor.
-		 */
-		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
-					sizeof(*chan->cyclic_seg_v),
-					&chan->cyclic_seg_p, GFP_KERNEL);
-		if (!chan->cyclic_seg_v) {
-			dev_err(chan->dev,
-				"unable to allocate desc segment for cyclic DMA\n");
-			return -ENOMEM;
-		}
-		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
-	}
-
 	dma_cookie_init(dchan);
 
 	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
1.7.1
