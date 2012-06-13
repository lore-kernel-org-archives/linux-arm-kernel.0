From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 13 Jun 2012 20:34:13 +0800
Subject: [Patch v5 03/13] USB: notify phy when root hub port connect change
In-Reply-To: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1339590863-10564-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phy may need to change settings when port connect change.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/core/hub.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 04fb834..e1a6d31 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -20,6 +20,7 @@
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/otg.h>
 #include <linux/usb/quirks.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
@@ -4034,6 +4035,13 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 		}
 	}
 
+	if (unlikely(hcd->phy && !hdev->level)) {
+		if (portstatus & USB_PORT_STAT_CONNECTION)
+			usb_phy_notify_connect(hcd->phy, port1);
+		else
+			usb_phy_notify_disconnect(hcd->phy, port1);
+	}
+
 	/* Return now if debouncing failed or nothing is connected or
 	 * the device was "removed".
 	 */
-- 
1.7.9.5
