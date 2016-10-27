From: david@lechnology.com (David Lechner)
Date: Wed, 26 Oct 2016 19:18:15 -0500
Subject: [PATCH v7 1/4] ARM: davinci: da8xx: Add USB PHY platform declaration
In-Reply-To: <1477527498-21930-1-git-send-email-david@lechnology.com>
References: <1477527498-21930-1-git-send-email-david@lechnology.com>
Message-ID: <1477527498-21930-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is now a proper phy driver for the DA8xx SoC USB PHY. This adds the
platform device declarations needed to use it.

Signed-off-by: David Lechner <david@lechnology.com>
---

Updated this patch so that it applies/builds cleanly before "ARM: davinci:
da8xx: add usb phy clocks" since that patch now uses da8xx_usb_phy from this
patch.


 arch/arm/mach-davinci/board-da830-evm.c     | 22 +++++++---------------
 arch/arm/mach-davinci/board-omapl138-hawk.c |  5 +++++
 arch/arm/mach-davinci/include/mach/da8xx.h  |  1 +
 arch/arm/mach-davinci/usb-da8xx.c           | 11 +++++++++++
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 2a96b40..829f68d 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -26,7 +26,6 @@
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
-#include <linux/platform_data/usb-davinci.h>
 #include <linux/mfd/da8xx-cfgchip.h>
 
 #include <asm/mach-types.h>
@@ -111,7 +110,7 @@ static __init void da830_evm_usb_init(void)
 	int ret;
 
 	/*
-	 * Set up USB clock/mode in the CFGCHIP2 register.
+	 * Set up USB clock in the CFGCHIP2 register.
 	 * FYI:  CFGCHIP2 is 0x0000ef00 initially.
 	 */
 	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
@@ -128,22 +127,15 @@ static __init void da830_evm_usb_init(void)
 	cfgchip2 &= ~CFGCHIP2_USB1PHYCLKMUX;
 	cfgchip2 |=  CFGCHIP2_USB2PHYCLKMUX;
 
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
 	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
 	/* USB_REFCLKIN is not used. */
+
+	ret = da8xx_register_usb_phy();
+	if (ret)
+		pr_warn("%s: USB PHY registration failed: %d\n",
+			__func__, ret);
+
 	ret = davinci_cfg_reg(DA830_USB0_DRVVBUS);
 	if (ret)
 		pr_warn("%s: USB 2.0 PinMux setup failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 70ebbba..0fd2ef1 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -259,6 +259,11 @@ static __init void omapl138_hawk_usb_init(void)
 	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
 	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
+	ret = da8xx_register_usb_phy();
+	if (ret)
+		pr_warn("%s: USB PHY registration failed: %d\n",
+			__func__, ret);
+
 	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
 			GPIOF_DIR_OUT, "USB1 VBUS");
 	if (ret < 0) {
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 2f6fe2f0..5e07d06 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -89,6 +89,7 @@ int da850_register_edma(struct edma_rsv_info *rsv[2]);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
 int da8xx_register_spi_bus(int instance, unsigned num_chipselect);
 int da8xx_register_watchdog(void);
+int da8xx_register_usb_phy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_emac(void);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index f141f51..4bb1903 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -3,6 +3,7 @@
  */
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_device.h>
 #include <linux/usb/musb.h>
@@ -15,6 +16,16 @@
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
+static struct platform_device da8xx_usb_phy = {
+	.name		= "da8xx-usb-phy",
+	.id		= -1,
+};
+
+int __init da8xx_register_usb_phy(void)
+{
+	return platform_device_register(&da8xx_usb_phy);
+}
+
 #if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
 
 static struct musb_hdrc_config musb_config = {
-- 
2.7.4
