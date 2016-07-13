From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 13 Jul 2016 10:29:08 +0200
Subject: [PATCH] usb: ehci-platform: use helper variables in probe function
Message-ID: <1468398548-5050-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Probing function was using &dev->dev and dev->dev.of_node over 20 times
so I believe it made sense to use helper variables for both of them.
To avoid some uncommon variable name for struct device I first replaced
existing dev variable with pdev.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 drivers/usb/host/ehci-platform.c | 65 +++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 6816b8c..c5cf4e2 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -143,11 +143,13 @@ static struct usb_ehci_pdata ehci_platform_defaults = {
 	.power_off =		ehci_platform_power_off,
 };
 
-static int ehci_platform_probe(struct platform_device *dev)
+static int ehci_platform_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct usb_hcd *hcd;
 	struct resource *res_mem;
-	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
+	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
 	struct ehci_platform_priv *priv;
 	struct ehci_hcd *ehci;
 	int err, irq, phy_num, clk = 0, rst;
@@ -162,52 +164,49 @@ static int ehci_platform_probe(struct platform_device *dev)
 	if (!pdata)
 		pdata = &ehci_platform_defaults;
 
-	err = dma_coerce_mask_and_coherent(&dev->dev,
+	err = dma_coerce_mask_and_coherent(dev,
 		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (err) {
-		dev_err(&dev->dev, "Error: DMA mask configuration failed\n");
+		dev_err(dev, "Error: DMA mask configuration failed\n");
 		return err;
 	}
 
-	irq = platform_get_irq(dev, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+		dev_err(dev, "no irq provided");
 		return irq;
 	}
 
-	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
-			     dev_name(&dev->dev));
+	hcd = usb_create_hcd(&ehci_platform_hc_driver, dev, dev_name(dev));
 	if (!hcd)
 		return -ENOMEM;
 
-	platform_set_drvdata(dev, hcd);
-	dev->dev.platform_data = pdata;
+	platform_set_drvdata(pdev, hcd);
+	dev->platform_data = pdata;
 	priv = hcd_to_ehci_priv(hcd);
 	ehci = hcd_to_ehci(hcd);
 
-	if (pdata == &ehci_platform_defaults && dev->dev.of_node) {
-		if (of_property_read_bool(dev->dev.of_node, "big-endian-regs"))
+	if (pdata == &ehci_platform_defaults && np) {
+		if (of_property_read_bool(np, "big-endian-regs"))
 			ehci->big_endian_mmio = 1;
 
-		if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
+		if (of_property_read_bool(np, "big-endian-desc"))
 			ehci->big_endian_desc = 1;
 
-		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
+		if (of_property_read_bool(np, "big-endian"))
 			ehci->big_endian_mmio = ehci->big_endian_desc = 1;
 
-		if (of_property_read_bool(dev->dev.of_node,
-					  "needs-reset-on-resume"))
+		if (of_property_read_bool(np, "needs-reset-on-resume"))
 			priv->reset_on_resume = true;
 
-		if (of_property_read_bool(dev->dev.of_node,
-					  "has-transaction-translator"))
+		if (of_property_read_bool(np, "has-transaction-translator"))
 			hcd->has_tt = 1;
 
-		priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
-				"phys", "#phy-cells");
+		priv->num_phys = of_count_phandle_with_args(np, "phys",
+							    "#phy-cells");
 
 		if (priv->num_phys > 0) {
-			priv->phys = devm_kcalloc(&dev->dev, priv->num_phys,
+			priv->phys = devm_kcalloc(dev, priv->num_phys,
 					    sizeof(struct phy *), GFP_KERNEL);
 			if (!priv->phys)
 				return -ENOMEM;
@@ -216,7 +215,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 		for (phy_num = 0; phy_num < priv->num_phys; phy_num++) {
 			priv->phys[phy_num] = devm_of_phy_get_by_index(
-					&dev->dev, dev->dev.of_node, phy_num);
+					dev, np, phy_num);
 			if (IS_ERR(priv->phys[phy_num])) {
 				err = PTR_ERR(priv->phys[phy_num]);
 					goto err_put_hcd;
@@ -224,7 +223,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 		}
 
 		for (clk = 0; clk < EHCI_MAX_CLKS; clk++) {
-			priv->clks[clk] = of_clk_get(dev->dev.of_node, clk);
+			priv->clks[clk] = of_clk_get(np, clk);
 			if (IS_ERR(priv->clks[clk])) {
 				err = PTR_ERR(priv->clks[clk]);
 				if (err == -EPROBE_DEFER)
@@ -237,7 +236,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 	for (rst = 0; rst < EHCI_MAX_RSTS; rst++) {
 		priv->rsts[rst] = devm_reset_control_get_shared_by_index(
-					&dev->dev, rst);
+					dev, rst);
 		if (IS_ERR(priv->rsts[rst])) {
 			err = PTR_ERR(priv->rsts[rst]);
 			if (err == -EPROBE_DEFER)
@@ -262,29 +261,27 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 #ifndef CONFIG_USB_EHCI_BIG_ENDIAN_MMIO
 	if (ehci->big_endian_mmio) {
-		dev_err(&dev->dev,
-			"Error: CONFIG_USB_EHCI_BIG_ENDIAN_MMIO not set\n");
+		dev_err(dev, "Error: CONFIG_USB_EHCI_BIG_ENDIAN_MMIO not set\n");
 		err = -EINVAL;
 		goto err_reset;
 	}
 #endif
 #ifndef CONFIG_USB_EHCI_BIG_ENDIAN_DESC
 	if (ehci->big_endian_desc) {
-		dev_err(&dev->dev,
-			"Error: CONFIG_USB_EHCI_BIG_ENDIAN_DESC not set\n");
+		dev_err(dev, "Error: CONFIG_USB_EHCI_BIG_ENDIAN_DESC not set\n");
 		err = -EINVAL;
 		goto err_reset;
 	}
 #endif
 
 	if (pdata->power_on) {
-		err = pdata->power_on(dev);
+		err = pdata->power_on(pdev);
 		if (err < 0)
 			goto err_reset;
 	}
 
-	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&dev->dev, res_mem);
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->regs = devm_ioremap_resource(dev, res_mem);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
 		goto err_power;
@@ -297,13 +294,13 @@ static int ehci_platform_probe(struct platform_device *dev)
 		goto err_power;
 
 	device_wakeup_enable(hcd->self.controller);
-	platform_set_drvdata(dev, hcd);
+	platform_set_drvdata(pdev, hcd);
 
 	return err;
 
 err_power:
 	if (pdata->power_off)
-		pdata->power_off(dev);
+		pdata->power_off(pdev);
 err_reset:
 	while (--rst >= 0)
 		reset_control_assert(priv->rsts[rst]);
@@ -312,7 +309,7 @@ err_put_clks:
 		clk_put(priv->clks[clk]);
 err_put_hcd:
 	if (pdata == &ehci_platform_defaults)
-		dev->dev.platform_data = NULL;
+		dev->platform_data = NULL;
 
 	usb_put_hcd(hcd);
 
-- 
1.8.4.5
