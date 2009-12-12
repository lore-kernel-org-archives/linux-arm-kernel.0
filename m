From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 12 Dec 2009 15:13:24 +0100
Subject: [PATCH] pxa27x_udc: Fix deadlocks on request queueing
Message-ID: <mailman.109.1262031886.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by Antonio, there are cases where the ep->lock
can be taken twice, triggering a deadlock.
The typical sequence is :
 irq_handler
   \
    -> gadget.complete()
       \
        -> pxa27x_udc.pxa_ep_queue() : ep->lock is taken
           \
            -> gadget.complete()
               \
                -> pxa27x_udc.pxa_ep_queue() : ep->lock is taken
                                               ==> *deadlock*
The patch fixes this by :
 - releasing the lock each time gadget.complete() is called
 - adding a check in handle_ep() to detect a recursive call,
   in which case the function becomes on no-op.

The patch is still not good enough for ep0. For this unique
endpoint, another well thought over patch will be needed.

Reported-by: Antonio Ospite <ospite@studenti.unina.it>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/usb/gadget/pxa27x_udc.c |  114 +++++++++++++++++++++++++++------------
 drivers/usb/gadget/pxa27x_udc.h |    6 ++
 2 files changed, 85 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index 1937d8c..6ca81a9 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -742,13 +742,17 @@ static void ep_del_request(struct pxa_ep *ep, struct pxa27x_request *req)
  * @ep: pxa physical endpoint
  * @req: pxa request
  * @status: usb request status sent to gadget API
+ * @pflags: flags of previous spinlock_irq_save() or NULL if no lock held
  *
- * Context: ep->lock held
+ * Context: ep->lock held if flags not NULL, else ep->lock released
  *
  * Retire a pxa27x usb request. Endpoint must be locked.
  */
-static void req_done(struct pxa_ep *ep, struct pxa27x_request *req, int status)
+static void req_done(struct pxa_ep *ep, struct pxa27x_request *req, int status,
+	unsigned long *pflags)
 {
+	unsigned long	flags;
+
 	ep_del_request(ep, req);
 	if (likely(req->req.status == -EINPROGRESS))
 		req->req.status = status;
@@ -760,38 +764,48 @@ static void req_done(struct pxa_ep *ep, struct pxa27x_request *req, int status)
 			&req->req, status,
 			req->req.actual, req->req.length);
 
+	if (pflags)
+		spin_unlock_irqrestore(&ep->lock, *pflags);
+	local_irq_save(flags);
 	req->req.complete(&req->udc_usb_ep->usb_ep, &req->req);
+	local_irq_restore(flags);
+	if (pflags)
+		spin_lock_irqsave(&ep->lock, *pflags);
 }
 
 /**
  * ep_end_out_req - Ends endpoint OUT request
  * @ep: physical endpoint
  * @req: pxa request
+ * @pflags: flags of previous spinlock_irq_save() or NULL if no lock held
  *
- * Context: ep->lock held
+ * Context: ep->lock held or released (see req_done())
  *
  * Ends endpoint OUT request (completes usb request).
  */
-static void ep_end_out_req(struct pxa_ep *ep, struct pxa27x_request *req)
+static void ep_end_out_req(struct pxa_ep *ep, struct pxa27x_request *req,
+	unsigned long *pflags)
 {
 	inc_ep_stats_reqs(ep, !USB_DIR_IN);
-	req_done(ep, req, 0);
+	req_done(ep, req, 0, pflags);
 }
 
 /**
  * ep0_end_out_req - Ends control endpoint OUT request (ends data stage)
  * @ep: physical endpoint
  * @req: pxa request
+ * @pflags: flags of previous spinlock_irq_save() or NULL if no lock held
  *
- * Context: ep->lock held
+ * Context: ep->lock held or released (see req_done())
  *
  * Ends control endpoint OUT request (completes usb request), and puts
  * control endpoint into idle state
  */
