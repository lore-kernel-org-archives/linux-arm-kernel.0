From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:32:19 +0200
Subject: [PATCH v3 32/46] usb: gadget: udc-xilinx: add ep capabilities support
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-33-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 1f24274..1cbb0ac 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1317,12 +1317,21 @@ static void xudc_eps_init(struct xusb_udc *udc)
 			snprintf(ep->name, EPNAME_SIZE, "ep%d", ep_number);
 			ep->ep_usb.name = ep->name;
 			ep->ep_usb.ops = &xusb_ep_ops;
+
+			ep->ep_usb.caps.type_iso = true;
+			ep->ep_usb.caps.type_bulk = true;
+			ep->ep_usb.caps.type_int = true;
 		} else {
 			ep->ep_usb.name = ep0name;
 			usb_ep_set_maxpacket_limit(&ep->ep_usb, EP0_MAX_PACKET);
 			ep->ep_usb.ops = &xusb_ep0_ops;
+
+			ep->ep_usb.caps.type_control = true;
 		}
 
+		ep->ep_usb.caps.dir_in = true;
+		ep->ep_usb.caps.dir_out = true;
+
 		ep->udc = udc;
 		ep->epnumber = ep_number;
 		ep->desc = NULL;
-- 
1.9.1
