From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:55 +0200
Subject: [PATCH/RFT 10/12] USB: ohci-da8xx: Add device tree support
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-11-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

This allows the controller to be specified via device tree.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 52 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index d7a0f11..10db421 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -18,6 +18,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #ifndef CONFIG_ARCH_DAVINCI_DA8XX
 #error "This file is DA8xx bus glue.  Define CONFIG_ARCH_DAVINCI_DA8XX."
@@ -311,6 +312,47 @@ static const struct hc_driver ohci_da8xx_hc_driver = {
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_OF
+static const struct of_device_id da8xx_ohci_ids[] = {
+	{ .compatible = "ti,da830-ohci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da8xx_ohci_ids);
+
+static int ohci_da8xx_of_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct da8xx_ohci_platform_data *pdata;
+	u32 tmp;
+
+	if (!np)
+		return 0;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->gpio_vbus = of_get_named_gpio(np, "vbus-gpio", 0);
+	if (pdata->gpio_vbus >= 0)
+		pdata->flags |= DA8XX_OHCI_FLAG_GPIO_VBUS;
+
+	pdata->gpio_overcurrent = of_get_named_gpio(np, "oci-gpio", 0);
+	if (pdata->gpio_overcurrent >= 0)
+		pdata->flags |= DA8XX_OHCI_FLAG_GPIO_OCI;
+
+	if (!of_property_read_u32(np, "power-on-delay", &tmp))
+		pdata->potpgt = tmp;
+
+	pdev->dev.platform_data = pdata;
+
+	return 0;
+}
+#else
+static int ohci_da8xx_of_init(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
 
 /**
  * usb_hcd_da8xx_probe - initialize DA8xx-based HCDs
@@ -323,12 +365,17 @@ static const struct hc_driver ohci_da8xx_hc_driver = {
 static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 			       struct platform_device *pdev)
 {
-	struct da8xx_ohci_platform_data *pdata	= dev_get_platdata(&pdev->dev);
+	struct da8xx_ohci_platform_data *pdata;
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
 
-	if (pdata == NULL)
+	error = ohci_da8xx_of_init(pdev);
+	if (error)
+		pr_err("error initializing platform data: %d\n", error);
+
+	pdata  = dev_get_platdata(&pdev->dev);
+	if (!pdata)
 		return -ENODEV;
 
 	usb11_clk = devm_clk_get(&pdev->dev, "usb11");
@@ -498,6 +545,7 @@ static struct platform_driver ohci_hcd_da8xx_driver = {
 #endif
 	.driver		= {
 		.name	= "ohci",
+		.of_match_table = da8xx_ohci_ids,
 	},
 };
 
-- 
2.7.1
