From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 28 Jun 2013 17:07:52 +0800
Subject: [PATCH v3 3/4] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <1372410473-30920-1-git-send-email-ming.lei@canonical.com>
References: <1372410473-30920-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1372410473-30920-4-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ehci-hcd currently unlinks an interrupt QH when it becomes empty, that
is, after its last URB completes.  This works well because in almost
all cases, the completion handler for an interrupt URB resubmits the
URB; therefore the QH doesn't become empty and doesn't get unlinked.

When we start using tasklets for URB completion, this scheme won't work
as well.  The resubmission won't occur until the tasklet runs, which
will be some time after the completion is queued with the tasklet.
During that delay, the QH will be empty and so will be unlinked
unnecessarily.

To prevent this problem, this patch adds a 5-ms time delay before empty
interrupt QHs are unlinked.  Most often, during that time the interrupt
URB will be resubmitted and thus we can avoid unlinking the QH.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/usb/host/ehci-hcd.c   |    1 +
 drivers/usb/host/ehci-hub.c   |    1 +
 drivers/usb/host/ehci-mem.c   |    1 +
 drivers/usb/host/ehci-sched.c |   47 ++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/ehci-timer.c |   35 ++++++++++++++++++++++++++++--
 drivers/usb/host/ehci.h       |    3 +++
 6 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 246e124..e2fccc0 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -484,6 +484,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	ehci->periodic_size = DEFAULT_I_TDPS;
 	INIT_LIST_HEAD(&ehci->async_unlink);
 	INIT_LIST_HEAD(&ehci->async_idle);
+	INIT_LIST_HEAD(&ehci->intr_unlink_wait);
 	INIT_LIST_HEAD(&ehci->intr_unlink);
 	INIT_LIST_HEAD(&ehci->intr_qh_list);
 	INIT_LIST_HEAD(&ehci->cached_itd_list);
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
 
diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index ef2c3a1..52a7773 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -93,6 +93,7 @@ static struct ehci_qh *ehci_qh_alloc (struct ehci_hcd *ehci, gfp_t flags)
 	qh->qh_dma = dma;
 	// INIT_LIST_HEAD (&qh->qh_list);
 	INIT_LIST_HEAD (&qh->qtd_list);
+	INIT_LIST_HEAD(&qh->unlink_node);
 
 	/* dummy td enables safe urb queuing */
 	qh->dummy = ehci_qtd_alloc (ehci, flags);
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index acff5b8..101aea6 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -601,12 +601,29 @@ static void qh_unlink_periodic(struct ehci_hcd *ehci, struct ehci_qh *qh)
 	list_del(&qh->intr_node);
 }
 
+static void cancel_unlink_wait_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
+{
+	if (qh->qh_state != QH_STATE_LINKED ||
+			list_empty(&qh->unlink_node))
+		return;
+
+	list_del_init(&qh->unlink_node);
+
+	/*
+	 * TODO: disable the event of EHCI_HRTIMER_START_UNLINK_INTR for
+	 * avoiding unnecessary CPU wakeup
+	 */
+}
+
 static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
 	/* If the QH isn't linked then there's nothing we can do. */
 	if (qh->qh_state != QH_STATE_LINKED)
 		return;
 
+	/* if the qh is waiting for unlink, cancel it now */
+	cancel_unlink_wait_intr(ehci, qh);
+
 	qh_unlink_periodic (ehci, qh);
 
 	/* Make sure the unlinks are visible before starting the timer */
@@ -632,6 +649,31 @@ static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
 	}
 }
 
+/*
+ * It is common only one intr URB is scheduled on one qh, and
+ * given complete() is run in tasklet context, introduce a bit
+ * delay to avoid unlink qh too early.
+ */
+static void start_unlink_intr_wait(struct ehci_hcd *ehci,
+				   struct ehci_qh *qh)
+{
+	/* If the QH isn't linked then there's nothing we can do. */
+	if (qh->qh_state != QH_STATE_LINKED)
+		return;
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
 static void end_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
 	struct ehci_qh_hw	*hw = qh->hw;
@@ -884,6 +926,9 @@ static int intr_submit (
 	if (qh->qh_state == QH_STATE_IDLE) {
 		qh_refresh(ehci, qh);
 		qh_link_periodic(ehci, qh);
+	} else {
+		/* cancel unlink wait for the qh */
+		cancel_unlink_wait_intr(ehci, qh);
 	}
 
 	/* ... update usbfs periodic stats */
@@ -921,7 +966,7 @@ static void scan_intr(struct ehci_hcd *ehci)
 			temp = qh_completions(ehci, qh);
 			if (unlikely(temp || (list_empty(&qh->qtd_list) &&
 					qh->qh_state == QH_STATE_LINKED)))
-				start_unlink_intr(ehci, qh);
+				start_unlink_intr_wait(ehci, qh);
 		}
 	}
 }
