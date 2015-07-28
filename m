From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 28 Jul 2015 07:19:58 +0200
Subject: [PATCH 1/7] usb: gadget: add 'quirk_altset_not_supp' to usb_gadget
In-Reply-To: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
References: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438060804-21706-2-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to some UDC controllers may not support altsettings, usb gadget layer
needs to provide a generic way to inform gadget functions about non-standard
hardware limitations.

This patch adds 'quirk_altset_not_supp' field to struct usb_gadget and helper
function gadget_is_altset_supported(). It also sets 'quirk_altset_not_supp'
to 1 in pxa25x_udc and pxa27x_udc drivers, which have such limitation.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/pxa25x_udc.c |  1 +
 drivers/usb/gadget/udc/pxa27x_udc.c |  1 +
 include/linux/usb/gadget.h          | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index f53e526..b82cb14 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1176,6 +1176,7 @@ static void udc_reinit(struct pxa25x_udc *dev)
 	INIT_LIST_HEAD (&dev->gadget.ep_list);
 	INIT_LIST_HEAD (&dev->gadget.ep0->ep_list);
 	dev->ep0state = EP0_IDLE;
+	dev->gadget.quirk_altset_not_supp = 1;
 
 	/* basic endpoint records init */
 	for (i = 0; i < PXA_UDC_NUM_ENDPOINTS; i++) {
diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 042f06b..670ac0b 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1710,6 +1710,7 @@ static void udc_init_data(struct pxa_udc *dev)
 	INIT_LIST_HEAD(&dev->gadget.ep_list);
 	INIT_LIST_HEAD(&dev->gadget.ep0->ep_list);
 	dev->udc_usb_ep[0].pxa_ep = &dev->pxa_ep[0];
+	dev->gadget.quirk_altset_not_supp = 1;
 	ep0_idle(dev);
 
 	/* PXA endpoints init */
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 91b71a3..5362faa 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -617,6 +617,7 @@ struct usb_gadget {
 	unsigned			a_hnp_support:1;
 	unsigned			a_alt_hnp_support:1;
 	unsigned			quirk_ep_out_aligned_size:1;
+	unsigned			quirk_altset_not_supp:1;
 	unsigned			is_selfpowered:1;
 	unsigned			deactivated:1;
 	unsigned			connected:1;
@@ -673,6 +674,16 @@ usb_ep_align_maybe(struct usb_gadget *g, struct usb_ep *ep, size_t len)
 }
 
 /**
+ * gadget_is_altset_supported - return true iff the hardware supports
+ *	altsettings
+ * @g: controller to check for quirk
+ */
+static inline int gadget_is_altset_supported(struct usb_gadget *g)
+{
+	return !g->quirk_altset_not_supp;
+}
+
+/**
  * gadget_is_dualspeed - return true iff the hardware handles high speed
  * @g: controller that might support both high and full speeds
  */
-- 
1.9.1
