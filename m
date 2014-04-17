From: joelf@ti.com (Joel Fernandes)
Date: Thu, 17 Apr 2014 00:58:33 -0500
Subject: [PATCH] dmaengine: edma: No need save/restore interrupt flags during
 spin_lock in IRQ
Message-ID: <1397714313-26561-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vchan lock in edma_callback is acquired in hard interrupt context. As
interrupts are already disabled, there's no point in save/restoring interrupt
mask bit or cpsr flags.

Get rid of flags local variable and use spin_lock instead of spin_lock_irqsave.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 91849aa..25a75e2 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -638,7 +638,6 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 	struct edma_chan *echan = data;
 	struct device *dev = echan->vchan.chan.device->dev;
 	struct edma_desc *edesc;
-	unsigned long flags;
 	struct edmacc_param p;
 
 	edesc = echan->edesc;
@@ -649,7 +648,7 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 
 	switch (ch_status) {
 	case EDMA_DMA_COMPLETE:
-		spin_lock_irqsave(&echan->vchan.lock, flags);
+		spin_lock(&echan->vchan.lock);
 
 		if (edesc) {
 			if (edesc->cyclic) {
@@ -665,11 +664,11 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 			}
 		}
 
-		spin_unlock_irqrestore(&echan->vchan.lock, flags);
+		spin_unlock(&echan->vchan.lock);
 
 		break;
 	case EDMA_DMA_CC_ERROR:
-		spin_lock_irqsave(&echan->vchan.lock, flags);
+		spin_lock(&echan->vchan.lock);
 
 		edma_read_slot(EDMA_CHAN_SLOT(echan->slot[0]), &p);
 
@@ -700,7 +699,7 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 			edma_trigger_channel(echan->ch_num);
 		}
 
-		spin_unlock_irqrestore(&echan->vchan.lock, flags);
+		spin_unlock(&echan->vchan.lock);
 
 		break;
 	default:
-- 
1.7.9.5
