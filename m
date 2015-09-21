From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 21 Sep 2015 11:06:32 +0200
Subject: [PATCH] dmaengine: pxa_dma: fix initial list move
Message-ID: <1442826392-9082-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the commit to have an allocated list of virtual descriptors was
reverted, the pxa_dma driver is broken, as it assumes the descriptor is
placed on the allocated list upon allocation.

Fix the issue in pxa_dma by making an allocated virtual descriptor a
singleton.

Fixes: 8c8fe97b2b8a ("Revert "dmaengine: virt-dma: don't always free descriptor upon completion"")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Vinod, this is my fallback plan as I'm getting no answer on
https://lkml.org/lkml/2015/9/6/112. If I get no answer before v4.3-rc3,
I'll put that into the pxa tree.
---
 drivers/dma/pxa_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 9d3458e2a366..53c05ca514f1 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -891,6 +891,7 @@ pxad_tx_prep(struct virt_dma_chan *vc, struct virt_dma_desc *vd,
 	struct dma_async_tx_descriptor *tx;
 	struct pxad_chan *chan = container_of(vc, struct pxad_chan, vc);
 
+	INIT_LIST_HEAD(&vd->node);
 	tx = vchan_tx_prep(vc, vd, tx_flags);
 	tx->tx_submit = pxad_tx_submit;
 	dev_dbg(&chan->vc.chan.dev->device,
-- 
2.1.4
