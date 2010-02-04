From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Feb 2010 16:03:42 +0100
Subject: [PATCH 5/8] i.MX27 pca100: Add USB support
In-Reply-To: <1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265295825-8705-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/Kconfig       |    1 +
 arch/arm/mach-mx2/mach-pca100.c |  103 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index 7bc797c..ca1278d 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -100,6 +100,7 @@ config MACH_IMX27LITE
 config MACH_PCA100
 	bool "Phytec phyCARD-s (pca100)"
 	depends on MACH_MX27
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for phyCARD-s (aka pca100) platform. This
 	  includes specific configurations for the module and its peripherals.
diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index 9279b42..cda52a6 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -26,6 +26,9 @@
 #include <linux/spi/eeprom.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -41,9 +44,14 @@
 #include <mach/mxc_nand.h>
 #include <mach/irqs.h>
 #include <mach/mmc.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 
+#define OTG_PHY_CS_GPIO (GPIO_PORTB + 23)
+#define USBH2_PHY_CS_GPIO (GPIO_PORTB + 24)
+
 static int pca100_pins[] = {
 	/* UART1 */
 	PE12_PF_UART1_TXD,
@@ -92,6 +100,34 @@ static int pca100_pins[] = {
 	PD29_PF_CSPI1_SCLK,
 	PD30_PF_CSPI1_MISO,
 	PD31_PF_CSPI1_MOSI,
+	/* OTG */
+	OTG_PHY_CS_GPIO | GPIO_GPIO | GPIO_OUT,
+	PC7_PF_USBOTG_DATA5,
+	PC8_PF_USBOTG_DATA6,
+	PC9_PF_USBOTG_DATA0,
+	PC10_PF_USBOTG_DATA2,
+	PC11_PF_USBOTG_DATA1,
+	PC12_PF_USBOTG_DATA4,
+	PC13_PF_USBOTG_DATA3,
+	PE0_PF_USBOTG_NXT,
+	PE1_PF_USBOTG_STP,
+	PE2_PF_USBOTG_DIR,
+	PE24_PF_USBOTG_CLK,
+	PE25_PF_USBOTG_DATA7,
+	/* USBH2 */
+	USBH2_PHY_CS_GPIO | GPIO_GPIO | GPIO_OUT,
+	PA0_PF_USBH2_CLK,
+	PA1_PF_USBH2_DIR,
+	PA2_PF_USBH2_DATA7,
+	PA3_PF_USBH2_NXT,
+	PA4_PF_USBH2_STP,
+	PD19_AF_USBH2_DATA4,
+	PD20_AF_USBH2_DATA3,
+	PD21_AF_USBH2_DATA6,
+	PD22_AF_USBH2_DATA0,
+	PD23_AF_USBH2_DATA2,
+	PD24_AF_USBH2_DATA1,
+	PD26_AF_USBH2_DATA5,
 };
 
 static struct imxuart_platform_data uart_pdata = {
@@ -182,6 +218,50 @@ static struct imxmmc_platform_data sdhc_pdata = {
 	.exit = pca100_sdhc2_exit,
 };
 
+static int otg_phy_init(struct platform_device *pdev)
+{
+	gpio_set_value(OTG_PHY_CS_GPIO, 0);
+	return 0;
+}
+
+static struct mxc_usbh_platform_data otg_pdata = {
+	.init	= otg_phy_init,
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static int usbh2_phy_init(struct platform_device *pdev)
+{
+	gpio_set_value(USBH2_PHY_CS_GPIO, 0);
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.init	= usbh2_phy_init,
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static struct fsl_usb2_platform_data otg_device_pdata = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode       = FSL_USB2_PHY_ULPI,
+};
+
+static int otg_mode_host;
+
+static int __init pca100_otg_mode(char *options)
+{
+	if (!strcmp(options, "host"))
+		otg_mode_host = 1;
+	else if (!strcmp(options, "device"))
+		otg_mode_host = 0;
+	else
+		pr_info("otg_mode neither \"host\" nor \"device\". "
+			"Defaulting to device\n");
+	return 0;
+}
+__setup("otg_mode=", pca100_otg_mode);
+
 static void __init pca100_init(void)
 {
 	int ret;
@@ -220,6 +300,29 @@ static void __init pca100_init(void)
 	mxc_register_device(&mxc_spi_device0, &pca100_spi_0_data);
 #endif
 
+	gpio_request(OTG_PHY_CS_GPIO, "usb-otg-cs");
+	gpio_direction_output(OTG_PHY_CS_GPIO, 1);
+	gpio_request(USBH2_PHY_CS_GPIO, "usb-host2-cs");
+	gpio_direction_output(USBH2_PHY_CS_GPIO, 1);
+
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host) {
+		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+		mxc_register_device(&mxc_otg_host, &otg_pdata);
+	}
+
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+#endif
+	if (!otg_mode_host) {
+		gpio_set_value(OTG_PHY_CS_GPIO, 0);
+		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+	}
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
-- 
1.6.6
