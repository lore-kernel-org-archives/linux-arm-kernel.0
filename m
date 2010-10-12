From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 17:01:15 +0200
Subject: [PATCH 1/2] mx5: add cpuimx51sd module and its baseboard
Message-ID: <1286895676-9407-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/Kconfig                          |   25 ++
 arch/arm/mach-mx5/Makefile                         |    2 +
 arch/arm/mach-mx5/board-cpuimx51sd.c               |  333 ++++++++++++++++++++
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c       |  166 ++++++++++
 arch/arm/plat-mxc/include/mach/eukrea-baseboards.h |    5 +-
 arch/arm/plat-mxc/include/mach/uncompress.h        |    1 +
 6 files changed, 531 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-cpuimx51sd.c
 create mode 100644 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index fad31cc..254b891 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -49,6 +49,31 @@ config MACH_EUKREA_MBIMX51_BASEBOARD
 
 endchoice
 
+config MACH_EUKREA_CPUIMX51SD
+	bool "Support Eukrea CPUIMX51SD module"
+	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_NAND
+	help
+	  Include support for Eukrea CPUIMX51SD platform. This includes
+	  specific configurations for the module and its peripherals.
+
+choice
+	prompt "Baseboard"
+	depends on MACH_EUKREA_CPUIMX51SD
+	default MACH_EUKREA_MBIMXSD51_BASEBOARD
+
+config MACH_EUKREA_MBIMXSD51_BASEBOARD
+	prompt "Eukrea MBIMXSD development board"
+	bool
+	select IMX_HAVE_PLATFORM_ESDHC
+	help
+	  This adds board specific devices that can be found on Eukrea's
+	  MBIMXSD evaluation board.
+
+endchoice
+
 config MACH_MX51_EFIKAMX
 	bool "Support MX51 Genesi Efika MX nettop"
 	select IMX_HAVE_PLATFORM_IMX_UART
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index d1aac9c..1769c16 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -9,4 +9,6 @@ obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
 obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
 obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
 obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += board-cpuimx51sd.o
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd-baseboard.o
 obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
