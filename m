From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 4 Feb 2013 16:59:48 +0800
Subject: [PATCH v7 6/8] usb: chipidea: udc: retire the flag CI13_PULLUP_ON_VBUS
In-Reply-To: <1359968390-317-1-git-send-email-peter.chen@freescale.com>
References: <1359968390-317-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1359968390-317-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(change CI13XXX to CI13 to avoid junk email check)
Now, we have handled vbus session in core driver when the
vbus interrupt occurs, so our pullup operations are all
according to vbus.
Of cource, the software can still call .pullup when device connects
to host if it wants to connect/disconnect with host.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci13xxx_imx.c |    1 -
 drivers/usb/chipidea/ci13xxx_msm.c |    1 -
 drivers/usb/chipidea/udc.c         |   23 ++++++++---------------
 include/linux/usb/chipidea.h       |    1 -
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 8c29122..3b91ff4 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -88,7 +88,6 @@ EXPORT_SYMBOL_GPL(usbmisc_get_init_data);
 static struct ci13xxx_platform_data ci13xxx_imx_platdata  = {
 	.name			= "ci13xxx_imx",
 	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
-				  CI13XXX_PULLUP_ON_VBUS |
 				  CI13XXX_DISABLE_STREAMING,
 	.capoffset		= DEF_CAPOFFSET,
 };
diff --git a/drivers/usb/chipidea/ci13xxx_msm.c b/drivers/usb/chipidea/ci13xxx_msm.c
index 7d16681..5755ee8 100644
--- a/drivers/usb/chipidea/ci13xxx_msm.c
+++ b/drivers/usb/chipidea/ci13xxx_msm.c
@@ -49,7 +49,6 @@ static struct ci13xxx_platform_data ci13xxx_msm_platdata = {
 	.name			= "ci13xxx_msm",
 	.flags			= CI13XXX_REGS_SHARED |
 				  CI13XXX_REQUIRE_TRANSCEIVER |
-				  CI13XXX_PULLUP_ON_VBUS |
 				  CI13XXX_DISABLE_STREAMING,
 
 	.notify_event		= ci13xxx_msm_notify_event,
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 597ae64..b57b735 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1360,9 +1360,6 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 	unsigned long flags;
 	int gadget_ready = 0;
 
-	if (!(ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS))
-		return -EOPNOTSUPP;
-
 	spin_lock_irqsave(&ci->lock, flags);
 	ci->vbus_active = is_active;
 	if (ci->driver)
@@ -1426,8 +1423,7 @@ static int ci13xxx_pullup(struct usb_gadget *_gadget, int is_on)
 {
 	struct ci13xxx *ci = container_of(_gadget, struct ci13xxx, gadget);
 
-	if ((ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) &&
-			!ci->vbus_active)
+	if (!ci->vbus_active)
 		return -ENOTSUPP;
 
 	if (is_on)
@@ -1551,14 +1547,12 @@ static int ci13xxx_start(struct usb_gadget *gadget,
 
 	ci->driver = driver;
 	pm_runtime_get_sync(&ci->gadget.dev);
-	if (ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) {
-		if (ci->vbus_active) {
-			if (ci->platdata->flags & CI13XXX_REGS_SHARED)
-				hw_device_reset(ci, USBMODE_CM_DC);
-		} else {
-			pm_runtime_put_sync(&ci->gadget.dev);
-			goto done;
-		}
+	if (ci->vbus_active) {
+		if (ci->platdata->flags & CI13XXX_REGS_SHARED)
+			hw_device_reset(ci, USBMODE_CM_DC);
+	} else {
+		pm_runtime_put_sync(&ci->gadget.dev);
+		goto done;
 	}
 
 	retval = hw_device_state(ci, ci->ep0out->qh.dma);
@@ -1581,8 +1575,7 @@ static int ci13xxx_stop(struct usb_gadget *gadget,
 
 	spin_lock_irqsave(&ci->lock, flags);
 
-	if (!(ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) ||
-			ci->vbus_active) {
+	if (ci->vbus_active) {
 		hw_device_state(ci, 0);
 		if (ci->platdata->notify_event)
 			ci->platdata->notify_event(ci,
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 544825d..37821b3 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -17,7 +17,6 @@ struct ci13xxx_platform_data {
 	unsigned long	 flags;
 #define CI13XXX_REGS_SHARED		BIT(0)
 #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
-#define CI13XXX_PULLUP_ON_VBUS		BIT(2)
 #define CI13XXX_DISABLE_STREAMING	BIT(3)
 
 #define CI13XXX_CONTROLLER_RESET_EVENT		0
-- 
1.7.0.4
