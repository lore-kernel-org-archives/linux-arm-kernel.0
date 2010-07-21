From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 21 Jul 2010 09:17:43 +0200
Subject: [PATCH v2 3/3] i.MX51: add support for cpuimx51 module and its
	baseboard
In-Reply-To: <20100721044239.GC31367@jasper.tkos.co.il>
References: <20100721044239.GC31367@jasper.tkos.co.il>
Message-ID: <1279696663-3931-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPUIMX51 is build around Freescale's i.MX515 and has up to
512MB of RAM, NAND Flash, Ethernet, USB Host with 4 ports
hub, USB OTG, ST16554 Quad UART on nCS1, I2C RTC ...

MBIMX51 adds LEDS, Keypad, TSC2007 touchscreen controler ...

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
v2 : fix board name in Kconfig help

 arch/arm/mach-mx5/Kconfig                          |   21 ++
 arch/arm/mach-mx5/Makefile                         |    2 +
 arch/arm/mach-mx5/board-cpuimx51.c                 |  299 ++++++++++++++++++++
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |  200 +++++++++++++
 .../plat-mxc/include/mach/board-eukrea_cpuimx51.h  |   37 +++
 5 files changed, 559 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-cpuimx51.c
 create mode 100644 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx51.h

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 6ef3428..0848db5 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -21,4 +21,25 @@ config MACH_MX51_3DS
 	help
 	  Include support for MX51PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
