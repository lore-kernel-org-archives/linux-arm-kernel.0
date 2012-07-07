From: richard.zhao@freescale.com (Richard Zhao)
Date: Sat, 7 Jul 2012 22:56:44 +0800
Subject: [PATCH v9 REBASE 5/9] usb: otg: add notify_connect/notify_disconnect
 callback
In-Reply-To: <1341673008-29808-1-git-send-email-richard.zhao@freescale.com>
References: <1341673008-29808-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1341673008-29808-6-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This let usb phy driver has a chance to change hw settings when connect
status change.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Tested-by: Subodh Nijsure <snijsure@grid-net.com>
---
 include/linux/usb/otg.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 0cb2ec2..45824be 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -128,6 +128,9 @@ struct usb_phy {
 	int	(*set_suspend)(struct usb_phy *x,
 				int suspend);
 
+	/* notify phy connect status change */
+	int	(*notify_connect)(struct usb_phy *x, int port);
+	int	(*notify_disconnect)(struct usb_phy *x, int port);
 };
 
 
@@ -277,6 +280,24 @@ usb_phy_set_suspend(struct usb_phy *x, int suspend)
 }
 
 static inline int
+usb_phy_notify_connect(struct usb_phy *x, int port)
+{
+	if (x->notify_connect)
+		return x->notify_connect(x, port);
+	else
+		return 0;
+}
+
+static inline int
+usb_phy_notify_disconnect(struct usb_phy *x, int port)
+{
+	if (x->notify_disconnect)
+		return x->notify_disconnect(x, port);
+	else
+		return 0;
+}
+
+static inline int
 otg_start_srp(struct usb_otg *otg)
 {
 	if (otg && otg->start_srp)
-- 
1.7.9.5
