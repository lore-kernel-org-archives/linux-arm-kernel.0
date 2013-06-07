From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Fri,  7 Jun 2013 11:33:31 +0530
Subject: [RFC][PATCH 5/7] USB: OHCI: export ohci_hub_control and
 ohci_hub_status_data
In-Reply-To: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1370585013-12809-6-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make ohci-at91 and ohci-s3c2410 as a separate driver,
ohci_hub_control and ohci_hub_status_data symbol needs to be exported.
This work is part of enabling multi-platform kernels on ARM.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-hub.c |    8 ++++----
 drivers/usb/host/ohci.h     |    9 +++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 2347ab8..c601e70 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -437,8 +437,7 @@ static int ohci_root_hub_state_changes(struct ohci_hcd *ohci, int changed,
 
 /* build "status change" packet (one or two bytes) from HC registers */
 
-static int
-ohci_hub_status_data (struct usb_hcd *hcd, char *buf)
+int ohci_hub_status_data(struct usb_hcd *hcd, char *buf)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	int		i, changed = 0, length = 1;
@@ -503,6 +502,7 @@ done:
 
 	return changed ? length : 0;
 }
+EXPORT_SYMBOL_GPL(ohci_hub_status_data);
 
 /*-------------------------------------------------------------------------*/
 
@@ -645,7 +645,7 @@ static inline int root_port_reset (struct ohci_hcd *ohci, unsigned port)
 	return 0;
 }
 
-static int ohci_hub_control (
+int ohci_hub_control(
 	struct usb_hcd	*hcd,
 	u16		typeReq,
 	u16		wValue,
@@ -773,4 +773,4 @@ error:
 	}
 	return retval;
 }
-
+EXPORT_SYMBOL_GPL(ohci_hub_control);
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index e2e5faa..d0d9b60 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -738,3 +738,12 @@ extern int	ohci_setup(struct usb_hcd *hcd);
 extern int	ohci_suspend(struct usb_hcd *hcd, bool do_wakeup);
 extern int	ohci_resume(struct usb_hcd *hcd, bool hibernated);
 #endif
+extern int ohci_hub_control(
+		struct usb_hcd  *hcd,
+		u16		typeReq,
+		u16		wValue,
+		u16		wIndex,
+		char            *buf,
+		u16		wLength
+);
+extern int ohci_hub_status_data(struct usb_hcd *hcd, char *buf);
-- 
1.7.9.5
