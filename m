From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 18 Jun 2013 23:03:51 +0800
Subject: [RFC PATCH v1 5/6] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <1371567833-9077-1-git-send-email-ming.lei@canonical.com>
References: <1371567833-9077-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1371567833-9077-6-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given interrupt URB will be resubmitted from tasklet context which
is scheduled by ehci hardware interrupt handler, and commonly only
one interrupt URB is scheduled on qh, so the qh may be unlinked
immediately once qh_completions() returns from ehci_irq(), then
the intr URB to be resubmitted in complete() can only be scheduled
and linked to hardware until the qh unlink is completed.

This patch applied the QH_STATE_UNLINK_WAIT(not used by interrupt qh)
state to improve this above situation, and the qh will wait for 5
milliseconds before being unlinked from hardware, if one URB is submitted
during the period, the qh is move out of unlink wait state and the
interrupt transfer can be scheduled immediately, not like before: the
transfer is only linked to hardware until previous unlink is completed.

Only enable the improvement in case that HCD supports to run
giveback of URB in tasklet context.

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/usb/host/ehci-hcd.c   |   16 ++++++++---
 drivers/usb/host/ehci-hub.c   |    1 +
 drivers/usb/host/ehci-sched.c |   60 ++++++++++++++++++++++++++++++++++++++---
 drivers/usb/host/ehci-timer.c |   43 +++++++++++++++++++++++++++++
 drivers/usb/host/ehci.h       |    3 +++
 5 files changed, 115 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 246e124..0ab82de 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -304,7 +304,9 @@ static void end_unlink_async(struct ehci_hcd *ehci);
 static void unlink_empty_async(struct ehci_hcd *ehci);
 static void unlink_empty_async_suspended(struct ehci_hcd *ehci);
 static void ehci_work(struct ehci_hcd *ehci);
-static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh);
+static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh,
+			      bool wait);
+static void start_do_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh);
 static void end_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh);
 
 #include "ehci-timer.c"
@@ -484,6 +486,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	ehci->periodic_size = DEFAULT_I_TDPS;
 	INIT_LIST_HEAD(&ehci->async_unlink);
 	INIT_LIST_HEAD(&ehci->async_idle);
+	INIT_LIST_HEAD(&ehci->intr_unlink_wait);
 	INIT_LIST_HEAD(&ehci->intr_unlink);
 	INIT_LIST_HEAD(&ehci->intr_qh_list);
 	INIT_LIST_HEAD(&ehci->cached_itd_list);
@@ -908,15 +911,20 @@ static int ehci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		switch (qh->qh_state) {
 		case QH_STATE_LINKED:
 			if (usb_pipetype(urb->pipe) == PIPE_INTERRUPT)
-				start_unlink_intr(ehci, qh);
+				start_unlink_intr(ehci, qh, false);
 			else
 				start_unlink_async(ehci, qh);
 			break;
 		case QH_STATE_COMPLETING:
 			qh->dequeue_during_giveback = 1;
 			break;
-		case QH_STATE_UNLINK:
 		case QH_STATE_UNLINK_WAIT:
+			if (usb_pipetype(urb->pipe) == PIPE_INTERRUPT) {
+				cancel_unlink_wait_intr(ehci, qh);
+				start_unlink_intr(ehci, qh, false);
+			}
+			break;
+		case QH_STATE_UNLINK:
 			/* already started */
 			break;
 		case QH_STATE_IDLE:
@@ -1042,7 +1050,7 @@ ehci_endpoint_reset(struct usb_hcd *hcd, struct usb_host_endpoint *ep)
 			if (eptype == USB_ENDPOINT_XFER_BULK)
 				start_unlink_async(ehci, qh);
 			else
-				start_unlink_intr(ehci, qh);
+				start_unlink_intr(ehci, qh, false);
 		}
 	}
 	spin_unlock_irqrestore(&ehci->lock, flags);
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index b2f6450..4104c66 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -345,6 +345,7 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
 
 	end_unlink_async(ehci);
 	unlink_empty_async_suspended(ehci);
+	ehci_handle_start_intr_unlinks(ehci);
 	ehci_handle_intr_unlinks(ehci);
 	end_free_itds(ehci);
 
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index f80d033..5b9ca31 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -601,10 +601,10 @@ static void qh_unlink_periodic(struct ehci_hcd *ehci, struct ehci_qh *qh)
 	list_del(&qh->intr_node);
 }
 