new file mode 100644
index 0000000..bd5eb61
--- /dev/null
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -0,0 +1,333 @@
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
+#include <linux/i2c.h>
+#include <linux/i2c/tsc2007.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/fsl_devices.h>
+#include <linux/i2c-gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/can/platform/mcp251x.h>
+
+#include <mach/eukrea-baseboards.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/iomux-mx51.h>
+#include <mach/mxc_ehci.h>
+
+#include <asm/irq.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "devices-imx51.h"
+#include "devices.h"
+
+#define USBH1_RST		(1*32 + 28)
+#define ETH_RST			(1*32 + 31)
+#define TSC2007_IRQGPIO		(2*32 + 12)
+#define CAN_IRQGPIO		(0*32 + 1)
+#define CAN_RST			(3*32 + 15)
+#define CAN_NCS			(3*32 + 24)
+#define CAN_RXOBF		(0*32 + 4)
+#define CAN_RX1BF		(0*32 + 6)
+#define CAN_TXORTS		(0*32 + 7)
+#define CAN_TX1RTS		(0*32 + 8)
+#define CAN_TX2RTS		(0*32 + 9)
+#define I2C_SCL			(3*32 + 16)
+#define I2C_SDA			(3*32 + 17)
+
+/* USB_CTRL_1 */
+#define MX51_USB_CTRL_1_OFFSET		0x10
+#define MX51_USB_CTRL_UH1_EXT_CLK_EN	(1 << 25)
+
+#define	MX51_USB_PLLDIV_12_MHZ		0x00
+#define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
+#define	MX51_USB_PLL_DIV_24_MHZ		0x02
+
+#define CPUIMX51SD_GPIO_3_12 IOMUX_PAD(0x57C, 0x194, 3, 0x0, 0, \
+				MX51_PAD_CTRL_1 | PAD_CTL_PUS_22K_UP)
+
+static struct pad_desc eukrea_cpuimx51sd_pads[] = {
+	/* UART1 */
+	MX51_PAD_UART1_RXD__UART1_RXD,
+	MX51_PAD_UART1_TXD__UART1_TXD,
+	MX51_PAD_UART1_RTS__UART1_RTS,
+	MX51_PAD_UART1_CTS__UART1_CTS,
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
+	MX51_PAD_EIM_CS3__GPIO_2_28,		/* PHY nRESET */
+
+	/* FEC */
+	MX51_PAD_EIM_DTACK__GPIO_2_31,		/* PHY nRESET */
+
+	/* HSI2C */
+	MX51_PAD_I2C1_CLK__GPIO_4_16,
+	MX51_PAD_I2C1_DAT__GPIO_4_17,
+
+	/* CAN */
+	MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI,
+	MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
+	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
+	MX51_PAD_CSPI1_SS0__GPIO_4_24,		/* nCS */
+	MX51_PAD_CSI2_PIXCLK__GPIO_4_15,	/* nReset */
+	MX51_PAD_GPIO_1_1__GPIO_1_1,		/* IRQ */
+	MX51_PAD_GPIO_1_4__GPIO_1_4,		/* Control signals */
+	MX51_PAD_GPIO_1_6__GPIO_1_6,
+	MX51_PAD_GPIO_1_7__GPIO_1_7,
+	MX51_PAD_GPIO_1_8__GPIO_1_8,
+	MX51_PAD_GPIO_1_9__GPIO_1_9,
+
+	/* Touchscreen */
+	CPUIMX51SD_GPIO_3_12,			/* IRQ */
+};
+
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static int ts_get_pendown_state(void)
+{
+	return gpio_get_value(TSC2007_IRQGPIO) ? 0 : 1;
+}
+
+static struct tsc2007_platform_data tsc2007_info = {
+	.model			= 2007,
+	.x_plate_ohms		= 180,
+	.get_pendown_state	= ts_get_pendown_state,
+};
+
+static struct i2c_board_info eukrea_cpuimx51sd_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pcf8563", 0x51),
+	}, {
+		I2C_BOARD_INFO("tsc2007", 0x49),
+		.type		= "tsc2007",
+		.platform_data	= &tsc2007_info,
+		.irq		= gpio_to_irq(TSC2007_IRQGPIO),
+	},
+};
+
+static const struct mxc_nand_platform_data
+		eukrea_cpuimx51sd_nand_board_info __initconst = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
+/* This function is board specific as the bit mask for the plldiv will also
+be different for other Freescale SoCs, thus a common bitmask is not
+possible and cannot get place in /plat-mxc/ehci.c.*/
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
+	/* The clock for the USBH1 ULPI port will come from the PHY. */
+	v = __raw_readl(usbother_base + MX51_USB_CTRL_1_OFFSET);
+	__raw_writel(v | MX51_USB_CTRL_UH1_EXT_CLK_EN,
+			usbother_base + MX51_USB_CTRL_1_OFFSET);
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
+static int __init eukrea_cpuimx51sd_otg_mode(char *options)
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
+__setup("otg_mode=", eukrea_cpuimx51sd_otg_mode);
+
+static struct i2c_gpio_platform_data pdata = {
+	.sda_pin		= I2C_SDA,
+	.sda_is_open_drain	= 0,
+	.scl_pin		= I2C_SCL,
+	.scl_is_open_drain	= 0,
+	.udelay			= 2,
+};
+
+static struct platform_device hsi2c_gpio_device = {
+	.name			= "i2c-gpio",
+	.id			= 0,
+	.dev.platform_data	= &pdata,
+};
+
+static struct mcp251x_platform_data mcp251x_info = {
+	.oscillator_frequency = 24E6,
+};
+
+static struct spi_board_info cpuimx51sd_spi_device[] = {
+	{
+		.modalias        = "mcp2515",
+		.max_speed_hz    = 6500000,
+		.bus_num         = 0,
+		.mode		= SPI_MODE_0,
+		.chip_select     = 0,
+		.platform_data   = &mcp251x_info,
+		.irq             = gpio_to_irq(0 * 32 + 1)
+	},
+};
+
+static int cpuimx51sd_spi1_cs[] = {
+	CAN_NCS,
+};
+
+static const struct spi_imx_master cpuimx51sd_ecspi1_pdata __initconst = {
+	.chipselect	= cpuimx51sd_spi1_cs,
+	.num_chipselect	= ARRAY_SIZE(cpuimx51sd_spi1_cs),
+};
+
+static struct platform_device *platform_devices[] __initdata = {
+	&hsi2c_gpio_device,
+};
+
+static void __init eukrea_cpuimx51sd_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx51sd_pads,
+					ARRAY_SIZE(eukrea_cpuimx51sd_pads));
+
+	imx51_add_imx_uart(0, &uart_pdata);
+	imx51_add_mxc_nand(&eukrea_cpuimx51sd_nand_board_info);
+
+	gpio_request(ETH_RST, "eth_rst");
+	gpio_set_value(ETH_RST, 1);
+	imx51_add_fec(NULL);
+
+	gpio_request(CAN_IRQGPIO, "can_irq");
+	gpio_direction_input(CAN_IRQGPIO);
+	gpio_free(CAN_IRQGPIO);
+	gpio_request(CAN_NCS, "can_ncs");
+	gpio_direction_output(CAN_NCS, 1);
+	gpio_free(CAN_NCS);
+	gpio_request(CAN_RST, "can_rst");
+	gpio_direction_output(CAN_RST, 0);
+	msleep(20);
+	gpio_set_value(CAN_RST, 1);
+	imx51_add_ecspi(0, &cpuimx51sd_ecspi1_pdata);
+	spi_register_board_info(cpuimx51sd_spi_device,
+				ARRAY_SIZE(cpuimx51sd_spi_device));
+
+	gpio_request(TSC2007_IRQGPIO, "tsc2007_irq");
+	gpio_direction_input(TSC2007_IRQGPIO);
+	gpio_free(TSC2007_IRQGPIO);
+
+	i2c_register_board_info(0, eukrea_cpuimx51sd_i2c_devices,
+			ARRAY_SIZE(eukrea_cpuimx51sd_i2c_devices));
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+
+	if (otg_mode_host)
+		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
+	else {
+		initialize_otg_port(NULL);
+		mxc_register_device(&mxc_usbdr_udc_device, &usb_pdata);
+	}
+
+	gpio_request(USBH1_RST, "usb_rst");
+	gpio_direction_output(USBH1_RST, 0);
+	msleep(20);
+	gpio_set_value(USBH1_RST, 1);
+	mxc_register_device(&mxc_usbh1_device, &usbh1_config);
+
+#ifdef CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD
+	eukrea_mbimxsd51_baseboard_init();
+#endif
+}
+
+static void __init eukrea_cpuimx51sd_timer_init(void)
+{
+	mx51_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer mxc_timer = {
+	.init	= eukrea_cpuimx51sd_timer_init,
+};
+
+MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
+	/* Maintainer: Eric B?nard <eric@eukrea.com> */
+	.phys_io = MX51_AIPS1_BASE_ADDR,
+	.io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params = PHYS_OFFSET + 0x100,
+	.map_io = mx51_map_io,
+	.init_irq = mx51_init_irq,
+	.init_machine = eukrea_cpuimx51sd_init,
+	.timer = &mxc_timer,
+MACHINE_END
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
new file mode 100644
index 0000000..2b48f51
--- /dev/null
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -0,0 +1,166 @@
+/*
+ * Copyright (C) 2010 Eric Benard - eric at eukrea.com
+ *
+ * Based on pcm970-baseboard.c which is :
+ * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
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
+#include <linux/types.h>
+#include <linux/init.h>
+
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx51.h>
+#include <mach/audmux.h>
+
+#include "devices-imx51.h"
+#include "devices.h"
+
+#define MBIMXSD_GPIO_3_31 IOMUX_PAD(0x554, 0x16C, 3, 0x0, 0, \
+				MX51_PAD_CTRL_1 | PAD_CTL_PUS_22K_UP)
+
+static struct pad_desc eukrea_mbimxsd_pads[] = {
+	/* LED */
+	MX51_PAD_NANDF_D10__GPIO_3_30,
+	/* SWITCH */
+	MBIMXSD_GPIO_3_31,
+	/* UART2 */
+	MX51_PAD_UART2_RXD__UART2_RXD,
+	MX51_PAD_UART2_TXD__UART2_TXD,
+	/* UART 3 */
+	MX51_PAD_UART3_RXD__UART3_RXD,
+	MX51_PAD_UART3_TXD__UART3_TXD,
+	MX51_PAD_KEY_COL4__UART3_RTS,
+	MX51_PAD_KEY_COL5__UART3_CTS,
+	/* SD */
+	MX51_PAD_SD1_CMD__SD1_CMD,
+	MX51_PAD_SD1_CLK__SD1_CLK,
+	MX51_PAD_SD1_DATA0__SD1_DATA0,
+	MX51_PAD_SD1_DATA1__SD1_DATA1,
+	MX51_PAD_SD1_DATA2__SD1_DATA2,
+	MX51_PAD_SD1_DATA3__SD1_DATA3,
+};
+
+#define GPIO_LED1	(2 * 32 + 30)
+#define GPIO_SWITCH1	(2 * 32 + 31)
+
+static struct gpio_led eukrea_mbimxsd_leds[] = {
+	{
+		.name			= "led1",
+		.default_trigger	= "heartbeat",
+		.active_low		= 1,
+		.gpio			= GPIO_LED1,
+	},
+};
+
+static struct gpio_led_platform_data eukrea_mbimxsd_led_info = {
+	.leds		= eukrea_mbimxsd_leds,
+	.num_leds	= ARRAY_SIZE(eukrea_mbimxsd_leds),
+};
+
+static struct platform_device eukrea_mbimxsd_leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &eukrea_mbimxsd_led_info,
+	},
+};
+
+static struct gpio_keys_button eukrea_mbimxsd_gpio_buttons[] = {
+	{
+		.gpio		= GPIO_SWITCH1,
+		.code		= BTN_0,
+		.desc		= "BP1",
+		.active_low	= 1,
+		.wakeup		= 1,
+	},
+};
+
+static struct gpio_keys_platform_data eukrea_mbimxsd_button_data = {
+	.buttons	= eukrea_mbimxsd_gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(eukrea_mbimxsd_gpio_buttons),
+};
+
+static struct platform_device eukrea_mbimxsd_button_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &eukrea_mbimxsd_button_data,
+	}
+};
+
+static struct platform_device *platform_devices[] __initdata = {
+	&eukrea_mbimxsd_leds_gpio,
+	&eukrea_mbimxsd_button_device,
+};
+
+static const struct imxuart_platform_data uart_pdata __initconst = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
+	},
+};
+
+/*
+ * system init for baseboard usage. Will be called by cpuimx51sd init.
+ *
+ * Add platform devices present on this baseboard and init
+ * them from CPU side as far as required to use them later on
+ */
+void __init eukrea_mbimxsd51_baseboard_init(void)
+{
+	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd_pads,
+			ARRAY_SIZE(eukrea_mbimxsd_pads)))
+		printk(KERN_ERR "error setting mbimxsd pads !\n");
+
+	imx51_add_imx_uart(1, NULL);
+	imx51_add_imx_uart(2, &uart_pdata);
+
+	imx51_add_esdhc(0, NULL);
+
+	gpio_request(GPIO_LED1, "LED1");
+	gpio_direction_output(GPIO_LED1, 1);
+	gpio_free(GPIO_LED1);
+
+	gpio_request(GPIO_SWITCH1, "SWITCH1");
+	gpio_direction_input(GPIO_SWITCH1);
+	gpio_free(GPIO_SWITCH1);
+
+	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
+				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
+
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+}
diff --git a/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h b/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
index 656acb4..a21d331 100644
--- a/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
+++ b/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
@@ -28,19 +28,22 @@
  * its own devices, it calls baseboard's init function.
  * TODO: Add your own baseboard init function and call it from
  * inside eukrea_cpuimx25_init() eukrea_cpuimx27_init()
