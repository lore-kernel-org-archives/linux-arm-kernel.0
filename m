From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:52 +0200
Subject: [PATCH/RFT 07/12] USB: ohci-da8xx: Request gpios and handle interrupt
 in the driver
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-8-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

Currently requesting the vbus and overcurrent gpio is handled on
the board specific file. But this does not play well moving to
device tree.

In preparation to migrate to a device tree boot, handle requesting
gpios and overcurrent interrupt on the usb driver itself, thus avoiding
callbacks to arch/mach*

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     | 71 ++---------------------
 arch/arm/mach-davinci/board-omapl138-hawk.c | 11 ----
 drivers/usb/host/ohci-da8xx.c               | 90 +++++++++++++++++++++++------
 include/linux/platform_data/usb-davinci.h   | 16 +++--
 4 files changed, 82 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 8d126e4..cfba9fa 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -47,62 +47,15 @@ static const short da830_evm_usb11_pins[] = {
 	-1
 };
 
-static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
-
-static int da830_evm_usb_set_power(unsigned port, int on)
-{
-	gpio_set_value(ON_BD_USB_DRV, on);
-	return 0;
-}
-
-static int da830_evm_usb_get_power(unsigned port)
-{
-	return gpio_get_value(ON_BD_USB_DRV);
-}
-
-static int da830_evm_usb_get_oci(unsigned port)
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
 static struct da8xx_ohci_platform_data da830_evm_usb11_pdata = {
-	.set_power	= da830_evm_usb_set_power,
-	.get_power	= da830_evm_usb_get_power,
-	.get_oci	= da830_evm_usb_get_oci,
-	.ocic_notify	= da830_evm_usb_ocic_notify,
-
+	.gpio_vbus		= ON_BD_USB_DRV,
+	.gpio_overcurrent	= ON_BD_USB_OVC,
+	.flags			= (DA8XX_OHCI_FLAG_GPIO_VBUS
+					| DA8XX_OHCI_FLAG_GPIO_OCI),
 	/* TPS2065 switch @ 5V */
 	.potpgt		= 3,	/* 3 ms max */
 };
 
