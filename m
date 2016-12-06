From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  6 Dec 2016 22:59:43 +0100
Subject: [PATCH] usb: gadget: udc: atmel: Fix check in usba_ep_enable()
Message-ID: <1481061583-4727-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK is not necessarily
equal to ep->index and that's perfectly fine. The usba endpoint index is
just an internal identifier used by the driver to know which registers
to use for a USB endpoint.

Enforcing this constraint is not only useless, but can also lead to
errors since nothing guarantees that the endpoint number and index are
matching when an endpoint is selected for a specific descriptor, thus
leading to errors at ->enable() time when it's already too late to choose
another endpoint.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Hi,

I intentionally didn't add the Cc stable and Fixes tags because this
bug dates back to the drivers creation, and I fear the index <->
epnum constraint was actually required at that time.

Note that I discovered this bug thanks to the WARN_ON_ONCE() in
usb_ep_queue() [1] which was introduced in 4.5.
It might appear that this problem was silently ignored before that
(with part of the usba_ep_enable() code being skipped without any
notice).

Regards,

Boris

[1]http://lxr.free-electrons.com/source/drivers/usb/gadget/udc/core.c#L264
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index bb1f6c8f0f01..981d2639d413 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -531,11 +531,8 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 
 	maxpacket = usb_endpoint_maxp(desc) & 0x7ff;
 
-	if (((desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK) != ep->index)
-			|| ep->index == 0
-			|| desc->bDescriptorType != USB_DT_ENDPOINT
-			|| maxpacket == 0
-			|| maxpacket > ep->fifo_size) {
+	if (ep->index == 0 || desc->bDescriptorType != USB_DT_ENDPOINT ||
+	    maxpacket == 0 || maxpacket > ep->fifo_size) {
 		DBG(DBG_ERR, "ep_enable: Invalid argument");
 		return -EINVAL;
 	}
-- 
2.7.4
