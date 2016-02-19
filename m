From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 22:40:28 +0100
Subject: [PATCH] usb: move usb_calc_bus_time into common code
Message-ID: <1455918064-410571-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwc2 dual-role USB controller driver has started calling
usb_calc_bus_time, and does so regardless of whether it is
being built as a host controller or gadget. In case all
USB host support is disabled (CONFIG_USB=n), this now causes
a link error:

ERROR: "usb_calc_bus_time" [drivers/usb/dwc2/dwc2.ko] undefined!

Moving the function that is called from the USB HCD specific code
into the shared USB code avoids this problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f889904b25df ("usb: dwc2: host: Properly set even/odd frame")
---
I have no idea if this is the correct solution for the problem,
it just seemed like the easiest way to avoid the build failure.

 drivers/usb/common/common.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/hcd.c      | 51 ---------------------------------------------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index e3d01619d6b3..654fd37f89d5 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -17,6 +17,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/hcd.h>
 #include <linux/of_platform.h>
 
 const char *usb_otg_state_string(enum usb_otg_state state)
@@ -126,6 +127,56 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_get_dr_mode);
 
+/*-------------------------------------------------------------------------*/
+
+/**
+ * usb_calc_bus_time - approximate periodic transaction time in nanoseconds
+ * @speed: from dev->speed; USB_SPEED_{LOW,FULL,HIGH}
+ * @is_input: true iff the transaction sends data to the host
+ * @isoc: true for isochronous transactions, false for interrupt ones
+ * @bytecount: how many bytes in the transaction.
+ *
+ * Return: Approximate bus time in nanoseconds for a periodic transaction.
+ *
+ * Note:
+ * See USB 2.0 spec section 5.11.3; only periodic transfers need to be
+ * scheduled in software, this function is only used for such scheduling.
+ */
+long usb_calc_bus_time (int speed, int is_input, int isoc, int bytecount)
+{
+	unsigned long	tmp;
+
+	switch (speed) {
+	case USB_SPEED_LOW: 	/* INTR only */
+		if (is_input) {
+			tmp = (67667L * (31L + 10L * BitTime (bytecount))) / 1000L;
+			return 64060L + (2 * BW_HUB_LS_SETUP) + BW_HOST_DELAY + tmp;
+		} else {
+			tmp = (66700L * (31L + 10L * BitTime (bytecount))) / 1000L;
+			return 64107L + (2 * BW_HUB_LS_SETUP) + BW_HOST_DELAY + tmp;
+		}
+	case USB_SPEED_FULL:	/* ISOC or INTR */
+		if (isoc) {
+			tmp = (8354L * (31L + 10L * BitTime (bytecount))) / 1000L;
+			return ((is_input) ? 7268L : 6265L) + BW_HOST_DELAY + tmp;
+		} else {
+			tmp = (8354L * (31L + 10L * BitTime (bytecount))) / 1000L;
+			return 9107L + BW_HOST_DELAY + tmp;
+		}
+	case USB_SPEED_HIGH:	/* ISOC or INTR */
+		/* FIXME adjust for input vs output */
+		if (isoc)
+			tmp = HS_NSECS_ISO (bytecount);
+		else
+			tmp = HS_NSECS (bytecount);
+		return tmp;
+	default:
+		pr_debug ("%s: bogus device speed!\n", __func__);
+		return -1;
+	}
+}
+EXPORT_SYMBOL_GPL(usb_calc_bus_time);
+
 #ifdef CONFIG_OF
 /**
  * of_usb_get_dr_mode_by_phy - Get dual role mode for the controller device
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 0b8a91004737..cbaa78043793 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1170,57 +1170,6 @@ EXPORT_SYMBOL_GPL(usb_hcd_end_port_resume);
 
 /*-------------------------------------------------------------------------*/
 
-/**
- * usb_calc_bus_time - approximate periodic transaction time in nanoseconds
- * @speed: from dev->speed; USB_SPEED_{LOW,FULL,HIGH}
- * @is_input: true iff the transaction sends data to the host
- * @isoc: true for isochronous transactions, false for interrupt ones
- * @bytecount: how many bytes in the transaction.
- *
- * Return: Approximate bus time in nanoseconds for a periodic transaction.
- *
- * Note:
- * See USB 2.0 spec section 5.11.3; only periodic transfers need to be
- * scheduled in software, this function is only used for such scheduling.
- */
-long usb_calc_bus_time (int speed, int is_input, int isoc, int bytecount)
-{
-	unsigned long	tmp;
-
-	switch (speed) {
-	case USB_SPEED_LOW: 	/* INTR only */
-		if (is_input) {
-			tmp = (67667L * (31L + 10L * BitTime (bytecount))) / 1000L;
-			return 64060L + (2 * BW_HUB_LS_SETUP) + BW_HOST_DELAY + tmp;
-		} else {
-			tmp = (66700L * (31L + 10L * BitTime (bytecount))) / 1000L;
-			return 64107L + (2 * BW_HUB_LS_SETUP) + BW_HOST_DELAY + tmp;
-		}
-	case USB_SPEED_FULL:	/* ISOC or INTR */
-		if (isoc) {
-			tmp = (8354L * (31L + 10L * BitTime (bytecount))) / 1000L;
-			return ((is_input) ? 7268L : 6265L) + BW_HOST_DELAY + tmp;
-		} else {
-			tmp = (8354L * (31L + 10L * BitTime (bytecount))) / 1000L;
-			return 9107L + BW_HOST_DELAY + tmp;
-		}
-	case USB_SPEED_HIGH:	/* ISOC or INTR */
-		/* FIXME adjust for input vs output */
-		if (isoc)
-			tmp = HS_NSECS_ISO (bytecount);
-		else
-			tmp = HS_NSECS (bytecount);
-		return tmp;
-	default:
-		pr_debug ("%s: bogus device speed!\n", usbcore_name);
-		return -1;
-	}
-}
-EXPORT_SYMBOL_GPL(usb_calc_bus_time);
-
-
-/*-------------------------------------------------------------------------*/
-
 /*
  * Generic HC operations.
  */
-- 
2.7.0
