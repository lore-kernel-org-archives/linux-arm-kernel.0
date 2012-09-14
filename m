From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 14 Sep 2012 11:23:38 +0800
Subject: [PATCH 4/4] usb: refine phy notify operation during connection and
 disconnection
Message-ID: <1347593018-13149-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At commit 925aa46ba963a4da6d8ee6ab1d04a02ffa8db62b, Richard Zhao
<richard.zhao@freescale.com> adds the phy notification callback
when port change occurs. In fact, this phy notification should
be added according to below rules:

1. Only set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
during high speed host mode.
2. Do not set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
during the reset and speed negotiation period.
3. Do not set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
during host suspend/resume sequence.

Please refer: i.mx23RM(page: 413) for below rules.
http://www.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf

Freescale i.MX SoC, i.mx23, i.mx28 and i.mx6(i.mx6SL does not
need to follow the 3rd rule) need to follow above rules.

Current code set connect notification (HW_USBPHY_CTRL.ENHOSTDISCONDETECT)
at hub_port_connect_change, it conflicts with above the 2th rule.

The correct notification setting method should be:
1. Set connect notify after the second bus reset.
2. Set disconnect notify after disconnection.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/core/hub.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 6dc41c6..2523fc0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3994,6 +3994,9 @@ hub_port_init (struct usb_hub *hub, struct usb_device *udev, int port1,
 	if (retval)
 		goto fail;
 
+	if (hcd->phy && !hdev->parent)
+		usb_phy_notify_connect(hcd->phy, udev->speed);
+
 	/*
 	 * Some superspeed devices have finished the link training process
 	 * and attached to a superspeed hub port, but the device descriptor
@@ -4187,6 +4190,10 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 		}
 	}
 
+	if (hcd->phy && !hdev->parent &&
+		!(portstatus & USB_PORT_STAT_CONNECTION))
+			usb_phy_notify_disconnect(hcd->phy, udev->speed);
+
 	/* Disconnect any existing devices under this port */
 	if (udev)
 		usb_disconnect(&hub->ports[port1 - 1]->child);
@@ -4212,13 +4219,6 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 		}
 	}
 
-	if (hcd->phy && !hdev->parent) {
-		if (portstatus & USB_PORT_STAT_CONNECTION)
-			usb_phy_notify_connect(hcd->phy, port1);
-		else
-			usb_phy_notify_disconnect(hcd->phy, port1);
-	}
-
 	/* Return now if debouncing failed or nothing is connected or
 	 * the device was "removed".
 	 */
-- 
1.7.0.4
