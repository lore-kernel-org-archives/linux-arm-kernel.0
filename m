From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 12 Dec 2009 15:13:24 +0100
Subject: [PATCH] pxa27x_udc: Fix deadlocks on request queueing
Message-ID: <mailman.90.1260628145.2170.linux-arm-kernel@lists.infradead.org>
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

Reported-by: Antonio Ospite <ospite@studenti.unina.it>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/usb/gadget/pxa27x_udc.c |   51 ++++++++++++++++++++++++++------------
 drivers/usb/gadget/pxa27x_udc.h |    6 ++++
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index e305799..c104d3e 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -743,7 +743,7 @@ static void ep_del_request(struct pxa_ep *ep, struct pxa27x_request *req)
  * @req: pxa request
  * @status: usb request status sent to gadget API
  *
- * Context: ep->lock held
+ * Context: ep->lock released
  *
  * Retire a pxa27x usb request. Endpoint must be locked.
  */
@@ -768,7 +768,7 @@ static void req_done(struct pxa_ep *ep, struct pxa27x_request *req, int status)
  * @ep: physical endpoint
  * @req: pxa request
  *
- * Context: ep->lock held
+ * Context: ep->lock released
  *
  * Ends endpoint OUT request (completes usb request).
  */
@@ -783,7 +783,7 @@ static void ep_end_out_req(struct pxa_ep *ep, struct pxa27x_request *req)
  * @ep: physical endpoint
  * @req: pxa request
  *
- * Context: ep->lock held
+ * Context: ep->lock released
  *
  * Ends control endpoint OUT request (completes usb request), and puts
  * control endpoint into idle state
@@ -800,7 +800,7 @@ static void ep0_end_out_req(struct pxa_ep *ep, struct pxa27x_request *req)
  * @ep: physical endpoint
  * @req: pxa request
  *
- * Context: ep->lock held
+ * Context: ep->lock released
  *
  * Ends endpoint IN request (completes usb request).
  */
@@ -815,7 +815,7 @@ static void ep_end_in_req(struct pxa_ep *ep, struct pxa27x_request *req)
  * @ep: physical endpoint
  * @req: pxa request
  *
- * Context: ep->lock held
+ * Context: ep->lock released
  *
  * Ends control endpoint IN request (completes usb request), and puts
  * control endpoint into status state
@@ -831,17 +831,21 @@ static void ep0_end_in_req(struct pxa_ep *ep, struct pxa27x_request *req)
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
 
 	while (!list_empty(&ep->queue)) {
+		spin_lock_irqsave(&ep->lock, flags);
 		req = list_entry(ep->queue.next, struct pxa27x_request, queue);
+		spin_unlock_irqrestore(&ep->lock, flags);
+
 		req_done(ep, req, status);
 	}
 }
@@ -1173,6 +1177,7 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	_req->actual = 0;
 
 	ep_add_request(ep, req);
+	spin_unlock_irqrestore(&ep->lock, flags);
 
 	if (is_ep0(ep)) {
 		switch (dev->ep0state) {
@@ -1210,7 +1215,6 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	}
 
 out:
-	spin_unlock_irqrestore(&ep->lock, flags);
 	return rc;
 }
 
@@ -1241,13 +1245,15 @@ static int pxa_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	/* make sure it's actually queued on this endpoint */
 	list_for_each_entry(req, &ep->queue, queue) {
 		if (&req->req == _req) {
-			req_done(ep, req, -ECONNRESET);
 			rc = 0;
 			break;
 		}
 	}
 
 	spin_unlock_irqrestore(&ep->lock, flags);
+
+	if (!rc)
+		req_done(ep, req, -ECONNRESET);
 	return rc;
 }
 
@@ -1444,7 +1450,6 @@ static int pxa_ep_disable(struct usb_ep *_ep)
 {
 	struct pxa_ep		*ep;
 	struct udc_usb_ep	*udc_usb_ep;
-	unsigned long		flags;
 
 	if (!_ep)
 		return -EINVAL;
@@ -1454,10 +1459,8 @@ static int pxa_ep_disable(struct usb_ep *_ep)
 	if (!ep || is_ep0(ep) || !list_empty(&ep->queue))
 		return -EINVAL;
 
-	spin_lock_irqsave(&ep->lock, flags);
 	ep->enabled = 0;
 	nuke(ep, -ESHUTDOWN);
-	spin_unlock_irqrestore(&ep->lock, flags);
 
 	pxa_ep_fifo_flush(_ep);
 	udc_usb_ep->pxa_ep = NULL;
@@ -2090,7 +2093,7 @@ static void handle_ep0(struct pxa_udc *udc, int fifo_irq, int opc_irq)
  * Tries to transfer all pending request data into the endpoint and/or
  * transfer all pending data in the endpoint into usb requests.
  *
- * Is always called when in_interrupt() or with ep->lock held.
+ * Is always called when in_interrupt() and with ep->lock released.
  */
 static void handle_ep(struct pxa_ep *ep)
 {
@@ -2099,13 +2102,20 @@ static void handle_ep(struct pxa_ep *ep)
 	u32 udccsr;
 	int is_in = ep->dir_in;
 	int loop = 0;
+	unsigned long		flags;
 
 	/* some code below uses registers not available for ep0 */
 	BUG_ON(is_ep0(ep));
 
+	spin_lock_irqsave(&ep->lock, flags);
+	if (ep->in_handle_ep)
+		goto recursion_detected;
+	ep->in_handle_ep = 1;
+
 	do {
 		completed = 0;
 		udccsr = udc_ep_readl(ep, UDCCSR);
+
 		if (likely(!list_empty(&ep->queue)))
 			req = list_entry(ep->queue.next,
 					struct pxa27x_request, queue);
@@ -2124,15 +2134,24 @@ static void handle_ep(struct pxa_ep *ep)
 		if (unlikely(is_in)) {
 			if (likely(!ep_is_full(ep)))
 				completed = write_fifo(ep, req);
-			if (completed)
-				ep_end_in_req(ep, req);
 		} else {
 			if (likely(epout_has_pkt(ep)))
 				completed = read_fifo(ep, req);
-			if (completed)
+		}
+
+		if (completed) {
+			spin_unlock_irqrestore(&ep->lock, flags);
+			if (is_in)
+				ep_end_in_req(ep, req);
+			else
 				ep_end_out_req(ep, req);
+			spin_lock_irqsave(&ep->lock, flags);
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
