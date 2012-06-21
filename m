From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 21 Jun 2012 14:41:12 +0800
Subject: [PATCH v6 11/14] USB: notify phy when root hub port connect change
In-Reply-To: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
References: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1340260875-21934-12-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phy may need to change settings when port connect change.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Tested-by: Subodh Nijsure <snijsure@grid-net.com>
---
 drivers/usb/core/hub.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 25a7422..6ecfb5e 100644
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
 
+	if (unlikely(hcd->phy && !hdev->parent)) {
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
