From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Mon, 24 Oct 2016 18:46:29 +0200
Subject: [PATCH/RFT v2 12/17] USB: ochi-da8xx: Use a regulator for
 vbus/overcurrent
In-Reply-To: <20161024164634.4330-1-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
Message-ID: <20161024164634.4330-13-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

Currently, the da8xx ohci driver uses a set of gpios and callbacks in
board files to handle vbus and overcurrent irqs form the power supply.
However, this does not play nice when moving to a DT based boot were
we wont have board files.

Instead of requesting and handling the gpio, use the regulator framework
to take care of enabling and disabling vbus power. This has the benefit
that we dont need to pass any more platform data to the driver:

These will be handled by the regulator framework:
set_power   ->  regulator_enable/regulator_disable
get_power   ->  regulator_is_enabled
get_oci     ->  regulator_get_mode
ocic_notify ->  regulator notification

We can keep the default potpgt and use the regulator start delay instead:
potpgt      -> regulator startup delay time

The hawk board does not have a GPIO/OVERCURRENT gpio to control vbus,
(they should not have been decleared/reserved) so, just remove those
definitions from the hwk board file.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  97 ++++++++----------------
 arch/arm/mach-davinci/board-omapl138-hawk.c |  96 +-----------------------
 arch/arm/mach-davinci/include/mach/da8xx.h  |   2 +-
 arch/arm/mach-davinci/usb-da8xx.c           |   3 +-
 drivers/usb/host/ohci-da8xx.c               | 111 ++++++++++++++++++----------
 include/linux/platform_data/usb-davinci.h   |  19 -----
 6 files changed, 105 insertions(+), 223 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index d12fcf5..d6f9f8a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -27,6 +27,7 @@
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -48,61 +49,35 @@
 	-1
 };
 
-static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
+static struct regulator_consumer_supply usb_ohci_consumer_supply =
+	REGULATOR_SUPPLY("vbus", "ohci");
 
-static int da830_evm_usb_set_power(int on)
-{
-	gpio_set_value(ON_BD_USB_DRV, on);
-	return 0;
-}
-
-static int da830_evm_usb_get_power(void)
-{
-	return gpio_get_value(ON_BD_USB_DRV);
-}
-
-static int da830_evm_usb_get_oci(void)
-{
-	return !gpio_get_value(ON_BD_USB_OVC);
-}
-
-static irqreturn_t da830_evm_usb_ocic_irq(int, void *);
-
-static int da830_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
-{
-	int irq 	= gpio_to_irq(ON_BD_USB_OVC);
-	int error	= 0;
-
-	if (handler != NULL) {
-		da830_evm_usb_ocic_handler = handler;
-
-		error = request_irq(irq, da830_evm_usb_ocic_irq,
-				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				    "OHCI over-current indicator", NULL);
-		if (error)
-			pr_err("%s: could not request IRQ to watch over-current indicator changes\n",
-			       __func__);
-	} else
-		free_irq(irq, NULL);
-
-	return error;
-}
-
-static struct da8xx_ohci_root_hub da830_evm_usb11_pdata = {
-	.set_power	= da830_evm_usb_set_power,
-	.get_power	= da830_evm_usb_get_power,
-	.get_oci	= da830_evm_usb_get_oci,
-	.ocic_notify	= da830_evm_usb_ocic_notify,
+static struct regulator_init_data usb_ohci_initdata = {
+	.consumer_supplies = &usb_ohci_consumer_supply,
+	.num_consumer_supplies = 1,
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
 
-	/* TPS2065 switch @ 5V */
-	.potpgt		= (3 + 1) / 2,	/* 3 ms max */
+static struct fixed_voltage_config usb_ohci_config = {
+	.supply_name		= "vbus",
+	.microvolts		= 5000000,
+	.gpio			= ON_BD_USB_DRV,
+	.oc_gpio		= ON_BD_USB_OVC,
+	.has_oc_gpio		= 1,
+	.enable_high		= 1,
+	.enabled_at_boot	= 0,
+	.init_data		= &usb_ohci_initdata,
 };
 
-static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
-{
-	da830_evm_usb_ocic_handler(&da830_evm_usb11_pdata);
-	return IRQ_HANDLED;
-}
+static struct platform_device da8xx_usb11_regulator = {
+	.name	= "reg-fixed-voltage",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &usb_ohci_config,
+	},
+};
 
 static __init void da830_evm_usb_init(void)
 {
@@ -144,23 +119,11 @@ static __init void da830_evm_usb_init(void)
 		return;
 	}
 
-	ret = gpio_request(ON_BD_USB_DRV, "ON_BD_USB_DRV");
-	if (ret) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port power control: %d\n",
-		       __func__, ret);
-		return;
-	}
-	gpio_direction_output(ON_BD_USB_DRV, 0);
-
-	ret = gpio_request(ON_BD_USB_OVC, "ON_BD_USB_OVC");
-	if (ret) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port over-current indicator: %d\n",
-		       __func__, ret);
-		return;
-	}
-	gpio_direction_input(ON_BD_USB_OVC);
+	ret = platform_device_register(&da8xx_usb11_regulator);
+	if (ret)
+		pr_warn("fail to add ohci regulator\n");
 
