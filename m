From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Fri,  4 Dec 2009 15:45:19 -0200
Subject: [PATCH] mx27: mxt_td60: Add USB Support
Message-ID: <1259948719-10008-1-git-send-email-acassis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add USB support on i-MXT TD60 to Host1 and Host2 ports.

Signed-off-by: Alan Carvalho de Assis <acassis@gmail.com>
---
 arch/arm/mach-mx2/Kconfig                   |    1 +
 arch/arm/mach-mx2/mxt_td60.c                |  106 +++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/iomux-mx27.h |   14 ++++
 3 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/Kconfig b/arch/arm/mach-mx2/Kconfig
index b96c6a3..f67f295 100644
--- a/arch/arm/mach-mx2/Kconfig
+++ b/arch/arm/mach-mx2/Kconfig
@@ -107,6 +107,7 @@ config MACH_PCA100
 config MACH_MXT_TD60
 	bool "Maxtrack i-MXT TD60"
 	depends on MACH_MX27
+	select MXC_ULPI
 	help
 	  Include support for i-MXT (aka td60) platform. This
 	  includes specific configurations for the module and its peripherals.
diff --git a/arch/arm/mach-mx2/mxt_td60.c b/arch/arm/mach-mx2/mxt_td60.c
index 8bcc1a5..aa376ea 100644
--- a/arch/arm/mach-mx2/mxt_td60.c
+++ b/arch/arm/mach-mx2/mxt_td60.c
@@ -23,6 +23,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
 #include <mach/common.h>