diff --git a/drivers/usb/host/ehci-timer.c b/drivers/usb/host/ehci-timer.c
index 11e5b32..25b9fa3 100644
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
@@ -98,7 +99,6 @@ static void ehci_enable_event(struct ehci_hcd *ehci, unsigned event,
 	}
 }
 
-
 /* Poll the STS_ASS status bit; see when it agrees with CMD_ASE */
 static void ehci_poll_ASS(struct ehci_hcd *ehci)
 {
@@ -215,6 +215,36 @@ static void ehci_handle_controller_death(struct ehci_hcd *ehci)
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
+				struct ehci_qh, unlink_node);
+		if (!stopped && (qh->unlink_cycle ==
+				ehci->intr_unlink_wait_cycle))
+			break;
+		list_del_init(&qh->unlink_node);
+		start_unlink_intr(ehci, qh);
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
@@ -236,7 +266,7 @@ static void ehci_handle_intr_unlinks(struct ehci_hcd *ehci)
 				unlink_node);
 		if (!stopped && qh->unlink_cycle == ehci->intr_unlink_cycle)
 			break;
-		list_del(&qh->unlink_node);
+		list_del_init(&qh->unlink_node);
 		end_unlink_intr(ehci, qh);
 	}
 
@@ -363,6 +393,7 @@ static void (*event_handlers[])(struct ehci_hcd *) = {
 	ehci_handle_controller_death,	/* EHCI_HRTIMER_POLL_DEAD */
 	ehci_handle_intr_unlinks,	/* EHCI_HRTIMER_UNLINK_INTR */
 	end_free_itds,			/* EHCI_HRTIMER_FREE_ITDS */
+	ehci_handle_start_intr_unlinks,	/* EHCI_HRTIMER_START_UNLINK_INTR */
 	unlink_empty_async,		/* EHCI_HRTIMER_ASYNC_UNLINKS */
 	ehci_iaa_watchdog,		/* EHCI_HRTIMER_IAA_WATCHDOG */
 	ehci_disable_PSE,		/* EHCI_HRTIMER_DISABLE_PERIODIC */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 7c978b2..2a55504 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -88,6 +88,7 @@ enum ehci_hrtimer_event {
 	EHCI_HRTIMER_POLL_DEAD,		/* Wait for dead controller to stop */
 	EHCI_HRTIMER_UNLINK_INTR,	/* Wait for interrupt QH unlink */
 	EHCI_HRTIMER_FREE_ITDS,		/* Wait for unused iTDs and siTDs */
+	EHCI_HRTIMER_START_UNLINK_INTR, /* Unlink empty interrupt QHs */
 	EHCI_HRTIMER_ASYNC_UNLINKS,	/* Unlink empty async QHs */
 	EHCI_HRTIMER_IAA_WATCHDOG,	/* Handle lost IAA interrupts */
 	EHCI_HRTIMER_DISABLE_PERIODIC,	/* Wait to disable periodic sched */
@@ -143,7 +144,9 @@ struct ehci_hcd {			/* one per controller */
 	unsigned		i_thresh;	/* uframes HC might cache */
 
 	union ehci_shadow	*pshadow;	/* mirror hw periodic table */
+	struct list_head	intr_unlink_wait;
 	struct list_head	intr_unlink;
+	unsigned		intr_unlink_wait_cycle;
 	unsigned		intr_unlink_cycle;
 	unsigned		now_frame;	/* frame from HC hardware */
 	unsigned		last_iso_frame;	/* last frame scanned for iso */
-- 
1.7.9.5
