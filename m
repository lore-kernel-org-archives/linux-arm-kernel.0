From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:34 +0800
Subject: [PATCH 06/14] usb: mv_u3d_core: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Yu Xu <yuxu@marvell.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/mv_u3d.h      |    1 -
 drivers/usb/gadget/mv_u3d_core.c |   14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/mv_u3d.h b/drivers/usb/gadget/mv_u3d.h
index e32a787..16a6955 100644
--- a/drivers/usb/gadget/mv_u3d.h
+++ b/drivers/usb/gadget/mv_u3d.h
@@ -274,7 +274,6 @@ struct mv_u3d {
 	unsigned int		errors;
 
 	unsigned		softconnect:1;
-	unsigned		vbus_active:1;	/* vbus is active or not */
 	unsigned		remote_wakeup:1; /* support remote wakeup */
 	unsigned		clock_gating:1;	/* clock gating or not */
 	unsigned		active:1;	/* udc is active or not */
diff --git a/drivers/usb/gadget/mv_u3d_core.c b/drivers/usb/gadget/mv_u3d_core.c
index b5cea27..95236db 100644
--- a/drivers/usb/gadget/mv_u3d_core.c
+++ b/drivers/usb/gadget/mv_u3d_core.c
@@ -1159,15 +1159,15 @@ static int mv_u3d_vbus_session(struct usb_gadget *gadget, int is_active)
 
 	spin_lock_irqsave(&u3d->lock, flags);
 
-	u3d->vbus_active = (is_active != 0);
+	u3d->gadget.vbus_active = (is_active != 0);
 	dev_dbg(u3d->dev, "%s: softconnect %d, vbus_active %d\n",
-		__func__, u3d->softconnect, u3d->vbus_active);
+		__func__, u3d->softconnect, u3d->gadget.vbus_active);
 	/*
 	 * 1. external VBUS detect: we can disable/enable clock on demand.
 	 * 2. UDC VBUS detect: we have to enable clock all the time.
 	 * 3. No VBUS detect: we have to enable clock all the time.
 	 */
-	if (u3d->driver && u3d->softconnect && u3d->vbus_active) {
+	if (u3d->driver && u3d->softconnect && u3d->gadget.vbus_active) {
 		retval = mv_u3d_enable(u3d);
 		if (retval == 0) {
 			/*
@@ -1218,9 +1218,9 @@ static int mv_u3d_pullup(struct usb_gadget *gadget, int is_on)
 	spin_lock_irqsave(&u3d->lock, flags);
 
 	dev_dbg(u3d->dev, "%s: softconnect %d, vbus_active %d\n",
-		__func__, u3d->softconnect, u3d->vbus_active);
+		__func__, u3d->softconnect, u3d->gadget.vbus_active);
 	u3d->softconnect = (is_on != 0);
-	if (u3d->driver && u3d->softconnect && u3d->vbus_active) {
+	if (u3d->driver && u3d->softconnect && u3d->gadget.vbus_active) {
 		retval = mv_u3d_enable(u3d);
 		if (retval == 0) {
 			/*
@@ -1231,7 +1231,7 @@ static int mv_u3d_pullup(struct usb_gadget *gadget, int is_on)
 			mv_u3d_ep0_reset(u3d);
 			mv_u3d_controller_start(u3d);
 		}
-	} else if (u3d->driver && u3d->vbus_active) {
+	} else if (u3d->driver && u3d->gadget.vbus_active) {
 		/* stop all the transfer in queue*/
 		mv_u3d_stop_activity(u3d, u3d->driver);
 		mv_u3d_controller_stop(u3d);
@@ -1976,7 +1976,7 @@ static int mv_u3d_probe(struct platform_device *dev)
 	}
 
 	if (!u3d->clock_gating)
-		u3d->vbus_active = 1;
+		u3d->gadget.vbus_active = 1;
 
 	/* enable usb3 controller vbus detection */
 	u3d->vbus_valid_detect = 1;
-- 
1.7.0.4
