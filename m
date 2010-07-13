From: andrei.pushkin@promwad.com (Andrew Pushkin)
Date: Tue, 13 Jul 2010 19:13:38 +0300
Subject: [PATCH] Added support board sbc9261-I v2
In-Reply-To: <Added support board sbc9261-I v2>
References: <Added support board sbc9261-I v2>
Message-ID: <1279037618-6293-1-git-send-email-andrei.pushkin@promwad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added support board sbc9261 http://www.embedinfo.com/English/product/sbc9261-i.asp .

Signed-off-by: Andrew Pushkin <andrei.pushkin@promwad.com>
---
 arch/arm/mach-at91/Kconfig         |   35 ++
 arch/arm/mach-at91/Makefile        |    3 +
 arch/arm/mach-at91/board-sbc9261.c |  680 ++++++++++++++++++++++++++++++++++++
 3 files changed, 718 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-at91/board-sbc9261.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 841eaf8..3243f79 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -264,6 +264,41 @@ config MACH_AT91SAM9261EK
 	  Select this if you are using Atmel's AT91SAM9261-EK Evaluation Kit.
 	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=3820>
 
+config MACH_SBC9261
+	bool "Embest SBC9261 Board"
+	depends on ARCH_AT91SAM9261
+	help
+	  Select this if you are using Embest sbc9261 board.
+	  <http://www.embedinfo.com/English/product/sbc9261-i.asp>
+
+choice
+	prompt "sbc9261 master clock "
+	depends on MACH_SBC9261
+	default SBC9261_100MHz
+
+config SBC9261_100MHz
+	bool "99.5328 MHz"
+
+config SBC9261_120MHz
+	bool "119.8080 MHz"
+
+endchoice
+
+choice
+	prompt "sbc9261 boot mode"
+	depends on MACH_SBC9261
+	default DATAFLASH_BOOT
+
+config DATAFLASH_BOOT
+	bool "dataflash boot"
+
+config NANDFLASH_BOOT
+	bool "nandflash boot"
+
+endchoice
+
+
+
 endif
 
 # ----------------------------------------------------------
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index c1f821e..98dfafa 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -78,6 +78,9 @@ obj-$(CONFIG_MACH_AT572D940HFEB) += board-at572d940hf_ek.o
 # AT91X40 board-specific support
 obj-$(CONFIG_MACH_AT91EB01)	+= board-eb01.o
 
+# AT91SAM9RL board-specific support
+obj-$(CONFIG_MACH_SBC9261) 		+= board-sbc9261.o
+
 # Drivers
 obj-y				+= leds.o
 
