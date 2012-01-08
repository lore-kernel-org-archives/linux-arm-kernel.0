From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 8 Jan 2012 21:57:55 +0100
Subject: [PATCH 1/3] s3c-hsudc: Use helper functions instead of generic
 container_of
In-Reply-To: <201201082156.44142.heiko@sntech.de>
References: <201201082156.44142.heiko@sntech.de>
Message-ID: <201201082157.55898.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The helper functions were definied but never used until now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/usb/gadget/s3c-hsudc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index df8661d..41b3a58 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -759,7 +759,7 @@ static int s3c_hsudc_ep_enable(struct usb_ep *_ep,
 	unsigned long flags;
 	u32 ecr = 0;
 
-	hsep = container_of(_ep, struct s3c_hsudc_ep, ep);
+	hsep = our_ep(_ep);
 	if (!_ep || !desc || hsep->desc || _ep->name == ep0name
 		|| desc->bDescriptorType != USB_DT_ENDPOINT
 		|| hsep->bEndpointAddress != desc->bEndpointAddress
@@ -853,7 +853,7 @@ static void s3c_hsudc_free_request(struct usb_ep *ep, struct usb_request *_req)
 {
 	struct s3c_hsudc_req *hsreq;
 
-	hsreq = container_of(_req, struct s3c_hsudc_req, req);
+	hsreq = our_req(_req);
 	WARN_ON(!list_empty(&hsreq->queue));
 	kfree(hsreq);
 }
@@ -876,12 +876,12 @@ static int s3c_hsudc_queue(struct usb_ep *_ep, struct usb_request *_req,
 	u32 offset;
 	u32 csr;
 
-	hsreq = container_of(_req, struct s3c_hsudc_req, req);
+	hsreq = our_req(_req);
 	if ((!_req || !_req->complete || !_req->buf ||
 		!list_empty(&hsreq->queue)))
 		return -EINVAL;
 
-	hsep = container_of(_ep, struct s3c_hsudc_ep, ep);
+	hsep = our_ep(_ep);
 	hsudc = hsep->dev;
 	if (!hsudc->driver || hsudc->gadget.speed == USB_SPEED_UNKNOWN)
 		return -ESHUTDOWN;
@@ -935,7 +935,7 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct s3c_hsudc_req *hsreq;
 	unsigned long flags;
 
-	hsep = container_of(_ep, struct s3c_hsudc_ep, ep);
+	hsep = our_ep(_ep);
 	if (!_ep || hsep->ep.name == ep0name)
 		return -EINVAL;
 
-- 
1.7.2.3
