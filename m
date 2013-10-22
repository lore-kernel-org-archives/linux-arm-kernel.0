From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 13:58:41 +0800
Subject: [Patch v2 07/14] usb: phy: add notify suspend and resume callback
In-Reply-To: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382421528-17897-8-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They are used to notify PHY that the controller enters suspend
or finishes resume.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 include/linux/usb/phy.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 6c0b1c5..a747960 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -116,6 +116,11 @@ struct usb_phy {
 			enum usb_device_speed speed);
 	int	(*notify_disconnect)(struct usb_phy *x,
 			enum usb_device_speed speed);
+	int	(*notify_suspend)(struct usb_phy *x,
+			enum usb_device_speed speed);
+	int	(*notify_resume)(struct usb_phy *x,
+			enum usb_device_speed speed);
+
 };
 
 /**
@@ -282,6 +287,24 @@ usb_phy_notify_disconnect(struct usb_phy *x, enum usb_device_speed speed)
 		return 0;
 }
 
+static inline int usb_phy_notify_suspend
+	(struct usb_phy *x, enum usb_device_speed speed)
+{
+	if (x && x->notify_suspend)
+		return x->notify_suspend(x, speed);
+	else
+		return 0;
+}
+
+static inline int usb_phy_notify_resume
+	(struct usb_phy *x, enum usb_device_speed speed)
+{
+	if (x && x->notify_resume)
+		return x->notify_resume(x, speed);
+	else
+		return 0;
+}
+
 /* notifiers */
 static inline int
 usb_register_notifier(struct usb_phy *x, struct notifier_block *nb)
-- 
1.7.1
