From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:35 +0800
Subject: [PATCH 07/14] usb: mv_udc: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-8-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Chao Xie <chao.xie@marvell.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/mv_udc.h      |    1 -
 drivers/usb/gadget/mv_udc_core.c |   14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
index 9073436..6d848b4 100644
--- a/drivers/usb/gadget/mv_udc.h
+++ b/drivers/usb/gadget/mv_udc.h
@@ -206,7 +206,6 @@ struct mv_udc {
 
 	int			errors;
 	unsigned		softconnect:1,
-				vbus_active:1,
 				remote_wakeup:1,
 				softconnected:1,
 				force_fs:1,
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index c8cf959..91a1b0d 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -1204,12 +1204,12 @@ static int mv_udc_vbus_session(struct usb_gadget *gadget, int is_active)
 	udc = container_of(gadget, struct mv_udc, gadget);
 	spin_lock_irqsave(&udc->lock, flags);
 
-	udc->vbus_active = (is_active != 0);
+	gadget->vbus_active = (is_active != 0);
 
 	dev_dbg(&udc->dev->dev, "%s: softconnect %d, vbus_active %d\n",
-		__func__, udc->softconnect, udc->vbus_active);
+		__func__, udc->softconnect, gadget->vbus_active);
 
-	if (udc->driver && udc->softconnect && udc->vbus_active) {
+	if (udc->driver && udc->softconnect && gadget->vbus_active) {
 		retval = mv_udc_enable(udc);
 		if (retval == 0) {
 			/* Clock is disabled, need re-init registers */
@@ -1244,9 +1244,9 @@ static int mv_udc_pullup(struct usb_gadget *gadget, int is_on)
 	udc->softconnect = (is_on != 0);
 
 	dev_dbg(&udc->dev->dev, "%s: softconnect %d, vbus_active %d\n",
-			__func__, udc->softconnect, udc->vbus_active);
+			__func__, udc->softconnect, gadget->vbus_active);
 
-	if (udc->driver && udc->softconnect && udc->vbus_active) {
+	if (udc->driver && udc->softconnect && gadget->vbus_active) {
 		retval = mv_udc_enable(udc);
 		if (retval == 0) {
 			/* Clock is disabled, need re-init registers */
@@ -1254,7 +1254,7 @@ static int mv_udc_pullup(struct usb_gadget *gadget, int is_on)
 			ep0_reset(udc);
 			udc_start(udc);
 		}
-	} else if (udc->driver && udc->vbus_active) {
+	} else if (udc->driver && gadget->vbus_active) {
 		/* stop all the transfer in queue*/
 		stop_activity(udc, udc->driver);
 		udc_stop(udc);
@@ -2356,7 +2356,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 	if (udc->clock_gating)
 		mv_udc_disable_internal(udc);
 	else
-		udc->vbus_active = 1;
+		udc->gadget.vbus_active = 1;
 
 	retval = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (retval)
-- 
1.7.0.4
