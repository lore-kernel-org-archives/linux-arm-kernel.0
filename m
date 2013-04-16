From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Apr 2013 13:49:34 +0200
Subject: [PATCH] dmaengine: at_hdmac: fix race condition in atc_advance_work()
Message-ID: <1366112974-32043-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The BUG_ON() directive is triggered probably due to a latency modification
following inclusion of c10d736 (softirq: reduce latencies).
This condition has not been met before 3.9-rc1 and doesn't trigger without
this patch.

We now make sure that DMA channel is idle before calling atc_complete_all()
which makes the BUG_ON() "protection" useless.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Linus,

We have identified a race condition on the Atmel ARM-based AT91 DMA controller
driver that leads to hitting a BUG_ON() directive.
This error, only triggered after the inclusion of a patch that reduces the
softirq latency, is affecting several AT91 SoCs and can be seen
as a regression by people using the dmaengine driver (on NAND flash
accesses for instance).

I know that it is late in the development cycle but can you please consider
including it in your tree before 3.9-final?

This patch can also go through dmaengine tree (Vinod Koul) but I do not know if
there is enough time remaining.

Thanks a lot, best regards,

Nicolas Ferre


 drivers/dma/at_hdmac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6e13f26..88cfc61 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -310,8 +310,6 @@ static void atc_complete_all(struct at_dma_chan *atchan)
 
 	dev_vdbg(chan2dev(&atchan->chan_common), "complete all\n");
 
-	BUG_ON(atc_chan_is_enabled(atchan));
-
 	/*
 	 * Submit queued descriptors ASAP, i.e. before we go through
 	 * the completed ones.
@@ -368,6 +366,9 @@ static void atc_advance_work(struct at_dma_chan *atchan)
 {
 	dev_vdbg(chan2dev(&atchan->chan_common), "advance_work\n");
 
+	if (atc_chan_is_enabled(atchan))
+		return;
+
 	if (list_empty(&atchan->active_list) ||
 	    list_is_singular(&atchan->active_list)) {
 		atc_complete_all(atchan);
@@ -1078,9 +1079,7 @@ static void atc_issue_pending(struct dma_chan *chan)
 		return;
 
 	spin_lock_irqsave(&atchan->lock, flags);
-	if (!atc_chan_is_enabled(atchan)) {
-		atc_advance_work(atchan);
-	}
+	atc_advance_work(atchan);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 }
 
-- 
1.8.0
