From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed,  9 Jul 2014 15:31:35 +0530
Subject: [PATCH v2 3/4] usb: host: xhci-plat: Caibrate PHY post host reset
In-Reply-To: <1404900096-1721-1-git-send-email-gautam.vivek@samsung.com>
References: <1404900096-1721-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1404900096-1721-4-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some quirky PHYs may require to be calibrated post the host
controller initialization.
The USB 3.0 DRD PHY on Exynos5420/5800 systems, coming along with
Synopsys's DWC3 controller, is one such PHY which needs to be
calibrated post xhci's reset at initialization time and at
resume time, to get the controller work at SuperSpeed.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 drivers/usb/host/xhci-plat.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index e50bd7d..decf349 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -35,7 +35,27 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 /* called during probe() after chip reset completes */
 static int xhci_plat_setup(struct usb_hcd *hcd)
 {
-	return xhci_gen_setup(hcd, xhci_plat_quirks);
+	struct device *parent;
+	int ret;
+
+	ret = xhci_gen_setup(hcd, xhci_plat_quirks);
+	if (ret) {
+		dev_err(hcd->self.controller, "xhci setup failed\n");
+		return ret;
+	}
+
+	parent = hcd->self.controller->parent;
+	if (of_device_is_compatible(parent->of_node, "synopsys,dwc3") ||
+	    of_device_is_compatible(parent->of_node, "snps,dwc3")) {
+		if (!IS_ERR(hcd->gen_phy)) {
+			ret = phy_calibrate(hcd->gen_phy);
+			if (ret < 0 && ret != -ENOTSUPP)
+				dev_err(hcd->self.controller,
+					"failed to calibrate USB PHY\n");
+		}
+	}
+
+	return ret;
 }
 
 static int xhci_plat_start(struct usb_hcd *hcd)
@@ -288,8 +308,23 @@ static int xhci_plat_resume(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	int ret;
+
+	ret = xhci_resume(xhci, 0);
+	if (ret)
+		return ret;
 
-	return xhci_resume(xhci, 0);
+	if (of_device_is_compatible(dev->parent->of_node, "synopsys,dwc3") ||
+	    of_device_is_compatible(dev->parent->of_node, "snps,dwc3")) {
+		if (!IS_ERR(hcd->gen_phy)) {
+			ret = phy_calibrate(hcd->gen_phy);
+			if (ret < 0 && ret != -ENOTSUPP)
+				dev_err(hcd->self.controller,
+					"failed to calibrate USB PHY\n");
+		}
+	}
+
+	return ret;
 }
 
 static const struct dev_pm_ops xhci_plat_pm_ops = {
-- 
1.7.10.4