-	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
+	ret = da8xx_register_usb11();
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
 }
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 1d31f45..2df34cb 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -28,9 +28,6 @@
 #define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
 #define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
 
-#define DA850_USB1_VBUS_PIN		GPIO_TO_PIN(2, 4)
-#define DA850_USB1_OC_PIN		GPIO_TO_PIN(6, 13)
-
 static short omapl138_hawk_mii_pins[] __initdata = {
 	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
 	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
@@ -181,76 +178,10 @@ static __init void omapl138_hawk_mmc_init(void)
 	gpio_free(DA850_HAWK_MMCSD_CD_PIN);
 }
 
-static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
-static da8xx_ocic_handler_t hawk_usb_ocic_handler;
-
-static const short da850_hawk_usb11_pins[] = {
-	DA850_GPIO2_4, DA850_GPIO6_13,
-	-1
-};
-
-static int hawk_usb_set_power(int on)
-{
-	gpio_set_value(DA850_USB1_VBUS_PIN, on);
-	return 0;
-}
-
-static int hawk_usb_get_power(void)
-{
-	return gpio_get_value(DA850_USB1_VBUS_PIN);
-}
-
-static int hawk_usb_get_oci(void)
-{
-	return !gpio_get_value(DA850_USB1_OC_PIN);
-}
-
-static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
-{
-	int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
-	int error       = 0;
-
-	if (handler != NULL) {
-		hawk_usb_ocic_handler = handler;
-
-		error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
-					"OHCI over-current indicator", NULL);
-		if (error)
-			pr_err("%s: could not request IRQ to watch "
-				"over-current indicator changes\n", __func__);
-	} else {
-		free_irq(irq, NULL);
-	}
-	return error;
-}
-
-static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
-	.set_power      = hawk_usb_set_power,
-	.get_power      = hawk_usb_get_power,
-	.get_oci        = hawk_usb_get_oci,
-	.ocic_notify    = hawk_usb_ocic_notify,
-	/* TPS2087 switch @ 5V */
-	.potpgt         = (3 + 1) / 2,  /* 3 ms max */
-};
-
-static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
-{
-	hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata);
-	return IRQ_HANDLED;
-}
-
 static __init void omapl138_hawk_usb_init(void)
 {
 	int ret;
 
-	ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
-	if (ret) {
-		pr_warn("%s: USB 1.1 PinMux setup failed: %d\n", __func__, ret);
-		return;
-	}
-
 	/* USB_REFCLKIN is not used. */
 	ret = da8xx_register_usb20_phy_clk(false);
 	if (ret)
@@ -266,34 +197,11 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB PHY registration failed: %d\n",
 			__func__, ret);
 
