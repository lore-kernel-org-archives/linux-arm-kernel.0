From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 19 Jan 2015 12:06:04 +0100
Subject: [PATCHv6 3/6] USB: host: ehci-atmel: Move global variables to private
 struct
In-Reply-To: <1421665567-31759-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421665567-31759-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421665567-31759-4-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch move Atmel EHCI global variables (clocks ptr and clocked
boolean) to private struct atmel_ehci_priv, stored in ehci->priv.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/usb/host/ehci-atmel.c | 79 +++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 5a15e3d..663f790 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -27,48 +27,66 @@
 #define DRIVER_DESC "EHCI Atmel driver"
 
 static const char hcd_name[] = "ehci-atmel";
-static struct hc_driver __read_mostly ehci_atmel_hc_driver;
 
 /* interface and function clocks */
-static struct clk *iclk, *fclk, *uclk;
-static int clocked;
+#define hcd_to_atmel_ehci_priv(h) \
+	((struct atmel_ehci_priv *)hcd_to_ehci(h)->priv)
+
+struct atmel_ehci_priv {
+	struct clk *iclk;
+	struct clk *fclk;
+	struct clk *uclk;
+	bool clocked;
+};
+
+static struct hc_driver __read_mostly ehci_atmel_hc_driver;
+
+static const struct ehci_driver_overrides ehci_atmel_drv_overrides __initconst = {
+	.extra_priv_size = sizeof(struct atmel_ehci_priv),
+};
 
 /*-------------------------------------------------------------------------*/
 
-static void atmel_start_clock(void)
+static void atmel_start_clock(struct atmel_ehci_priv *atmel_ehci)
 {
-	if (clocked)
+	if (atmel_ehci->clocked)
 		return;
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
-		clk_set_rate(uclk, 48000000);
-		clk_prepare_enable(uclk);
+		clk_set_rate(atmel_ehci->uclk, 48000000);
+		clk_prepare_enable(atmel_ehci->uclk);
 	}
-	clk_prepare_enable(iclk);
-	clk_prepare_enable(fclk);
-	clocked = 1;
+	clk_prepare_enable(atmel_ehci->iclk);
+	clk_prepare_enable(atmel_ehci->fclk);
+	atmel_ehci->clocked = true;
 }
 
-static void atmel_stop_clock(void)
+static void atmel_stop_clock(struct atmel_ehci_priv *atmel_ehci)
 {
-	if (!clocked)
+	if (!atmel_ehci->clocked)
 		return;
-	clk_disable_unprepare(fclk);
-	clk_disable_unprepare(iclk);
+	clk_disable_unprepare(atmel_ehci->fclk);
+	clk_disable_unprepare(atmel_ehci->iclk);
 	if (IS_ENABLED(CONFIG_COMMON_CLK))
-		clk_disable_unprepare(uclk);
-	clocked = 0;
+		clk_disable_unprepare(atmel_ehci->uclk);
+	atmel_ehci->clocked = false;
 }
 
 static void atmel_start_ehci(struct platform_device *pdev)
 {
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct atmel_ehci_priv *atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
+
 	dev_dbg(&pdev->dev, "start\n");
-	atmel_start_clock();
+	atmel_start_clock(atmel_ehci);
 }
 
 static void atmel_stop_ehci(struct platform_device *pdev)
 {
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct atmel_ehci_priv *atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
+
 	dev_dbg(&pdev->dev, "stop\n");
-	atmel_stop_clock();
+	atmel_stop_clock(atmel_ehci);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -79,6 +97,7 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 	const struct hc_driver *driver = &ehci_atmel_hc_driver;
 	struct resource *res;
 	struct ehci_hcd *ehci;
+	struct atmel_ehci_priv *atmel_ehci;
 	int irq;
 	int retval;
 
@@ -109,6 +128,7 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 		retval = -ENOMEM;
 		goto fail_create_hcd;
 	}
+	atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
@@ -120,23 +140,23 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
-	iclk = devm_clk_get(&pdev->dev, "ehci_clk");
-	if (IS_ERR(iclk)) {
+	atmel_ehci->iclk = devm_clk_get(&pdev->dev, "ehci_clk");
+	if (IS_ERR(atmel_ehci->iclk)) {
 		dev_err(&pdev->dev, "Error getting interface clock\n");
 		retval = -ENOENT;
 		goto fail_request_resource;
 	}
-	fclk = devm_clk_get(&pdev->dev, "uhpck");
-	if (IS_ERR(fclk)) {
+	atmel_ehci->fclk = devm_clk_get(&pdev->dev, "uhpck");
+	if (IS_ERR(atmel_ehci->fclk)) {
 		dev_err(&pdev->dev, "Error getting function clock\n");
 		retval = -ENOENT;
 		goto fail_request_resource;
 	}
 	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
-		uclk = devm_clk_get(&pdev->dev, "usb_clk");
-		if (IS_ERR(uclk)) {
+		atmel_ehci->uclk = devm_clk_get(&pdev->dev, "usb_clk");
+		if (IS_ERR(atmel_ehci->uclk)) {
 			dev_err(&pdev->dev, "failed to get uclk\n");
-			retval = PTR_ERR(uclk);
+			retval = PTR_ERR(atmel_ehci->uclk);
 			goto fail_request_resource;
 		}
 	}
@@ -173,7 +193,6 @@ static int ehci_atmel_drv_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 
 	atmel_stop_ehci(pdev);
-	fclk = iclk = NULL;
 
 	return 0;
 }
@@ -182,21 +201,23 @@ static int ehci_atmel_drv_remove(struct platform_device *pdev)
 static int ehci_atmel_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct atmel_ehci_priv *atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
 	int ret;
 
 	ret = ehci_suspend(hcd, false);
 	if (ret)
 		return ret;
 
-	atmel_stop_clock();
+	atmel_stop_clock(atmel_ehci);
 	return 0;
 }
 
 static int ehci_atmel_drv_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct atmel_ehci_priv *atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
 
-	atmel_start_clock();
+	atmel_start_clock(atmel_ehci);
 	return ehci_resume(hcd, false);
 }
 #endif
@@ -230,7 +251,7 @@ static int __init ehci_atmel_init(void)
 		return -ENODEV;
 
 	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-	ehci_init_driver(&ehci_atmel_hc_driver, NULL);
+	ehci_init_driver(&ehci_atmel_hc_driver, &ehci_atmel_drv_overrides);
 	return platform_driver_register(&ehci_atmel_driver);
 }
 module_init(ehci_atmel_init);
-- 
2.1.4
