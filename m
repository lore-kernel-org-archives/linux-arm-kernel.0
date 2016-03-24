From: david@lechnology.com (David Lechner)
Date: Thu, 24 Mar 2016 18:51:36 -0500
Subject: [PATCH v3 11/16] ARM: davinci: da8xx: Add USB PHY platform declaration
In-Reply-To: <1458863503-31121-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
Message-ID: <1458863503-31121-12-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is now a proper phy driver for the DA8xx SoC USB PHY. This adds the
platform device declarations needed to use it.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes:

* The declaration is now in the new usb-da8xx.c file.

 arch/arm/mach-davinci/board-da830-evm.c     | 28 +++++-----------------------
 arch/arm/mach-davinci/board-omapl138-hawk.c |  5 +++++
 arch/arm/mach-davinci/include/mach/da8xx.h  |  1 +
 arch/arm/mach-davinci/usb-da8xx.c           | 11 +++++++++++
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 3051cb6..6421cfe 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -26,7 +26,6 @@
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
-#include <linux/platform_data/usb-davinci.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -106,30 +105,8 @@ static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
 
 static __init void da830_evm_usb_init(void)
 {
-	u32 cfgchip2;
 	int ret;
 
-	/*
-	 * Set up USB clock/mode in the CFGCHIP2 register.
-	 * FYI:  CFGCHIP2 is 0x0000ef00 initially.
-	 */
-	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	/*
-	 * We have to override VBUS/ID signals when MUSB is configured into the
-	 * host-only mode -- ID pin will float if no cable is connected, so the
-	 * controller won't be able to drive VBUS thinking that it's a B-device.
-	 * Otherwise, we want to use the OTG mode and enable VBUS comparators.
-	 */
-	cfgchip2 &= ~CFGCHIP2_OTGMODE;
-#ifdef	CONFIG_USB_MUSB_HOST
-	cfgchip2 |=  CFGCHIP2_FORCE_HOST;
-#else
-	cfgchip2 |=  CFGCHIP2_SESENDEN | CFGCHIP2_VBDTCTEN;
-#endif
-
-	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
 	/* USB_REFCLKIN is not used. */
 	ret = da8xx_register_usb20_phy_clk(false);
 	if (ret)
@@ -141,6 +118,11 @@ static __init void da830_evm_usb_init(void)
 		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
 			__func__, ret);
 
+	ret = da8xx_register_usbphy();
+	if (ret)
+		pr_warn("%s: USB PHY registration failed: %d\n",
+			__func__, ret);
+
 	ret = davinci_cfg_reg(DA830_USB0_DRVVBUS);
 	if (ret)
 		pr_warn("%s: USB 2.0 PinMux setup failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 8691a25..79aaa84 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -260,6 +260,11 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
 			__func__, ret);
 
+	ret = da8xx_register_usbphy();
+	if (ret)
+		pr_warn("%s: USB PHY registration failed: %d\n",
+			__func__, ret);
+
 	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
 			GPIOF_DIR_OUT, "USB1 VBUS");
 	if (ret < 0) {
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index c32444b..44ab55e 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -92,6 +92,7 @@ int da8xx_register_watchdog(void);
 int da8xx_register_usb_refclkin(int rate);
 int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
+int da8xx_register_usbphy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_emac(void);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index aca5867..6bd0009 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -6,6 +6,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/phy/phy.h>
 #include <linux/usb/musb.h>
 
 #include <asm/delay.h>
@@ -231,6 +232,16 @@ int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 	return ret;
 }
 
+static struct platform_device da8xx_usbphy = {
+	.name		= "da8xx-usbphy",
+	.id		= 0,
+};
+
+int __init da8xx_register_usbphy(void)
+{
+	return platform_device_register(&da8xx_usbphy);
+}
+
 #if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
 
 static struct musb_hdrc_eps_bits musb_eps[] = {
-- 
1.9.1