-static void ep0_end_out_req(struct pxa_ep *ep, struct pxa27x_request *req)
+static void ep0_end_out_req(struct pxa_ep *ep, struct pxa27x_request *req,
+	unsigned long *pflags)
 {
 	set_ep0state(ep->dev, OUT_STATUS_STAGE);
-	ep_end_out_req(ep, req);
+	ep_end_out_req(ep, req, pflags);
 	ep0_idle(ep->dev);
 }
 
@@ -799,31 +813,35 @@ static void ep0_end_out_req(struct pxa_ep *ep, struct pxa27x_request *req)
  * ep_end_in_req - Ends endpoint IN request
  * @ep: physical endpoint
  * @req: pxa request
+ * @pflags: flags of previous spinlock_irq_save() or NULL if no lock held
  *
- * Context: ep->lock held
+ * Context: ep->lock held or released (see req_done())
  *
  * Ends endpoint IN request (completes usb request).
  */
-static void ep_end_in_req(struct pxa_ep *ep, struct pxa27x_request *req)
+static void ep_end_in_req(struct pxa_ep *ep, struct pxa27x_request *req,
+	unsigned long *pflags)
 {
 	inc_ep_stats_reqs(ep, USB_DIR_IN);
-	req_done(ep, req, 0);
+	req_done(ep, req, 0, pflags);
 }
 
 /**
  * ep0_end_in_req - Ends control endpoint IN request (ends data stage)
  * @ep: physical endpoint
  * @req: pxa request
+ * @pflags: flags of previous spinlock_irq_save() or NULL if no lock held
  *
- * Context: ep->lock held
+ * Context: ep->lock held or released (see req_done())
  *
  * Ends control endpoint IN request (completes usb request), and puts
  * control endpoint into status state
  */
-static void ep0_end_in_req(struct pxa_ep *ep, struct pxa27x_request *req)
+static void ep0_end_in_req(struct pxa_ep *ep, struct pxa27x_request *req,
+	unsigned long *pflags)
 {
 	set_ep0state(ep->dev, IN_STATUS_STAGE);
-	ep_end_in_req(ep, req);
+	ep_end_in_req(ep, req, pflags);
 }
 
 /**
@@ -831,19 +849,22 @@ static void ep0_end_in_req(struct pxa_ep *ep, struct pxa27x_request *req)
  * @ep: pxa endpoint
  * @status: usb request status
  *
- * Context: ep->lock held
+ * Context: ep->lock released
  *
  * Dequeues all requests on an endpoint. As a side effect, interrupts will be
  * disabled on that endpoint (because no more requests).
  */
 static void nuke(struct pxa_ep *ep, int status)
 {
-	struct pxa27x_request *req;
+	struct pxa27x_request	*req;
+	unsigned long		flags;
 
+	spin_lock_irqsave(&ep->lock, flags);
 	while (!list_empty(&ep->queue)) {
 		req = list_entry(ep->queue.next, struct pxa27x_request, queue);
-		req_done(ep, req, status);
+		req_done(ep, req, status, &flags);
 	}
+	spin_unlock_irqrestore(&ep->lock, flags);
 }
 
 /**
@@ -1123,6 +1144,7 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	int			rc = 0;
 	int			is_first_req;
 	unsigned		length;
+	int			recursion_detected;
 
 	req = container_of(_req, struct pxa27x_request, req);
 	udc_usb_ep = container_of(_ep, struct udc_usb_ep, usb_ep);
@@ -1152,6 +1174,7 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 		return -EMSGSIZE;
 
 	spin_lock_irqsave(&ep->lock, flags);
+	recursion_detected = ep->in_handle_ep;
 
 	is_first_req = list_empty(&ep->queue);
 	ep_dbg(ep, "queue req %p(first=%s), len %d buf %p\n",
@@ -1161,12 +1184,12 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	if (!ep->enabled) {
 		_req->status = -ESHUTDOWN;
 		rc = -ESHUTDOWN;
-		goto out;
+		goto out_locked;
 	}
 
 	if (req->in_use) {
 		ep_err(ep, "refusing to queue req %p (already queued)\n", req);
-		goto out;
+		goto out_locked;
 	}
 
 	length = _req->length;
@@ -1174,12 +1197,13 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	_req->actual = 0;
 
 	ep_add_request(ep, req);
+	spin_unlock_irqrestore(&ep->lock, flags);
 
 	if (is_ep0(ep)) {
 		switch (dev->ep0state) {
 		case WAIT_ACK_SET_CONF_INTERF:
 			if (length == 0) {
-				ep_end_in_req(ep, req);
+				ep_end_in_req(ep, req, NULL);
 			} else {
 				ep_err(ep, "got a request of %d bytes while"
 					"in state WAIT_ACK_SET_CONF_INTERF\n",
@@ -1192,12 +1216,12 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 		case IN_DATA_STAGE:
 			if (!ep_is_full(ep))
 				if (write_ep0_fifo(ep, req))
-					ep0_end_in_req(ep, req);
+					ep0_end_in_req(ep, req, NULL);
 			break;
 		case OUT_DATA_STAGE:
 			if ((length == 0) || !epout_has_pkt(ep))
 				if (read_ep0_fifo(ep, req))
-					ep0_end_out_req(ep, req);
+					ep0_end_out_req(ep, req, NULL);
 			break;
 		default:
 			ep_err(ep, "odd state %s to send me a request\n",
@@ -1207,12 +1231,15 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 			break;
 		}
 	} else {
-		handle_ep(ep);
+		if (!recursion_detected)
+			handle_ep(ep);
 	}
 
 out:
-	spin_unlock_irqrestore(&ep->lock, flags);
 	return rc;
+out_locked:
+	spin_unlock_irqrestore(&ep->lock, flags);
+	goto out;
 }
 
 /**
@@ -1242,13 +1269,14 @@ static int pxa_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	/* make sure it's actually queued on this endpoint */
 	list_for_each_entry(req, &ep->queue, queue) {
 		if (&req->req == _req) {
-			req_done(ep, req, -ECONNRESET);
 			rc = 0;
 			break;
 		}
 	}
 
 	spin_unlock_irqrestore(&ep->lock, flags);
