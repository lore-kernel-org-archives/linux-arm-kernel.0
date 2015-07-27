From: r.baldyga@samsung.com (Robert Baldyga)
Date: Mon, 27 Jul 2015 11:16:35 +0200
Subject: [PATCH v4 25/46] usb: gadget: omap_udc: add ep capabilities support
In-Reply-To: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1437988616-6962-26-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/omap_udc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index e2fcdb8..9b7d394 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2579,6 +2579,28 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 	ep->double_buf = dbuf;
 	ep->udc = udc;
 
+	switch (type) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		ep->ep.caps.type_control = true;
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		ep->ep.caps.type_iso = true;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		ep->ep.caps.type_bulk = true;
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		ep->ep.caps.type_int = true;
+		break;
+	};
+
+	if (addr & USB_DIR_IN)
+		ep->ep.caps.dir_in = true;
+	else
+		ep->ep.caps.dir_out = true;
+
 	ep->ep.name = ep->name;
 	ep->ep.ops = &omap_ep_ops;
 	ep->maxpacket = maxp;
-- 
1.9.1
