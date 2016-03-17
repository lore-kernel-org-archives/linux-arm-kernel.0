From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:40 -0500
Subject: [PATCH v2 07/11] ARM: davinci: da8xx: Add USB PHY platform declaration
In-Reply-To: <1458181615-27782-1-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
Message-ID: <1458181615-27782-8-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is now a proper phy driver for the DA8XX SoC USB PHY. This adds the
platform device declarations needed to use it.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: This is new patch in v2.


 arch/arm/mach-davinci/include/mach/da8xx.h |  1 +
 arch/arm/mach-davinci/usb.c                | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index f9f9713..049d26f 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -88,6 +88,7 @@ int da850_register_edma(struct edma_rsv_info *rsv[2]);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
 int da8xx_register_spi_bus(int instance, unsigned num_chipselect);
 int da8xx_register_watchdog(void);
+int da8xx_register_usbphy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_emac(void);
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index b0a6b52..6a0802e 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -4,7 +4,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-
+#include <linux/phy/phy.h>
 #include <linux/usb/musb.h>
 
 #include <mach/common.h>
@@ -18,6 +18,28 @@
 #define DA8XX_USB0_BASE 	0x01e00000
 #define DA8XX_USB1_BASE 	0x01e25000
 
+#ifdef CONFIG_ARCH_DAVINCI_DA8XX
+static struct resource da8xx_usbphy_resources[] = {
+	[0] = {
+		.start	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG,
+		.end	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG + 4 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device da8xx_usbphy = {
+	.name		= "da8xx-usbphy",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(da8xx_usbphy_resources),
+	.resource	= da8xx_usbphy_resources,
+};
+
+int __init da8xx_register_usbphy(void)
+{
+	return platform_device_register(&da8xx_usbphy);
+}
+#endif /* CONFIG_ARCH_DAVINCI_DA8XX */
+
 #if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
 static struct musb_hdrc_eps_bits musb_eps[] = {
 	{ "ep1_tx", 8, },
-- 
1.9.1