-static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
+static void start_do_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
-	/* If the QH isn't linked then there's nothing we can do. */
-	if (qh->qh_state != QH_STATE_LINKED)
+	/* If the QH isn't unlink wait then there's nothing we can do. */
+	if (qh->qh_state != QH_STATE_UNLINK_WAIT)
 		return;
 
 	qh_unlink_periodic (ehci, qh);
@@ -632,6 +632,55 @@ static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
 	}
 }
 
+static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh,
+			      bool wait)
+{
+	/* If the QH isn't linked then there's nothing we can do. */
+	if (qh->qh_state != QH_STATE_LINKED)
+		return;
+
+	/*
+	 * It is common only one intr URB is scheduled on one qh, and given
+	 * complete() is run in tasklet context, introduce QH_STATE_UNLINK_WAIT
+	 * to avoid unlink qh too early.
+	 */
+	qh->qh_state = QH_STATE_UNLINK_WAIT;
+
+	/* bypass the optimization without URB giveback in tasklet */
+	if (!hcd_giveback_urb_in_bh(ehci_to_hcd(ehci)) || !wait) {
+		start_do_unlink_intr(ehci, qh);
+		return;
+	}
+
+	qh->unlink_cycle = ehci->intr_unlink_wait_cycle;
+
+	/* New entries go at the end of the intr_unlink_wait list */
+	list_add_tail(&qh->unlink_node, &ehci->intr_unlink_wait);
+
+	if (ehci->rh_state < EHCI_RH_RUNNING)
+		ehci_handle_start_intr_unlinks(ehci);
+	else if (ehci->intr_unlink_wait.next == &qh->unlink_node) {
+		ehci_enable_event(ehci, EHCI_HRTIMER_START_UNLINK_INTR, true);
+		++ehci->intr_unlink_wait_cycle;
+	}
+}
+
+/* must be called with holding ehci->lock */
+static void cancel_unlink_wait_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
+{
+	/* If the QH isn't waited for unlink then do nothing */
+	if (qh->qh_state != QH_STATE_UNLINK_WAIT)
+		return;
+
+	/* restored to linked state */
+	list_del(&qh->unlink_node);
+	qh->qh_state = QH_STATE_LINKED;
+
+	/* avoid unnecessary CPU wakeup */
+	if (list_empty(&ehci->intr_unlink_wait))
+		ehci_disable_event(ehci, EHCI_HRTIMER_START_UNLINK_INTR);
+}
+
 static void end_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
 	struct ehci_qh_hw	*hw = qh->hw;
@@ -881,6 +930,9 @@ static int intr_submit (
 			goto done;
 	}
 
+	/* put back qh from unlink wait list */
+	cancel_unlink_wait_intr(ehci, qh);
+
 	/* then queue the urb's tds to the qh */
 	qh = qh_append_tds(ehci, urb, qtd_list, epnum, &urb->ep->hcpriv);
 	BUG_ON (qh == NULL);
@@ -926,7 +978,7 @@ static void scan_intr(struct ehci_hcd *ehci)
 			temp = qh_completions(ehci, qh);
 			if (unlikely(temp || (list_empty(&qh->qtd_list) &&
 					qh->qh_state == QH_STATE_LINKED)))
-				start_unlink_intr(ehci, qh);
+				start_unlink_intr(ehci, qh, true);
 		}
 	}
 }
diff --git a/drivers/usb/host/ehci-timer.c b/drivers/usb/host/ehci-timer.c
index 11e5b32..c2320f3 100644
--- a/drivers/usb/host/ehci-timer.c
+++ b/drivers/usb/host/ehci-timer.c
@@ -72,6 +72,7 @@ static unsigned event_delays_ns[] = {
 	1 * NSEC_PER_MSEC,	/* EHCI_HRTIMER_POLL_DEAD */
 	1125 * NSEC_PER_USEC,	/* EHCI_HRTIMER_UNLINK_INTR */
 	2 * NSEC_PER_MSEC,	/* EHCI_HRTIMER_FREE_ITDS */
+	5 * NSEC_PER_MSEC,	/* EHCI_HRTIMER_START_UNLINK_INTR */
 	6 * NSEC_PER_MSEC,	/* EHCI_HRTIMER_ASYNC_UNLINKS */
 	10 * NSEC_PER_MSEC,	/* EHCI_HRTIMER_IAA_WATCHDOG */
 	10 * NSEC_PER_MSEC,	/* EHCI_HRTIMER_DISABLE_PERIODIC */
@@ -98,6 +99,17 @@ static void ehci_enable_event(struct ehci_hcd *ehci, unsigned event,
 	}
 }
 
