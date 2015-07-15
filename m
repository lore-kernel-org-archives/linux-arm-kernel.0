From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:32:09 +0200
Subject: [PATCH v3 22/46] usb: gadget: mv_udc_core: add ep capabilities support
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-23-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index d32160d..306a7ff 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -1257,6 +1257,9 @@ static int eps_init(struct mv_udc *udc)
 	ep->wedge = 0;
 	ep->stopped = 0;
 	usb_ep_set_maxpacket_limit(&ep->ep, EP0_MAX_PKT_SIZE);
+	ep->ep.caps.type_control = true;
+	ep->ep.caps.dir_in = true;
+	ep->ep.caps.dir_out = true;
 	ep->ep_num = 0;
 	ep->ep.desc = &mv_ep0_desc;
 	INIT_LIST_HEAD(&ep->queue);
@@ -1269,14 +1272,20 @@ static int eps_init(struct mv_udc *udc)
 		if (i % 2) {
 			snprintf(name, sizeof(name), "ep%din", i / 2);
 			ep->direction = EP_DIR_IN;
+			ep->ep.caps.dir_in = true;
 		} else {
 			snprintf(name, sizeof(name), "ep%dout", i / 2);
 			ep->direction = EP_DIR_OUT;
+			ep->ep.caps.dir_out = true;
 		}
 		ep->udc = udc;
 		strncpy(ep->name, name, sizeof(ep->name));
 		ep->ep.name = ep->name;
 
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
+
 		ep->ep.ops = &mv_ep_ops;
 		ep->stopped = 0;
 		usb_ep_set_maxpacket_limit(&ep->ep, (unsigned short) ~0);
-- 
1.9.1
