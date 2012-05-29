From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:43:40 +0100
Subject: [RFC 25/34] dmaengine: PL08x: start next descriptor from irq context
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIxo-00070N-Kj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than waiting for the tasklet to run, we can start the next
descriptor from interrupt context, as soon as we know that the
previous descriptor has completed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 4788ec0..1118fc0 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1661,10 +1661,7 @@ static void pl08x_tasklet(unsigned long data)
 	spin_lock_irqsave(&plchan->lock, flags);
 	list_splice_tail_init(&plchan->done_list, &head);
 
-	/* If a new descriptor is queued, set it up plchan->at is NULL here */
-	if (!list_empty(&plchan->issued_list)) {
-		pl08x_start_next_txd(plchan);
-	} else if (!list_empty(&plchan->pend_list) || plchan->phychan_hold) {
+	if (plchan->at || !list_empty(&plchan->pend_list) || plchan->phychan_hold) {
 		/*
 		 * This channel is still in use - we have a new txd being
 		 * prepared and will soon be queued.  Don't give up the
@@ -1776,6 +1773,10 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 				pl08x_release_mux(plchan);
 				dma_cookie_complete(&tx->tx);
 				list_add_tail(&tx->node, &plchan->done_list);
+
+				/* And start the next descriptor */
+				if (!list_empty(&plchan->issued_list))
+					pl08x_start_next_txd(plchan);
 			}
 			spin_unlock(&plchan->lock);
 
-- 
1.7.4.4
