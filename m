From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 17:18:41 +0100
Subject: [PATCH] usb: xhci: fix build error for USB_SPEED_SUPER_PLUS
Message-ID: <1508874.HIZbDSzAVR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent patch introduced support for superspeed plus (USB3.1), but that
caused a new gcc warning in the XHCI code:

usb/host/xhci.c: In function 'xhci_drop_ep_from_interval_table':
usb/host/xhci.c:2440:2: error: enumeration value 'USB_SPEED_SUPER_PLUS' not handled in switch [-Werror=switch]

This changes the XHCI driver to handle USB_SPEED_SUPER_PLUS the
same way as USB_SPEED_SUPER in the xhci_drop_ep_from_interval_table
and xhci_add_ep_to_interval_table functions, explicitly ignoring
it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 8a1b2725a60d ("usb: define USB_SPEED_SUPER_PLUS speed for SuperSpeedPlus USB3.1 devices")
---
Found on ARM randconfig builds last week

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 26a44c0e969e..a74beec879b4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2448,6 +2448,7 @@ void xhci_drop_ep_from_interval_table(struct xhci_hcd *xhci,
 		interval_bw->overhead[HS_OVERHEAD_TYPE] -= 1;
 		break;
 	case USB_SPEED_SUPER:
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_UNKNOWN:
 	case USB_SPEED_WIRELESS:
 		/* Should never happen because only LS/FS/HS endpoints will get
@@ -2507,6 +2508,7 @@ static void xhci_add_ep_to_interval_table(struct xhci_hcd *xhci,
 		interval_bw->overhead[HS_OVERHEAD_TYPE] += 1;
 		break;
 	case USB_SPEED_SUPER:
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_UNKNOWN:
 	case USB_SPEED_WIRELESS:
 		/* Should never happen because only LS/FS/HS endpoints will get
