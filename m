From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 10 Jun 2010 16:07:50 +0200
Subject: [PATCH] i.MX35: add cpuimx35 support and its baseboard
Message-ID: <1276178870-10202-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* cpuimx35 integrates i.MX35, RAM, NAND, Ethernet, I2C RTC, USB Host,
USB OTG and I2C touchscreen controller
* mbimxsd provides access to LCD, Audio, LED, Switch button, UART ...

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx3/Kconfig                          |   22 ++
 arch/arm/mach-mx3/Makefile                         |    2 +
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c       |  263 ++++++++++++++++++++
 arch/arm/mach-mx3/mach-cpuimx35.c                  |  227 +++++++++++++++++
 .../plat-mxc/include/mach/board-eukrea_cpuimx35.h  |   40 +++
 5 files changed, 554 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
 create mode 100644 arch/arm/mach-mx3/mach-cpuimx35.c
 create mode 100644 arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 344753f..b09e9a9 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -125,4 +125,26 @@ config MACH_KZM_ARM11_01
 	  Include support for KZM-ARM11-01. This includes specific
 	  configurations for the board and its peripherals.
 
+config MACH_EUKREA_CPUIMX35
+	bool "Support Eukrea CPUIMX35 Platform"
+	select ARCH_MX35
+	select MXC_ULPI if USB_ULPI
+	help
+	  Include support for Eukrea CPUIMX35 platform. This includes
+	  specific configurations for the board and its peripherals.
+
+choice
+	prompt "Baseboard"
+	depends on MACH_EUKREA_CPUIMX35
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
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 5d650fd..ef68ff5 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -24,3 +24,5 @@ obj-$(CONFIG_MACH_PCM043)	+= mach-pcm043.o
 obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
 obj-$(CONFIG_MACH_MX35_3DS)	+= mach-mx35pdk.o
 obj-$(CONFIG_MACH_KZM_ARM11_01)	+= mach-kzm_arm11_01.o
