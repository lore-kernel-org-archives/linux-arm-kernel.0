From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 13 Apr 2010 20:11:37 +0200
Subject: [PATCH] ARM: mx3/lilly1131: add USB support
In-Reply-To: <1271181961-27844-1-git-send-email-daniel@caiaq.de>
References: <1271181961-27844-1-git-send-email-daniel@caiaq.de>
Message-ID: <1271182297-27984-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---

Another version with "select MXC_ULPI if USB_ULPI"

 arch/arm/mach-mx3/Kconfig          |    1 +
 arch/arm/mach-mx3/mach-mx31lilly.c |  145 ++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 3872af1..bc71de3 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -73,6 +73,7 @@ config MACH_MX31MOBOARD
 config MACH_MX31LILLY
 	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
 	select ARCH_MX31
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for mx31 based LILLY1131 modules. This includes
 	  specific configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/mach-mx31lilly.c b/arch/arm/mach-mx3/mach-mx31lilly.c
index 80847b0..d3d5877 100644
--- a/arch/arm/mach-mx3/mach-mx31lilly.c
+++ b/arch/arm/mach-mx3/mach-mx31lilly.c
@@ -27,12 +27,15 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/smsc911x.h>
 #include <linux/mtd/physmap.h>
 #include <linux/spi/spi.h>
 #include <linux/mfd/mc13783.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -44,6 +47,8 @@
 #include <mach/iomux-mx3.h>
 #include <mach/board-mx31lilly.h>
 #include <mach/spi.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 
@@ -108,6 +113,137 @@ static struct platform_device physmap_flash_device = {
 	.num_resources = 1,
 };
 
+/* USB */
+
+#define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
+			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
+static int usbotg_init(struct platform_device *pdev)
+{
+	unsigned int pins[] = {
+		MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
+		MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
+		MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
+		MX31_PIN_USBOTG_DATA3__USBOTG_DATA3,
+		MX31_PIN_USBOTG_DATA4__USBOTG_DATA4,
+		MX31_PIN_USBOTG_DATA5__USBOTG_DATA5,
+		MX31_PIN_USBOTG_DATA6__USBOTG_DATA6,
+		MX31_PIN_USBOTG_DATA7__USBOTG_DATA7,
+		MX31_PIN_USBOTG_CLK__USBOTG_CLK,
+		MX31_PIN_USBOTG_DIR__USBOTG_DIR,
+		MX31_PIN_USBOTG_NXT__USBOTG_NXT,
+		MX31_PIN_USBOTG_STP__USBOTG_STP,
+	};
+
+	mxc_iomux_setup_multiple_pins(pins, ARRAY_SIZE(pins), "USB OTG");
+
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
+	mxc_iomux_set_gpr(MUX_PGP_USB_4WIRE, true);
+	mxc_iomux_set_gpr(MUX_PGP_USB_COMMON, true);
+
+	/* chip select */
+	mxc_iomux_alloc_pin(IOMUX_MODE(MX31_PIN_DTR_DCE2, IOMUX_CONFIG_GPIO),
+				"USBOTG_CS");
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE2), "USBH1 CS");
+	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE2), 0);
+
+	return 0;
+}
+
+static int usbh1_init(struct platform_device *pdev)
+{
+	int pins[] = {
+		MX31_PIN_CSPI1_MOSI__USBH1_RXDM,
+		MX31_PIN_CSPI1_MISO__USBH1_RXDP,
+		MX31_PIN_CSPI1_SS0__USBH1_TXDM,
+		MX31_PIN_CSPI1_SS1__USBH1_TXDP,
+		MX31_PIN_CSPI1_SS2__USBH1_RCV,
+		MX31_PIN_CSPI1_SCLK__USBH1_OEB,
+		MX31_PIN_CSPI1_SPI_RDY__USBH1_FS,
+	};
+
+	mxc_iomux_setup_multiple_pins(pins, ARRAY_SIZE(pins), "USB H1");
+
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_MOSI, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_MISO, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS0, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS1, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SS2, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SCLK, USB_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_CSPI1_SPI_RDY, USB_PAD_CFG);
+
+	mxc_iomux_set_gpr(MUX_PGP_USB_SUSPEND, true);
+
+	return 0;
+}
+
+static int usbh2_init(struct platform_device *pdev)
+{
+	int pins[] = {
+		MX31_PIN_USBH2_DATA0__USBH2_DATA0,
+		MX31_PIN_USBH2_DATA1__USBH2_DATA1,
+		MX31_PIN_USBH2_CLK__USBH2_CLK,
+		MX31_PIN_USBH2_DIR__USBH2_DIR,
+		MX31_PIN_USBH2_NXT__USBH2_NXT,
+		MX31_PIN_USBH2_STP__USBH2_STP,
+	};
+
+	mxc_iomux_setup_multiple_pins(pins, ARRAY_SIZE(pins), "USB H2");
+
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
+	/* chip select */
+	mxc_iomux_alloc_pin(IOMUX_MODE(MX31_PIN_DTR_DCE1, IOMUX_CONFIG_GPIO),
+				"USBH2_CS");
+	gpio_request(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), "USBH2 CS");
+	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1), 0);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbotg_pdata = {
+	.init	= usbotg_init,
+	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
+};
+
+static struct mxc_usbh_platform_data usbh1_pdata = {
+	.init	= usbh1_init,
+	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
+};
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.init	= usbh2_init,
+	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&smsc91x_device,
 	&physmap_flash_device,
@@ -183,6 +319,15 @@ static void __init mx31lilly_board_init(void)
 	spi_register_board_info(&mc13783_dev, 1);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	/* USB */
+	usbotg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 }
 
 static void __init mx31lilly_timer_init(void)
-- 
1.7.0.3
