From: alberto.panizzo@gmail.com (Alberto Panizzo)
Date: Thu, 25 Feb 2010 00:27:12 +0100
Subject: [PATCH] MXC: mach_armadillo5x0: Add USB Host support.
Message-ID: <1267054032.3870.47.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add USB Host capability. The Armadillo 500 board is supplied
with two USB Host connectors driven by the USB OTG and USB Host 2
ports, through two NXP isp 1504 transceivers.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---

Sascha, if there aren't problems, can you add this for 2.6.34?

 arch/arm/mach-mx3/Kconfig             |    1 +
 arch/arm/mach-mx3/mach-armadillo5x0.c |  128 +++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 3872af1..96069a4 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -95,6 +95,7 @@ config MACH_PCM043
 config MACH_ARMADILLO5X0
 	bool "Support Atmark Armadillo-500 Development Base Board"
 	select ARCH_MX31
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Atmark Armadillo-500 platform. This includes
 	  specific configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
index 3d72b0b..a29f8ef 100644
--- a/arch/arm/mach-mx3/mach-armadillo5x0.c
+++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
@@ -36,6 +36,9 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/delay.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -52,6 +55,8 @@
 #include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/mxc_nand.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 #include "crm_regs.h"
@@ -103,6 +108,118 @@ static int armadillo5x0_pins[] = {
 	/* I2C2 */
 	MX31_PIN_CSPI2_MOSI__SCL,
 	MX31_PIN_CSPI2_MISO__SDA,
+	/* OTG */
+	MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
+	MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
+	MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
+	MX31_PIN_USBOTG_DATA3__USBOTG_DATA3,
+	MX31_PIN_USBOTG_DATA4__USBOTG_DATA4,
+	MX31_PIN_USBOTG_DATA5__USBOTG_DATA5,
+	MX31_PIN_USBOTG_DATA6__USBOTG_DATA6,
+	MX31_PIN_USBOTG_DATA7__USBOTG_DATA7,
+	MX31_PIN_USBOTG_CLK__USBOTG_CLK,
+	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
+	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
+	MX31_PIN_USBOTG_STP__USBOTG_STP,
+	/* USB host 2 */
+	IOMUX_MODE(MX31_PIN_USBH2_CLK, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DIR, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_NXT, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_STP, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DATA0, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DATA1, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_STXD3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SRXD3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SCK3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SFS3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_STXD6, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SRXD6, IOMUX_CONFIG_FUNC),
+};
+
+/* USB */
+#define OTG_RESET IOMUX_TO_GPIO(MX31_PIN_STXD4)
+#define USBH2_RESET IOMUX_TO_GPIO(MX31_PIN_SCK6)
+#define USBH2_CS IOMUX_TO_GPIO(MX31_PIN_GPIO1_3)
+
+#define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
+			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
+static int usbotg_init(struct platform_device *pdev)
+{
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA3, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA4, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA5, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA6, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA7, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_CLK, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DIR, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP, USB_PAD_CFG);
+
+	/* Chip already enabled by hardware */
+	/* OTG phy reset*/
+	gpio_request(OTG_RESET, "USB-OTG-RESET");
+
+	if (gpio_direction_output(OTG_RESET, 1/*HIGH*/)) {
+		pr_warning("Failed to reset usbotg phy \n");
+		return -1;
+	}
+	gpio_set_value(OTG_RESET, 0/*LOW*/);
+	mdelay(5);
+	gpio_set_value(OTG_RESET, 1/*HIGH*/);
+
+	return 0;
+}
+
+static int usbh2_init(struct platform_device *pdev)
+{
+	mxc_iomux_set_pad(MX31_PIN_USBH2_CLK, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DIR, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_NXT, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_STP, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA0, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SRXD6, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_STXD6, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SFS3, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SCK3, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_SRXD3, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_STXD3, USB_PAD_CFG);
+
+	mxc_iomux_set_gpr(MUX_PGP_UH2, true);
+
+
+	/* Enable the chip */
+	gpio_request(USBH2_CS, "USB-H2-CS");
+	gpio_direction_output(USBH2_CS, 0/*Enabled*/);
+
+	/* H2 phy reset*/
+	gpio_request(USBH2_RESET, "USB-H2-RESET");
+
+	if (gpio_direction_output(USBH2_RESET, 1/*HIGH*/)) {
+		pr_warning("Failed to reset usbh2 phy \n");
+		return -1;
+	}
+	gpio_set_value(USBH2_RESET, 0/*LOW*/);
+	mdelay(5);
+	gpio_set_value(USBH2_RESET, 1/*HIGH*/);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbotg_pdata = {
+	.init	= usbotg_init,
+	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.init	= usbh2_init,
+	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_DIFF_UNI,
 };
 
 /* RTC over I2C*/
@@ -393,6 +510,15 @@ static void __init armadillo5x0_init(void)
 	if (armadillo5x0_i2c_rtc.irq == 0)
 		pr_warning("armadillo5x0_init: failed to get RTC IRQ\n");
 	i2c_register_board_info(1, &armadillo5x0_i2c_rtc, 1);
+
+	/* USB */
+	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+	mxc_register_device(&mxc_otg_host, &usbotg_pdata);
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 }
 
 static void __init armadillo5x0_timer_init(void)
-- 
1.6.3.3
