From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 28 Jul 2015 07:19:59 +0200
Subject: [PATCH 2/7] usb: gadget: add 'quirk_stall_not_supp' to usb_gadget
In-Reply-To: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
References: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438060804-21706-3-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to some UDC controllers may not support stalling, usb gadget layer
needs to provide a generic way to inform gadget functions about non-standard
hardware limitations.

This patch adds 'quirk_stall_not_supp' field to struct usb_gadget and helper
function gadget_is_stall_supported(). It also sets 'quirk_stall_not_supp'
to 1 in at91_udc driver, which has such limitation.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/at91_udc.c |  1 +
 include/linux/usb/gadget.h        | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index a04b073..f663dce 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -839,6 +839,7 @@ static void udc_reinit(struct at91_udc *udc)
 
 	INIT_LIST_HEAD(&udc->gadget.ep_list);
 	INIT_LIST_HEAD(&udc->gadget.ep0->ep_list);
+	udc->gadget.quirk_stall_not_supp = 1;
 
 	for (i = 0; i < NUM_ENDPOINTS; i++) {
 		struct at91_ep *ep = &udc->ep[i];
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 5362faa..55cb6b2 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -618,6 +618,7 @@ struct usb_gadget {
 	unsigned			a_alt_hnp_support:1;
 	unsigned			quirk_ep_out_aligned_size:1;
 	unsigned			quirk_altset_not_supp:1;
+	unsigned			quirk_stall_not_supp:1;
 	unsigned			is_selfpowered:1;
 	unsigned			deactivated:1;
 	unsigned			connected:1;
@@ -684,6 +685,15 @@ static inline int gadget_is_altset_supported(struct usb_gadget *g)
 }
 
 /**
+ * gadget_is_stall_supported - return true iff the hardware supports stalling
+ * @g: controller to check for quirk
+ */
+static inline int gadget_is_stall_supported(struct usb_gadget *g)
+{
+	return !g->quirk_stall_not_supp;
+}
+
+/**
  * gadget_is_dualspeed - return true iff the hardware handles high speed
  * @g: controller that might support both high and full speeds
  */
-- 
1.9.1
