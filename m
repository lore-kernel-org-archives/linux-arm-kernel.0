From: manish.narani@xilinx.com (Manish Narani)
Date: Wed, 4 Jan 2017 18:53:01 +0530
Subject: [RFC PATCH] usb: host: xhci: plat: add support for otg_set_host() call
In-Reply-To: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
Message-ID: <1483536181-22356-7-git-send-email-mnarani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch will add support for OTG host initialization. This will
help OTG drivers to populate their host subsystem.

Signed-off-by: Manish Narani <mnarani@xilinx.com>
---
 drivers/usb/host/xhci-plat.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index ddfab30..aa08bdd 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -19,6 +19,7 @@
 #include <linux/usb/phy.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/usb/otg.h>
 
 #include "xhci.h"
 #include "xhci-plat.h"
@@ -144,6 +145,37 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+static int usb_otg_set_host(struct device *dev, struct usb_hcd *hcd, bool yes)
+{
+	int ret = 0;
+
+	hcd->usb_phy = usb_get_phy(USB_PHY_TYPE_USB3);
+	if (!IS_ERR_OR_NULL(hcd->usb_phy) && hcd->usb_phy->otg) {
+		dev_dbg(dev, "%s otg support available\n", __func__);
+		if (yes) {
+			if (otg_set_host(hcd->usb_phy->otg, &hcd->self)) {
+				dev_err(dev, "%s otg_set_host failed\n",
+						__func__);
+				usb_put_phy(hcd->usb_phy);
+				goto disable_phy;
+			}
+		} else {
+			ret = otg_set_host(hcd->usb_phy->otg, NULL);
+			usb_put_phy(hcd->usb_phy);
+			goto disable_phy;
+		}
+
+	} else
+		goto disable_phy;
+
+	return 0;
+
+disable_phy:
+	hcd->usb_phy = NULL;
+
+	return ret;
+}
+
 static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -255,6 +287,11 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto dealloc_usb2_hcd;
 
+	ret = usb_otg_set_host(&pdev->dev, hcd, 1);
+	if (ret)
+		goto dealloc_usb2_hcd;
+
+
 	return 0;
 
 
@@ -283,6 +320,8 @@ static int xhci_plat_remove(struct platform_device *dev)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct clk *clk = xhci->clk;
 
+	usb_otg_set_host(&dev->dev, hcd, 0);
+
 	usb_remove_hcd(xhci->shared_hcd);
 	usb_phy_shutdown(hcd->usb_phy);
 
-- 
2.1.1
