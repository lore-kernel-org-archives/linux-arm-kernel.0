From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 Jun 2010 11:03:01 +0200
Subject: [PATCH 7/8] i.MX25: add cpuimx25 module and its baseboard
In-Reply-To: <1275987782-16094-6-git-send-email-eric@eukrea.com>
References: <1275987782-16094-1-git-send-email-eric@eukrea.com>
	<1275987782-16094-2-git-send-email-eric@eukrea.com>
	<1275987782-16094-3-git-send-email-eric@eukrea.com>
	<1275987782-16094-4-git-send-email-eric@eukrea.com>
	<1275987782-16094-5-git-send-email-eric@eukrea.com>
	<1275987782-16094-6-git-send-email-eric@eukrea.com>
Message-ID: <1275987782-16094-7-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* cpuimx25 integrates i.MX25, RAM, NAND, Ethernet, I2C RTC, USB Host
and USB OTG
* mbimxsd provides access to LCD, Audio, LED, Switch button, UART ...

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/Kconfig                         |   18 ++
 arch/arm/mach-mx25/Makefile                        |    2 +
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c      |  260 ++++++++++++++++++++
 arch/arm/mach-mx25/mach-cpuimx25.c                 |  172 +++++++++++++
 .../plat-mxc/include/mach/board-eukrea_cpuimx25.h  |   40 +++
 5 files changed, 492 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
 create mode 100644 arch/arm/mach-mx25/mach-cpuimx25.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index 54d2173..3a6668e 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -5,4 +5,22 @@ comment "MX25 platforms:"
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
 
+config MACH_EUKREA_CPUIMX25
+	bool "Support Eukrea CPUIMX25 Platform"
+	select MXC_ULPI if USB_ULPI
+
+choice
+	prompt "Baseboard"
+	depends on MACH_EUKREA_CPUIMX25
+	default MACH_EUKREA_MBIMXSD_BASEBOARD
+
+config MACH_EUKREA_MBIMXSD_BASEBOARD
+	prompt "Eukrea MBIMXSD development board"
+	bool
+	help
+	  This adds board specific devices that can be found on Eukrea's
+	  MBIMXSD evaluation board.
+
+endchoice
+
 endif
diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
index 10cebc5..83ab5d8 100644
--- a/arch/arm/mach-mx25/Makefile
+++ b/arch/arm/mach-mx25/Makefile
@@ -1,3 +1,5 @@
 obj-y				:= mm.o devices.o
 obj-$(CONFIG_ARCH_MX25)		+= clock.o
 obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25pdk.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX25)		+= mach-cpuimx25.o
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
new file mode 100644
index 0000000..e0f0dfd
--- /dev/null
+++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
@@ -0,0 +1,260 @@
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
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <video/platform_lcd.h>
+
+#include <mach/board-eukrea_cpuimx25.h>
+#include <mach/hardware.h>
+#include <mach/iomux-mx25.h>
+#include <mach/common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/mx25.h>
+#include <mach/imx-uart.h>
+#include <mach/imxfb.h>
+#include <mach/ssi.h>
+#include <mach/audmux.h>
+
+#include "devices.h"
+
+static struct pad_desc eukrea_mbimxsd_pads[] = {
+	/* LCD */
+	MX25_PAD_LD0__LD0,
+	MX25_PAD_LD1__LD1,
+	MX25_PAD_LD2__LD2,
+	MX25_PAD_LD3__LD3,
+	MX25_PAD_LD4__LD4,
+	MX25_PAD_LD5__LD5,
+	MX25_PAD_LD6__LD6,
+	MX25_PAD_LD7__LD7,
+	MX25_PAD_LD8__LD8,
+	MX25_PAD_LD9__LD9,
+	MX25_PAD_LD10__LD10,
+	MX25_PAD_LD11__LD11,
+	MX25_PAD_LD12__LD12,
+	MX25_PAD_LD13__LD13,
+	MX25_PAD_LD14__LD14,
+	MX25_PAD_LD15__LD15,
+	MX25_PAD_GPIO_E__LD16,
+	MX25_PAD_GPIO_F__LD17,
+	MX25_PAD_HSYNC__HSYNC,
+	MX25_PAD_VSYNC__VSYNC,
+	MX25_PAD_LSCLK__LSCLK,
+	MX25_PAD_OE_ACD__OE_ACD,
+	MX25_PAD_CONTRAST__CONTRAST,
+	/* LCD_PWR */
+	MX25_PAD_PWM__GPIO_1_26,
+	/* LED */
+	MX25_PAD_POWER_FAIL__GPIO_3_19,
+	/* SWITCH */
+	MX25_PAD_VSTBY_ACK__GPIO_3_18,
+	/* UART2 */
+	MX25_PAD_UART2_RTS__UART2_RTS,
+	MX25_PAD_UART2_CTS__UART2_CTS,
+	MX25_PAD_UART2_TXD__UART2_TXD,
+	MX25_PAD_UART2_RXD__UART2_RXD,
+	/* SD1 */
+	MX25_PAD_SD1_CMD__SD1_CMD,
+	MX25_PAD_SD1_CLK__SD1_CLK,
+	MX25_PAD_SD1_DATA0__SD1_DATA0,
+	MX25_PAD_SD1_DATA1__SD1_DATA1,
+	MX25_PAD_SD1_DATA2__SD1_DATA2,
+	MX25_PAD_SD1_DATA3__SD1_DATA3,
+	/* SD1 CD */
+	MX25_PAD_DE_B__GPIO_2_20,
+	/* I2S */
+	MX25_PAD_KPP_COL3__AUD5_TXFS,
+	MX25_PAD_KPP_COL2__AUD5_TXC,
+	MX25_PAD_KPP_COL1__AUD5_RXD,
+	MX25_PAD_KPP_COL0__AUD5_TXD,
+};
+
+#define GPIO_LED1	83
+#define GPIO_SWITCH1	82
+#define GPIO_SD1CD	52
+#define GPIO_LCDPWR	26
+
+static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
+	{
+		.mode	= {
+			.name		= "CMO-QVGA",
+			.refresh	= 60,
+			.xres		= 320,
+			.yres		= 240,
+			.pixclock	= KHZ2PICOS(6500),
+			.left_margin	= 30,
+			.right_margin	= 38,
+			.upper_margin	= 20,
+			.lower_margin	= 3,
+			.hsync_len	= 15,
+			.vsync_len	= 4,
+		},
+		.bpp	= 16,
+		.pcr	= 0xCAD08B80,
+	},
+};
+
+static struct imx_fb_platform_data eukrea_mximxsd_fb_pdata = {
+	.mode		= eukrea_mximxsd_modes,
+	.num_modes	= ARRAY_SIZE(eukrea_mximxsd_modes),
+	.pwmr		= 0x00A903FF,
+	.lscr1		= 0x00120300,
+	.dmacr		= 0x00040060,
+};
+
+static void eukrea_mbimxsd_lcd_power_set(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power)
+		gpio_direction_output(GPIO_LCDPWR, 1);
+	else
+		gpio_direction_output(GPIO_LCDPWR, 0);
+}
+
+static struct plat_lcd_data eukrea_mbimxsd_lcd_power_data = {
+	.set_power		= eukrea_mbimxsd_lcd_power_set,
+};
+
+static struct platform_device eukrea_mbimxsd_lcd_powerdev = {
+	.name			= "platform-lcd",
+	.dev.platform_data	= &eukrea_mbimxsd_lcd_power_data,
+};
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
+	&eukrea_mbimxsd_lcd_powerdev,
+};
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct i2c_board_info eukrea_mbimxsd_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
+	},
+};
+
+struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
+	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
+};
+
+/*
+ * system init for baseboard usage. Will be called by cpuimx25 init.
+ *
+ * Add platform devices present on this baseboard and init
+ * them from CPU side as far as required to use them later on
+ */
+void __init eukrea_mbimxsd_baseboard_init(void)
+{
+	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd_pads,
+			ARRAY_SIZE(eukrea_mbimxsd_pads)))
+		printk(KERN_ERR "error setting mbimxsd pads !\n");
+
+#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
+	/* SSI unit master I2S codec connected to SSI_AUD5*/
+	mxc_audmux_v2_configure_port(0,
+			MXC_AUDMUX_V2_PTCR_SYN |
+			MXC_AUDMUX_V2_PTCR_TFSDIR |
+			MXC_AUDMUX_V2_PTCR_TFSEL(4) |
+			MXC_AUDMUX_V2_PTCR_TCLKDIR |
+			MXC_AUDMUX_V2_PTCR_TCSEL(4),
+			MXC_AUDMUX_V2_PDCR_RXDSEL(4)
+	);
+	mxc_audmux_v2_configure_port(4,
+			MXC_AUDMUX_V2_PTCR_SYN,
+			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
+	);
+#endif
+
+	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	mxc_register_device(&mx25_fb_device, &eukrea_mximxsd_fb_pdata);
+	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
+
+	gpio_request(GPIO_LED1, "LED1");
+	gpio_direction_output(GPIO_LED1, 1);
+	gpio_free(GPIO_LED1);
+
+	gpio_request(GPIO_SWITCH1, "SWITCH1");
+	gpio_direction_input(GPIO_SWITCH1);
+	gpio_free(GPIO_SWITCH1);
+
+	gpio_request(GPIO_LCDPWR, "LCDPWR");
+	gpio_direction_output(GPIO_LCDPWR, 1);
+	gpio_free(GPIO_SWITCH1);
+
+	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
+				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
+
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+}
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
new file mode 100644
index 0000000..4796484
--- /dev/null
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
+ * Copyright 2010 Eric B?nard - Eukr?a Electromatique, <eric@eukrea.com>
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
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/fec.h>
+#include <linux/platform_device.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/fsl_devices.h>
+
+#include <mach/board-eukrea_cpuimx25.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/memory.h>
+#include <asm/mach/map.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/i2c.h>
+#include <mach/mx25.h>
+#include <mach/mxc_nand.h>
+#include <mach/imxfb.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
+
+#include "devices.h"
+#include <mach/iomux-mx25.h>
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct pad_desc eukrea_cpuimx25_pads[] = {
+	/* FEC - RMII */
+	MX25_PAD_FEC_MDC__FEC_MDC,
+	MX25_PAD_FEC_MDIO__FEC_MDIO,
+	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
+	MX25_PAD_FEC_TDATA1__FEC_TDATA1,
+	MX25_PAD_FEC_TX_EN__FEC_TX_EN,
+	MX25_PAD_FEC_RDATA0__FEC_RDATA0,
+	MX25_PAD_FEC_RDATA1__FEC_RDATA1,
+	MX25_PAD_FEC_RX_DV__FEC_RX_DV,
+	MX25_PAD_FEC_TX_CLK__FEC_TX_CLK,
+	/* I2C1 */
+	MX25_PAD_I2C1_CLK__I2C1_CLK,
+	MX25_PAD_I2C1_DAT__I2C1_DAT,
+};
+
+static struct fec_platform_data mx25_fec_pdata = {
+	.phy	= PHY_INTERFACE_MODE_RMII,
+};
+
+static struct mxc_nand_platform_data eukrea_cpuimx25_nand_board_info = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
+static struct imxi2c_platform_data eukrea_cpuimx25_i2c_1_data = {
+	.bitrate = 100000,
+};
+
+static struct i2c_board_info eukrea_cpuimx25_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pcf8563", 0x51),
+	},
+};
+
+static struct mxc_usbh_platform_data otg_pdata = {
+	.portsc	= MXC_EHCI_MODE_UTMI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.portsc	= MXC_EHCI_MODE_SERIAL,
+	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
+		  MXC_EHCI_IPPUE_DOWN,
+};
+
+static struct fsl_usb2_platform_data otg_device_pdata = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode       = FSL_USB2_PHY_UTMI,
+};
+
+static int otg_mode_host;
+
+static int __init eukrea_cpuimx25_otg_mode(char *options)
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
+__setup("otg_mode=", eukrea_cpuimx25_otg_mode);
+
+static void __init eukrea_cpuimx25_init(void)
+{
+	if (mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx25_pads,
+			ARRAY_SIZE(eukrea_cpuimx25_pads)))
+		printk(KERN_ERR "error setting cpuimx25 pads !\n");
+
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_nand_device, &eukrea_cpuimx25_nand_board_info);
+	mxc_register_device(&mx25_rtc_device, NULL);
+	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
+
+	i2c_register_board_info(0, eukrea_cpuimx25_i2c_devices,
+				ARRAY_SIZE(eukrea_cpuimx25_i2c_devices));
+	mxc_register_device(&mxc_i2c_device0, &eukrea_cpuimx25_i2c_1_data);
+
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host) {
+		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+		mxc_register_device(&mxc_otg, &otg_pdata);
+	}
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+#endif
+	if (!otg_mode_host)
+		mxc_register_device(&otg_udc_device, &otg_device_pdata);
+
+#ifdef CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD
+	eukrea_mbimxsd_baseboard_init();
+#endif
+}
+
+static void __init eukrea_cpuimx25_timer_init(void)
+{
+	mx25_clocks_init();
+}
+
+static struct sys_timer eukrea_cpuimx25_timer = {
+	.init   = eukrea_cpuimx25_timer_init,
+};
+
+MACHINE_START(EUKREA_CPUIMX25, "Eukrea CPUIMX25")
+	/* Maintainer: Eukrea Electromatique */
+	.phys_io	= MX25_AIPS1_BASE_ADDR,
+	.io_pg_offst	= ((MX25_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params    = MX25_PHYS_OFFSET + 0x100,
+	.map_io         = mx25_map_io,
+	.init_irq       = mx25_init_irq,
+	.init_machine   = eukrea_cpuimx25_init,
+	.timer          = &eukrea_cpuimx25_timer,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h
new file mode 100644
index 0000000..5c9901e
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx25.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2010 Eric Benard - eric at eukrea.com
+ *
+ * Based on board-pcm038.h which is :
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
+#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__
+#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__
+
+#ifndef __ASSEMBLY__
+/*
+ * This CPU module needs a baseboard to work. After basic initializing
+ * its own devices, it calls baseboard's init function.
+ * TODO: Add your own baseboard init function and call it from
+ * inside eukrea_cpuimx25_init().
+ *
+ * This example here is for the development board. Refer
+ * eukrea_mbimx25-baseboard.c
+ */
+
+extern void eukrea_mbimxsd_baseboard_init(void);
+
+#endif
+
+#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX25_H__ */
-- 
1.6.3.3
