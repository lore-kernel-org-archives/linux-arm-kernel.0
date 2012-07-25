From: zonque@gmail.com (Daniel Mack)
Date: Wed, 25 Jul 2012 17:48:21 +0200
Subject: [PATCH] USB: ohci-pxa27x: add DT bindings
Message-ID: <1343231301-8987-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings to the ohci-pxa27x driver and some documentation.

Successfully tested on a PXA3xx board.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/usb/pxa-usb.txt |   31 ++++++++++
 drivers/usb/host/ohci-pxa27x.c                    |   68 +++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/pxa-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/pxa-usb.txt b/Documentation/devicetree/bindings/usb/pxa-usb.txt
new file mode 100644
index 0000000..d623012
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/pxa-usb.txt
@@ -0,0 +1,31 @@
+PXA USB controllers
+
+OHCI
+
+Required properties:
+ - compatible: Should be "mrvl,pxa-ohci" for USB controllers
+   used in host mode.
+
+Optional properties:
+ - "mrvl,enable-port1", "mrvl,enable-port2", "mrvl,enable-port3"
+   If present, enables the appropriate USB port of the controller.
+ - "mrvl,port-mode" selects the mode of the ports:
+	1 = PMM_NPS_MODE
+	2 = PMM_GLOBAL_MODE
+	3 = PMM_PERPORT_MODE
+ - "mrvl,power-sense-low" - power sense pin is low-active.
+ - "mrvl,power-control-low" - power control pin is low-active.
+ - "mrvl,no-oc-protection" - disable over-current protection.
+ - "mrvl,oc-mode-perport" - enable per-port over-current protection.
+ - "mrvl,power_on_delay" Power On to Power Good time - in ms.
+
+Example:
+
+	usb0: ohci at 4c000000 {
+		compatible = "mrvl,pxa-ohci", "usb-ohci";
+		reg = <0x4c000000 0x100000>;
+		interrupts = <18>;
+		mrvl,enable-port1;
+		mrvl,port-mode = <2>; /* PMM_GLOBAL_MODE */
+	};
+
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index e1a3cc6..9cec49f 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -23,6 +23,8 @@
 #include <linux/signal.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
 #include <mach/hardware.h>
 #include <mach/ohci.h>
 #include <mach/pxa3xx-u2d.h>
@@ -272,6 +274,67 @@ static void pxa27x_stop_hc(struct pxa27x_ohci *ohci, struct device *dev)
 	clk_disable_unprepare(ohci->clk);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id pxa_ohci_dt_ids[] = {
+	{ .compatible = "mrvl,pxa-ohci" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, pxa_ohci_dt_ids);
+
+static u64 pxa_ohci_dma_mask = DMA_BIT_MASK(32);
+
+static int __devinit ohci_pxa_of_init(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct pxaohci_platform_data *pdata;
+	u32 tmp;
+
+	if (!np)
+		return 0;
+
+	/* Right now device-tree probed devices don't get dma_mask set.
+	 * Since shared usb code relies on it, set it here for now.
+	 * Once we have dma capability bindings this can go away.
+	 */
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &pxa_ohci_dma_mask;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	if (of_get_property(np, "mrvl,enable-port1", NULL))
+		pdata->flags |= ENABLE_PORT1;
+	if (of_get_property(np, "mrvl,enable-port2", NULL))
+		pdata->flags |= ENABLE_PORT2;
+	if (of_get_property(np, "mrvl,enable-port3", NULL))
+		pdata->flags |= ENABLE_PORT3;
+	if (of_get_property(np, "mrvl,port-sense-low", NULL))
+		pdata->flags |= POWER_SENSE_LOW;
+	if (of_get_property(np, "mrvl,power-control-low", NULL))
+		pdata->flags |= POWER_CONTROL_LOW;
+	if (of_get_property(np, "mrvl,no-oc-protection", NULL))
+		pdata->flags |= NO_OC_PROTECTION;
+	if (of_get_property(np, "mrvl,oc-mode-perport", NULL))
+		pdata->flags |= OC_MODE_PERPORT;
+	if (!of_property_read_u32(np, "mrvl,power-on-delay", &tmp))
+		pdata->power_on_delay = tmp;
+	if (!of_property_read_u32(np, "mrvl,port-mode", &tmp))
+		pdata->port_mode = tmp;
+	if (!of_property_read_u32(np, "mrvl,power-budget", &tmp))
+		pdata->power_budget = tmp;
+
+	pdev->dev.platform_data = pdata;
+
+	return 0;
+}
+#else
+static int __devinit ohci_pxa_of_init(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
 
 /*-------------------------------------------------------------------------*/
 
@@ -297,6 +360,10 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 	struct resource *r;
 	struct clk *usb_clk;
 
+	retval = ohci_pxa_of_init(pdev);
+	if (retval)
+		return retval;
+
 	inf = pdev->dev.platform_data;
 
 	if (!inf)
@@ -544,6 +611,7 @@ static struct platform_driver ohci_hcd_pxa27x_driver = {
 	.driver		= {
 		.name	= "pxa27x-ohci",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(pxa_ohci_dt_ids),
 #ifdef CONFIG_PM
 		.pm	= &ohci_hcd_pxa27x_pm_ops,
 #endif
-- 
1.7.10.4
