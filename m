From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue,  5 Aug 2014 13:21:09 +0530
Subject: [PATCH] usb: ehci/ohci-exynos: Fix PHY getting sequence
Message-ID: <1407225069-28443-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we want to keep support for both older usb-phys as well as the
newer generic phys, lets first get the generic PHYs and fallback to
older USB-PHYs only when we fail to get the former.
This should fix the issue with ehci-exynos and ohci-exynos, wherein
in the absence of SAMSUNG_USB2PHY config symbol, we end up getting
the NOP_USB_XCEIV phy when the same is enabled. And thus the PHYs
are not configured properly.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Jingoo Han <jg1.han@samsung.com>
---
 drivers/usb/host/ehci-exynos.c |   40 +++++++++++++++++-----------------
 drivers/usb/host/ohci-exynos.c |   47 +++++++++++++++++++---------------------
 2 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index cda0a2f..2eed9a4 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -62,18 +62,6 @@ static int exynos_ehci_get_phy(struct device *dev,
 	int phy_number;
 	int ret = 0;
 
-	exynos_ehci->phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-	if (IS_ERR(exynos_ehci->phy)) {
-		ret = PTR_ERR(exynos_ehci->phy);
-		if (ret != -ENXIO && ret != -ENODEV) {
-			dev_err(dev, "no usb2 phy configured\n");
-			return ret;
-		}
-		dev_dbg(dev, "Failed to get usb2 phy\n");
-	} else {
-		exynos_ehci->otg = exynos_ehci->phy->otg;
-	}
-
 	for_each_available_child_of_node(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &phy_number);
 		if (ret) {
@@ -90,15 +78,27 @@ static int exynos_ehci_get_phy(struct device *dev,
 
 		phy = devm_of_phy_get(dev, child, NULL);
 		of_node_put(child);
-		if (IS_ERR(phy)) {
-			ret = PTR_ERR(phy);
-			if (ret != -ENOSYS && ret != -ENODEV) {
-				dev_err(dev, "no usb2 phy configured\n");
-				return ret;
-			}
-			dev_dbg(dev, "Failed to get usb2 phy\n");
-		}
+		if (IS_ERR(phy))
+			/* Lets fallback to older USB-PHYs */
+			goto usb_phy_old;
 		exynos_ehci->phy_g[phy_number] = phy;
+		/* Make the older PHYs unavailable */
+		exynos_ehci->phy = ERR_PTR(-ENXIO);
+	}
+
+	return 0;
+
+usb_phy_old:
+	exynos_ehci->phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	if (IS_ERR(exynos_ehci->phy)) {
+		ret = PTR_ERR(exynos_ehci->phy);
+		if (ret != -ENXIO && ret != -ENODEV) {
+			dev_err(dev, "no usb2 phy configured\n");
+			return ret;
+		}
+		dev_dbg(dev, "Failed to get usb2 phy\n");
+	} else {
+		exynos_ehci->otg = exynos_ehci->phy->otg;
 	}
 
 	return ret;
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index a72ab8f..7c48e3f 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -51,27 +51,12 @@ static int exynos_ohci_get_phy(struct device *dev,
 	int phy_number;
 	int ret = 0;
 
-	exynos_ohci->phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-	if (IS_ERR(exynos_ohci->phy)) {
-		ret = PTR_ERR(exynos_ohci->phy);
-		if (ret != -ENXIO && ret != -ENODEV) {
-			dev_err(dev, "no usb2 phy configured\n");
-			return ret;
-		}
-		dev_dbg(dev, "Failed to get usb2 phy\n");
-	} else {
-		exynos_ohci->otg = exynos_ohci->phy->otg;
-	}
-
 	/*
 	 * Getting generic phy:
 	 * We are keeping both types of phys as a part of transiting OHCI
 	 * to generic phy framework, so as to maintain backward compatibilty
-	 * with old DTB.
-	 * If there are existing devices using DTB files built from them,
-	 * to remove the support for old bindings in this driver,
-	 * we need to make sure that such devices have their DTBs
-	 * updated to ones built from new DTS.
+	 * with old DTB too.
+	 * We fallback to older USB-PHYs when we fail to get generic PHYs.
 	 */
 	for_each_available_child_of_node(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &phy_number);
@@ -89,15 +74,27 @@ static int exynos_ohci_get_phy(struct device *dev,
 
 		phy = devm_of_phy_get(dev, child, NULL);
 		of_node_put(child);
-		if (IS_ERR(phy)) {
-			ret = PTR_ERR(phy);
-			if (ret != -ENOSYS && ret != -ENODEV) {
-				dev_err(dev, "no usb2 phy configured\n");
-				return ret;
-			}
-			dev_dbg(dev, "Failed to get usb2 phy\n");
-		}
+		if (IS_ERR(phy))
+			/* Lets fallback to older USB-PHYs */
+			goto usb_phy_old;
 		exynos_ohci->phy_g[phy_number] = phy;
+		/* Make the older PHYs unavailable */
+		exynos_ohci->phy = ERR_PTR(-ENXIO);
+	}
+
+	return 0;
+
+usb_phy_old:
+	exynos_ohci->phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	if (IS_ERR(exynos_ohci->phy)) {
+		ret = PTR_ERR(exynos_ohci->phy);
+		if (ret != -ENXIO && ret != -ENODEV) {
+			dev_err(dev, "no usb2 phy configured\n");
+			return ret;
+		}
+		dev_dbg(dev, "Failed to get usb2 phy\n");
+	} else {
+		exynos_ohci->otg = exynos_ohci->phy->otg;
 	}
 
 	return ret;
-- 
1.7.10.4
