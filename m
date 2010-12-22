From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 22 Dec 2010 12:25:31 -0200
Subject: [PATCH v2 2/3] ARM: imx/mx27_3ds: Add USB OTG support
In-Reply-To: <1293027932-13201-1-git-send-email-fabio.estevam@freescale.com>
References: <1293027932-13201-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1293027932-13201-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    3 ++
 arch/arm/mach-imx/mach-mx27_3ds.c |   71 +++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index fed3ee5..9a715ce 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -235,10 +235,13 @@ endchoice
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
 	select SOC_IMX27
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for MX27PDK platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 1a7e879..0ed2fcc 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -23,16 +23,22 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/irq.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/delay.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx27.h>
+#include <mach/ulpi.h>
 
 #include "devices-imx27.h"
 
 #define SD1_EN_GPIO (GPIO_PORTB + 25)
+#define OTG_PHY_RESET_GPIO (GPIO_PORTB + 23)
 
 static const int mx27pdk_pins[] __initconst = {
 	/* UART1 */
@@ -67,6 +73,20 @@ static const int mx27pdk_pins[] __initconst = {
 	PE22_PF_SD1_CMD,
 	PE23_PF_SD1_CLK,
 	SD1_EN_GPIO | GPIO_GPIO | GPIO_OUT,
+	/* OTG */
+	OTG_PHY_RESET_GPIO | GPIO_GPIO | GPIO_OUT,
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
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -118,6 +138,45 @@ static void mx27_3ds_sdhc1_enable_level_translator(void)
 	gpio_direction_output(SD1_EN_GPIO, 1);
 }
 
+
+static int otg_phy_init(void)
+{
+	gpio_request(OTG_PHY_RESET_GPIO, "usb-otg-reset");
+	gpio_direction_output(OTG_PHY_RESET_GPIO, 0);
+	mdelay(1);
+	gpio_set_value(OTG_PHY_RESET_GPIO, 1);
+	return 0;
+}
+
+#if defined(CONFIG_USB_ULPI)
+
+static struct mxc_usbh_platform_data otg_pdata __initdata = {
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+#endif
+
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode       = FSL_USB2_PHY_ULPI,
+};
+
+static int otg_mode_host;
+
+static int __init mx27_3ds_otg_mode(char *options)
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
+__setup("otg_mode=", mx27_3ds_otg_mode);
+
+
 static void __init mx27pdk_init(void)
 {
 	mxc_gpio_setup_multiple_pins(mx27pdk_pins, ARRAY_SIZE(mx27pdk_pins),
@@ -128,6 +187,18 @@ static void __init mx27pdk_init(void)
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
 	imx27_add_mxc_mmc(0, &sdhc1_pdata);
 	imx27_add_imx2_wdt(NULL);
+	otg_phy_init();
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host) {
+		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+
+		imx27_add_mxc_ehci_otg(&otg_pdata);
+	}
+#endif
+	if (!otg_mode_host)
+		imx27_add_fsl_usb2_udc(&otg_device_pdata);
+
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.6.0.4