- * eukrea_cpuimx35_init() or eukrea_cpuimx51_init().
+ * eukrea_cpuimx35_init() eukrea_cpuimx51_init()
+ * or eukrea_cpuimx51sd_init().
  *
  * This example here is for the development board. Refer
  * mach-mx25/eukrea_mbimxsd-baseboard.c for cpuimx25
  * mach-imx/eukrea_mbimx27-baseboard.c for cpuimx27
  * mach-mx3/eukrea_mbimxsd-baseboard.c for cpuimx35
  * mach-mx5/eukrea_mbimx51-baseboard.c for cpuimx51
+ * mach-mx5/eukrea_mbimxsd-baseboard.c for cpuimx51sd
  */
 
 extern void eukrea_mbimxsd25_baseboard_init(void);
 extern void eukrea_mbimx27_baseboard_init(void);
 extern void eukrea_mbimxsd35_baseboard_init(void);
 extern void eukrea_mbimx51_baseboard_init(void);
+extern void eukrea_mbimxsd51_baseboard_init(void);
 
 #endif
 
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index d9bd37e..9dd9c20 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -99,6 +99,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 		uart_base = MX3X_UART2_BASE_ADDR;
 		break;
 	case MACH_TYPE_MX51_BABBAGE:
+	case MACH_TYPE_EUKREA_CPUIMX51SD:
 		uart_base = MX51_UART1_BASE_ADDR;
 		break;
 	default:
-- 
1.7.0.4