-	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
-			GPIOF_DIR_OUT, "USB1 VBUS");
-	if (ret < 0) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port "
-			"power control: %d\n", __func__, ret);
-		return;
-	}
-
-	ret = gpio_request_one(DA850_USB1_OC_PIN,
-			GPIOF_DIR_IN, "USB1 OC");
-	if (ret < 0) {
-		pr_err("%s: failed to request GPIO for USB 1.1 port "
-			"over-current indicator: %d\n", __func__, ret);
-		goto usb11_setup_oc_fail;
-	}
-
-	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
-	if (ret) {
+	ret = da8xx_register_usb11();
+	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
-		goto usb11_setup_fail;
-	}
 
 	return;
-
-usb11_setup_fail:
-	gpio_free(DA850_USB1_OC_PIN);
-usb11_setup_oc_fail:
-	gpio_free(DA850_USB1_VBUS_PIN);
 }
 
 static __init void omapl138_hawk_init(void)
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 38d932e..93d2db3 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -94,7 +94,7 @@
 int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb_phy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
-int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
+int da8xx_register_usb11(void);
 int da8xx_register_emac(void);
 int da8xx_register_uio_pruss(void);
 int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 982e105..7a9af216 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -337,8 +337,7 @@ int __init da8xx_register_usb20(unsigned int mA, unsigned int potpgt)
 	.resource	= da8xx_usb11_resources,
 };
 
-int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
+int __init da8xx_register_usb11(void)
 {
-	da8xx_usb11_device.dev.platform_data = pdata;
 	return platform_device_register(&da8xx_usb11_device);
 }
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 5585d9e..f4bda4d 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -39,6 +39,8 @@ static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
 
 static struct clk *usb11_clk;
 static struct phy *usb11_phy;
+static struct regulator *vbus_reg;
+struct notifier_block nb;
 
 /* Over-current indicator change flag */
 static int ocic_flag;
@@ -76,22 +78,57 @@ static void ohci_da8xx_disable(void)
 	clk_disable_unprepare(usb11_clk);
 }
 
