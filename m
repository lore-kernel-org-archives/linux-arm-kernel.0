From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:32:26 +0200
Subject: [PATCH v3 39/46] usb: gadget: epautoconf: remove ep and desc
 configuration from ep_matches()
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-40-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As function ep_matches() is used to match endpoint with usb descriptor it's
highly unintuitive that it modifies endpoint and descriptor structures fields.
This patch moves code configuring ep and desc from ep_matches() to
usb_ep_autoconfig_ss(), so now function ep_matches() does nothing more than
its name suggests.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 66 +++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 4f66e9d73..7bb28f1 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -82,13 +82,6 @@ ep_matches (
 
 	}
 
-	/*
-	 * If the protocol driver hasn't yet decided on wMaxPacketSize
-	 * and wants to know the maximum possible, provide the info.
-	 */
-	if (desc->wMaxPacketSize == 0)
-		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);
-
 	/* endpoint maxpacket size is an input parameter, except for bulk
 	 * where it's an output parameter representing the full speed limit.
 	 * the usb spec fixes high speed bulk maxpacket at 512 bytes.
@@ -119,31 +112,6 @@ ep_matches (
 
 	/* MATCH!! */
 
-	/* report address */
-	desc->bEndpointAddress &= USB_DIR_IN;
-	if (isdigit (ep->name [2])) {
-		u8	num = simple_strtoul (&ep->name [2], NULL, 10);
-		desc->bEndpointAddress |= num;
-	} else if (desc->bEndpointAddress & USB_DIR_IN) {
-		if (++gadget->in_epnum > 15)
-			return 0;
-		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
-	} else {
-		if (++gadget->out_epnum > 15)
-			return 0;
-		desc->bEndpointAddress |= gadget->out_epnum;
-	}
-
-	/* report (variable) full speed bulk maxpacket */
-	if ((USB_ENDPOINT_XFER_BULK == type) && !ep_comp) {
-		int size = ep->maxpacket_limit;
-
-		/* min() doesn't work on bitfields with gcc-3.5 */
-		if (size > 64)
-			size = 64;
-		desc->wMaxPacketSize = cpu_to_le16(size);
-	}
-	ep->address = desc->bEndpointAddress;
 	return 1;
 }
 
@@ -280,6 +248,40 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	/* Fail */
 	return NULL;
 found_ep:
+
+	/*
+	 * If the protocol driver hasn't yet decided on wMaxPacketSize
+	 * and wants to know the maximum possible, provide the info.
+	 */
+	if (desc->wMaxPacketSize == 0)
+		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);
+
+	/* report address */
+	desc->bEndpointAddress &= USB_DIR_IN;
+	if (isdigit(ep->name[2])) {
+		u8 num = simple_strtoul(&ep->name[2], NULL, 10);
+		desc->bEndpointAddress |= num;
+	} else if (desc->bEndpointAddress & USB_DIR_IN) {
+		if (++gadget->in_epnum > 15)
+			return 0;
+		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
+	} else {
+		if (++gadget->out_epnum > 15)
+			return 0;
+		desc->bEndpointAddress |= gadget->out_epnum;
+	}
+
+	/* report (variable) full speed bulk maxpacket */
+	if ((type == USB_ENDPOINT_XFER_BULK) && !ep_comp) {
+		int size = ep->maxpacket_limit;
+
+		/* min() doesn't work on bitfields with gcc-3.5 */
+		if (size > 64)
+			size = 64;
+		desc->wMaxPacketSize = cpu_to_le16(size);
+	}
+
+	ep->address = desc->bEndpointAddress;
 	ep->desc = NULL;
 	ep->comp_desc = NULL;
 	ep->claimed = true;
-- 
1.9.1