+obj-$(CONFIG_MACH_EUKREA_CPUIMX35)	+= mach-cpuimx35.o
+obj-$(CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD)	+= eukrea_mbimxsd-baseboard.o
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
new file mode 100644
index 0000000..6785978
--- /dev/null
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -0,0 +1,263 @@
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
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+#include <video/platform_lcd.h>
+#include <linux/i2c.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+
+#include <mach/board-eukrea_cpuimx35.h>
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx35.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
+#include <mach/audmux.h>
+#include <mach/ssi.h>
+
+#include "devices.h"
+
+static const struct fb_videomode fb_modedb[] = {
+	{
+		.name		= "CMO_QVGA",
+		.refresh	= 60,
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= KHZ2PICOS(6500),
+		.left_margin	= 68,
+		.right_margin	= 20,
+		.upper_margin	= 15,
+		.lower_margin	= 4,
+		.hsync_len	= 30,
+		.vsync_len	= 3,
+		.sync		= 0,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.name		= "CMO_QVGA",
+	.mode		= fb_modedb,
+	.num_modes	= ARRAY_SIZE(fb_modedb),
+};
+
+static struct pad_desc eukrea_mbimxsd_pads[] = {
+	/* LCD */
+	MX35_PAD_LD0__IPU_DISPB_DAT_0,
+	MX35_PAD_LD1__IPU_DISPB_DAT_1,
+	MX35_PAD_LD2__IPU_DISPB_DAT_2,
+	MX35_PAD_LD3__IPU_DISPB_DAT_3,
+	MX35_PAD_LD4__IPU_DISPB_DAT_4,
+	MX35_PAD_LD5__IPU_DISPB_DAT_5,
+	MX35_PAD_LD6__IPU_DISPB_DAT_6,
+	MX35_PAD_LD7__IPU_DISPB_DAT_7,
+	MX35_PAD_LD8__IPU_DISPB_DAT_8,
+	MX35_PAD_LD9__IPU_DISPB_DAT_9,
+	MX35_PAD_LD10__IPU_DISPB_DAT_10,
+	MX35_PAD_LD11__IPU_DISPB_DAT_11,
+	MX35_PAD_LD12__IPU_DISPB_DAT_12,
+	MX35_PAD_LD13__IPU_DISPB_DAT_13,
+	MX35_PAD_LD14__IPU_DISPB_DAT_14,
+	MX35_PAD_LD15__IPU_DISPB_DAT_15,
+	MX35_PAD_LD16__IPU_DISPB_DAT_16,
+	MX35_PAD_LD17__IPU_DISPB_DAT_17,
+	MX35_PAD_D3_HSYNC__IPU_DISPB_D3_HSYNC,
+	MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK,
+	MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY,
+	MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC,
+	/* Backlight */
+	MX35_PAD_CONTRAST__IPU_DISPB_CONTR,
+	/* LCD_PWR */
+	MX35_PAD_D3_CLS__GPIO1_4,
+	/* LED */
+	MX35_PAD_LD23__GPIO3_29,
+	/* SWITCH */
+	MX35_PAD_LD19__GPIO3_25,
+	/* UART2 */
+	MX35_PAD_CTS2__UART2_CTS,
+	MX35_PAD_RTS2__UART2_RTS,
+	MX35_PAD_TXD2__UART2_TXD_MUX,
+	MX35_PAD_RXD2__UART2_RXD_MUX,
+	/* I2S */
+	MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS,
+	MX35_PAD_STXD4__AUDMUX_AUD4_TXD,
+	MX35_PAD_SRXD4__AUDMUX_AUD4_RXD,
+	MX35_PAD_SCK4__AUDMUX_AUD4_TXC,
+};
+
+#define GPIO_LED1	(2 * 32 + 29)
+#define GPIO_SWITCH1	(2 * 32 + 25)
+#define GPIO_LCDPWR	(4)
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
+ * system init for baseboard usage. Will be called by cpuimx35 init.
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
+	/* SSI unit master I2S codec connected to SSI_AUD4 */
+	mxc_audmux_v2_configure_port(0,
+			MXC_AUDMUX_V2_PTCR_SYN |
+			MXC_AUDMUX_V2_PTCR_TFSDIR |
+			MXC_AUDMUX_V2_PTCR_TFSEL(3) |
+			MXC_AUDMUX_V2_PTCR_TCLKDIR |
+			MXC_AUDMUX_V2_PTCR_TCSEL(3),
+			MXC_AUDMUX_V2_PDCR_RXDSEL(3)
+	);
+	mxc_audmux_v2_configure_port(3,
+			MXC_AUDMUX_V2_PTCR_SYN,
+			MXC_AUDMUX_V2_PDCR_RXDSEL(0)
+	);
+#endif
+
+	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+
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
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
new file mode 100644
index 0000000..26fc976
--- /dev/null
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -0,0 +1,227 @@
+/*
+ * Copyright (C) 2010 Eric Benard - eric at eukrea.com
+ * Copyright (C) 2009 Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/memory.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i2c/tsc2007.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+
+#include <mach/board-eukrea_cpuimx35.h>
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/i2c.h>
+#include <mach/iomux-mx35.h>
+#include <mach/mxc_nand.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
+
+#include "devices.h"
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct imxi2c_platform_data eukrea_cpuimx35_i2c_1_data = {
+	.bitrate = 50000,
+};
+
+#define TSC2007_IRQGPIO		(2 * 32 + 2)
+static int ts_get_pendown_state(void)
+{
+	int val = 0;
+	gpio_free(TSC2007_IRQGPIO);
+	gpio_request(TSC2007_IRQGPIO, NULL);
+	gpio_direction_input(TSC2007_IRQGPIO);
+
+	val = gpio_get_value(TSC2007_IRQGPIO);
+
+	gpio_free(TSC2007_IRQGPIO);
+	gpio_request(TSC2007_IRQGPIO, NULL);
+
+	return val ? 0 : 1;
+}
+
+static int ts_init(void)
+{
+	gpio_request(TSC2007_IRQGPIO, NULL);
+	return 0;
+}
+
+static struct tsc2007_platform_data tsc2007_info = {
+	.model			= 2007,
+	.x_plate_ohms		= 180,
+	.get_pendown_state	= ts_get_pendown_state,
+	.init_platform_hw	= ts_init,
+};
+
+static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("pcf8563", 0x51),
+	}, {
+		I2C_BOARD_INFO("tsc2007", 0x48),
+		.type		= "tsc2007",
+		.platform_data	= &tsc2007_info,
+		.irq		= gpio_to_irq(TSC2007_IRQGPIO),
+	},
+};
+
+static struct platform_device *devices[] __initdata = {
+	&mxc_fec_device,
+	&imx_wdt_device0,
+};
+
+static struct pad_desc eukrea_cpuimx35_pads[] = {
+	/* UART1 */
+	MX35_PAD_CTS1__UART1_CTS,
+	MX35_PAD_RTS1__UART1_RTS,
+	MX35_PAD_TXD1__UART1_TXD_MUX,
+	MX35_PAD_RXD1__UART1_RXD_MUX,
+	/* FEC */
+	MX35_PAD_FEC_TX_CLK__FEC_TX_CLK,
+	MX35_PAD_FEC_RX_CLK__FEC_RX_CLK,
+	MX35_PAD_FEC_RX_DV__FEC_RX_DV,
+	MX35_PAD_FEC_COL__FEC_COL,
+	MX35_PAD_FEC_RDATA0__FEC_RDATA_0,
+	MX35_PAD_FEC_TDATA0__FEC_TDATA_0,
+	MX35_PAD_FEC_TX_EN__FEC_TX_EN,
+	MX35_PAD_FEC_MDC__FEC_MDC,
+	MX35_PAD_FEC_MDIO__FEC_MDIO,
+	MX35_PAD_FEC_TX_ERR__FEC_TX_ERR,
+	MX35_PAD_FEC_RX_ERR__FEC_RX_ERR,
+	MX35_PAD_FEC_CRS__FEC_CRS,
+	MX35_PAD_FEC_RDATA1__FEC_RDATA_1,
+	MX35_PAD_FEC_TDATA1__FEC_TDATA_1,
+	MX35_PAD_FEC_RDATA2__FEC_RDATA_2,
+	MX35_PAD_FEC_TDATA2__FEC_TDATA_2,
+	MX35_PAD_FEC_RDATA3__FEC_RDATA_3,
+	MX35_PAD_FEC_TDATA3__FEC_TDATA_3,
+	/* I2C1 */
+	MX35_PAD_I2C1_CLK__I2C1_SCL,
+	MX35_PAD_I2C1_DAT__I2C1_SDA,
+	/* TSC2007 IRQ */
+	MX35_PAD_ATA_DA2__GPIO3_2,
+};
+
+static struct mxc_nand_platform_data pcm037_nand_board_info = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
+static struct mxc_usbh_platform_data otg_pdata = {
+	.portsc	= MXC_EHCI_MODE_UTMI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static struct mxc_usbh_platform_data usbh1_pdata = {
+	.portsc	= MXC_EHCI_MODE_SERIAL,
+	.flags	= MXC_EHCI_INTERFACE_SINGLE_UNI | MXC_EHCI_INTERNAL_PHY |
+		  MXC_EHCI_IPPUE_DOWN,
+};
+
+static struct fsl_usb2_platform_data otg_device_pdata = {
+	.operating_mode	= FSL_USB2_DR_DEVICE,
+	.phy_mode	= FSL_USB2_PHY_UTMI,
+};
+
+static int otg_mode_host;
+
+static int __init eukrea_cpuimx35_otg_mode(char *options)
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
+__setup("otg_mode=", eukrea_cpuimx35_otg_mode);
+
+/*
+ * Board specific initialization.
+ */
+static void __init mxc_board_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx35_pads,
+			ARRAY_SIZE(eukrea_cpuimx35_pads));
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_nand_device, &pcm037_nand_board_info);
+
+	i2c_register_board_info(0, eukrea_cpuimx35_i2c_devices,
+			ARRAY_SIZE(eukrea_cpuimx35_i2c_devices));
+	mxc_register_device(&mxc_i2c_device0, &eukrea_cpuimx35_i2c_1_data);
+
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host) {
+		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+		mxc_register_device(&mxc_otg_host, &otg_pdata);
+	}
+	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+#endif
+	if (!otg_mode_host)
+		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+
+#ifdef CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD
+	eukrea_mbimxsd_baseboard_init();
+#endif
+}
+
+static void __init eukrea_cpuimx35_timer_init(void)
+{
+	mx35_clocks_init();
+}
+
+struct sys_timer eukrea_cpuimx35_timer = {
+	.init	= eukrea_cpuimx35_timer_init,
+};
+
+MACHINE_START(EUKREA_CPUIMX35, "Eukrea CPUIMX35")
+	/* Maintainer: Eukrea Electromatique */
+	.phys_io	= MX35_AIPS1_BASE_ADDR,
+	.io_pg_offst	= ((MX35_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
+	.map_io         = mx35_map_io,
+	.init_irq       = mx35_init_irq,
+	.init_machine   = mxc_board_init,
+	.timer          = &eukrea_cpuimx35_timer,
+MACHINE_END
+
diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h
new file mode 100644
index 0000000..116eee7
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx35.h
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
+#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__
+#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__
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
+#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX35_H__ */
-- 
1.6.3.3