@@ -40,6 +41,12 @@
 #include <mach/imxfb.h>
 #include <mach/mmc.h>
 
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
+
 #include "devices.h"
 
 static unsigned int mxt_td60_pins[] __initdata = {
@@ -126,6 +133,29 @@ static unsigned int mxt_td60_pins[] __initdata = {
 	PB7_PF_SD2_D3,
 	PB8_PF_SD2_CMD,
 	PB9_PF_SD2_CLK,
+	/* USBH1 */
+	PB22_PF_USBH1_SUSP,
+	PB25_PF_USBH1_RCV,
+	PB26_PF_USBH1_FS,
+	PB27_PF_USBH1_OE_B,
+	PB28_PF_USBH1_TXDM,
+	PB29_PF_USBH1_TXDP,
+	PB30_PF_USBH1_RXDM,
+	PB31_PF_USBH1_RXDP,
+	PB23_PF_USB_PWR,
+	/* USBH2 */
+	PA0_PF_USBH2_CLK,
+	PA1_PF_USBH2_DIR,
+	PA3_PF_USBH2_NXT,
+	PA4_PF_USBH2_STP,
+	PD22_AF_USBH2_DATA0,
+	PD24_AF_USBH2_DATA1,
+	PD23_AF_USBH2_DATA2,
+	PD20_AF_USBH2_DATA3,
+	PD19_AF_USBH2_DATA4,
+	PD26_AF_USBH2_DATA5,
+	PD21_AF_USBH2_DATA6,
+	PA2_PF_USBH2_DATA7,
 };
 
 static struct mxc_nand_platform_data mxt_td60_nand_board_info = {
@@ -249,6 +279,79 @@ static struct imxuart_platform_data uart_pdata[] = {
 	},
 };
 
+static int isp1105_init(struct otg_transceiver *otg)
+{
+	mxc_gpio_mode(GPIO_PORTB | 23 | GPIO_GPIO | GPIO_OUT);
+	gpio_set_value(GPIO_PORTB + 23, 1);
+	mxc_gpio_mode(GPIO_PORTC | 31 | GPIO_GPIO | GPIO_OUT);
+	gpio_set_value(GPIO_PORTC + 31, 1);
+	return 0;
+}
+
+
+static int isp1105_set_vbus(struct otg_transceiver *otg, bool on)
+{
+	if (on)
+		gpio_set_value(GPIO_PORTB + 27, 0);
+	else
+		gpio_set_value(GPIO_PORTB + 27, 1);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbh1_pdata = {
+	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
+};
+
+static int __init usbh1_init(void)
+{
+	struct otg_transceiver *otg;
+
+	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
+	if (!otg)
+		return -ENOMEM;
+
+	otg->label	= "ISP1105";
+	otg->init	= isp1105_init;
+	otg->set_vbus	= isp1105_set_vbus;
+
+	usbh1_pdata.otg = otg;
+
+	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+}
+
+static int isp1504_init(struct platform_device *pdev)
+{
+	/* CS_N */
+	mxc_gpio_mode(GPIO_PORTA | 24 | GPIO_GPIO | GPIO_OUT);
+	gpio_set_value(GPIO_PORTA + 24, 0);
+
+	mdelay(1);
+
+	/* RST_N */
+	mxc_gpio_mode(GPIO_PORTA | 26 | GPIO_GPIO | GPIO_OUT);
+	gpio_set_value(GPIO_PORTA + 26, 1);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.init	= isp1504_init,
+	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
+	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
+};
+
+static int __init usbh2_init(void)
+{
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT |
+				USB_OTG_PULLDOWN_DP | USB_OTG_PULLDOWN_DM);
+
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+	return 0;
+}
+
 static void __init mxt_td60_board_init(void)
 {
 	mxc_gpio_setup_multiple_pins(mxt_td60_pins, ARRAY_SIZE(mxt_td60_pins),
@@ -270,6 +373,9 @@ static void __init mxt_td60_board_init(void)
 	mxc_register_device(&mxc_fb_device, &mxt_td60_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc1_pdata);
 
+	usbh1_init();
+	usbh2_init();
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx27.h b/arch/arm/plat-mxc/include/mach/iomux-mx27.h
index 5ac158b..82766af 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx27.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx27.h
@@ -33,7 +33,14 @@
 #define PA3_PF_USBH2_NXT        (GPIO_PORTA | GPIO_PF | 3)
 #define PA4_PF_USBH2_STP        (GPIO_PORTA | GPIO_PF | 4)
 #define PB22_PF_USBH1_SUSP      (GPIO_PORTB | GPIO_PF | 22)
+#define PB23_PF_USB_PWR         (GPIO_PORTB | GPIO_PF | 23)
 #define PB25_PF_USBH1_RCV       (GPIO_PORTB | GPIO_PF | 25)
+#define PB26_PF_USBH1_FS        (GPIO_PORTB | GPIO_PF | 26)
+#define PB27_PF_USBH1_OE_B      (GPIO_PORTB | GPIO_PF | 27)
+#define PB28_PF_USBH1_TXDM      (GPIO_PORTB | GPIO_PF | 28)
+#define PB29_PF_USBH1_TXDP      (GPIO_PORTB | GPIO_PF | 29)
+#define PB30_PF_USBH1_RXDM      (GPIO_PORTB | GPIO_PF | 30)
+#define PB31_PF_USBH1_RXDP      (GPIO_PORTB | GPIO_PF | 31)
 #define PC5_PF_I2C2_SDA         (GPIO_PORTC | GPIO_PF | GPIO_IN | 5)
 #define PC6_PF_I2C2_SCL         (GPIO_PORTC | GPIO_PF | GPIO_IN | 6)
 #define PC7_PF_USBOTG_DATA5     (GPIO_PORTC | GPIO_PF | GPIO_OUT | 7)
@@ -123,6 +130,13 @@
 #define PD14_AF_ETMTRACE_PKT7   (GPIO_PORTD | GPIO_AF | 14)
 #define PD15_AF_ETMTRACE_PKT6   (GPIO_PORTD | GPIO_AF | 15)
 #define PD16_AF_ETMTRACE_PKT5   (GPIO_PORTD | GPIO_AF | 16)
+#define PD19_AF_USBH2_DATA4     (GPIO_PORTD | GPIO_AF | 19)
+#define PD20_AF_USBH2_DATA3     (GPIO_PORTD | GPIO_AF | 20)
+#define PD21_AF_USBH2_DATA6     (GPIO_PORTD | GPIO_AF | 21)
+#define PD22_AF_USBH2_DATA0     (GPIO_PORTD | GPIO_AF | 22)
+#define PD23_AF_USBH2_DATA2     (GPIO_PORTD | GPIO_AF | 23)
+#define PD24_AF_USBH2_DATA1     (GPIO_PORTD | GPIO_AF | 24)
+#define PD26_AF_USBH2_DATA5     (GPIO_PORTD | GPIO_AF | 26)
 #define PF1_AF_ETMTRACE_PKT0    (GPIO_PORTF | GPIO_AF | 1)
 #define PF3_AF_ETMTRACE_PKT2    (GPIO_PORTF | GPIO_AF | 3)
 #define PF5_AF_ETMPIPESTAT11    (GPIO_PORTF | GPIO_AF | 5)
-- 
1.6.0.4
