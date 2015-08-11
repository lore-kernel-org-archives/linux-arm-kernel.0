From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 11 Aug 2015 22:16:32 +0200
Subject: [PATCH] dma: pxa_dma: don't use config direction parameter
Message-ID: <1439324192-9148-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Jarzmik <rj@valbob.noip.me>

Don't use the direction passed in the configuration, and rely on each
transfer's direction to prepare the transfers. This will enable
future removal of direction parameter from dma_slave_config.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index be5b5248b7b6..5cb61ce01036 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -905,21 +905,21 @@ static void pxad_get_config(struct pxad_chan *chan,
 	enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
 
 	*dcmd = 0;
-	if (chan->cfg.direction == DMA_DEV_TO_MEM) {
+	if (dir == DMA_DEV_TO_MEM) {
 		maxburst = chan->cfg.src_maxburst;
 		width = chan->cfg.src_addr_width;
 		dev_addr = chan->cfg.src_addr;
 		*dev_src = dev_addr;
 		*dcmd |= PXA_DCMD_INCTRGADDR | PXA_DCMD_FLOWSRC;
 	}
-	if (chan->cfg.direction == DMA_MEM_TO_DEV) {
+	if (dir == DMA_MEM_TO_DEV) {
 		maxburst = chan->cfg.dst_maxburst;
 		width = chan->cfg.dst_addr_width;
 		dev_addr = chan->cfg.dst_addr;
 		*dev_dst = dev_addr;
 		*dcmd |= PXA_DCMD_INCSRCADDR | PXA_DCMD_FLOWTRG;
 	}
-	if (chan->cfg.direction == DMA_MEM_TO_MEM)
+	if (dir == DMA_MEM_TO_MEM)
 		*dcmd |= PXA_DCMD_BURST32 | PXA_DCMD_INCTRGADDR |
 			PXA_DCMD_INCSRCADDR;
 
-- 
2.1.4
