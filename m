From: george.cherian@ti.com (George Cherian)
Date: Tue, 25 Nov 2014 18:41:39 +0530
Subject: [PATCH 03/19] usb: host: xhci-plat: Add support to pass
 XHCI_DRD_SUPPORT quirk
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Message-ID: <1416921115-10467-4-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the platform data to pass XHCI_DRD_SUPPORT quirk to the xhci driver.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/usb/host/xhci-plat.c     | 4 ++++
 include/linux/usb/xhci_pdriver.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d78b0c..2c42273 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -27,6 +27,10 @@ static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
 static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
+	struct usb_xhci_pdata   *pdata = dev_get_platdata(dev);
+
+	if (pdata->usb_drd_support)
+		xhci->quirks |= XHCI_DRD_SUPPORT;
 	/*
 	 * As of now platform drivers don't provide MSI support so we ensure
 	 * here that the generic code does not try to make a pci_dev from our
diff --git a/include/linux/usb/xhci_pdriver.h b/include/linux/usb/xhci_pdriver.h
index 376654b..539c2d8 100644
--- a/include/linux/usb/xhci_pdriver.h
+++ b/include/linux/usb/xhci_pdriver.h
@@ -22,6 +22,7 @@
  */
 struct usb_xhci_pdata {
 	unsigned	usb3_lpm_capable:1;
+	unsigned	usb_drd_support:1;
 };
 
 #endif /* __USB_CORE_XHCI_PDRIVER_H */
-- 
1.8.3.1
