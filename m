From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 7 Dec 2015 20:49:24 +0800
Subject: [PATCH v2 7/7] usb: xhci: plat: add vbus regulator control
In-Reply-To: <1449492564-4803-1-git-send-email-jszhang@marvell.com>
References: <1449492564-4803-1-git-send-email-jszhang@marvell.com>
Message-ID: <1449492564-4803-8-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell BG4CT STB board has board level vbus control through gpio.
This patch adds the vbus regulator control to support this board.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/host/xhci-plat.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  2 ++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index bb972a6..c03e8d5 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/xhci_pdriver.h>
@@ -116,6 +117,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	struct clk              *clk;
 	struct usb_phy		*usb_phy;
 	struct phy		*phy;
+	struct regulator	*vbus;
 	int			ret;
 	int			irq;
 
@@ -179,14 +181,31 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 	device_wakeup_enable(hcd->self.controller);
 
+	vbus = devm_regulator_get(&pdev->dev, "vbus");
+	if (PTR_ERR(vbus) == -ENODEV) {
+		vbus = NULL;
+	} else if (IS_ERR(vbus)) {
+		ret = PTR_ERR(vbus);
+		goto disable_clk;
+	} else if (vbus) {
+		ret = regulator_enable(vbus);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to enable usb vbus regulator: %d\n",
+				ret);
+			goto disable_clk;
+		}
+	}
+
 	xhci = hcd_to_xhci(hcd);
 	xhci->clk = clk;
+	xhci->vbus = vbus;
 	xhci->main_hcd = hcd;
 	xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
 			dev_name(&pdev->dev), hcd);
 	if (!xhci->shared_hcd) {
 		ret = -ENOMEM;
-		goto disable_clk;
+		goto disable_vbus;
 	}
 
 	if ((node && of_property_read_bool(node, "usb3-lpm-capable")) ||
@@ -254,6 +273,10 @@ disable_usb2_phy:
 put_usb3_hcd:
 	usb_put_hcd(xhci->shared_hcd);
 
+disable_vbus:
+	if (vbus)
+		regulator_disable(vbus);
+
 disable_clk:
 	clk_disable_unprepare(clk);
 
@@ -268,6 +291,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	struct usb_hcd	*hcd = platform_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct clk *clk = xhci->clk;
+	struct regulator *vbus = xhci->vbus;
 
 	usb_remove_hcd(xhci->shared_hcd);
 	xhci_plat_phy_exit(xhci->shared_hcd);
@@ -278,6 +302,9 @@ static int xhci_plat_remove(struct platform_device *dev)
 	clk_disable_unprepare(clk);
 	usb_put_hcd(hcd);
 
+	if (vbus)
+		regulator_disable(vbus);
+
 	return 0;
 }
 
@@ -287,6 +314,7 @@ static int xhci_plat_suspend(struct device *dev)
 	int ret;
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	struct regulator *vbus = xhci->vbus;
 
 	/*
 	 * xhci_suspend() needs `do_wakeup` to know whether host is allowed
@@ -303,6 +331,8 @@ static int xhci_plat_suspend(struct device *dev)
 	xhci_plat_phy_exit(xhci->shared_hcd);
 	xhci_plat_phy_exit(hcd);
 	clk_disable_unprepare(xhci->clk);
+	if (vbus)
+		ret = regulator_disable(vbus);
 
 	return ret;
 }
@@ -312,11 +342,18 @@ static int xhci_plat_resume(struct device *dev)
 	int ret;
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	struct regulator *vbus = xhci->vbus;
 
 	ret = clk_prepare_enable(xhci->clk);
 	if (ret)
 		return ret;
 
+	if (vbus) {
+		ret = regulator_enable(vbus);
+		if (ret)
+			return ret;
+	}
+
 	ret = xhci_plat_phy_init(hcd);
 	if (ret)
 		return ret;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 0b94512..1355d2a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1541,6 +1541,8 @@ struct xhci_hcd {
 	struct msix_entry	*msix_entries;
 	/* optional clock */
 	struct clk		*clk;
+	/* optional regulator */
+	struct regulator	*vbus;
 	/* data structures */
 	struct xhci_device_context_array *dcbaa;
 	struct xhci_ring	*cmd_ring;
-- 
2.6.2