-static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
-{
-	da830_evm_usb_ocic_handler(&da830_evm_usb11_pdata, 1);
-	return IRQ_HANDLED;
-}
-
 static __init void da830_evm_usb_init(void)
 {
 	int ret;
@@ -143,22 +96,6 @@ static __init void da830_evm_usb_init(void)
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
-
 	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
 	if (ret)
 		pr_warn("%s: USB 1.1 registration failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 075be1b..8d72bc1 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -178,11 +178,6 @@ static __init void omapl138_hawk_mmc_init(void)
 	gpio_free(DA850_HAWK_MMCSD_CD_PIN);
 }
 
-static const short da850_hawk_usb11_pins[] = {
-	DA850_GPIO2_4, DA850_GPIO6_13,
-	-1
-};
-
 static struct da8xx_ohci_platform_data omapl138_hawk_usb11_pdata = {
 	/* TPS2087 switch @ 5V */
 	.potpgt         = 3  /* 3 ms max */
@@ -192,12 +187,6 @@ static __init void omapl138_hawk_usb_init(void)
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
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 9d9f8e3..d7a0f11 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_data/usb-davinci.h>
+#include <linux/gpio.h>
 
 #ifndef CONFIG_ARCH_DAVINCI_DA8XX
 #error "This file is DA8xx bus glue.  Define CONFIG_ARCH_DAVINCI_DA8XX."
@@ -61,6 +62,24 @@ static void ohci_da8xx_disable(void)
 	clk_disable_unprepare(usb11_clk);
 }
 
+
+static int ohci_da8xx_set_power(struct da8xx_ohci_platform_data *pdata,
+				int on)
+{
+	gpio_set_value(pdata->gpio_vbus, on);
+	return 0;
+}
+
+static int ohci_da8xx_get_power(struct da8xx_ohci_platform_data *pdata)
+{
+	return gpio_get_value(pdata->gpio_vbus);
+}
+
+static int ohci_da8xx_get_oci(struct da8xx_ohci_platform_data *pdata)
+{
+	return !gpio_get_value(pdata->gpio_overcurrent);
+}
+
 /*
  * Handle the port over-current indicator change.
  */
@@ -70,8 +89,18 @@ static void ohci_da8xx_ocic_handler(struct da8xx_ohci_platform_data *pdata,
 	ocic_mask |= 1 << port;
 
 	/* Once over-current is detected, the port needs to be powered down */
-	if (pdata->get_oci(port) > 0)
-		pdata->set_power(port, 0);
+	if (ohci_da8xx_get_oci(pdata) > 0)
+		ohci_da8xx_set_power(pdata, 0);
+}
+
+static irqreturn_t ohci_da8xx_ocic_irq(int irq, void *data)
+{
+	struct platform_device *pdev = (struct platform_device *) data;
+	struct da8xx_ohci_platform_data *pdata	= dev_get_platdata(&pdev->dev);
+
+	ohci_da8xx_ocic_handler(pdata, 1);
+
+	return IRQ_HANDLED;
 }
 
 static int ohci_da8xx_init(struct usb_hcd *hcd)
@@ -107,11 +136,11 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
 	 * the correct hub descriptor...
 	 */
 	rh_a = ohci_readl(ohci, &ohci->regs->roothub.a);
-	if (pdata->set_power) {
+	if (pdata->flags & DA8XX_OHCI_FLAG_GPIO_VBUS) {
 		rh_a &= ~RH_A_NPS;
 		rh_a |=  RH_A_PSM;
 	}
-	if (pdata->get_oci) {
+	if (pdata->flags & DA8XX_OHCI_FLAG_GPIO_OCI) {
 		rh_a &= ~RH_A_NOCP;
 		rh_a |=  RH_A_OCPM;
 	}
@@ -185,11 +214,13 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		temp = roothub_portstatus(hcd_to_ohci(hcd), wIndex - 1);
 
 		/* The port power status (PPS) bit defaults to 1 */
-		if (pdata->get_power && pdata->get_power(wIndex) == 0)
+		if ((pdata->flags & DA8XX_OHCI_FLAG_GPIO_VBUS)
+			&& ohci_da8xx_get_power(pdata) == 0)
 			temp &= ~RH_PS_PPS;
 
 		/* The port over-current indicator (POCI) bit is always 0 */
-		if (pdata->get_oci && pdata->get_oci(wIndex) > 0)
+		if ((pdata->flags & DA8XX_OHCI_FLAG_GPIO_OCI)
+			&& ohci_da8xx_get_oci(pdata) > 0)
 			temp |=  RH_PS_POCI;
 
 		/* The over-current indicator change (OCIC) bit is 0 too */
@@ -214,10 +245,10 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex, "POWER");
 
-			if (!pdata->set_power)
+			if (!(pdata->flags & DA8XX_OHCI_FLAG_GPIO_VBUS))
 				return 0;
 
-			return pdata->set_power(wIndex, temp) ? -EPIPE : 0;
+			return ohci_da8xx_set_power(pdata, temp) ? -EPIPE : 0;
 		case USB_PORT_FEAT_C_OVER_CURRENT:
 			dev_dbg(dev, "%sPortFeature(%u): %s\n",
 				temp ? "Set" : "Clear", wIndex,
@@ -314,6 +345,38 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 		return PTR_ERR(usb11_phy);
 	}
 
+
+	if (pdata->flags & DA8XX_OHCI_FLAG_GPIO_VBUS) {
+		error = devm_gpio_request_one(&pdev->dev,
+					pdata->gpio_vbus,
+					GPIOF_DIR_OUT, "usb11 vbus");
+		if (error) {
+			pr_err("could not request vbus gpio: %d\n", error);
+			return error;
+		}
+	}
+
+	if (pdata->flags & DA8XX_OHCI_FLAG_GPIO_OCI) {
+		error = devm_gpio_request_one(&pdev->dev,
+					pdata->gpio_overcurrent,
+					GPIOF_DIR_IN, "usb11 oci");
+		if (error) {
+			pr_err("could not request oci gpio: %d\n", error);
+			return error;
+		}
+
+		error = devm_request_irq(&pdev->dev,
+				gpio_to_irq(pdata->gpio_overcurrent),
+				ohci_da8xx_ocic_irq,
+				IRQF_TRIGGER_RISING |
+				IRQF_TRIGGER_FALLING,
+				"ohci overcurrent indicator", pdev);
+		if (error) {
+			pr_err("could not request oci irq: %d\n", error);
+			return error;
+		}
+	}
+
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd)
 		return -ENOMEM;
@@ -341,15 +404,7 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 
 	device_wakeup_enable(hcd->self.controller);
 
-	if (pdata->ocic_notify) {
-		error = pdata->ocic_notify(ohci_da8xx_ocic_handler);
-		if (error)
-			goto err_notify;
-	}
-
 	return 0;
-err_notify:
-	usb_remove_hcd(hcd);
 err:
 	usb_put_hcd(hcd);
 	return error;
@@ -367,9 +422,6 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
 static inline void
 usb_hcd_da8xx_remove(struct usb_hcd *hcd, struct platform_device *pdev)
 {
-	struct da8xx_ohci_platform_data *pdata	= dev_get_platdata(&pdev->dev);
-
-	pdata->ocic_notify(NULL);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 }
diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index dffe3bf..b72f703 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -41,17 +41,15 @@ typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_platform_data *pdata,
 
 /* Passed as the platform data to the OHCI driver */
 struct	da8xx_ohci_platform_data {
-	/* Switch the port power on/off */
-	int	(*set_power)(unsigned port, int on);
-	/* Read the port power status */
-	int	(*get_power)(unsigned port);
-	/* Read the port over-current indicator */
-	int	(*get_oci)(unsigned port);
-	/* Over-current indicator change notification (pass NULL to disable) */
-	int	(*ocic_notify)(da8xx_ocic_handler_t handler);
-
 	/* Time from power on to power good (in 2 ms units) */
 	u8	potpgt;
+
+	u32	flags;
+#define DA8XX_OHCI_FLAG_GPIO_VBUS	(1 << 0)
+#define DA8XX_OHCI_FLAG_GPIO_OCI	(1 << 1)
+
+	int	gpio_vbus;
+	int	gpio_overcurrent;
 };
 
 void davinci_setup_usb(unsigned mA, unsigned potpgt_ms);
-- 
2.7.1
