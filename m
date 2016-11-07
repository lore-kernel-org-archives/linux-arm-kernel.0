From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon,  7 Nov 2016 21:39:39 +0100
Subject: [PATCH v3 01/10] USB: ohci: da8xx: use ohci priv data instead of
 globals
In-Reply-To: <20161107203948.28324-1-ahaslam@baylibre.com>
References: <20161107203948.28324-1-ahaslam@baylibre.com>
Message-ID: <20161107203948.28324-2-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of global variables, use the extra_priv_size of
the ohci driver.

We cannot yet move the ocic mask because this is used on
the interrupt handler which is registerded through platform
data and does not have an hcd pointer. This will be moved
on a later patch.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 72 +++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 429d58b..0442c64 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -35,43 +35,49 @@ static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
 			u16 wValue, u16 wIndex, char *buf, u16 wLength);
 static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
 
-static struct clk *usb11_clk;
-static struct phy *usb11_phy;
+struct da8xx_ohci_hcd {
+	struct clk *usb11_clk;
+	struct phy *usb11_phy;
+};
+#define to_da8xx_ohci(hcd) (struct da8xx_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
 
 /* Over-current indicator change bitmask */
 static volatile u16 ocic_mask;
 
-static int ohci_da8xx_enable(void)
+static int ohci_da8xx_enable(struct usb_hcd *hcd)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	int ret;
 
-	ret = clk_prepare_enable(usb11_clk);
+	ret = clk_prepare_enable(da8xx_ohci->usb11_clk);
 	if (ret)
 		return ret;
 
-	ret = phy_init(usb11_phy);
+	ret = phy_init(da8xx_ohci->usb11_phy);
 	if (ret)
 		goto err_phy_init;
 
-	ret = phy_power_on(usb11_phy);
+	ret = phy_power_on(da8xx_ohci->usb11_phy);
 	if (ret)
 		goto err_phy_power_on;
 
 	return 0;
 
 err_phy_power_on:
-	phy_exit(usb11_phy);
+	phy_exit(da8xx_ohci->usb11_phy);
 err_phy_init:
-	clk_disable_unprepare(usb11_clk);
+	clk_disable_unprepare(da8xx_ohci->usb11_clk);
 
 	return ret;
 }
 
-static void ohci_da8xx_disable(void)
+static void ohci_da8xx_disable(struct usb_hcd *hcd)
 {
-	phy_power_off(usb11_phy);
-	phy_exit(usb11_phy);
-	clk_disable_unprepare(usb11_clk);
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
+
+	phy_power_off(da8xx_ohci->usb11_phy);
+	phy_exit(da8xx_ohci->usb11_phy);
+	clk_disable_unprepare(da8xx_ohci->usb11_clk);
 }
 
 /*
@@ -97,7 +103,7 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
 
 	dev_dbg(dev, "starting USB controller\n");
 
-	result = ohci_da8xx_enable();
+	result = ohci_da8xx_enable(hcd);
 	if (result < 0)
 		return result;
 
@@ -109,7 +115,7 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
 
 	result = ohci_setup(hcd);
 	if (result < 0) {
-		ohci_da8xx_disable();
+		ohci_da8xx_disable(hcd);
 		return result;
 	}
 
@@ -231,6 +237,7 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 static int ohci_da8xx_probe(struct platform_device *pdev)
 {
 	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
+	struct da8xx_ohci_hcd *da8xx_ohci;
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
@@ -238,25 +245,29 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	if (hub == NULL)
 		return -ENODEV;
 
-	usb11_clk = devm_clk_get(&pdev->dev, "usb11");
-	if (IS_ERR(usb11_clk)) {
-		if (PTR_ERR(usb11_clk) != -EPROBE_DEFER)
+	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
+				dev_name(&pdev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	da8xx_ohci = to_da8xx_ohci(hcd);
+
+	da8xx_ohci->usb11_clk = devm_clk_get(&pdev->dev, "usb11");
+	if (IS_ERR(da8xx_ohci->usb11_clk)) {
+		if (PTR_ERR(da8xx_ohci->usb11_clk) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Failed to get clock.\n");
-		return PTR_ERR(usb11_clk);
+		error = PTR_ERR(da8xx_ohci->usb11_clk);
+		goto err;
 	}
 
-	usb11_phy = devm_phy_get(&pdev->dev, "usb-phy");
-	if (IS_ERR(usb11_phy)) {
-		if (PTR_ERR(usb11_phy) != -EPROBE_DEFER)
+	da8xx_ohci->usb11_phy = devm_phy_get(&pdev->dev, "usb-phy");
+	if (IS_ERR(da8xx_ohci->usb11_phy)) {
+		if (PTR_ERR(da8xx_ohci->usb11_phy) != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Failed to get phy.\n");
-		return PTR_ERR(usb11_phy);
+		error = PTR_ERR(da8xx_ohci->usb11_phy);
+		goto err;
 	}
 
-	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
-				dev_name(&pdev->dev));
-	if (!hcd)
-		return -ENOMEM;
-
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hcd->regs = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(hcd->regs)) {
@@ -321,7 +332,7 @@ static int ohci_da8xx_suspend(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	ohci_da8xx_disable();
+	ohci_da8xx_disable(hcd);
 	hcd->state = HC_STATE_SUSPENDED;
 
 	return ret;
@@ -337,7 +348,7 @@ static int ohci_da8xx_resume(struct platform_device *dev)
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
-	ret = ohci_da8xx_enable();
+	ret = ohci_da8xx_enable(hcd);
 	if (ret)
 		return ret;
 
@@ -349,7 +360,8 @@ static int ohci_da8xx_resume(struct platform_device *dev)
 #endif
 
 static const struct ohci_driver_overrides da8xx_overrides __initconst = {
-	.reset		= ohci_da8xx_reset,
+	.reset		 = ohci_da8xx_reset,
+	.extra_priv_size = sizeof(struct da8xx_ohci_hcd),
 };
 
 /*
-- 
2.10.1
