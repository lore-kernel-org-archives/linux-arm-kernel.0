From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 19 Jan 2015 12:06:05 +0100
Subject: [PATCHv6 4/6] USB: host: ohci-at91: Move global variables to private
 struct
In-Reply-To: <1421665567-31759-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421665567-31759-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421665567-31759-5-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch move AT91 OHCI global variables (clocks ptr and clocked
boolean) to private struct ohci_at91_priv, stored in ohci->priv.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/usb/host/ohci-at91.c | 84 +++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 65e7836..c810917 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -33,7 +33,16 @@
 		for ((index) = 0; (index) < AT91_MAX_USBH_PORTS; (index)++)
 
 /* interface, function and usb clocks; sometimes also an AHB clock */
-static struct clk *iclk, *fclk, *uclk, *hclk;
+#define hcd_to_ohci_at91_priv(h) \
+	((struct ohci_at91_priv *)hcd_to_ohci(h)->priv)
+
+struct ohci_at91_priv {
+	struct clk *iclk;
+	struct clk *fclk;
+	struct clk *uclk;
+	struct clk *hclk;
+	bool clocked;
+};
 /* interface and function clocks; sometimes also an AHB clock */
 
 #define DRIVER_DESC "OHCI Atmel driver"
@@ -41,45 +50,49 @@ static struct clk *iclk, *fclk, *uclk, *hclk;
 static const char hcd_name[] = "ohci-atmel";
 
 static struct hc_driver __read_mostly ohci_at91_hc_driver;
-static int clocked;
+
+static const struct ohci_driver_overrides ohci_at91_drv_overrides __initconst = {
+	.extra_priv_size = sizeof(struct ohci_at91_priv),
+};
 
 extern int usb_disabled(void);
 
 /*-------------------------------------------------------------------------*/
 
-static void at91_start_clock(void)
+static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
 {
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
-		clk_set_rate(uclk, 48000000);
-		clk_prepare_enable(uclk);
+		clk_set_rate(ohci_at91->uclk, 48000000);
+		clk_prepare_enable(ohci_at91->uclk);
 	}
-	clk_prepare_enable(hclk);
-	clk_prepare_enable(iclk);
-	clk_prepare_enable(fclk);
-	clocked = 1;
+	clk_prepare_enable(ohci_at91->hclk);
+	clk_prepare_enable(ohci_at91->iclk);
+	clk_prepare_enable(ohci_at91->fclk);
+	ohci_at91->clocked = true;
 }
 
-static void at91_stop_clock(void)
+static void at91_stop_clock(struct ohci_at91_priv *ohci_at91)
 {
-	clk_disable_unprepare(fclk);
-	clk_disable_unprepare(iclk);
-	clk_disable_unprepare(hclk);
+	clk_disable_unprepare(ohci_at91->fclk);
+	clk_disable_unprepare(ohci_at91->iclk);
+	clk_disable_unprepare(ohci_at91->hclk);
 	if (IS_ENABLED(CONFIG_COMMON_CLK))
-		clk_disable_unprepare(uclk);
-	clocked = 0;
+		clk_disable_unprepare(ohci_at91->uclk);
+	ohci_at91->clocked = false;
 }
 
 static void at91_start_hc(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ohci_regs __iomem *regs = hcd->regs;
+	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
 	dev_dbg(&pdev->dev, "start\n");
 
 	/*
 	 * Start the USB clocks.
 	 */
-	at91_start_clock();
+	at91_start_clock(ohci_at91);
 
 	/*
 	 * The USB host controller must remain in reset.
@@ -91,6 +104,7 @@ static void at91_stop_hc(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ohci_regs __iomem *regs = hcd->regs;
+	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
 	dev_dbg(&pdev->dev, "stop\n");
 
@@ -102,7 +116,7 @@ static void at91_stop_hc(struct platform_device *pdev)
 	/*
 	 * Stop the USB clocks.
 	 */
-	at91_stop_clock();
+	at91_stop_clock(ohci_at91);
 }
 
 
@@ -129,6 +143,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	struct ohci_hcd *ohci;
 	int retval;
 	struct usb_hcd *hcd = NULL;
+	struct ohci_at91_priv *ohci_at91;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	int irq;
@@ -142,6 +157,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	hcd = usb_create_hcd(driver, dev, "at91");
 	if (!hcd)
 		return -ENOMEM;
+	ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hcd->regs = devm_ioremap_resource(dev, res);
@@ -152,29 +168,29 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
-	iclk = devm_clk_get(dev, "ohci_clk");
-	if (IS_ERR(iclk)) {
+	ohci_at91->iclk = devm_clk_get(dev, "ohci_clk");
+	if (IS_ERR(ohci_at91->iclk)) {
 		dev_err(dev, "failed to get ohci_clk\n");
-		retval = PTR_ERR(iclk);
+		retval = PTR_ERR(ohci_at91->iclk);
 		goto err;
 	}
-	fclk = devm_clk_get(dev, "uhpck");
-	if (IS_ERR(fclk)) {
+	ohci_at91->fclk = devm_clk_get(dev, "uhpck");
+	if (IS_ERR(ohci_at91->fclk)) {
 		dev_err(dev, "failed to get uhpck\n");
-		retval = PTR_ERR(fclk);
+		retval = PTR_ERR(ohci_at91->fclk);
 		goto err;
 	}
-	hclk = devm_clk_get(dev, "hclk");
-	if (IS_ERR(hclk)) {
+	ohci_at91->hclk = devm_clk_get(dev, "hclk");
+	if (IS_ERR(ohci_at91->hclk)) {
 		dev_err(dev, "failed to get hclk\n");
-		retval = PTR_ERR(hclk);
+		retval = PTR_ERR(ohci_at91->hclk);
 		goto err;
 	}
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
-		uclk = devm_clk_get(dev, "usb_clk");
-		if (IS_ERR(uclk)) {
+		ohci_at91->uclk = devm_clk_get(dev, "usb_clk");
+		if (IS_ERR(ohci_at91->uclk)) {
 			dev_err(dev, "failed to get uclk\n");
-			retval = PTR_ERR(uclk);
+			retval = PTR_ERR(ohci_at91->uclk);
 			goto err;
 		}
 	}
@@ -597,6 +613,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 	bool		do_wakeup = device_may_wakeup(dev);
 	int		ret;
 
@@ -623,7 +640,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
-		at91_stop_clock();
+		at91_stop_clock(ohci_at91);
 	}
 
 	return ret;
@@ -632,12 +649,13 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 static int ohci_hcd_at91_drv_resume(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(hcd->irq);
 
-	if (!clocked)
-		at91_start_clock();
+	if (!ohci_at91->clocked)
+		at91_start_clock(ohci_at91);
 
 	ohci_resume(hcd, false);
 	return 0;
@@ -664,7 +682,7 @@ static int __init ohci_at91_init(void)
 		return -ENODEV;
 
 	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-	ohci_init_driver(&ohci_at91_hc_driver, NULL);
+	ohci_init_driver(&ohci_at91_hc_driver, &ohci_at91_drv_overrides);
 
 	/*
 	 * The Atmel HW has some unusual quirks, which require Atmel-specific
-- 
2.1.4
