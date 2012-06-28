From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 28 Jun 2012 11:37:27 +0800
Subject: [PATCH v8 10/14] usb: otg: add notify_connect/notify_disconnect
 callback
In-Reply-To: <1340854652-24717-1-git-send-email-richard.zhao@freescale.com>
References: <1340854652-24717-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1340854652-24717-11-git-send-email-richard.zhao@freescale.com>
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
index 38ab3f4..6dfdc8d 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -117,6 +117,9 @@ struct usb_phy {
 	int	(*set_suspend)(struct usb_phy *x,
 				int suspend);
 
+	/* notify phy connect status change */
+	int	(*notify_connect)(struct usb_phy *x, int port);
+	int	(*notify_disconnect)(struct usb_phy *x, int port);
 };
 
 
@@ -252,6 +255,24 @@ usb_phy_set_suspend(struct usb_phy *x, int suspend)
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
