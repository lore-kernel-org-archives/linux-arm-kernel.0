From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:39:30 +0200
Subject: [PATCH v2 42/48] usb: gadget: epautoconf: use 'ep_match' gadget
 callback
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-43-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If gadget has set 'ep_match' callback we prefer to call it first to allow
UDC driver to find the best matching endpoint basing on chip-specific "best
usage" knowledge.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index ee0d4e6..92a1a4c 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -165,6 +165,12 @@ struct usb_ep *usb_ep_autoconfig_ss(
 
 	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
 
+	if (gadget->ops->match_ep) {
+		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
+		if (ep)
+			goto found_ep;
+	}
+
 	/* First, apply chip-specific "best usage" knowledge.
 	 * This might make a good usb_gadget_ops hook ...
 	 */
-- 
1.9.1
