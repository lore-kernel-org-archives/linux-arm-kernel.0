From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 25 May 2012 10:24:14 +0800
Subject: [PATCH v3 01/12] usb: otg: add notify_connect/notify_disconnect
 callback
In-Reply-To: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337912665-16615-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This let usb phy driver has a chance to change hw settings when connect
status change.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 include/linux/usb/otg.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

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
1.7.5.4
