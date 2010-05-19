From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:46:02 +0200
Subject: [PATCH 07/13] mach-cpuimx27: add USB Host2 and OTG support
In-Reply-To: <1274287568-30253-6-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
	<1274287568-30253-5-git-send-email-eric@eukrea.com>
	<1274287568-30253-6-git-send-email-eric@eukrea.com>
Message-ID: <1274287568-30253-7-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support copied from mach-pca100.c

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/Kconfig         |    1 +
 arch/arm/mach-mx2/mach-cpuimx27.c |   77 +++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index 9d3a909..3f756f4 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -59,6 +59,7 @@ endchoice
 config MACH_CPUIMX27
 	bool "Eukrea CPUIMX27 module"
 	depends on MACH_MX27
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
 	  specific configurations for the module and its peripherals.
diff --git a/arch/arm/mach-mx2/mach-cpuimx27.c b/arch/arm/mach-mx2/mach-cpuimx27.c
index a3449ed..19877f1 100644
--- a/arch/arm/mach-mx2/mach-cpuimx27.c
+++ b/arch/arm/mach-mx2/mach-cpuimx27.c
@@ -26,6 +26,9 @@
 #include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +42,8 @@
 #include <mach/iomux-mx27.h>
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 
@@ -93,6 +98,32 @@ static int eukrea_cpuimx27_pins[] = {
 	GPIO_PORTB | 27 | GPIO_GPIO | GPIO_IN,
 	GPIO_PORTB | 30 | GPIO_GPIO | GPIO_IN,
 #endif
+	/* OTG */
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
 
 static struct physmap_flash_data eukrea_cpuimx27_flash_data = {
@@ -186,6 +217,36 @@ static struct platform_device serial_device = {
 };
 #endif
 
+static struct mxc_usbh_platform_data otg_pdata = {
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
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
+static int __init eukrea_cpuimx27_otg_mode(char *options)
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
+__setup("otg_mode=", eukrea_cpuimx27_otg_mode);
+
 static void __init eukrea_cpuimx27_init(void)
 {
 	mxc_gpio_setup_multiple_pins(eukrea_cpuimx27_pins,
@@ -216,6 +277,22 @@ static void __init eukrea_cpuimx27_init(void)
 	platform_device_register(&serial_device);
 #endif
 
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
+	if (!otg_mode_host)
+		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+
 #ifdef CONFIG_MACH_EUKREA_MBIMX27_BASEBOARD
 	eukrea_mbimx27_baseboard_init();
 #endif
-- 
1.6.3.3
