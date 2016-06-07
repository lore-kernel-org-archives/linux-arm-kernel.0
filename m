From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Wed, 8 Jun 2016 00:48:38 +0530
Subject: [PATCH] dmaengine: xilinx_vdma: Use dma_pool_zalloc
Message-ID: <20160607191838.GA26841@amitoj-Inspiron-3542>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dma_pool_zalloc combines dma_pool_alloc and memset 0.

The Coccinelle semantic patch used to make this change is as follows:
@@
type T;
T *d;
expression e;
statement S;
@@

        d =
-            dma_pool_alloc
+            dma_pool_zalloc
             (...);
        if (!d) S
-       memset(d, 0, sizeof(T));

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/dma/xilinx/xilinx_vdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index ef67f27..d35317f 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -315,11 +315,10 @@ xilinx_vdma_alloc_tx_segment(struct xilinx_vdma_chan *chan)
 	struct xilinx_vdma_tx_segment *segment;
 	dma_addr_t phys;
 
-	segment = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &phys);
+	segment = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC, &phys);
 	if (!segment)
 		return NULL;
 
-	memset(segment, 0, sizeof(*segment));
 	segment->phys = phys;
 
 	return segment;
-- 
1.9.1
