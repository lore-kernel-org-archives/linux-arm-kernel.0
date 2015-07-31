From: r.baldyga@samsung.com (Robert Baldyga)
Date: Fri, 31 Jul 2015 16:00:38 +0200
Subject: [PATCH v5 26/46] usb: gadget: pch_udc: add ep capabilities support
In-Reply-To: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438351258-31578-27-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index dcf5def..fa9eb3c 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -2895,11 +2895,21 @@ static void pch_udc_pcd_reinit(struct pch_udc_dev *dev)
 		ep->in = ~i & 1;
 		ep->ep.name = ep_string[i];
 		ep->ep.ops = &pch_udc_ep_ops;
-		if (ep->in)
+		if (ep->in) {
 			ep->offset_addr = ep->num * UDC_EP_REG_SHIFT;
-		else
+			ep->ep.caps.dir_in = true;
+		} else {
 			ep->offset_addr = (UDC_EPINT_OUT_SHIFT + ep->num) *
 					  UDC_EP_REG_SHIFT;
+			ep->ep.caps.dir_out = true;
+		}
+		if (i == UDC_EP0IN_IDX || i == UDC_EP0OUT_IDX) {
+			ep->ep.caps.type_control = true;
+		} else {
+			ep->ep.caps.type_iso = true;
+			ep->ep.caps.type_bulk = true;
+			ep->ep.caps.type_int = true;
+		}
 		/* need to set ep->ep.maxpacket and set Default Configuration?*/
 		usb_ep_set_maxpacket_limit(&ep->ep, UDC_BULK_MAX_PKT_SIZE);
 		list_add_tail(&ep->ep.ep_list, &dev->gadget.ep_list);
-- 
1.9.1
