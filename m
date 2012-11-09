From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 9 Nov 2012 08:00:04 +0100
Subject: [PATCH] dmaengine: imx-dma: fix missing irq disable in tasklet
Message-ID: <1352444404-11423-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas Pape <external.Andreas.Pape@de.bosch.com>

Interrupt handler uses spinlock, too.
To avoid deadlock tasklet must disable IRQ.

Signed-off-by: Andreas Pape <external.Andreas.Pape@de.bosch.com>
CC: Vinod Koul <vinod.koul@linux.intel.com>
CC: Javier Martin <javier.martin@vista-silicon.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
---

I'm no DMA expert, so sorry if it's wrong ;)

And btw.: While looking at this code, we wonder if imxdma_xfer_desc() can
get the spin lock recursively, e.g. from imxdma_tasklet()? Or what ensures
that the lock is always taken from an other DMA engine than the one already
holding the lock? 

 drivers/dma/imx-dma.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 7d9554c..bce30e8 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -562,8 +562,9 @@ static void imxdma_tasklet(unsigned long data)
 	struct imxdma_channel *imxdmac = (void *)data;
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
 	struct imxdma_desc *desc;
+	unsigned long flags;
 
-	spin_lock(&imxdma->lock);
+	spin_lock_irqsave(&imxdma->lock, flags);
 
 	if (list_empty(&imxdmac->ld_active)) {
 		/* Someone might have called terminate all */
@@ -600,7 +601,7 @@ static void imxdma_tasklet(unsigned long data)
 				 __func__, imxdmac->channel);
 	}
 out:
-	spin_unlock(&imxdma->lock);
+	spin_unlock_irqrestore(&imxdma->lock, flags);
 }
 
 static int imxdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
-- 
1.7.0.4
