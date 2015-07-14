From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:39:23 +0200
Subject: [PATCH v2 35/48] usb: renesas: gadget: add ep capabilities support
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-36-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index dc2aa32..ed8d890 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1041,12 +1041,18 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		if (usbhsg_is_dcp(uep)) {
 			gpriv->gadget.ep0 = &uep->ep;
 			usb_ep_set_maxpacket_limit(&uep->ep, 64);
+			uep->ep.caps.type_control = true;
 		}
 		/* init normal pipe */
 		else {
 			usb_ep_set_maxpacket_limit(&uep->ep, 512);
+			uep->ep.caps.type_iso = true;
+			uep->ep.caps.type_bulk = true;
+			uep->ep.caps.type_int = true;
 			list_add_tail(&uep->ep.ep_list, &gpriv->gadget.ep_list);
 		}
+		uep->ep.caps.dir_in = true;
+		uep->ep.caps.dir_out = true;
 	}
 
 	ret = usb_add_gadget_udc(dev, &gpriv->gadget);
-- 
1.9.1
