From: javi.merino@arm.com (Javi Merino)
Date: Mon, 19 Sep 2011 18:11:31 +0100
Subject: [PATCH] ARM: pl330: Fix a race condition
Message-ID: <1316452291-19632-1-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If two requests have been submitted and one of them is running, if you
call pl330_chan_ctrl(ch_id, PL330_OP_START), there's a window of time
between the spin_lock_irqsave() and the _state() check in which the
running transaction may finish.  In that case, we don't receive the
interrupt (because they are disabled), but _start() sees that the DMA
is stopped, so it starts it.  The problem is that it sends the
transaction that has just finished again, because pl330_update()
hasn't mark it as done yet.

This patch moves the _state() check out of the critical section, which
removes the race condition.  It also treats PL330_STATE_COMPLETING as
still executing, because that introduces another race condition now
that we call _state() with interrupts enabled.  Namely, if we read the
state as "completing" and the DMA sends the interrupt before we
disable interrupts, pl330_update() starts the next transaction and
returns.  Then the _start() in pl330_chan_ctrl() will patiently wait
until the just issued transaction finishes (because the state we read
was PL330_STATE_COMPLETING) and when it does, it _trigger()s the same
transaction again.

Signed-off-by: Javi Merino <javi.merino@arm.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/common/pl330.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 97912fa..26b5615 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -936,9 +936,9 @@ static bool _trigger(struct pl330_thread *thrd)
 	return true;
 }
 
-static bool _start(struct pl330_thread *thrd)
+static bool _start(struct pl330_thread *thrd, u32 state)
 {
-	switch (_state(thrd)) {
+	switch (state) {
 	case PL330_STATE_FAULT_COMPLETING:
 		UNTIL(thrd, PL330_STATE_FAULTING | PL330_STATE_KILLING);
 
@@ -949,7 +949,6 @@ static bool _start(struct pl330_thread *thrd)
 		_stop(thrd);
 
 	case PL330_STATE_KILLING:
-	case PL330_STATE_COMPLETING:
 		UNTIL(thrd, PL330_STATE_STOPPED)
 
 	case PL330_STATE_STOPPED:
@@ -961,6 +960,7 @@ static bool _start(struct pl330_thread *thrd)
 	case PL330_STATE_UPDTPC:
 	case PL330_STATE_CACHEMISS:
 	case PL330_STATE_EXECUTING:
+	case PL330_STATE_COMPLETING:
 		return true;
 
 	case PL330_STATE_WFE: /* For RESUME, nothing yet */
@@ -1471,7 +1471,7 @@ int pl330_update(const struct pl330_info *pi)
 			MARK_FREE(rqdone);
 
 			/* Get going again ASAP */
-			_start(thrd);
+			_start(thrd, _state(thrd));
 
 			/* For now, just make a list of callbacks to be done */
 			list_add_tail(&rqdone->rqd, &pl330->req_done);
@@ -1510,12 +1510,14 @@ int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
 	struct pl330_dmac *pl330;
 	unsigned long flags;
 	int ret = 0, active;
+	u32 dma_state;
 
 	if (!thrd || thrd->free || thrd->dmac->state == DYING)
 		return -EINVAL;
 
 	pl330 = thrd->dmac;
 
+	dma_state = _state(thrd);
 	spin_lock_irqsave(&pl330->lock, flags);
 
 	switch (op) {
@@ -1546,7 +1548,7 @@ int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
 
 		/* Start the next */
 	case PL330_OP_START:
-		if (!_start(thrd))
+		if (!_start(thrd, dma_state))
 			ret = -EIO;
 		break;
 
-- 
1.7.0.4