+
+config MACH_EUKREA_CPUIMX51
+	bool "Support Eukrea CPUIMX51 module"
+	help
+	  Include support for Eukrea CPUIMX51 platform. This includes
+	  specific configurations for the module and its peripherals.
+
+choice
+	prompt "Baseboard"
+	depends on MACH_EUKREA_CPUIMX51
+	default MACH_EUKREA_MBIMX51_BASEBOARD
+
+config MACH_EUKREA_MBIMX51_BASEBOARD
+	prompt "Eukrea MBIMX51 development board"
+	bool
+	help
+	  This adds board specific devices that can be found on Eukrea's
+	  MBIMX51 evaluation board.
+
+endchoice
+
 endif
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index c757c59..86c66e7 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -7,3 +7,5 @@ obj-y   := cpu.o mm.o clock-mx51.o devices.o
 
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
+obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
new file mode 100644
index 0000000..79a666c
--- /dev/null
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -0,0 +1,299 @@
+/*
+ *
+ * Copyright (C) 2010 Eric B?nard <eric@eukrea.com>
+ *
+ * based on board-mx51_babbage.c which is
+ * Copyright 2009 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright (C) 2009-2010 Amit Kucheria <amit.kucheria@canonical.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/fsl_devices.h>
+
+#include <mach/board-eukrea_cpuimx51.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx51.h>
+#include <mach/i2c.h>
+#include <mach/mxc_ehci.h>
+
+#include <asm/irq.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "devices.h"
+
+#define CPUIMX51_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
+#define CPUIMX51_QUARTA_GPIO	(2*32 + 28)
+#define CPUIMX51_QUARTB_GPIO	(2*32 + 25)
+#define CPUIMX51_QUARTC_GPIO	(2*32 + 26)
+#define CPUIMX51_QUARTD_GPIO	(2*32 + 27)
+#define CPUIMX51_QUARTA_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTA_GPIO)
+#define CPUIMX51_QUARTB_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTB_GPIO)
+#define CPUIMX51_QUARTC_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTC_GPIO)
+#define CPUIMX51_QUARTD_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTD_GPIO)
+#define CPUIMX51_QUART_XTAL	14745600
+#define CPUIMX51_QUART_REGSHIFT	17
+
+/* USB_CTRL_1 */
+#define MX51_USB_CTRL_1_OFFSET			0x10
+#define MX51_USB_CTRL_UH1_EXT_CLK_EN		(1 << 25)
+
+#define	MX51_USB_PLLDIV_12_MHZ		0x00
+#define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
+#define	MX51_USB_PLL_DIV_24_MHZ	0x02
+
+#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
+static struct plat_serial8250_port serial_platform_data[] = {
+	{
+		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x400000),
+		.irq = CPUIMX51_QUARTA_IRQ,
+		.uartclk = CPUIMX51_QUART_XTAL,
+		.regshift = CPUIMX51_QUART_REGSHIFT,
+		.iotype = UPIO_MEM,
+		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
+	}, {
+		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x800000),
+		.irq = CPUIMX51_QUARTB_IRQ,
+		.uartclk = CPUIMX51_QUART_XTAL,
+		.regshift = CPUIMX51_QUART_REGSHIFT,
+		.iotype = UPIO_MEM,
+		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
+	}, {
+		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x1000000),
+		.irq = CPUIMX51_QUARTC_IRQ,
+		.uartclk = CPUIMX51_QUART_XTAL,
+		.regshift = CPUIMX51_QUART_REGSHIFT,
+		.iotype = UPIO_MEM,
+		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
+	}, {
+		.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
+		.irq = CPUIMX51_QUARTD_IRQ,
+		.uartclk = CPUIMX51_QUART_XTAL,
+		.regshift = CPUIMX51_QUART_REGSHIFT,
+		.iotype = UPIO_MEM,
+		.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
+	}, {
+	}
+};
+
+static struct platform_device serial_device = {
+	.name = "serial8250",
+	.id = 0,
+	.dev = {
+		.platform_data = serial_platform_data,
+	},
+};
+#endif
+
+static struct platform_device *devices[] __initdata = {
+	&mxc_fec_device,
+#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
+	&serial_device,
+#endif
+};
+
+static struct pad_desc mx51babbage_pads[] = {
+	/* UART1 */
+	MX51_PAD_UART1_RXD__UART1_RXD,
+	MX51_PAD_UART1_TXD__UART1_TXD,
+	MX51_PAD_UART1_RTS__UART1_RTS,
+	MX51_PAD_UART1_CTS__UART1_CTS,
+
+	/* I2C2 */
+	MX51_PAD_GPIO_1_2__I2C2_SCL,
+	MX51_PAD_GPIO_1_3__I2C2_SDA,
+	MX51_PAD_NANDF_D10__GPIO_3_30,
+
+	/* QUART IRQ */
+	MX51_PAD_NANDF_D15__GPIO_3_25,
+	MX51_PAD_NANDF_D14__GPIO_3_26,
+	MX51_PAD_NANDF_D13__GPIO_3_27,
+	MX51_PAD_NANDF_D12__GPIO_3_28,
+
+	/* USB HOST1 */
+	MX51_PAD_USBH1_CLK__USBH1_CLK,
+	MX51_PAD_USBH1_DIR__USBH1_DIR,
+	MX51_PAD_USBH1_NXT__USBH1_NXT,
+	MX51_PAD_USBH1_DATA0__USBH1_DATA0,
+	MX51_PAD_USBH1_DATA1__USBH1_DATA1,
+	MX51_PAD_USBH1_DATA2__USBH1_DATA2,
+	MX51_PAD_USBH1_DATA3__USBH1_DATA3,
+	MX51_PAD_USBH1_DATA4__USBH1_DATA4,
+	MX51_PAD_USBH1_DATA5__USBH1_DATA5,
+	MX51_PAD_USBH1_DATA6__USBH1_DATA6,
+	MX51_PAD_USBH1_DATA7__USBH1_DATA7,
+	MX51_PAD_USBH1_STP__USBH1_STP,
+};
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct imxi2c_platform_data babbage_i2c_data = {
+	.bitrate = 100000,
+};
+
+static struct i2c_board_info eukrea_cpuimx51_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pcf8563", 0x51),
+	},
+};
+
+/*
+ * This function is board specific as the bit mask for the plldiv will
+ * also be different for other Freescale SoCs, thus a common bitmask is
+ * not possible and cannot get place in /plat-mxc/ehci.c.
+ */
+static int initialize_otg_port(struct platform_device *pdev)
+{
+	u32 v;
+	void __iomem *usb_base;
+	void __iomem *usbother_base;
+
+	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
+
+	/* Set the PHY clock to 19.2MHz */
+	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
+	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
+	v |= MX51_USB_PLL_DIV_19_2_MHZ;
+	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
+	iounmap(usb_base);
+	return 0;
+}
+
+static int initialize_usbh1_port(struct platform_device *pdev)
+{
+	u32 v;
+	void __iomem *usb_base;
+	void __iomem *usbother_base;
+
+	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
+
+	/*
+	 * The clock for the USBH1 ULPI port will come externally
+	 * from the PHY.
+	 */
+	v = __raw_readl(usbother_base + MX51_USB_CTRL_1_OFFSET);
+	__raw_writel(v | MX51_USB_CTRL_UH1_EXT_CLK_EN, usbother_base \
+			+ MX51_USB_CTRL_1_OFFSET);
+	iounmap(usb_base);
+	return 0;
+}
+
+static struct mxc_usbh_platform_data dr_utmi_config = {
+	.init		= initialize_otg_port,
+	.portsc	= MXC_EHCI_UTMI_16BIT,
+	.flags	= MXC_EHCI_INTERNAL_PHY,
+};
+
+static struct fsl_usb2_platform_data usb_pdata = {
+	.operating_mode	= FSL_USB2_DR_DEVICE,
+	.phy_mode	= FSL_USB2_PHY_UTMI_WIDE,
+};
+
+static struct mxc_usbh_platform_data usbh1_config = {
+	.init		= initialize_usbh1_port,
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= (MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_ITC_NO_THRESHOLD),
+};
+
+static int otg_mode_host;
+
+static int __init babbage_otg_mode(char *options)
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
+__setup("otg_mode=", babbage_otg_mode);
+
+/*
+ * Board specific initialization.
+ */
+static void __init mxc_board_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
+					ARRAY_SIZE(mx51babbage_pads));
+
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	gpio_request(CPUIMX51_QUARTA_GPIO, "quarta_irq");
+	gpio_direction_input(CPUIMX51_QUARTA_GPIO);
+	gpio_free(CPUIMX51_QUARTA_GPIO);
+	set_irq_type(CPUIMX51_QUARTA_IRQ, IRQF_TRIGGER_HIGH);
+	gpio_request(CPUIMX51_QUARTB_GPIO, "quartb_irq");
+	gpio_direction_input(CPUIMX51_QUARTB_GPIO);
+	gpio_free(CPUIMX51_QUARTB_GPIO);
+	set_irq_type(CPUIMX51_QUARTB_IRQ, IRQF_TRIGGER_HIGH);
+	gpio_request(CPUIMX51_QUARTC_GPIO, "quartc_irq");
+	gpio_direction_input(CPUIMX51_QUARTC_GPIO);
+	gpio_free(CPUIMX51_QUARTC_GPIO);
+	set_irq_type(CPUIMX51_QUARTC_IRQ, IRQF_TRIGGER_HIGH);
+	gpio_request(CPUIMX51_QUARTD_GPIO, "quartd_irq");
+	gpio_direction_input(CPUIMX51_QUARTD_GPIO);
+	gpio_free(CPUIMX51_QUARTD_GPIO);
+	set_irq_type(CPUIMX51_QUARTD_IRQ, IRQF_TRIGGER_HIGH);
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	mxc_register_device(&mxc_i2c_device1, &babbage_i2c_data);
+	i2c_register_board_info(1, eukrea_cpuimx51_i2c_devices,
+				ARRAY_SIZE(eukrea_cpuimx51_i2c_devices));
+
+	if (otg_mode_host)
+		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
+	else {
+		initialize_otg_port(NULL);
+		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
+	}
+	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
+
+#ifdef CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD
+	eukrea_mbimx51_baseboard_init();
+#endif
+}
+
+static void __init cpuimx51_timer_init(void)
+{
+	mx51_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer mxc_timer = {
+	.init	= cpuimx51_timer_init,
+};
+
+MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
+	/* Maintainer: Eric B?nard <eric@eukrea.com> */
+	.phys_io = MX51_AIPS1_BASE_ADDR,
+	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params = PHYS_OFFSET + 0x100,
+	.map_io = mx51_map_io,
+	.init_irq = mx51_init_irq,
+	.init_machine = mxc_board_init,
+	.timer = &mxc_timer,
+MACHINE_END
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
new file mode 100644
index 0000000..40ed25a
--- /dev/null
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -0,0 +1,200 @@
+/*
+ *
+ * Copyright (C) 2010 Eric B?nard <eric@eukrea.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/fsl_devices.h>
+#include <linux/i2c/tsc2007.h>
+#include <linux/leds.h>
+#include <linux/input/matrix_keypad.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx51.h>
+
+#include <asm/mach/arch.h>
+
+#include "devices.h"
+
+#define MBIMX51_TSC2007_GPIO	(2*32 + 30)	/* GPIO_3_30 */
+#define MBIMX51_TSC2007_IRQ	(MXC_INTERNAL_IRQS + MBIMX51_TSC2007_GPIO)
+#define MBIMX51_LED0		(2*32 + 5)
+#define MBIMX51_LED1		(2*32 + 6)
+#define MBIMX51_LED2		(2*32 + 7)
+#define MBIMX51_LED3		(2*32 + 8)
+
+static struct gpio_led mbimx51_leds[] = {
+	{
+		.name			= "led0",
+		.default_trigger	= "heartbeat",
+		.active_low		= 1,
+		.gpio			= MBIMX51_LED0,
+	},
+	{
+		.name			= "led1",
+		.default_trigger	= "nand-disk",
+		.active_low		= 1,
+		.gpio			= MBIMX51_LED1,
+	},
+	{
+		.name			= "led2",
+		.default_trigger	= "mmc0",
+		.active_low		= 1,
+		.gpio			= MBIMX51_LED2,
+	},
+	{
+		.name			= "led3",
+		.default_trigger	= "default-on",
+		.active_low		= 1,
+		.gpio			= MBIMX51_LED3,
+	},
+};
+
+static struct gpio_led_platform_data mbimx51_leds_info = {
+	.leds		= mbimx51_leds,
+	.num_leds	= ARRAY_SIZE(mbimx51_leds),
+};
+
+static struct platform_device mbimx51_leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &mbimx51_leds_info,
+	},
+};
+
+static struct platform_device *devices[] __initdata = {
+	&mbimx51_leds_gpio,
+};
+
+static struct pad_desc mbimx51_pads[] = {
+	/* UART2 */
+	MX51_PAD_UART2_RXD__UART2_RXD,
+	MX51_PAD_UART2_TXD__UART2_TXD,
+
+	/* UART3 */
+	MX51_PAD_UART3_RXD__UART3_RXD,
+	MX51_PAD_UART3_TXD__UART3_TXD,
+	MX51_PAD_KEY_COL4__UART3_RTS,
+	MX51_PAD_KEY_COL5__UART3_CTS,
+
+	/* TSC2007 IRQ */
+	MX51_PAD_NANDF_D10__GPIO_3_30,
+
+	/* LEDS */
+	MX51_PAD_DISPB2_SER_DIN__GPIO_3_5,
+	MX51_PAD_DISPB2_SER_DIO__GPIO_3_6,
+	MX51_PAD_DISPB2_SER_CLK__GPIO_3_7,
+	MX51_PAD_DISPB2_SER_RS__GPIO_3_8,
+
+	/* KPP */
+	MX51_PAD_KEY_ROW0__KEY_ROW0,
+	MX51_PAD_KEY_ROW1__KEY_ROW1,
+	MX51_PAD_KEY_ROW2__KEY_ROW2,
+	MX51_PAD_KEY_ROW3__KEY_ROW3,
+	MX51_PAD_KEY_COL0__KEY_COL0,
+	MX51_PAD_KEY_COL1__KEY_COL1,
+	MX51_PAD_KEY_COL2__KEY_COL2,
+	MX51_PAD_KEY_COL3__KEY_COL3,
+};
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static int mbimx51_keymap[] = {
+	KEY(0, 0, KEY_1),
+	KEY(0, 1, KEY_2),
+	KEY(0, 2, KEY_3),
+	KEY(0, 3, KEY_UP),
+
+	KEY(1, 0, KEY_4),
+	KEY(1, 1, KEY_5),
+	KEY(1, 2, KEY_6),
+	KEY(1, 3, KEY_LEFT),
+
+	KEY(2, 0, KEY_7),
+	KEY(2, 1, KEY_8),
+	KEY(2, 2, KEY_9),
+	KEY(2, 3, KEY_RIGHT),
+
+	KEY(3, 0, KEY_0),
+	KEY(3, 1, KEY_DOWN),
+	KEY(3, 2, KEY_ESC),
+	KEY(3, 3, KEY_ENTER),
+};
+
+static struct matrix_keymap_data mbimx51_map_data = {
+	.keymap		= mbimx51_keymap,
+	.keymap_size	= ARRAY_SIZE(mbimx51_keymap),
+};
+
+static int tsc2007_get_pendown_state(void)
+{
+	return !gpio_get_value(MBIMX51_TSC2007_GPIO);
+}
+
+struct tsc2007_platform_data tsc2007_data = {
+	.model = 2007,
+	.x_plate_ohms = 180,
+	.get_pendown_state = tsc2007_get_pendown_state,
+};
+
+static struct i2c_board_info mbimx51_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tsc2007", 0x48),
+		.irq  = MBIMX51_TSC2007_IRQ,
+		.platform_data = &tsc2007_data,
+	},
+};
+
+/*
+ * baseboard initialization.
+ */
+void __init eukrea_mbimx51_baseboard_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mbimx51_pads,
+					ARRAY_SIZE(mbimx51_pads));
+
+	mxc_register_device(&mxc_uart_device1, NULL);
+	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+
+	gpio_request(MBIMX51_LED0, "LED0");
+	gpio_direction_output(MBIMX51_LED0, 1);
+	gpio_free(MBIMX51_LED0);
+	gpio_request(MBIMX51_LED1, "LED1");
+	gpio_direction_output(MBIMX51_LED1, 1);
+	gpio_free(MBIMX51_LED1);
+	gpio_request(MBIMX51_LED2, "LED2");
+	gpio_direction_output(MBIMX51_LED2, 1);
+	gpio_free(MBIMX51_LED2);
+	gpio_request(MBIMX51_LED3, "LED3");
+	gpio_direction_output(MBIMX51_LED3, 1);
+	gpio_free(MBIMX51_LED3);
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	mxc_register_device(&mxc_keypad_device, &mbimx51_map_data);
+
+	gpio_request(MBIMX51_TSC2007_GPIO, "tsc2007_irq");
+	gpio_direction_input(MBIMX51_TSC2007_GPIO);
+	set_irq_type(MBIMX51_TSC2007_IRQ, IRQF_TRIGGER_FALLING);
+	i2c_register_board_info(1, mbimx51_i2c_devices,
+				ARRAY_SIZE(mbimx51_i2c_devices));
+}
diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx51.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx51.h
new file mode 100644
index 0000000..73ce705
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx51.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2010 Eric Benard - eric at eukrea.com
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX51_H__
+#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX51_H__
+
+#ifndef __ASSEMBLY__
+/*
+ * This CPU module needs a baseboard to work. After basic initializing
+ * its own devices, it calls the baseboard's init function.
+ * TODO: Add your own baseboard init function and call it from
+ * inside eukrea_cpuimx51_init().
+ *
+ * This example here is for the development board. Refer
+ * eukrea_mbimx51-baseboard.c
+ */
+
+extern void eukrea_mbimx51_baseboard_init(void);
+
+#endif
+
+#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX51_H__ */
-- 
1.6.3.3
