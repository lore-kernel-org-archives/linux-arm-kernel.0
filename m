From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 17:19:09 +0100
Subject: [PATCH 8/9] usb: chipidea: udc: remove unlocked ep_queue which can
 lead to an race
In-Reply-To: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352909950-32555-9-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Its not nessecary to call ep_queue unlocked while in the
own driver. So we move the function to an unlocked version
and call it conditionaly.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/udc.c |  115 +++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 0ed2e1a..2999b0d 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -648,6 +648,68 @@ static void isr_get_status_complete(struct usb_ep *ep, struct usb_request *req)
 }
 
 /**
+ * _ep_queue: queues (submits) an I/O request to an endpoint
+ *
+ * Caller must hold lock
+ */
+static int _ep_queue(struct usb_ep *ep, struct usb_request *req,
+		    gfp_t __maybe_unused gfp_flags)
+{
+	struct ci13xxx_ep  *mEp  = container_of(ep,  struct ci13xxx_ep, ep);
+	struct ci13xxx_req *mReq = container_of(req, struct ci13xxx_req, req);
+	struct ci13xxx *ci = mEp->ci;
+	int retval = 0;
+
+	if (ep == NULL || req == NULL || mEp->ep.desc == NULL)
+		return -EINVAL;
+
+	if (mEp->type == USB_ENDPOINT_XFER_CONTROL) {
+		if (req->length)
+			mEp = (ci->ep0_dir == RX) ?
+			       ci->ep0out : ci->ep0in;
+		if (!list_empty(&mEp->qh.queue)) {
+			_ep_nuke(mEp);
+			retval = -EOVERFLOW;
+			dev_warn(mEp->ci->dev, "endpoint ctrl %X nuked\n",
+				 _usb_addr(mEp));
+		}
+	}
+
+	/* first nuke then test link, e.g. previous status has not sent */
+	if (!list_empty(&mReq->queue)) {
+		retval = -EBUSY;
+		dev_err(mEp->ci->dev, "request already in queue\n");
+		goto done;
+	}
+
+	if (req->length > 4 * CI13XXX_PAGE_SIZE) {
+		req->length = 4 * CI13XXX_PAGE_SIZE;
+		retval = -EMSGSIZE;
+		dev_warn(mEp->ci->dev, "request length truncated\n");
+	}
+
+	dbg_queue(_usb_addr(mEp), req, retval);
+
+	/* push request */
+	mReq->req.status = -EINPROGRESS;
+	mReq->req.actual = 0;
+
+	retval = _hardware_enqueue(mEp, mReq);
+
+	if (retval == -EALREADY) {
+		dbg_event(_usb_addr(mEp), "QUEUE", retval);
+		retval = 0;
+	}
+	if (!retval)
+		list_add_tail(&mReq->queue, &mEp->qh.queue);
+
+ done:
+	return retval;
+}
+
+
+
+/**
  * isr_get_status_response: get_status request response
  * @ci: ci struct
  * @setup: setup request packet
@@ -694,9 +756,7 @@ __acquires(mEp->lock)
 	}
 	/* else do nothing; reserved for future use */
 
-	spin_unlock(mEp->lock);
-	retval = usb_ep_queue(&mEp->ep, req, gfp_flags);
-	spin_lock(mEp->lock);
+	retval = _ep_queue(&mEp->ep, req, gfp_flags);
 	if (retval)
 		goto err_free_buf;
 
@@ -743,8 +803,6 @@ isr_setup_status_complete(struct usb_ep *ep, struct usb_request *req)
  * This function returns an error code
  */
 static int isr_setup_status_phase(struct ci13xxx *ci)
-__releases(mEp->lock)
-__acquires(mEp->lock)
 {
 	int retval;
 	struct ci13xxx_ep *mEp;
@@ -753,9 +811,7 @@ __acquires(mEp->lock)
 	ci->status->context = ci;
 	ci->status->complete = isr_setup_status_complete;
 
-	spin_unlock(mEp->lock);
-	retval = usb_ep_queue(&mEp->ep, ci->status, GFP_ATOMIC);
-	spin_lock(mEp->lock);
+	retval = _ep_queue(&mEp->ep, ci->status, GFP_ATOMIC);
 
 	return retval;
 }
@@ -1152,8 +1208,6 @@ static int ep_queue(struct usb_ep *ep, struct usb_request *req,
 		    gfp_t __maybe_unused gfp_flags)
 {
 	struct ci13xxx_ep  *mEp  = container_of(ep,  struct ci13xxx_ep, ep);
-	struct ci13xxx_req *mReq = container_of(req, struct ci13xxx_req, req);
-	struct ci13xxx *ci = mEp->ci;
 	int retval = 0;
 	unsigned long flags;
 
@@ -1162,47 +1216,8 @@ static int ep_queue(struct usb_ep *ep, struct usb_request *req,
 
 	spin_lock_irqsave(mEp->lock, flags);
 
-	if (mEp->type == USB_ENDPOINT_XFER_CONTROL) {
-		if (req->length)
-			mEp = (ci->ep0_dir == RX) ?
-			       ci->ep0out : ci->ep0in;
-		if (!list_empty(&mEp->qh.queue)) {
-			_ep_nuke(mEp);
-			retval = -EOVERFLOW;
-			dev_warn(mEp->ci->dev, "endpoint ctrl %X nuked\n",
-				 _usb_addr(mEp));
-		}
-	}
-
-	/* first nuke then test link, e.g. previous status has not sent */
-	if (!list_empty(&mReq->queue)) {
-		retval = -EBUSY;
-		dev_err(mEp->ci->dev, "request already in queue\n");
-		goto done;
-	}
-
-	if (req->length > 4 * CI13XXX_PAGE_SIZE) {
-		req->length = 4 * CI13XXX_PAGE_SIZE;
-		retval = -EMSGSIZE;
-		dev_warn(mEp->ci->dev, "request length truncated\n");
-	}
-
-	dbg_queue(_usb_addr(mEp), req, retval);
+	retval = _ep_queue(ep, req, gfp_flags);
 
-	/* push request */
-	mReq->req.status = -EINPROGRESS;
-	mReq->req.actual = 0;
-
-	retval = _hardware_enqueue(mEp, mReq);
-
-	if (retval == -EALREADY) {
-		dbg_event(_usb_addr(mEp), "QUEUE", retval);
-		retval = 0;
-	}
-	if (!retval)
-		list_add_tail(&mReq->queue, &mEp->qh.queue);
-
- done:
 	spin_unlock_irqrestore(mEp->lock, flags);
 	return retval;
 }
-- 
1.7.10.4
