From: r.baldyga@samsung.com (Robert Baldyga)
Date: Fri, 31 Jul 2015 16:00:25 +0200
Subject: [PATCH v5 13/46] usb: gadget: fotg210-udc: add ep capabilities support
In-Reply-To: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438351258-31578-14-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index a99ed6d..6ba122c 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1143,6 +1143,17 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 		ep->ep.name = fotg210_ep_name[i];
 		ep->ep.ops = &fotg210_ep_ops;
 		usb_ep_set_maxpacket_limit(&ep->ep, (unsigned short) ~0);
+
+		if (i == 0) {
+			ep->ep.caps.type_control = true;
+		} else {
+			ep->ep.caps.type_iso = true;
+			ep->ep.caps.type_bulk = true;
+			ep->ep.caps.type_int = true;
+		}
+
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
 	}
 	usb_ep_set_maxpacket_limit(&fotg210->ep[0]->ep, 0x40);
 	fotg210->gadget.ep0 = &fotg210->ep[0]->ep;
-- 
1.9.1
