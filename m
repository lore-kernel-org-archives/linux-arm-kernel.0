From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:32:05 +0000
Subject: [PATCH 06/48] ARM: PL08x: fix missed spin-unlock in
	pl08x_issue_pending()
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZswf-0001OF-I1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pl08x_issue_pending() returns with the spinlock locked and interrupts
disabled if the channel is waiting for a physical DMA to become free.
This is wrong - especially as pl08x_issue_pending() is an API function
as it leads to deadlocks.  Fix it to always return with the spinlock
unlocked.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b3b3180..9a8d445 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1294,15 +1294,11 @@ static void pl08x_issue_pending(struct dma_chan *chan)
 	unsigned long flags;
 
 	spin_lock_irqsave(&plchan->lock, flags);
-	/* Something is already active */
-	if (plchan->at) {
-			spin_unlock_irqrestore(&plchan->lock, flags);
-			return;
-	}
-
-	/* Didn't get a physical channel so waiting for it ... */
-	if (plchan->state == PL08X_CHAN_WAITING)
+	/* Something is already active, or we're waiting for a channel... */
+	if (plchan->at || plchan->state == PL08X_CHAN_WAITING) {
+		spin_unlock_irqrestore(&plchan->lock, flags);
 		return;
+	}
 
 	/* Take the first element in the queue and execute it */
 	if (!list_empty(&plchan->desc_list)) {
-- 
1.6.2.5