+/* Warning: don't call this function from hrtimer handler context */
+static void ehci_disable_event(struct ehci_hcd *ehci, unsigned event)
+{
+	if (!hcd_giveback_urb_in_bh(ehci_to_hcd(ehci)))
+		return;
+
+	ehci->enabled_hrtimer_events &= ~(1 << event);
+	if (!ehci->enabled_hrtimer_events)
+		hrtimer_cancel(&ehci->hrtimer);
+}
+
 
 /* Poll the STS_ASS status bit; see when it agrees with CMD_ASE */
 static void ehci_poll_ASS(struct ehci_hcd *ehci)
@@ -215,6 +227,36 @@ static void ehci_handle_controller_death(struct ehci_hcd *ehci)
 	/* Not in process context, so don't try to reset the controller */
 }
 
+/* start to unlink interrupt QHs  */
+static void ehci_handle_start_intr_unlinks(struct ehci_hcd *ehci)
+{
+	bool		stopped = (ehci->rh_state < EHCI_RH_RUNNING);
+
+	/*
+	 * Process all the QHs on the intr_unlink list that were added
+	 * before the current unlink cycle began.  The list is in
+	 * temporal order, so stop when we reach the first entry in the
+	 * current cycle.  But if the root hub isn't running then
+	 * process all the QHs on the list.
+	 */
+	while (!list_empty(&ehci->intr_unlink_wait)) {
+		struct ehci_qh	*qh;
+
+		qh = list_first_entry(&ehci->intr_unlink_wait,
+				      struct ehci_qh, unlink_node);
+		if (!stopped &&
+		    qh->unlink_cycle == ehci->intr_unlink_wait_cycle)
+			break;
+		list_del(&qh->unlink_node);
+		start_do_unlink_intr(ehci, qh);
+	}
+
+	/* Handle remaining entries later */
+	if (!list_empty(&ehci->intr_unlink_wait)) {
+		ehci_enable_event(ehci, EHCI_HRTIMER_START_UNLINK_INTR, true);
+		++ehci->intr_unlink_wait_cycle;
+	}
+}
 
 /* Handle unlinked interrupt QHs once they are gone from the hardware */
 static void ehci_handle_intr_unlinks(struct ehci_hcd *ehci)
@@ -363,6 +405,7 @@ static void (*event_handlers[])(struct ehci_hcd *) = {
 	ehci_handle_controller_death,	/* EHCI_HRTIMER_POLL_DEAD */
 	ehci_handle_intr_unlinks,	/* EHCI_HRTIMER_UNLINK_INTR */
 	end_free_itds,			/* EHCI_HRTIMER_FREE_ITDS */
+	ehci_handle_start_intr_unlinks,	/* EHCI_HRTIMER_START_UNLINK_INTR */
 	unlink_empty_async,		/* EHCI_HRTIMER_ASYNC_UNLINKS */
 	ehci_iaa_watchdog,		/* EHCI_HRTIMER_IAA_WATCHDOG */
 	ehci_disable_PSE,		/* EHCI_HRTIMER_DISABLE_PERIODIC */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 7c978b2..1d2c164 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -88,6 +88,7 @@ enum ehci_hrtimer_event {
 	EHCI_HRTIMER_POLL_DEAD,		/* Wait for dead controller to stop */
 	EHCI_HRTIMER_UNLINK_INTR,	/* Wait for interrupt QH unlink */
 	EHCI_HRTIMER_FREE_ITDS,		/* Wait for unused iTDs and siTDs */
+	EHCI_HRTIMER_START_UNLINK_INTR, /* wait for new intr schedule */
 	EHCI_HRTIMER_ASYNC_UNLINKS,	/* Unlink empty async QHs */
 	EHCI_HRTIMER_IAA_WATCHDOG,	/* Handle lost IAA interrupts */
 	EHCI_HRTIMER_DISABLE_PERIODIC,	/* Wait to disable periodic sched */
@@ -143,6 +144,8 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		i_thresh;	/* uframes HC might cache */
 
 	union ehci_shadow	*pshadow;	/* mirror hw periodic table */
+	struct list_head	intr_unlink_wait;
+	unsigned		intr_unlink_wait_cycle;
 	struct list_head	intr_unlink;
 	unsigned		intr_unlink_cycle;
 	unsigned		now_frame;	/* frame from HC hardware */
-- 
1.7.9.5