-/*
- * Handle the port over-current indicator change.
- */
-static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub)
+static int ohci_da8xx_set_power(int on)
+{
+	int ret = 0;
+
+	if (!vbus_reg)
+		return 0;
+
+	if (on) {
+		ret = regulator_enable(vbus_reg);
+		if (ret)
+			pr_err("fail to enable regulator: %d\n", ret);
+	} else {
+		ret = regulator_disable(vbus_reg);
+		if (ret)
+			pr_err("fail to disable regulator: %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int ohci_da8xx_get_power(void)
+{
+	if (!vbus_reg)
+		return 1;
+
+	return regulator_is_enabled(vbus_reg);
+}
+
+static int ohci_da8xx_get_oci(void)
+{
+	if (regulator_get_mode(vbus_reg) == REGULATOR_MODE_OVERCURRENT)
+		return 1;
+
+	return 0;
+}
+
+static int ohci_da8xx_regulator_event(struct notifier_block *nb,
+				unsigned long event, void *data)
 {
-	ocic_flag = 1;
+	if (event & REGULATOR_EVENT_OVER_CURRENT) {
+		ocic_flag = 1;
+		if (ohci_da8xx_get_oci())
+			ohci_da8xx_set_power(0);
+	}
 
-	/* Once over-current is detected, the port needs to be powered down */
-	if (hub->get_oci() > 0)
-		hub->set_power(0);
+	return 0;
 }
 
 static int ohci_da8xx_reset(struct usb_hcd *hcd)
 {
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	struct ohci_hcd	*ohci		= hcd_to_ohci(hcd);
 	int result;
 	u32 rh_a;
@@ -121,16 +158,14 @@ static int ohci_da8xx_reset(struct usb_hcd *hcd)
 	 * the correct hub descriptor...
 	 */
 	rh_a = ohci_readl(ohci, &ohci->regs->roothub.a);
-	if (hub->set_power) {
+
+	if (vbus_reg) {
 		rh_a &= ~RH_A_NPS;
 		rh_a |=  RH_A_PSM;
-	}
-	if (hub->get_oci) {
 		rh_a &= ~RH_A_NOCP;
 		rh_a |=  RH_A_OCPM;
 	}
-	rh_a &= ~RH_A_POTPGT;
-	rh_a |= hub->potpgt << 24;
+
 	ohci_writel(ohci, rh_a, &ohci->regs->roothub.a);
 
 	return result;
@@ -163,7 +198,6 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				  u16 wIndex, char *buf, u16 wLength)
 {
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	int temp;
 
 	switch (typeReq) {
@@ -177,11 +211,11 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = roothub_portstatus(hcd_to_ohci(hcd), wIndex - 1);
 
 		/* The port power status (PPS) bit defaults to 1 */
-		if (hub->get_power && hub->get_power() == 0)
+		if (ohci_da8xx_get_power() == 0)
 			temp &= ~RH_PS_PPS;
 
 		/* The port over-current indicator (POCI) bit is always 0 */
-		if (hub->get_oci && hub->get_oci() > 0)
+		if (ohci_da8xx_get_oci() > 0)
 			temp |=  RH_PS_POCI;
 
 		/* The over-current indicator change (OCIC) bit is 0 too */
@@ -206,19 +240,13 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex, "POWER");
 
-			if (!hub->set_power)
-				return -EPIPE;
-
-			return hub->set_power(temp) ? -EPIPE : 0;
+			return ohci_da8xx_set_power(temp) ? -EPIPE : 0;
 		case USB_PORT_FEAT_C_OVER_CURRENT:
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex,
 				"C_OVER_CURRENT");
 
-			if (temp)
-				ocic_flag = 1;
-			else
-				ocic_flag = 0;
+			ocic_flag = temp;
 			return 0;
 		}
 	}
@@ -231,14 +259,10 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 
 static int ohci_da8xx_probe(struct platform_device *pdev)
 {
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
 	struct usb_hcd	*hcd;
 	struct resource *mem;
 	int error, irq;
 
-	if (hub == NULL)
-		return -ENODEV;
-
 	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
 				dev_name(&pdev->dev));
 	if (!hcd)
@@ -258,6 +282,22 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		return PTR_ERR(usb11_phy);
 	}
 
+	vbus_reg = devm_regulator_get(&pdev->dev, "vbus");
+	if (IS_ERR(vbus_reg)) {
+		if (PTR_ERR(vbus_reg) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get regulator.\n");
+		return PTR_ERR(vbus_reg);
+	}
+
+	if (vbus_reg) {
+		nb.notifier_call = ohci_da8xx_regulator_event;
+		error = devm_regulator_register_notifier(vbus_reg, &nb);
+		if (error) {
+			dev_err(&pdev->dev,
+				"Could not register regulator notifier\n");
+			return error;
+		}
+	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hcd->regs = devm_ioremap_resource(&pdev->dev, mem);
@@ -281,13 +321,7 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 
 	device_wakeup_enable(hcd->self.controller);
 
-	if (hub->ocic_notify) {
-		error = hub->ocic_notify(ohci_da8xx_ocic_handler);
-		if (!error)
-			return 0;
-	}
-
-	usb_remove_hcd(hcd);
+	return 0;
 err:
 	usb_put_hcd(hcd);
 	return error;
@@ -295,10 +329,8 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 
 static int ohci_da8xx_remove(struct platform_device *pdev)
 {
-	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
+	struct usb_hcd  *hcd = platform_get_drvdata(pdev);
 
-	hub->ocic_notify(NULL);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
@@ -314,7 +346,6 @@ static int ohci_da8xx_suspend(struct platform_device *pdev,
 	bool		do_wakeup	= device_may_wakeup(&pdev->dev);
 	int		ret;
 
-
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index 3217fbe..58f4be0 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -11,25 +11,6 @@
 #ifndef __ASM_ARCH_USB_H
 #define __ASM_ARCH_USB_H
 
-struct	da8xx_ohci_root_hub;
-
-typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub);
-
-/* Passed as the platform data to the OHCI driver */
-struct	da8xx_ohci_root_hub {
-	/* Switch the port power on/off */
-	int	(*set_power)(int on);
-	/* Read the port power status */
-	int	(*get_power)(void);
-	/* Read the port over-current indicator */
-	int	(*get_oci)(void);
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
1.9.1
