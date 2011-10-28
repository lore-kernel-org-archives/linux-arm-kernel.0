From: svens@stackframe.org (Sven Schnelle)
Date: Fri, 28 Oct 2011 11:44:16 +0200
Subject: [PATCH] ATMEL USB: pass unknown FEATURE SET requests to gadget
Message-ID: <1319795056-8286-1-git-send-email-svens@stackframe.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the dbgp gadget with the atmel usb controller, the following
message is logged:

udc: ep0: Invalid setup request: 00.03 v0006 i0000 l0, halting endpoint...

That makes the gadget unusable with the atmel usba controller driver. Fix this
by passing unknown request to the gadget driver.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 drivers/usb/gadget/atmel_usba_udc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 271a9d8..49480493 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1310,7 +1310,7 @@ static int handle_ep0_setup(struct usba_udc *udc, struct usba_ep *ep,
 			} else if (feature_is_dev_remote_wakeup(crq)) {
 				udc->devstatus |= 1 << USB_DEVICE_REMOTE_WAKEUP;
 			} else {
-				goto stall;
+				goto delegate;
 			}
 		} else if (crq->bRequestType == USB_RECIP_ENDPOINT) {
 			struct usba_ep *target;
-- 
1.7.6.3
