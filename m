From: joelf@ti.com (Joel Fernandes)
Date: Sun, 21 Jul 2013 01:58:45 -0500
Subject: [RFC 5/5] DMA: EDMA: Leave linked to Null slot instead of DUMMY slot
Message-ID: <1374389925-32667-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dummy slot has been used as a way for missed-events not to be
reported as missing. This has been particularly troublesome for cases
where we might want to temporarily pause all incoming events.

For EDMA DMAC, there is no way to do any such pausing of events as
the occurence of the "next" event is not software controlled.
Using "edma_pause" in IRQ handlers doesn't help as by then the event
in concern from the slave is already missed.

Linking a dummy slot, is seen to absorb these events which we didn't
want to miss. So we don't link to dummy, but instead leave it linked
to NULL set, allow an error condition and detect the channel that
missed it.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index b0b5bcd..e9f1f27 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -160,9 +160,6 @@ static void edma_execute(struct edma_chan *echan)
 		/* Link to the previous slot if not the last set */
 		if (i != (total_process - 1))
 			edma_link(echan->slot[i], echan->slot[i+1]);
-		/* Final pset links to the dummy pset */
-		else
-			edma_link(echan->slot[i], echan->ecc->dummy_slot);
 	}
 
 	edesc->total_processed += total_process;
-- 
1.7.9.5
