From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:32:28 +0200
Subject: [PATCH v3 41/46] usb: gadget: add 'ep_match' callback to
 usb_gadget_ops
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-42-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add callback that is called by epautoconf to allow UDC driver match the
best endpoint for specific descriptor. It's intended to supply mechanism
which allows to get rid of chip-specific endpoint matching code from
epautoconf.

If gadget has set 'ep_match' callback we prefer to call it first, and
if it fails to find matching endpoint, then we try to use default matching
algorithm.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 6 ++++++
 include/linux/usb/gadget.h      | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 4fa6f5d..1b1fee0 100644
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
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e6cbc25..0041bb9 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -534,6 +534,9 @@ struct usb_gadget_ops {
 	int	(*udc_start)(struct usb_gadget *,
 			struct usb_gadget_driver *);
 	int	(*udc_stop)(struct usb_gadget *);
+	struct usb_ep *(*match_ep)(struct usb_gadget *,
+			struct usb_endpoint_descriptor *,
+			struct usb_ss_ep_comp_descriptor *);
 };
 
 /**
-- 
1.9.1
