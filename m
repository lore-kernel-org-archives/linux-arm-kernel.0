From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 20 Jun 2013 14:05:12 +0800
Subject: [RFC PATCH v1 5/6] USB: EHCI: improve interrupt qh unlink
In-Reply-To: <Pine.LNX.4.44L0.1306191138050.2026-100000@iolanthe.rowland.org>
References: <CACVXFVOMDbWRWErkF5iDqtsJVBwD4B4fn22ZR1vupb78bKoDiQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1306191138050.2026-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVOp_zPRA65QBwLdD7pPLR1efK1_HSg1CmHbYCpmY+JJqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 11:44 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 19 Jun 2013, Ming Lei wrote:
>
>> > The approach used in this patch is wrong.  You shouldn't start the
>> > unlink, then wait, then finish the unlink.  Consider what would happen
>>
>> What you mentioned above is just what the patch is doing, :-)
>>
>> start_unlink_intr() only sets the qh as QH_STATE_UNLINK_WAIT, puts
>> the qh into one wait list and starts a timer, if it is expired the qh will be
>> started to unlink, otherwise the qh can be recovered to QH_STATE_LINKED
>> immediately if there is one URB submitted.
>
> Okay, maybe I was fooled by your use of QH_STATE_UNLINK_WAIT.  Setting
> the state to that value means that the QH is going to be unlinked after

Here the meaning of intr qh's QH_STATE_UNLINK_WAIT is a bit different
with async qh's.

> a time delay.  However, that's not what you mean; you mean that after a
> time delay you will decide whether or not to unlink the QH.

Yes, that is the difference with async QH.

>
> I think you should copy the approach used for the async QHs.

Yes, we can copy, but current async unlinking has some disadvantages,
see below.

>> So unlinking intr qh becomes a 3-stage process:
>>
>>        - wait(qh return to linked state if URB is submitted during the period,
>>                   otherwise go to start unlink)
>>        - start unlink(do unlink, and wait for end of unlink)
>>        - end unlink
>>
>> > if an URB were submitted during the delay: It would have to wait until
>>
>> If an URB were submitted during the delay, the previous wait is canceled
>> immediately, and the qh state is recovered to linked state, please see
>> cancel_unlink_wait_intr() called in intr_submit().
>
> Right.  But you're not allowed to do that after changing qh->state.
> One of the invariants of the driver is that once qh->state takes on any
> value other than QH_STATE_LINKED (or, temporarily,
> QH_STATE_COMPLETING), the QH must be unlinked.  The state can't change
> back to QH_STATE_LINKED without first passing through QH_STATE_IDLE.

IMO, there is no any side effect when we change the state to
QH_STATE_UNLINK_WAIT and later change back to QH_STATE_LINKED
later under this situation.

The reason why I use QH_STATE_UNLINK_WAIT here is for avoiding
unnecessary CPU wakeup.  Without the state, the unlink wait timer
is still triggered to check if there are intr QHs to be unlinked, but in most of
situations, there aren't QHs to be unlinked since tasklet is surely run
before the wait timer is expired. So generally, without knowing the wait state,
CPU wakeup events may be introduced unnecessarily.

Considered that the interval of interrupt endpoint might be very
small(e.g. 125us,
1ms) and some devices have very frequent intr event, I think we
need to pay attention to the problem.

Even on async QH situation, we might need to consider the problem too
since some application(eg. bulk only mass storage on xhci) may have
thousands of interrupts per seconds during data transfer, so CPU wakeup
events could be increased much by letting wait timer expire unnecessarily.

Also the async QH unlink approach has another disadvantage:

- if there are several QHs which are become empty during one wait period,
the hrtimer has to be scheduled several times for starting unlink one qh
each time. And after introducing the unlink wait list like the patch, we only
need schedule the hrtimer one time for unlinking all these empty QHs.

Finally, unlink wait for intr qh is only needed when the qh is completed
right now, and other cases(eg. unlink) needn't the wait.

The attached patch removes the QH_STATE_UNLINK_WAIT, and can
avoid the above disadvantages of async QH unlink, could you comment
on the new patch?

---
 drivers/usb/host/ehci-hcd.c   |    8 +++---
 drivers/usb/host/ehci-hub.c   |    1 +
 drivers/usb/host/ehci-sched.c |   54 ++++++++++++++++++++++++++++++++++++++---
 drivers/usb/host/ehci-timer.c |   45 +++++++++++++++++++++++++++++++++-
 drivers/usb/host/ehci.h       |    3 +++
 5 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 246e124..35b4148 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -304,7 +304,8 @@ static void end_unlink_async(struct ehci_hcd *ehci);
 static void unlink_empty_async(struct ehci_hcd *ehci);
 static void unlink_empty_async_suspended(struct ehci_hcd *ehci);
 static void ehci_work(struct ehci_hcd *ehci);
-static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh);
+static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh,
+			      bool wait);
 static void end_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh);

 #include "ehci-timer.c"