+	if (!rc)
+		req_done(ep, req, -ECONNRESET, NULL);
 	return rc;
 }
 
@@ -1445,7 +1473,6 @@ static int pxa_ep_disable(struct usb_ep *_ep)
 {
 	struct pxa_ep		*ep;
 	struct udc_usb_ep	*udc_usb_ep;
-	unsigned long		flags;
 
 	if (!_ep)
 		return -EINVAL;
@@ -1455,10 +1482,8 @@ static int pxa_ep_disable(struct usb_ep *_ep)
 	if (!ep || is_ep0(ep) || !list_empty(&ep->queue))
 		return -EINVAL;
 
-	spin_lock_irqsave(&ep->lock, flags);
 	ep->enabled = 0;
 	nuke(ep, -ESHUTDOWN);
-	spin_unlock_irqrestore(&ep->lock, flags);
 
 	pxa_ep_fifo_flush(_ep);
 	udc_usb_ep->pxa_ep = NULL;
@@ -1907,8 +1932,10 @@ static void handle_ep0_ctrl_req(struct pxa_udc *udc,
 	} u;
 	int i;
 	int have_extrabytes = 0;
+	unsigned long flags;
 
 	nuke(ep, -EPROTO);
+	spin_lock_irqsave(&ep->lock, flags);
 
 	/*
 	 * In the PXA320 manual, in the section about Back-to-Back setup
@@ -1947,10 +1974,13 @@ static void handle_ep0_ctrl_req(struct pxa_udc *udc,
 	/* Tell UDC to enter Data Stage */
 	ep_write_UDCCSR(ep, UDCCSR0_SA | UDCCSR0_OPC);
 
+	spin_unlock_irqrestore(&ep->lock, flags);
 	i = udc->driver->setup(&udc->gadget, &u.r);
+	spin_lock_irqsave(&ep->lock, flags);
 	if (i < 0)
 		goto stall;
 out:
+	spin_unlock_irqrestore(&ep->lock, flags);
 	return;
 stall:
 	ep_dbg(ep, "protocol STALL, udccsr0=%03x err %d\n",
@@ -2055,13 +2085,13 @@ static void handle_ep0(struct pxa_udc *udc, int fifo_irq, int opc_irq)
 		if (req && !ep_is_full(ep))
 			completed = write_ep0_fifo(ep, req);
 		if (completed)
-			ep0_end_in_req(ep, req);
+			ep0_end_in_req(ep, req, NULL);
 		break;
 	case OUT_DATA_STAGE:			/* SET_DESCRIPTOR */
 		if (epout_has_pkt(ep) && req)
 			completed = read_ep0_fifo(ep, req);
 		if (completed)
-			ep0_end_out_req(ep, req);
+			ep0_end_out_req(ep, req, NULL);
 		break;
 	case STALL:
 		ep_write_UDCCSR(ep, UDCCSR0_FST);
@@ -2091,7 +2121,7 @@ static void handle_ep0(struct pxa_udc *udc, int fifo_irq, int opc_irq)
  * Tries to transfer all pending request data into the endpoint and/or
  * transfer all pending data in the endpoint into usb requests.
  *
- * Is always called when in_interrupt() or with ep->lock held.
+ * Is always called when in_interrupt() and with ep->lock released.
  */
 static void handle_ep(struct pxa_ep *ep)
 {
@@ -2100,10 +2130,17 @@ static void handle_ep(struct pxa_ep *ep)
 	u32 udccsr;
 	int is_in = ep->dir_in;
 	int loop = 0;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&ep->lock, flags);
+	if (ep->in_handle_ep)
+		goto recursion_detected;
+	ep->in_handle_ep = 1;
 
 	do {
 		completed = 0;
 		udccsr = udc_ep_readl(ep, UDCCSR);
+
 		if (likely(!list_empty(&ep->queue)))
 			req = list_entry(ep->queue.next,
 					struct pxa27x_request, queue);
@@ -2122,15 +2159,22 @@ static void handle_ep(struct pxa_ep *ep)
 		if (unlikely(is_in)) {
 			if (likely(!ep_is_full(ep)))
 				completed = write_fifo(ep, req);
-			if (completed)
-				ep_end_in_req(ep, req);
 		} else {
 			if (likely(epout_has_pkt(ep)))
 				completed = read_fifo(ep, req);
-			if (completed)
-				ep_end_out_req(ep, req);
+		}
+
+		if (completed) {
+			if (is_in)
+				ep_end_in_req(ep, req, &flags);
+			else
+				ep_end_out_req(ep, req, &flags);
 		}
 	} while (completed);
+
+	ep->in_handle_ep = 0;
+recursion_detected:
+	spin_unlock_irqrestore(&ep->lock, flags);
 }
 
 /**
diff --git a/drivers/usb/gadget/pxa27x_udc.h b/drivers/usb/gadget/pxa27x_udc.h
index e25225e..ff61e48 100644
--- a/drivers/usb/gadget/pxa27x_udc.h
+++ b/drivers/usb/gadget/pxa27x_udc.h
@@ -318,6 +318,11 @@ struct udc_usb_ep {
  * @queue: requests queue
  * @lock: lock to pxa_ep data (queues and stats)
  * @enabled: true when endpoint enabled (not stopped by gadget layer)
+ * @in_handle_ep: number of recursions of handle_ep() function
+ * 	Prevents deadlocks or infinite recursions of types :
+ *	  irq->handle_ep()->req_done()->req.complete()->pxa_ep_queue()->handle_ep()
+ *      or
+ *        pxa_ep_queue()->handle_ep()->req_done()->req.complete()->pxa_ep_queue()
  * @idx: endpoint index (1 => epA, 2 => epB, ..., 24 => epX)
  * @name: endpoint name (for trace/debug purpose)
  * @dir_in: 1 if IN endpoint, 0 if OUT endpoint
@@ -346,6 +351,7 @@ struct pxa_ep {
 	spinlock_t		lock;		/* Protects this structure */
 						/* (queues, stats) */
 	unsigned		enabled:1;
+	unsigned		in_handle_ep:1;
 
 	unsigned		idx:5;
 	char			*name;
-- 
1.6.3.3
