From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 28 Jul 2015 07:20:00 +0200
Subject: [PATCH 3/7] usb: gadget: add 'quirk_zlp_not_supp' to usb_gadget
In-Reply-To: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
References: <1438060804-21706-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438060804-21706-4-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to some UDC controllers may not support zlp, usb gadget layer
needs to provide a generic way to inform gadget functions about non-standard
hardware limitations.

This patch adds 'quirk_zlp_not_supp' field to struct usb_gadget and helper
function gadget_is_zlp_supported(). It also sets 'quirk_zlp_not_supp'
to 1 in musb UDC driver, which has such limitation.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/musb/musb_gadget.c |  1 +
 include/linux/usb/gadget.h     | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 3a64cf2..4b14ced 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -2121,6 +2121,7 @@ __acquires(musb->lock)
 	musb->g.b_hnp_enable = 0;
 	musb->g.a_alt_hnp_support = 0;
 	musb->g.a_hnp_support = 0;
+	musb->quirk_zlp_not_supp = 1;
 
 	/* Normal reset, as B-Device;
 	 * or else after HNP, as A-Device
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 55cb6b2..6a413ab 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -619,6 +619,7 @@ struct usb_gadget {
 	unsigned			quirk_ep_out_aligned_size:1;
 	unsigned			quirk_altset_not_supp:1;
 	unsigned			quirk_stall_not_supp:1;
+	unsigned			quirk_zlp_not_supp:1;
 	unsigned			is_selfpowered:1;
 	unsigned			deactivated:1;
 	unsigned			connected:1;
@@ -694,6 +695,15 @@ static inline int gadget_is_stall_supported(struct usb_gadget *g)
 }
 
 /**
+ * gadget_is_zlp_supported - return true iff the hardware supports zlp
+ * @g: controller to check for quirk
+ */
+static inline int gadget_is_zlp_supported(struct usb_gadget *g)
+{
+	return !g->quirk_zlp_not_supp;
+}
+
+/**
  * gadget_is_dualspeed - return true iff the hardware handles high speed
  * @g: controller that might support both high and full speeds
  */
-- 
1.9.1
