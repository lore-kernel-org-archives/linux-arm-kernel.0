From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 17:19:10 +0100
Subject: [PATCH 9/9] usb: chipidea: udc: configure iso endpoints
In-Reply-To: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352909950-32555-10-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implementation is derived from the fsl_udc_core code in
fsl_ep_enable and makes basic iso handling possible.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/udc.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2999b0d..0bc4308 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1058,6 +1058,9 @@ static int ep_enable(struct usb_ep *ep,
 	int retval = 0;
 	unsigned long flags;
 
+	unsigned short max = 0;
+	unsigned char mult = 0;
+
 	if (ep == NULL || desc == NULL)
 		return -EINVAL;
 
@@ -1075,6 +1078,7 @@ static int ep_enable(struct usb_ep *ep,
 	mEp->type = usb_endpoint_type(desc);
 
 	mEp->ep.maxpacket = usb_endpoint_maxp(desc);
+	max = usb_endpoint_maxp(desc);
 
 	dbg_event(_usb_addr(mEp), "ENABLE", 0);
 
@@ -1082,8 +1086,12 @@ static int ep_enable(struct usb_ep *ep,
 
 	if (mEp->type == USB_ENDPOINT_XFER_CONTROL)
 		mEp->qh.ptr->cap |=  QH_IOS;
-	else if (mEp->type == USB_ENDPOINT_XFER_ISOC)
-		mEp->qh.ptr->cap &= ~QH_MULT;
+	else if (mEp->type == USB_ENDPOINT_XFER_ISOC) {
+		/* Calculate transactions needed for high bandwidth iso */
+		mult = (unsigned char)(1 + ((max >> 11) & 0x03));
+		max = max & 0x7ff;	/* bit 0~10 */
+		mEp->qh.ptr->cap |= (mult << 30);
+	}
 	else
 		mEp->qh.ptr->cap &= ~QH_ZLT;
 
-- 
1.7.10.4