diff --git a/arch/arm/mach-at91/board-sbc9261.c b/arch/arm/mach-at91/board-sbc9261.c
new file mode 100644
index 0000000..8621655
--- /dev/null
+++ b/arch/arm/mach-at91/board-sbc9261.c
@@ -0,0 +1,680 @@
+/*
+ * linux/arch/arm/mach-at91/board-sbc9261.c
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2006 Atmel
+ *  Copyright (C) 2010 Promwad (adapted for kernel 2.6.35)
+ *
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
+
+#if defined(CONFIG_CAN_MCP251X)
+#include <linux/can/platform/mcp251x.h>
+#endif
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+#include <linux/spi/at73c213.h>
+#include <linux/clk.h>
+#include <linux/dm9000.h>
+#include <linux/fb.h>
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+
+#include <video/atmel_lcdc.h>
+
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/irq.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/board.h>
+#include <mach/gpio.h>
+#include <mach/at91sam9_smc.h>
+#include <mach/at91_shdwc.h>
+
+#include "sam9_smc.h"
+#include "generic.h"
+
+#include <video/atmel_lcdc.h>
+
+#include <linux/gpio_keys.h>
+#include <linux/input.h>
+
+static void __init sbc9261_map_io(void)
+{
+	/* Initialize processor: 18.432 MHz crystal */
+	at91sam9261_initialize(18432000);
+
+	/* Setup the LEDs */
+	at91_init_leds(AT91_PIN_PA15, AT91_PIN_PA16);
+
+	/* DBGU on ttyS0.(Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* set serial console to ttyS0(ie, DBGU) */
+	at91_set_serial_console(0);
+
+}
+
+static void __init sbc9261_init_irq(void)
+{
+	/* Initialize AIC controller */
+	at91sam9261_init_interrupts(NULL);
+}
+
+static struct gpio_led sbc9261_leds[] = {
+	{
+		.name		= "led0",
+		.gpio		= AT91_PIN_PA16,
+		.default_trigger	= "heartbeat",
+	},
+	{
+		.name		= "led1",
+		.gpio		= AT91_PIN_PA15,
+		.default_trigger	= "heartbeat",
+	}
+};
+
+/*
+ * DM9000 ethernet device
+ */
+#if defined(CONFIG_DM9000)
+
+/* EBI Chip Select 2 base address */
+#define AT91C_EBI_CS2(0x30000000)
+
+static struct resource sbc9261_dm9000_resource[] = {
+	[0] = {
+		.start	= AT91_CHIPSELECT_2,
+		.end	= AT91_CHIPSELECT_2 + 3,
+		.flags	= IORESOURCE_MEM
+	},
+	[1] = {
+		.start	= AT91_CHIPSELECT_2 + 4,
+		.end	= AT91_CHIPSELECT_2 + 7,
+		.flags	= IORESOURCE_MEM
+	},
+	[2] = {
+		.start	= AT91_PIN_PC11,
+		.end	= AT91_PIN_PC11,
+		.flags	= IORESOURCE_IRQ
+	}
+};
+
+static struct dm9000_plat_data sbc9261_dm9000_platdata = {
+	.flags		= DM9000_PLATF_16BITONLY,
+};
+
+static struct platform_device sbc9261_dm9000_device = {
+	.name		= "dm9000",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(sbc9261_dm9000_resource),
+	.resource	= sbc9261_dm9000_resource,
+	.dev		= {
+		.platform_data	= &sbc9261_dm9000_platdata,
+	}
+};
+
+static void __init sbc9261_add_device_dm9000(void)
+{
+	/*
+	 * Configure Chip-Select 2 on SMC for the DM9000.
+	 * Note: These timings were calculated for MASTER_CLOCK = 100000000
+	 *  according to the DM9000 timings.
+	 */
+	at91_sys_write(AT91_SMC_SETUP(2), \
+					AT91_SMC_NWESETUP_(2) |
+					AT91_SMC_NCS_WRSETUP_(0) |
+					AT91_SMC_NRDSETUP_(2) |
+					AT91_SMC_NCS_RDSETUP_(0));
+	at91_sys_write(AT91_SMC_PULSE(2), \
+					AT91_SMC_NWEPULSE_(4) |
+					AT91_SMC_NCS_WRPULSE_(8) |
+					AT91_SMC_NRDPULSE_(4) |
+					AT91_SMC_NCS_RDPULSE_(8));
+	at91_sys_write(AT91_SMC_CYCLE(2),
+					AT91_SMC_NWECYCLE_(16) |
+					AT91_SMC_NRDCYCLE_(16));
+	at91_sys_write(AT91_SMC_MODE(2),
+					AT91_SMC_READMODE |
+					AT91_SMC_WRITEMODE |
+					AT91_SMC_EXNWMODE_DISABLE |
+					AT91_SMC_BAT_WRITE |
+					AT91_SMC_DBW_16 |
+					AT91_SMC_TDF_(1));
+
+	/* Configure Reset signal as output */
+	at91_set_gpio_output(AT91_PIN_PC10, 0);
+
+	/* Configure Interrupt pin as input, no pull-up */
+	at91_set_gpio_input(AT91_PIN_PC11, 0);
+
+	platform_device_register(&sbc9261_dm9000_device);
+}
+#else
+static void __init sbc9261_add_device_dm9000(void) {}
+#endif /* CONFIG_DM9000 */
+
+
+/*
+ * USB Host Port
+ */
+static struct at91_usbh_data __initdata sbc9261_usbh_data = {
+	.ports		= 2,
+};
+
+/*
+ * USB Device Port
+ */
+static struct at91_udc_data __initdata sbc9261_udc_data = {
+	.vbus_pin	= AT91_PIN_PA15,
+	.pullup_pin	= 0,		/* pull-up driven by UDC */
+};
+
+/*
+ * NAND flash
+ */
+static struct mtd_partition __initdata
+sbc9261_nand_partition[] = {
+#if defined(CONFIG_DATAFLASH_BOOT)
+	{
+		.name	= "ramdisk",
+		.offset	= 0,
+		.size	= 4 * SZ_1M,
+	},
+#endif
+#if defined(CONFIG_NANDFLASH_BOOT)
+	{
+		.name = "bootstrap",
+		.offset = 0,
+		.size   = SZ_128K,
+	},
+	{
+		.name = "uboot",
+		.offset = SZ_128K,
+		.size = SZ_256K,
+	},
+	{
+		.name = "env1",
+		.offset = SZ_128K * 3,
+		.size = SZ_128K,
+	},
+
+	{
+		.name = "env2",
+		.offset = SZ_128K * 4,
+		.size = SZ_128K,
+	},
+	{
+		 .name   = "kernel",
+		 .offset = SZ_128K * 5,
+		 .size   = 2 * SZ_1M,
+	},
+#endif
+	{
+		.name	= "yaffs",
+		.offset	= 4 * SZ_1M,
+		.size	= 252 * SZ_1M,
+	},
+};
+
+static struct mtd_partition * __init nand_partitions(int size,
+						     int *num_partitions)
+{
+	*num_partitions = ARRAY_SIZE(sbc9261_nand_partition);
+	return sbc9261_nand_partition;
+}
+
+static struct atmel_nand_data __initdata sbc9261_nand_data = {
+	.ale		= 22,
+	.cle		= 21,
+	.rdy_pin	= AT91_PIN_PC15,
+	.enable_pin	= AT91_PIN_PC14,
+	.partition_info	= nand_partitions,
+#if defined(CONFIG_MTD_NAND_AT91_BUSWIDTH_16)
+	.bus_width_16	= 1,
+#else
+	.bus_width_16	= 0,
+#endif
+};
+
+#if defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)
+#if defined(CONFIG_SPI_TSC2301) || defined(CONFIG_SPI_TSC2301_MODULE)
+#include <linux/spi/tsc2301.h>
+
+static int sbc9261_get_keyb_irq_state(struct device *dev)
+{
+	return !at91_get_gpio_value(AT91_PIN_PA14);
+}
+
+static struct tsc2301_platform_data tsc2301_config = {
+	.dav_gpio	= AT91_PIN_PB29,
+	.keymap = {
+		KEY_F1,		/* Event for bit 0 */
+		KEY_F5,		/* Event for bit 1 */
+		KEY_F2,		/* Event for bit 2 */
+		KEY_F3,		/* Event for bit 3 */
+		KEY_F4,		/* Event for bit 4 */
+		KEY_F9,		/* Event for bit 5 */
+		KEY_F8,		/* Event for bit 6 */
+		KEY_F6,		/* Event for bit 7 */
+		KEY_F7,		/* Event for bit 8 */
+		KEY_F10,	/* Event for bit 9 */
+		KEY_UP,		/* Event for bit 10 (up) */
+		KEY_DOWN,	/* Event for bit 11 (down) */
+		KEY_ESC,	/* Event for bit 12 (cycle) */
+		KEY_LEFT,	/* Event for bit 13 (left) */
+		KEY_ENTER,	/* Event for bit 14 (enter) */
+		KEY_RIGHT,	/* Event for bit 15 (right) */
+	},
+	.kp_rep	= 0,
+	.keyb_int = AT91_PIN_PA14,
+	.get_keyb_irq_state = sbc9261_get_keyb_irq_state,
+};
+#endif
+
+/*
+ * SPI devices.
+ */
+
+int mcp251x_setup(struct spi_device *spi)
+{
+	printk(KERN_INFO "mcp251x_setup\n");
+	return 0;
+}
+
+int mcp251x_power_enable(int enable)
+{
+	printk(KERN_INFO "mcp251x_power_enable\n");
+	return 0;
+}
+
+
+#if defined(CONFIG_CAN_MCP251X) || defined(CONFIG_CAN_MCP251X_MODULE)
+static struct mcp251x_platform_data mcp251x_data = {
+	.oscillator_frequency = 12 * 1000 * 1000,
+	.model = CAN_MCP251X_MCP2510,
+    .board_specific_setup = &mcp251x_setup,
+    .power_enable = mcp251x_power_enable,
+    .transceiver_enable = NULL,
+};
+#endif
+
+static struct spi_board_info sbc9261_spi_devices[] = {
+/*	{	/* DataFlash chip*/
+		.modalias	= "mtd_dataflash",
+		.chip_select	= 0,
+		.max_speed_hz	= 15 * 1000 * 1000,
+		.bus_num	= 0,
+	},
+#if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
+	{	/* SPI MMC card */
+		.modalias	= "mmc_spi",
+		.chip_select	= 1,
+		.max_speed_hz	= 20 * 1000 * 1000,
+		.bus_num	= 0,
+		.irq		= AT91_PIN_PA22,
+	},
+#endif
+#if defined(CONFIG_SPI_TSC2301) || defined(CONFIG_SPI_TSC2301_MODULE)
+	{	/* TSC2301PAG - touchscreen,sound */
+		.modalias	= "tsc2301",
+		.chip_select	= 2,
+		.max_speed_hz	= 2 * 1000 * 1000,
+		.bus_num	= 0,
+		.platform_data  = &tsc2301_config,
+		.irq		= AT91_PIN_PB29,
+	},
+#endif
+#if defined(CONFIG_CAN_MCP251X) || defined(CONFIG_CAN_MCP251X_MODULE)
+	{
+		.modalias = "mcp251x",
+		.chip_select = 3,
+		.irq = AT91_PIN_PB30,
+		.platform_data = &mcp251x_data,
+		.max_speed_hz = 5 * 1000 * 1000,
+		.bus_num = 0,
+		.mode = 0,
+	},
+#endif
+};
+#endif
+
+
+/*
+ * LCD Controller
+ */
+#if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
+
+#if defined(CONFIG_FB_320x240) || defined(CONFIG_FB_320x240_MODULE)
+
+static struct fb_videomode at91_tft_vga_modes[] = {
+	{
+	     .name    = "TX09D50VM1CCA @ 60",
+		.refresh	= 60,
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= KHZ2PICOS(4965),
+
+		.left_margin	= 17,
+		.right_margin	= 11,
+		.upper_margin	= 4,
+		.lower_margin	= 7,
+		.hsync_len	= 5,
+		.vsync_len	= 1,
+		.vmode		= FB_VMODE_NONINTERLACED,
+	},
+};
+
+#endif
+
+
+#if defined(CONFIG_FB_800x480) || defined(CONFIG_FB_800x480_MODULE)
+
+static struct fb_videomode at91_tft_vga_modes[] = {
+	{
+		.name    = "TX09D50VM1CCA @ 60",
+		.refresh        = 60,
+		.xres           = 800,
+		.yres           = 480,
+		.pixclock       =  KHZ2PICOS(26214)/* (4965) */,
+		.left_margin    = 17,
+		.right_margin   = 11,
+		.upper_margin   = 4,
+		.lower_margin   = 7,
+		.hsync_len      = 5,
+		.vsync_len      = 1,
+		.sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode          = FB_VMODE_NONINTERLACED,
+	},
+};
+
+#endif
+
+
+#if defined(CONFIG_FB_800x600) || defined(CONFIG_FB_800x600_MODULE)
+
+static struct fb_videomode at91_tft_vga_modes[] = {
+	{
+		.name    = "TX09D50VM1CCA @ 60",
+		.refresh        = 60,
+		.xres           = 800,
+		.yres           = 600,
+		.pixclock       =  KHZ2PICOS(26214)/* (4965) */,
+
+		.left_margin    = 17,
+		.right_margin   = 11,
+		.upper_margin   = 4,
+		.lower_margin   = 7,
+
+		.hsync_len      = 5,
+		.vsync_len      = 1,
+
+		.sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.vmode          = FB_VMODE_NONINTERLACED,
+	},
+};
+
+#endif
+
+
+static struct fb_monspecs at91fb_default_monspecs = {
+	.manufacturer   = "HIT",
+	.monitor        = "TX09D70VM1CCA",
+
+	.modedb         = at91_tft_vga_modes,
+	.modedb_len     = ARRAY_SIZE(at91_tft_vga_modes),
+	.hfmin          = 15000,
+	.hfmax          = 64000,
+	.vfmin          = 50,
+	.vfmax          = 150,
+};
+
+
+#define AT91SAM9261_DEFAULT_LCDCON2	(ATMEL_LCDC_MEMOR_LITTLE \
+					| ATMEL_LCDC_DISTYPE_TFT  \
+					| ATMEL_LCDC_CLKMOD_ALWAYSACTIVE)
+
+static void at91_lcdc_power_control(int on)
+{
+	at91_set_gpio_output(AT91_PIN_PB21, 1);
+	at91_set_gpio_output(AT91_PIN_PB4, 1);
+	at91_set_gpio_value(AT91_PIN_PB4, 0);
+	if (on)
+		at91_set_gpio_value(AT91_PIN_PB21, 0);	/* power up */
+	else
+		at91_set_gpio_value(AT91_PIN_PB21, 1);	/* power down */
+}
+
+/* Driver datas */
+static struct atmel_lcdfb_info __initdata sbc9261_lcdc_data = {
+	.default_bpp			=   24,
+	.default_dmacon			= ATMEL_LCDC_DMAEN,
+	.default_lcdcon2		= AT91SAM9261_DEFAULT_LCDCON2,
+	.default_monspecs		= &at91fb_default_monspecs,
+	.atmel_lcdfb_power_control	= at91_lcdc_power_control,
+	.guard_time			= 0x0c,
+};
+
+#else
+static struct atmel_lcdfb_info __initdata sbc9261_lcdc_data;
+#endif
+
+/*
+ * GPIO Buttons
+ */
+#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
+static struct gpio_keys_button sbc9261_buttons[] = {
+	{
+		.gpio		= AT91_PIN_PA27,
+		.code		= BTN_0,
+		.desc		= "Button 0",
+		.active_low	= 1,
+	},
+	{
+		.gpio		= AT91_PIN_PA28,
+		.code		= BTN_1,
+		.desc		= "Button 1",
+		.active_low	= 1,
+	},
+};
+
+static struct gpio_keys_platform_data sbc9261_button_data = {
+	.buttons	= sbc9261_buttons,
+	.nbuttons	= ARRAY_SIZE(sbc9261_buttons),
+};
+
+static struct platform_device sbc9261_button_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &sbc9261_button_data,
+	}
+};
+
+static void __init sbc9261_add_device_buttons(void)
+{
+	at91_set_gpio_input(AT91_PIN_PA27, 1);	/* btn0 */
+	at91_set_deglitch(AT91_PIN_PA27, 1);
+	at91_set_gpio_input(AT91_PIN_PA28, 1);	/* btn1 */
+	at91_set_deglitch(AT91_PIN_PA28, 1);
+	platform_device_register(&sbc9261_button_device);
+}
+#else
+static void __init sbc9261_add_device_buttons(void) {}
+#endif
+
+#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE)
+
+static struct at91_cf_data sbc9261_cf_data = {
+	.det_pin	= AT91_PIN_PA23,
+	.irq_pin	= AT91_PIN_PA25,
+	.chipselect	= 4,
+};
+
+static struct resource sbc9261_cf_resources[] = {
+	[0] = {
+		.start	= AT91_CHIPSELECT_4,
+		.end	= AT91_CHIPSELECT_4 + (0x10000000 - 1),
+		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT,
+	},
+};
+
+static struct platform_device sbc9261_cf_device = {
+	.name		= "at91_cf",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &sbc9261_cf_data,
+	},
+	.resource	= sbc9261_cf_resources,
+	.num_resources	= ARRAY_SIZE(sbc9261_cf_resources),
+};
+
+#if 1
+#define CF_NWE_SETUP	(9 << 0)
+#define CF_NCS_WR_SETUP	(2 << 8)
+#define CF_NRD_SETUP	(9 << 16)
+#define CF_NCS_RD_SETUP	(2 << 24)
+
+#define CF_NWE_PULSE	(17 << 0)
+#define CF_NCS_WR_PULSE	(27 << 8)
+#define CF_NRD_PULSE	(17 << 16)
+#define CF_NCS_RD_PULSE	(27 << 24)
+
+#define CF_NWE_CYCLE	(40 << 0)
+#define CF_NRD_CYCLE	(40 << 16)
+
+#define CF_TDF		(1 << 16)
+
+#else
+#define CF_NWE_SETUP	(7 << 0)
+#define CF_NCS_WR_SETUP	(0 << 8)
+#define CF_NRD_SETUP	(7 << 16)
+#define CF_NCS_RD_SETUP	(0 << 24)
+#define CF_NWE_PULSE	(17 << 0)
+#define CF_NCS_WR_PULSE	(27 << 8)
+#define CF_NRD_PULSE	(17 << 16)
+#define CF_NCS_RD_PULSE	(27 << 24)
+#define CF_NWE_CYCLE	(38 << 0)
+#define CF_NRD_CYCLE	(38 << 16)
+#define CF_TDF		(0 << 16)
+#endif
+
+static void __init sbc9261_add_device_cf(void)
+{
+	struct at91_cf_data *data = &sbc9261_cf_data;
+	unsigned int csa;
+/*first enable the address range of CS4 in HMATRIX user interface */
+	csa = at91_sys_read(AT91_MATRIX_EBICSA);
+	at91_sys_write(AT91_MATRIX_EBICSA, csa|AT91_MATRIX_CS4A_SMC_CF1);
+
+	/* Configure SMC CS4 */
+	at91_sys_write(AT91_SMC_SETUP(4),
+				(CF_NWE_SETUP |
+				CF_NCS_WR_SETUP |
+				CF_NRD_SETUP |
+				CF_NCS_RD_SETUP));
+
+	at91_sys_write(AT91_SMC_PULSE(4), (CF_NWE_PULSE |
+					CF_NCS_WR_PULSE |
+					CF_NRD_PULSE |
+					CF_NCS_RD_PULSE));
+	at91_sys_write(AT91_SMC_CYCLE(4),
+			(CF_NWE_CYCLE | CF_NRD_CYCLE));
+	/* 16 bit */
+	at91_sys_write(AT91_SMC_MODE(4), (AT91_SMC_READMODE |
+					AT91_SMC_WRITEMODE |
+					AT91_SMC_EXNWMODE_DISABLE |
+					AT91_SMC_DBW_16 |
+					CF_TDF));
+
+	/* input/irq */
+	if (data->irq_pin) {
+		at91_set_gpio_input(data->irq_pin, 0);
+		at91_set_deglitch(data->irq_pin, 1);
+	}
+	at91_set_gpio_input(data->det_pin, 0);
+	at91_set_deglitch(data->det_pin, 1);
+
+	/* outputs, initially off */
+	if (data->vcc_pin)
+		at91_set_gpio_output(data->vcc_pin, 0);
+	if (data->rst_pin)
+		at91_set_gpio_output(data->rst_pin, 0);
+
+	/* force poweron defaults for these pins ... */
+	at91_set_A_periph(AT91_PIN_PC2, 1);	/* PC2/CF_NWAIT */
+	at91_set_A_periph(AT91_PIN_PC3, 1);	/* A25/CFRNW */
+	at91_set_A_periph(AT91_PIN_PC4, 1);	/* NCS4/CFCS0 */
+	at91_set_A_periph(AT91_PIN_PC6, 1);	/* PC6/CFCE1 */
+	at91_set_A_periph(AT91_PIN_PC7, 1);	/* PC7/CFCE2 */
+
+	platform_device_register(&sbc9261_cf_device);
+}
+#else
+void __init sbc9261_add_device_cf(void) {}
+#endif
+
+
+static void __init sbc9261_board_init(void)
+{
+	/* Serial */
+	at91_add_device_serial();
+	/* USB Host */
+	at91_add_device_usbh(&sbc9261_usbh_data);
+	/* USB Device */
+	at91_add_device_udc(&sbc9261_udc_data);
+	/* I2C */
+	at91_add_device_i2c(NULL, 0);
+	/* NAND */
+	at91_add_device_nand(&sbc9261_nand_data);
+	/* DM9000 ethernet */
+	sbc9261_add_device_dm9000();
+	/* LED */
+	at91_gpio_leds(sbc9261_leds, ARRAY_SIZE(sbc9261_leds));
+	/* LCD Controller */
+	at91_add_device_lcdc(&sbc9261_lcdc_data);
+	/* BUTTON */
+	sbc9261_add_device_buttons();
+	/* spi0 and mmc/sd share the same PIO pins */
+	at91_add_device_spi(sbc9261_spi_devices,
+			    ARRAY_SIZE(sbc9261_spi_devices));
+	/* CF */
+	sbc9261_add_device_cf();
+}
+
+MACHINE_START(SBC9261, "SBC9261")
+	/* Maintainer: Atmel */
+	.phys_io	= AT91_BASE_SYS,
+	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= sbc9261_map_io,
+	.init_irq	= sbc9261_init_irq,
+	.init_machine	= sbc9261_board_init,
+MACHINE_END
-- 
1.7.1
