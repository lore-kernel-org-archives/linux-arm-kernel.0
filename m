From: colin.king@canonical.com (Colin King)
Date: Tue,  7 Nov 2017 14:39:14 +0000
Subject: [PATCH][V2] usb: gadget: pxa27x: Remove redundant assignment to
 is_short and dev
Message-ID: <20171107143914.5748-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Variable is_short is set to zero but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.  Pointer dev is assigned a value that
is not read and it is updated a few statements later, this too is
redundant and can be removed. Cleans up clan warnings:

drivers/usb/gadget/udc/pxa27x_udc.c:986:3: warning: Value stored
to 'is_short' is never read
drivers/usb/gadget/udc/pxa27x_udc.c:1141:2: warning: Value stored
to 'dev' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 14606f340325..d88e56cce56d 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -984,8 +984,6 @@ static int write_fifo(struct pxa_ep *ep, struct pxa27x_request *req)
 
 	max = ep->fifo_size;
 	do {
-		is_short = 0;
-
 		udccsr = udc_ep_readl(ep, UDCCSR);
 		if (udccsr & UDCCSR_PC) {
 			ep_vdbg(ep, "Clearing Transmit Complete, udccsr=%x\n",
@@ -1139,7 +1137,6 @@ static int pxa_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	if (unlikely(!_ep))
 		return -EINVAL;
 
-	dev = udc_usb_ep->dev;
 	ep = udc_usb_ep->pxa_ep;
 	if (unlikely(!ep))
 		return -EINVAL;
-- 
2.14.1
