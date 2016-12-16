From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 16 Dec 2016 11:39:11 +0100
Subject: [PATCH] dmaengine: pl330: Fix runtime PM support for terminated
 transfers
Message-ID: <1481884751-21411-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PL330 DMA engine driver is leaking a runtime reference after any terminated
DMA transactions. This patch fixes this issue by tracking runtime PM state
of the device and making additional call to pm_runtime_put() in terminate_all
callback if needed.

Fixes: ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/pl330.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 030fe05ed43b..9f3dbc8c63d2 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -448,6 +448,9 @@ struct dma_pl330_chan {
 
 	/* for cyclic capability */
 	bool cyclic;
+
+	/* for runtime pm tracking */
+	bool active;
 };
 
 struct pl330_dmac {
@@ -2031,6 +2034,7 @@ static void pl330_tasklet(unsigned long data)
 		_stop(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
 		power_down = true;
+		pch->active = false;
 	} else {
 		/* Make sure the PL330 Channel thread is active */
 		spin_lock(&pch->thread->dmac->lock);
@@ -2050,6 +2054,7 @@ static void pl330_tasklet(unsigned long data)
 			desc->status = PREP;
 			list_move_tail(&desc->node, &pch->work_list);
 			if (power_down) {
+				pch->active = true;
 				spin_lock(&pch->thread->dmac->lock);
 				_start(pch->thread);
 				spin_unlock(&pch->thread->dmac->lock);
@@ -2164,6 +2169,7 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	struct pl330_dmac *pl330 = pch->dmac;
 	LIST_HEAD(list);
+	bool power_down = false;
 
 	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
@@ -2174,6 +2180,8 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	pch->thread->req[0].desc = NULL;
 	pch->thread->req[1].desc = NULL;
 	pch->thread->req_running = -1;
+	power_down = pch->active;
+	pch->active = false;
 
 	/* Mark all desc done */
 	list_for_each_entry(desc, &pch->submitted_list, node) {
@@ -2191,6 +2199,8 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
+	if (power_down)
+		pm_runtime_put_autosuspend(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
@@ -2350,6 +2360,7 @@ static void pl330_issue_pending(struct dma_chan *chan)
 		 * updated on work_list emptiness status.
 		 */
 		WARN_ON(list_empty(&pch->submitted_list));
+		pch->active = true;
 		pm_runtime_get_sync(pch->dmac->ddma.dev);
 	}
 	list_splice_tail_init(&pch->submitted_list, &pch->work_list);
-- 
1.9.1
