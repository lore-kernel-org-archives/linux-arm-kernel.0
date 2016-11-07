From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon,  7 Nov 2016 21:39:41 +0100
Subject: [PATCH v3 03/10] USB: ohci: da8xx: Allow a regulator to handle VBUS
In-Reply-To: <20161107203948.28324-1-ahaslam@baylibre.com>
References: <20161107203948.28324-1-ahaslam@baylibre.com>
Message-ID: <20161107203948.28324-4-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to remove the platform callbacks to be able to probe
the driver using device tree. Using a regulator to handle VBUS will
eliminate the need for these callbacks once all users are converted
to use a regulator.

The regulator equivalents to the platform callbacks are:
    set_power   ->  regulator_enable/regulator_disable
    get_power   ->  regulator_is_enabled
    get_oci     ->  regulator_get_error_flags
    ocic_notify ->  regulator event notification

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 97 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 9ed43c7..0a4b885 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_data/usb-davinci.h>
+#include <linux/regulator/consumer.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <asm/unaligned.h>
@@ -36,8 +37,12 @@ static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
 static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
 
 struct da8xx_ohci_hcd {
+	struct usb_hcd *hcd;
 	struct clk *usb11_clk;
 	struct phy *usb11_phy;
+	struct regulator *vbus_reg;
+	struct notifier_block nb;
+	unsigned int is_powered;
 };
 #define to_da8xx_ohci(hcd) (struct da8xx_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
 
@@ -82,56 +87,105 @@ static void ohci_da8xx_disable(struct usb_hcd *hcd)
 
 static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
 	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+	int ret;
 
 	if (hub && hub->set_power)
 		return hub->set_power(1, on);
 
+	if (!da8xx_ohci->vbus_reg)
+		return 0;
+
+	if (on && !da8xx_ohci->is_powered) {
+		ret = regulator_enable(da8xx_ohci->vbus_reg);
+		if (ret) {
+			dev_err(dev, "Fail to enable regulator: %d\n", ret);
+			return ret;
+		}
+		da8xx_ohci->is_powered = 1;
+
+	} else if (!on && da8xx_ohci->is_powered) {
+		ret = regulator_disable(da8xx_ohci->vbus_reg);
+		if (ret) {
+			dev_err(dev, "Fail to disable regulator: %d\n", ret);
+			return ret;
+		}
+		da8xx_ohci->is_powered = 0;
+	}
+
 	return 0;
 }
 
 static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
 	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
 	if (hub && hub->get_power)
 		return hub->get_power(1);
 
+	if (da8xx_ohci->vbus_reg)
+		return regulator_is_enabled(da8xx_ohci->vbus_reg);
+
 	return 1;
 }
 
 static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
 	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+	unsigned int flags;
+	int ret;
 
 	if (hub && hub->get_oci)
 		return hub->get_oci(1);
 
+	if (!da8xx_ohci->vbus_reg)
+		return 0;
+
+	ret = regulator_get_error_flags(da8xx_ohci->vbus_reg, &flags);
+	if (ret) {
+		dev_err(dev, "could not get regulator error flags: %d\n", ret);
+		return ret;
+	}
+
+	if (flags && REGULATOR_ERROR_OVER_CURRENT)
+		return 1;
+
 	return 0;
 }
 
 static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
 	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
 	if (hub && hub->set_power)
 		return 1;
 
+	if (da8xx_ohci->vbus_reg)
+		return 1;
+
 	return 0;
 }
 
 static int ohci_da8xx_has_oci(struct usb_hcd *hcd)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
 	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
 	if (hub && hub->get_oci)
 		return 1;
 
+	if (da8xx_ohci->vbus_reg)
+		return 1;
+
 	return 0;
 }
 
@@ -159,15 +213,41 @@ static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub,
 		hub->set_power(port, 0);
 }
 
+static int ohci_da8xx_regulator_event(struct notifier_block *nb,
+				unsigned long event, void *data)
+{
+	struct da8xx_ohci_hcd *da8xx_ohci =
+				container_of(nb, struct da8xx_ohci_hcd, nb);
+	struct device *dev = da8xx_ohci->hcd->self.controller;
+
+	if (event & REGULATOR_EVENT_OVER_CURRENT) {
+		dev_warn(dev, "over current event\n");
+		ocic_mask |= 1;
+		ohci_da8xx_set_power(da8xx_ohci->hcd, 0);
+	}
+
+	return 0;
+}
+
 static int ohci_da8xx_register_notify(struct usb_hcd *hcd)
 {
+	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
 	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+	int ret = 0;
 
 	if (hub && hub->ocic_notify)
-		return hub->ocic_notify(ohci_da8xx_ocic_handler);
+		ret = hub->ocic_notify(ohci_da8xx_ocic_handler);
+	else if (da8xx_ohci->vbus_reg) {
+		da8xx_ohci->nb.notifier_call = ohci_da8xx_regulator_event;
+		ret = devm_regulator_register_notifier(da8xx_ohci->vbus_reg,
+						&da8xx_ohci->nb);
+	}
 
-	return 0;
+	if (ret)
+		dev_err(dev, "Failed to register notifier: %d\n", ret);
+
+	return ret;
 }
 
 static void ohci_da8xx_unregister_notify(struct usb_hcd *hcd)
@@ -330,6 +410,7 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	da8xx_ohci = to_da8xx_ohci(hcd);
+	da8xx_ohci->hcd = hcd;
 
 	da8xx_ohci->usb11_clk = devm_clk_get(&pdev->dev, "usb11");
 	if (IS_ERR(da8xx_ohci->usb11_clk)) {
@@ -347,6 +428,18 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	da8xx_ohci->vbus_reg = devm_regulator_get_optional(&pdev->dev, "vbus");
+	if (IS_ERR(da8xx_ohci->vbus_reg)) {
+		error = PTR_ERR(da8xx_ohci->vbus_reg);
+		if (error == -ENODEV)
+			da8xx_ohci->vbus_reg = NULL;
+		else {
+			dev_err(&pdev->dev,
+				"Failed to get regulator: %d\n", error);
+			goto err;
+		}
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hcd->regs = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(hcd->regs)) {
-- 
2.10.1
