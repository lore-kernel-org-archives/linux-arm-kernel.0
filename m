From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:32:03 +0200
Subject: [PATCH v3 16/46] usb: gadget: fusb300_udc: add ep capabilities support
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-17-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/fusb300_udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index 3970f45..948845c 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1450,6 +1450,17 @@ static int fusb300_probe(struct platform_device *pdev)
 		ep->ep.name = fusb300_ep_name[i];
 		ep->ep.ops = &fusb300_ep_ops;
 		usb_ep_set_maxpacket_limit(&ep->ep, HS_BULK_MAX_PACKET_SIZE);
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
 	usb_ep_set_maxpacket_limit(&fusb300->ep[0]->ep, HS_CTL_MAX_PACKET_SIZE);
 	fusb300->ep[0]->epnum = 0;
-- 
1.9.1
