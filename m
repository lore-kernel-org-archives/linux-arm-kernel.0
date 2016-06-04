From: eric@anholt.net (Eric Anholt)
Date: Fri,  3 Jun 2016 19:29:11 -0700
Subject: [PATCH] dmaengine: bcm2835: Fix polling for completion of DMA with
 interrupts masked.
Message-ID: <1465007351-5559-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tx_status hook is supposed to be safe to call from interrupt
context, but it wouldn't ever return completion for the last transfer,
meaning you couldn't poll for DMA completion with interrupts masked.

This fixes IRQ handling for bcm2835's DSI1, which requires using the
DMA engine to write its registers due to a bug in the AXI bridge.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/dma/bcm2835-dma.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6149b27c33ad..320461c578e3 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -570,16 +570,16 @@ static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
 	struct virt_dma_desc *vd;
 	enum dma_status ret;
 	unsigned long flags;
+	u32 residue;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE || !txstate)
+	if (ret == DMA_COMPLETE)
 		return ret;
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 	vd = vchan_find_desc(&c->vc, cookie);
 	if (vd) {
-		txstate->residue =
-			bcm2835_dma_desc_size(to_bcm2835_dma_desc(&vd->tx));
+		residue = bcm2835_dma_desc_size(to_bcm2835_dma_desc(&vd->tx));
 	} else if (c->desc && c->desc->vd.tx.cookie == cookie) {
 		struct bcm2835_desc *d = c->desc;
 		dma_addr_t pos;
@@ -591,11 +591,25 @@ static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
 		else
 			pos = 0;
 
-		txstate->residue = bcm2835_dma_desc_size_pos(d, pos);
+		residue = bcm2835_dma_desc_size_pos(d, pos);
+
+		/*
+		 * If our non-cyclic transfer is done, then report
+		 * complete and trigger the next tx now.  This lets
+		 * the dmaengine API be used synchronously from an IRQ
+		 * handler.
+		 */
+		if (!d->cyclic && residue == 0) {
+			vchan_cookie_complete(&c->desc->vd);
+			bcm2835_dma_start_desc(c);
+			ret = dma_cookie_status(chan, cookie, txstate);
+		}
 	} else {
-		txstate->residue = 0;
+		residue = 0;
 	}
 
+	dma_set_residue(txstate, residue);
+
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
 	return ret;
-- 
2.8.0.rc3