@@ -484,6 +485,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	ehci->periodic_size = DEFAULT_I_TDPS;
 	INIT_LIST_HEAD(&ehci->async_unlink);
 	INIT_LIST_HEAD(&ehci->async_idle);
+	INIT_LIST_HEAD(&ehci->intr_unlink_wait);
 	INIT_LIST_HEAD(&ehci->intr_unlink);
 	INIT_LIST_HEAD(&ehci->intr_qh_list);
 	INIT_LIST_HEAD(&ehci->cached_itd_list);
@@ -908,7 +910,7 @@ static int ehci_urb_dequeue(struct usb_hcd *hcd,
struct urb *urb, int status)
 		switch (qh->qh_state) {
 		case QH_STATE_LINKED:
 			if (usb_pipetype(urb->pipe) == PIPE_INTERRUPT)
-				start_unlink_intr(ehci, qh);
+				start_unlink_intr(ehci, qh, false);
 			else
 				start_unlink_async(ehci, qh);
 			break;
@@ -1042,7 +1044,7 @@ ehci_endpoint_reset(struct usb_hcd *hcd, struct
usb_host_endpoint *ep)
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
index acff5b8..5dfda56 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -548,6 +548,9 @@ static void qh_link_periodic(struct ehci_hcd
*ehci, struct ehci_qh *qh)

 	list_add(&qh->intr_node, &ehci->intr_qh_list);

+	/* unlink need this node to be initialized */
+	INIT_LIST_HEAD(&qh->unlink_node);
+
 	/* maybe enable periodic schedule processing */
 	++ehci->intr_count;
 	enable_periodic(ehci);
@@ -601,12 +604,24 @@ static void qh_unlink_periodic(struct ehci_hcd
*ehci, struct ehci_qh *qh)
 	list_del(&qh->intr_node);
 }

-static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
+/* must be called with holding ehci->lock */
+static void cancel_unlink_wait_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
 {
-	/* If the QH isn't linked then there's nothing we can do. */
-	if (qh->qh_state != QH_STATE_LINKED)
+	if (qh->qh_state != QH_STATE_LINKED || list_empty(&qh->unlink_node))
 		return;

+	list_del_init(&qh->unlink_node);
+
+	/* avoid unnecessary CPU wakeup */
+	if (list_empty(&ehci->intr_unlink_wait))
+		ehci_disable_event(ehci, EHCI_HRTIMER_START_UNLINK_INTR);
+}
+
+static void start_do_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh)
+{
+	/* if the qh is waitting for unlink, cancel it now */
+	cancel_unlink_wait_intr(ehci, qh);
+
 	qh_unlink_periodic (ehci, qh);

 	/* Make sure the unlinks are visible before starting the timer */
@@ -632,6 +647,34 @@ static void start_unlink_intr(struct ehci_hcd
*ehci, struct ehci_qh *qh)
 	}
 }

+/*
+ * It is common only one intr URB is scheduled on one qh, and
+ * given complete() is run in tasklet context, introduce a bit
+ * delay to avoid unlink qh too early.
+ */
+static void start_unlink_intr(struct ehci_hcd *ehci, struct ehci_qh *qh,
+			      bool wait)
+{
+	/* If the QH isn't linked then there's nothing we can do. */
+	if (qh->qh_state != QH_STATE_LINKED)
+		return;
+
+	if (!wait)
+		return start_do_unlink_intr(ehci, qh);
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
@@ -876,6 +919,9 @@ static int intr_submit (
 			goto done;
 	}

+	/* put back qh from unlink wait list */
+	cancel_unlink_wait_intr(ehci, qh);
+
 	/* then queue the urb's tds to the qh */
 	qh = qh_append_tds(ehci, urb, qtd_list, epnum, &urb->ep->hcpriv);
 	BUG_ON (qh == NULL);
@@ -921,7 +967,7 @@ static void scan_intr(struct ehci_hcd *ehci)
 			temp = qh_completions(ehci, qh);
 			if (unlikely(temp || (list_empty(&qh->qtd_list) &&
 					qh->qh_state == QH_STATE_LINKED)))
-				start_unlink_intr(ehci, qh);
+				start_unlink_intr(ehci, qh, true);
 		}
 	}
 }
diff --git a/drivers/usb/host/ehci-timer.c b/drivers/usb/host/ehci-timer.c
index 11e5b32..b8aadb9 100644
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
@@ -98,6 +99,17 @@ static void ehci_enable_event(struct ehci_hcd
*ehci, unsigned event,
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
@@ -215,6 +227,36 @@ static void ehci_handle_controller_death(struct
ehci_hcd *ehci)
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
+		list_del_init(&qh->unlink_node);
+		start_unlink_intr(ehci, qh, false);
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
@@ -236,7 +278,7 @@ static void ehci_handle_intr_unlinks(struct ehci_hcd *ehci)
 				unlink_node);
 		if (!stopped && qh->unlink_cycle == ehci->intr_unlink_cycle)
 			break;
-		list_del(&qh->unlink_node);
+		list_del_init(&qh->unlink_node);
 		end_unlink_intr(ehci, qh);
 	}

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



Thanks,
--
Ming Lei
