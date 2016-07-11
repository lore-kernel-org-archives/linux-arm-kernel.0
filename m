From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2016 23:46:09 +0200
Subject: [PATCH] dmaengine: zynqmp: avoid cast warning
Message-ID: <20160711214642.2610193-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added zynqmp_dma driver produces a warning on 32-bit architectures
when dma_addr_t is 64-bit wide:

drivers/dma/xilinx/zynqmp_dma.c: In function 'zynqmp_dma_config_sg_ll_desc':
drivers/dma/xilinx/zynqmp_dma.c:321:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
        ((dma_addr_t)sdesc - (dma_addr_t)chan->desc_pool_v);
         ^
drivers/dma/xilinx/zynqmp_dma.c:321:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
        ((dma_addr_t)sdesc - (dma_addr_t)chan->desc_pool_v);

This changes the cast to the more appropriate uintptr_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 59bc1f730a48..f777a5bc0db8 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -318,7 +318,7 @@ static void zynqmp_dma_config_sg_ll_desc(struct zynqmp_dma_chan *chan,
 
 	if (prev) {
 		dma_addr_t addr = chan->desc_pool_p +
-			    ((dma_addr_t)sdesc - (dma_addr_t)chan->desc_pool_v);
+			    ((uintptr_t)sdesc - (uintptr_t)chan->desc_pool_v);
 		ddesc = prev + 1;
 		prev->nxtdscraddr = addr;
 		ddesc->nxtdscraddr = addr + ZYNQMP_DMA_DESC_SIZE(chan);
-- 
2.9.0
