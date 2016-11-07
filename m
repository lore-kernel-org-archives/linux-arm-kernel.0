From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon,  7 Nov 2016 21:39:44 +0100
Subject: [PATCH v3 06/10] USB: ohci: da8xx: Remove ohci platform callbacks
In-Reply-To: <20161107203948.28324-1-ahaslam@baylibre.com>
References: <20161107203948.28324-1-ahaslam@baylibre.com>
Message-ID: <20161107203948.28324-7-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all ohci users are are using a regulator, we can
remove the platform callbacks and data.

potpgt is no longer necessary as a power on delay time can
be specified for the regulator itself.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h  |  2 +-
 arch/arm/mach-davinci/usb-da8xx.c           |  3 +-
 drivers/usb/host/ohci-da8xx.c               | 84 ++---------------------------
 include/linux/platform_data/usb-davinci.h   | 20 -------
 6 files changed, 9 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 16a401a..cb67885 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -129,7 +129,7 @@ static __init void da830_evm_usb_init(void)
 	if (ret)
 		pr_warn("fail to add ohci regulator\n");
 
-	ret = da8xx_register_usb11(NULL);
+	ret = da8xx_register_usb11();
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
 }
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index a252404..cbe7324 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -197,7 +197,7 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB PHY registration failed: %d\n",
 			__func__, ret);
 
-	ret = da8xx_register_usb11(NULL);
+	ret = da8xx_register_usb11();
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n",
 			__func__, ret);
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 43322be..6096402 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -91,7 +91,7 @@ int da8xx_register_spi_bus(int instance, unsigned num_chipselect);
 int da8xx_register_watchdog(void);
 int da8xx_register_usb_phy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
-int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
+int da8xx_register_usb11(void);
 int da8xx_register_usb_refclkin(int rate);
 int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index c6feecf..4ea91bb 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -119,9 +119,8 @@ static struct platform_device da8xx_usb11_device = {
 	.resource	= da8xx_usb11_resources,
 };
 
-int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
+int __init da8xx_register_usb11(void)
 {
-	da8xx_usb11_device.dev.platform_data = pdata;
 	return platform_device_register(&da8xx_usb11_device);
 }
 
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 0a4b885..3dcbf1f 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -89,12 +89,8 @@ static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	int ret;
 
-	if (hub && hub->set_power)
-		return hub->set_power(1, on);
-
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
 
@@ -121,11 +117,6 @@ static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
-
-	if (hub && hub->get_power)
-		return hub->get_power(1);
 
 	if (da8xx_ohci->vbus_reg)
 		return regulator_is_enabled(da8xx_ohci->vbus_reg);
@@ -137,13 +128,9 @@ static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	unsigned int flags;
 	int ret;
 
-	if (hub && hub->get_oci)
-		return hub->get_oci(1);
-
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
 
@@ -159,29 +146,9 @@ static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
 	return 0;
 }
 
-static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
+static int ohci_da8xx_has_regulator(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
-
-	if (hub && hub->set_power)
-		return 1;
-
-	if (da8xx_ohci->vbus_reg)
-		return 1;
-
-	return 0;
-}
-
-static int ohci_da8xx_has_oci(struct usb_hcd *hcd)
-{
-	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
-
-	if (hub && hub->get_oci)
-		return 1;
 
 	if (da8xx_ohci->vbus_reg)
 		return 1;
@@ -189,30 +156,9 @@ static int ohci_da8xx_has_oci(struct usb_hcd *hcd)
 	return 0;
 }
 
-static int ohci_da8xx_has_potpgt(struct usb_hcd *hcd)
-{
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
-
-	if (hub && hub->potpgt)
-		return 1;
-
-	return 0;
-}
-
 /*
  * Handle the port over-current indicator change.
  */
-static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub,
-				    unsigned port)
-{
-	ocic_mask |= 1 << port;
-
-	/* Once over-current is detected, the port needs to be powered down */
-	if (hub->get_oci(port) > 0)
-		hub->set_power(port, 0);
-}
-
 static int ohci_da8xx_regulator_event(struct notifier_block *nb,
 				unsigned long event, void *data)
 {
@@ -233,12 +179,9 @@ static int ohci_da8xx_register_notify(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	int ret = 0;
 
-	if (hub && hub->ocic_notify)
-		ret = hub->ocic_notify(ohci_da8xx_ocic_handler);
-	else if (da8xx_ohci->vbus_reg) {
+	if (da8xx_ohci->vbus_reg) {
 		da8xx_ohci->nb.notifier_call = ohci_da8xx_regulator_event;
 		ret = devm_regulator_register_notifier(da8xx_ohci->vbus_reg,
 						&da8xx_ohci->nb);
@@ -250,19 +193,9 @@ static int ohci_da8xx_register_notify(struct usb_hcd *hcd)
 	return ret;
 }
 
-static void ohci_da8xx_unregister_notify(struct usb_hcd *hcd)
-{
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
-
-	if (hub && hub->ocic_notify)
-		hub->ocic_notify(NULL);
-}
-
 static int ohci_da8xx_reset(struct usb_hcd *hcd)
 {
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	struct ohci_hcd	*ohci		= hcd_to_ohci(hcd);
 	int result;
 	u32 rh_a;
@@ -291,20 +224,14 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
 	 * register's default value, so that ohci_hub_control() could return
 	 * the correct hub descriptor...
 	 */
-	rh_a = ohci_readl(ohci, &ohci->regs->roothub.a);
-	if (ohci_da8xx_has_set_power(hcd)) {
+	if (ohci_da8xx_has_regulator(hcd)) {
+		rh_a = ohci_readl(ohci, &ohci->regs->roothub.a);
 		rh_a &= ~RH_A_NPS;
 		rh_a |=  RH_A_PSM;
-	}
-	if (ohci_da8xx_has_oci(hcd)) {
 		rh_a &= ~RH_A_NOCP;
 		rh_a |=  RH_A_OCPM;
+		ohci_writel(ohci, rh_a, &ohci->regs->roothub.a);
 	}
-	if (ohci_da8xx_has_potpgt(hcd)) {
-		rh_a &= ~RH_A_POTPGT;
-		rh_a |= hub->potpgt << 24;
-	}
-	ohci_writel(ohci, rh_a, &ohci->regs->roothub.a);
 
 	return result;
 }
@@ -479,7 +406,6 @@ static int ohci_da8xx_remove(struct platform_device *pdev)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 
-	ohci_da8xx_unregister_notify(hcd);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index 0926e99..58f4be0 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -11,26 +11,6 @@
 #ifndef __ASM_ARCH_USB_H
 #define __ASM_ARCH_USB_H
 
-struct	da8xx_ohci_root_hub;
-
-typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
-				     unsigned port);
-
-/* Passed as the platform data to the OHCI driver */
-struct	da8xx_ohci_root_hub {
-	/* Switch the port power on/off */
-	int	(*set_power)(unsigned port, int on);
-	/* Read the port power status */
-	int	(*get_power)(unsigned port);
-	/* Read the port over-current indicator */
-	int	(*get_oci)(unsigned port);
-	/* Over-current indicator change notification (pass NULL to disable) */
-	int	(*ocic_notify)(da8xx_ocic_handler_t handler);
-
-	/* Time from power on to power good (in 2 ms units) */
-	u8	potpgt;
-};
-
 void davinci_setup_usb(unsigned mA, unsigned potpgt_ms);
 
 #endif	/* ifndef __ASM_ARCH_USB_H */
-- 
2.10.1
