From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 14 Sep 2012 11:20:26 +0800
Subject: [PATCH 1/4] usb: phy: add notify_suspend/notify_resume callback
Message-ID: <1347592826-13050-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This let usb phy driver has the chance to change hw settings during
the controller suspend/resume procedure.

Besides, old parameter "port" is useless for phy notify, as one usb
phy is only for one usb port. New parameter "speed" stands for
the device's speed which is on the port.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 include/linux/usb/phy.h |   44 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 06b5bae..45e2235 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -10,6 +10,7 @@
 #define __LINUX_USB_PHY_H
 
 #include <linux/notifier.h>
+#include <linux/usb.h>
 
 enum usb_phy_events {
 	USB_EVENT_NONE,         /* no events or cable disconnected */
@@ -98,9 +99,20 @@ struct usb_phy {
 	int	(*set_suspend)(struct usb_phy *x,
 				int suspend);
 
-	/* notify phy connect status change */
-	int	(*notify_connect)(struct usb_phy *x, int port);
-	int	(*notify_disconnect)(struct usb_phy *x, int port);
+	/*
+	 * Notify phy that
+	 * - The controller's connect status change.
+	 * - The controller's suspend/resume occurs, and the device
+	 * is on the port.
+	 */
+	int	(*notify_connect)(struct usb_phy *x,
+			enum usb_device_speed speed);
+	int	(*notify_disconnect)(struct usb_phy *x,
+			enum usb_device_speed speed);
+	int	(*notify_suspend)(struct usb_phy *x,
+			enum usb_device_speed speed);
+	int	(*notify_resume)(struct usb_phy *x,
+			enum usb_device_speed speed);
 };
 
 
@@ -189,19 +201,37 @@ usb_phy_set_suspend(struct usb_phy *x, int suspend)
 }
 
 static inline int
-usb_phy_notify_connect(struct usb_phy *x, int port)
+usb_phy_notify_connect(struct usb_phy *x, enum usb_device_speed speed)
 {
 	if (x->notify_connect)
-		return x->notify_connect(x, port);
+		return x->notify_connect(x, speed);
 	else
 		return 0;
 }
 
 static inline int
-usb_phy_notify_disconnect(struct usb_phy *x, int port)
+usb_phy_notify_disconnect(struct usb_phy *x, enum usb_device_speed speed)
 {
 	if (x->notify_disconnect)
-		return x->notify_disconnect(x, port);
+		return x->notify_disconnect(x, speed);
+	else
+		return 0;
+}
+
+static inline int
+usb_phy_notify_suspend(struct usb_phy *x, enum usb_device_speed speed)
+{
+	if (x->notify_suspend)
+		return x->notify_suspend(x, speed);
+	else
+		return 0;
+}
+
+static inline int
+usb_phy_notify_resume(struct usb_phy *x, enum usb_device_speed speed)
+{
+	if (x->notify_resume)
+		return x->notify_resume(x, speed);
 	else
 		return 0;
 }
-- 
1.7.0.4
