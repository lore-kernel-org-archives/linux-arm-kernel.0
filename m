From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 16 Apr 2014 15:16:52 +0200
Subject: [PATCH v3 1/4] USB: OHCI: Export the OHCI hub control and status_data
 functions
In-Reply-To: <1397654215-23699-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397654215-23699-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397654215-23699-2-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform drivers sometimes need to perform specific handling of hub
control requests and status data. Make this possible by exporting the
ohci_hub_control() and ohci_hub_status_data() functions which can then
be called from custom hub operations in the default case.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/usb/host/ohci-at91.c    | 11 ++---------
 drivers/usb/host/ohci-hub.c     |  8 ++++----
 drivers/usb/host/ohci-s3c2410.c | 13 +++----------
 drivers/usb/host/ohci.h         |  3 +++
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 091ae49..e49eb4f 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -46,9 +46,6 @@ static const char hcd_name[] = "ohci-atmel";
 
 static struct hc_driver __read_mostly ohci_at91_hc_driver;
 static int clocked;
-static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
-			u16 wValue, u16 wIndex, char *buf, u16 wLength);
-static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
 
 extern int usb_disabled(void);
 
@@ -262,7 +259,7 @@ static int ohci_at91_usb_get_power(struct at91_usbh_data *pdata, int port)
 static int ohci_at91_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
 	struct at91_usbh_data *pdata = hcd->self.controller->platform_data;
-	int length = orig_ohci_hub_status_data(hcd, buf);
+	int length = ohci_hub_status_data(hcd, buf);
 	int port;
 
 	at91_for_each_port(port) {
@@ -340,8 +337,7 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		break;
 	}
 
-	ret = orig_ohci_hub_control(hcd, typeReq, wValue, wIndex + 1,
-				buf, wLength);
+	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex + 1, buf, wLength);
 	if (ret)
 		goto out;
 
@@ -690,9 +686,6 @@ static int __init ohci_at91_init(void)
 	 * too easy.
 	 */
 
-	orig_ohci_hub_control = ohci_at91_hc_driver.hub_control;
-	orig_ohci_hub_status_data = ohci_at91_hc_driver.hub_status_data;
-
 	ohci_at91_hc_driver.hub_status_data	= ohci_at91_hub_status_data;
 	ohci_at91_hc_driver.hub_control		= ohci_at91_hub_control;
 
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index c81c872..3d53208 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -438,8 +438,7 @@ static int ohci_root_hub_state_changes(struct ohci_hcd *ohci, int changed,
 
 /* build "status change" packet (one or two bytes) from HC registers */
 
-static int
-ohci_hub_status_data (struct usb_hcd *hcd, char *buf)
+int ohci_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	int		i, changed = 0, length = 1;
@@ -504,6 +503,7 @@ done:
 
 	return changed ? length : 0;
 }
+EXPORT_SYMBOL_GPL(ohci_hub_status_data);
 
 /*-------------------------------------------------------------------------*/
 
@@ -646,7 +646,7 @@ static inline int root_port_reset (struct ohci_hcd *ohci, unsigned port)
 	return 0;
 }
 
-static int ohci_hub_control (
+int ohci_hub_control(
 	struct usb_hcd	*hcd,
 	u16		typeReq,
 	u16		wValue,
@@ -772,4 +772,4 @@ error:
 	}
 	return retval;
 }
-
+EXPORT_SYMBOL_GPL(ohci_hub_control);
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index ff7c8f1..3d753a9 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -45,10 +45,6 @@ static struct clk *usb_clk;
 
 /* forward definitions */
 
-static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
-			u16 wValue, u16 wIndex, char *buf, u16 wLength);
-static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
-
 static void s3c2410_hcd_oc(struct s3c2410_hcd_info *info, int port_oc);
 
 /* conversion functions */
@@ -110,7 +106,7 @@ ohci_s3c2410_hub_status_data(struct usb_hcd *hcd, char *buf)
 	int orig;
 	int portno;
 
-	orig = orig_ohci_hub_status_data(hcd, buf);
+	orig = ohci_hub_status_data(hcd, buf);
 
 	if (info == NULL)
 		return orig;
@@ -181,7 +177,7 @@ static int ohci_s3c2410_hub_control(
 	 * process the request straight away and exit */
 
 	if (info == NULL) {
-		ret = orig_ohci_hub_control(hcd, typeReq, wValue,
+		ret = ohci_hub_control(hcd, typeReq, wValue,
 				       wIndex, buf, wLength);
 		goto out;
 	}
@@ -231,7 +227,7 @@ static int ohci_s3c2410_hub_control(
 		break;
 	}
 
-	ret = orig_ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
 	if (ret)
 		goto out;
 
@@ -489,9 +485,6 @@ static int __init ohci_s3c2410_init(void)
 	 * override these functions by making it too easy.
 	 */
 
-	orig_ohci_hub_control = ohci_s3c2410_hc_driver.hub_control;
-	orig_ohci_hub_status_data = ohci_s3c2410_hc_driver.hub_status_data;
-
 	ohci_s3c2410_hc_driver.hub_status_data	= ohci_s3c2410_hub_status_data;
 	ohci_s3c2410_hc_driver.hub_control	= ohci_s3c2410_hub_control;
 
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index 9250cad..a116583 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -727,3 +727,6 @@ extern int	ohci_setup(struct usb_hcd *hcd);
 extern int	ohci_suspend(struct usb_hcd *hcd, bool do_wakeup);
 extern int	ohci_resume(struct usb_hcd *hcd, bool hibernated);
 #endif
+extern int	ohci_hub_control(struct usb_hcd	*hcd, u16 typeReq, u16 wValue,
+				 u16 wIndex, char *buf, u16 wLength);
+extern int	ohci_hub_status_data(struct usb_hcd *hcd, char *buf);
-- 
1.8.3.2
