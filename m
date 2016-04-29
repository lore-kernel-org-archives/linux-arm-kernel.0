From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Fri, 29 Apr 2016 22:09:09 +0200
Subject: [PATCH 2/5] dmaengine: vdma: Use dma_pool_zalloc
In-Reply-To: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1461960552-7429-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dma_pool_zalloc combines dma_pool_alloc and memset 0.  The semantic patch
that makes this transformation is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression d,e;
statement S;
@@

        d =
-            dma_pool_alloc
+            dma_pool_zalloc
             (...);
        if (!d) S
-       memset(d, 0, sizeof(*d));
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/dma/xilinx/xilinx_vdma.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index a95d603..6a70987 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -343,11 +343,10 @@ xilinx_vdma_alloc_tx_segment(struct xilinx_vdma_chan *chan)
 	struct xilinx_vdma_tx_segment *segment;
 	dma_addr_t phys;
 
-	segment = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &phys);
+	segment = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC, &phys);
 	if (!segment)
 		return NULL;
 
-	memset(segment, 0, sizeof(*segment));
 	segment->phys = phys;
 
 	return segment;
