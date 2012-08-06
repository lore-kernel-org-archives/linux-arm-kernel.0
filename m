From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  6 Aug 2012 15:32:13 -0600
Subject: [PATCH 2/3] ARM: tegra: remove board (but not DT) support for Paz00
In-Reply-To: <1344288734-24131-1-git-send-email-swarren@wwwdotorg.org>
References: <1344288734-24131-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1344288734-24131-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Paz00 (Toshiba AC100) can be booted using device tree with equal
functionality as when booted using a board file. Remove as much of the
board file as is possible, since it's no longer needed.

One special-case is still left in board-dt-tegra20.c, since there is no
way to create a WiFi rfkill device from device tree yet. This logic is
now enabled unconditionally rather than via CONFIG_MACH_PAZ00. The extra
cases where it's enabled (.configs which did not enable Paz00 support)
shouldn't impact much since the amount of code is tiny.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig              |    6 -
 arch/arm/mach-tegra/Makefile             |    3 +-
 arch/arm/mach-tegra/board-dt-tegra20.c   |    4 -
 arch/arm/mach-tegra/board-paz00-pinmux.c |  156 ------------------------
 arch/arm/mach-tegra/board-paz00.c        |  192 ------------------------------
 arch/arm/mach-tegra/board-paz00.h        |   17 +---
 6 files changed, 2 insertions(+), 376 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-paz00-pinmux.c

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 41bc73c..f6e79ed 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -66,12 +66,6 @@ config MACH_HARMONY
        help
          Support for nVidia Harmony development platform
 
-config MACH_PAZ00
-       bool "Paz00 board"
-       depends on ARCH_TEGRA_2x_SOC
-       help
-         Support for the Toshiba AC100/Dynabook AZ netbook
-
 choice
         prompt "Default low-level debug console UART"
         default TEGRA_DEBUG_UART_NONE
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 88ddb75..1c2b473 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -31,5 +31,4 @@ obj-$(CONFIG_MACH_HARMONY)              += board-harmony-pinmux.o
 obj-$(CONFIG_MACH_HARMONY)              += board-harmony-pcie.o
 obj-$(CONFIG_MACH_HARMONY)              += board-harmony-power.o
 
-obj-$(CONFIG_MACH_PAZ00)		+= board-paz00.o
-obj-$(CONFIG_MACH_PAZ00)		+= board-paz00-pinmux.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 422e89e..1d6c9df 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -124,12 +124,10 @@ static void __init harmony_init(void)
 }
 #endif
 
-#ifdef CONFIG_MACH_PAZ00
 static void __init paz00_init(void)
 {
 	tegra_paz00_wifikill_init();
 }
-#endif
 
 static struct {
 	char *machine;
@@ -139,9 +137,7 @@ static struct {
 #ifdef CONFIG_MACH_HARMONY
 	{ "nvidia,harmony", harmony_init },
 #endif
-#ifdef CONFIG_MACH_PAZ00
 	{ "compal,paz00", paz00_init },
-#endif
 };
 
 static void __init tegra_dt_init_late(void)
diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
deleted file mode 100644
index 6f1111b..0000000
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- * arch/arm/mach-tegra/board-paz00-pinmux.c
- *
- * Copyright (C) 2010 Marc Dietrich <marvin24@gmx.de>
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/kernel.h>
-
-#include "board-paz00.h"
-#include "board-pinmux.h"
-
-static struct pinctrl_map paz00_map[] = {
-	TEGRA_MAP_MUXCONF("ata",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("atb",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("atc",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("atd",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("ate",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("cdev1", "plla_out",      none, driven),
-	TEGRA_MAP_MUXCONF("cdev2", "pllp_out4",     down, driven),
-	TEGRA_MAP_MUXCONF("crtp",  "crt",           none, tristate),
-	TEGRA_MAP_MUXCONF("csus",  "pllc_out1",     down, tristate),
-	TEGRA_MAP_MUXCONF("dap1",  "dap1",          none, driven),
-	TEGRA_MAP_MUXCONF("dap2",  "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("dap3",  "dap3",          none, tristate),
-	TEGRA_MAP_MUXCONF("dap4",  "dap4",          none, tristate),
-	TEGRA_MAP_MUXCONF("ddc",   "i2c2",          up,   driven),
-	TEGRA_MAP_MUXCONF("dta",   "rsvd1",         up,   tristate),
-	TEGRA_MAP_MUXCONF("dtb",   "rsvd1",         none, tristate),
-	TEGRA_MAP_MUXCONF("dtc",   "rsvd1",         none, tristate),
-	TEGRA_MAP_MUXCONF("dtd",   "rsvd1",         up,   tristate),
-	TEGRA_MAP_MUXCONF("dte",   "rsvd1",         none, tristate),
-	TEGRA_MAP_MUXCONF("dtf",   "i2c3",          none, driven),
-	TEGRA_MAP_MUXCONF("gma",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("gmb",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("gmc",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("gmd",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("gme",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("gpu",   "pwm",           none, driven),
-	TEGRA_MAP_MUXCONF("gpu7",  "rtck",          none, driven),
-	TEGRA_MAP_MUXCONF("gpv",   "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("hdint", "hdmi",          na,   driven),
-	TEGRA_MAP_MUXCONF("i2cp",  "i2cp",          none, driven),
-	TEGRA_MAP_MUXCONF("irrx",  "uarta",         up,   driven),
-	TEGRA_MAP_MUXCONF("irtx",  "uarta",         up,   driven),
-	TEGRA_MAP_MUXCONF("kbca",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcb",  "sdio2",         up,   driven),
-	TEGRA_MAP_MUXCONF("kbcc",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcd",  "sdio2",         up,   driven),
-	TEGRA_MAP_MUXCONF("kbce",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcf",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("lcsn",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("ld0",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld1",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld10",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld11",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld12",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld13",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld14",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld15",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld16",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld17",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld2",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld3",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld4",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld5",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld6",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld7",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld8",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ld9",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ldc",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("ldi",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhp0",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lhp1",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lhp2",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lhs",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lm0",   "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lm1",   "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lpp",   "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lpw0",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lpw1",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lpw2",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lsc0",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lsc1",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lsck",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lsda",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lsdi",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lspi",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lvp0",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lvp1",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lvs",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("owc",   "owr",           up,   tristate),
-	TEGRA_MAP_MUXCONF("pmc",   "pwr_on",        na,   driven),
-	TEGRA_MAP_MUXCONF("pta",   "hdmi",          none, driven),
-	TEGRA_MAP_MUXCONF("rm",    "i2c1",          none, driven),
-	TEGRA_MAP_MUXCONF("sdb",   "pwm",           na,   tristate),
-	TEGRA_MAP_MUXCONF("sdc",   "twc",           up,   tristate),
-	TEGRA_MAP_MUXCONF("sdd",   "pwm",           up,   tristate),
-	TEGRA_MAP_MUXCONF("sdio1", "sdio1",         none, driven),
-	TEGRA_MAP_MUXCONF("slxa",  "pcie",          none, tristate),
-	TEGRA_MAP_MUXCONF("slxc",  "spi4",          none, tristate),
-	TEGRA_MAP_MUXCONF("slxd",  "spi4",          none, tristate),
-	TEGRA_MAP_MUXCONF("slxk",  "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("spdi",  "rsvd2",         none, tristate),
-	TEGRA_MAP_MUXCONF("spdo",  "rsvd2",         none, driven),
-	TEGRA_MAP_MUXCONF("spia",  "gmi",           down, tristate),
-	TEGRA_MAP_MUXCONF("spib",  "gmi",           down, tristate),
-	TEGRA_MAP_MUXCONF("spic",  "gmi",           up,   driven),
-	TEGRA_MAP_MUXCONF("spid",  "gmi",           down, tristate),
-	TEGRA_MAP_MUXCONF("spie",  "gmi",           up,   tristate),
-	TEGRA_MAP_MUXCONF("spif",  "rsvd4",         down, tristate),
-	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      up,   driven),
-	TEGRA_MAP_MUXCONF("spih",  "spi2_alt",      up,   tristate),
-	TEGRA_MAP_MUXCONF("uaa",   "ulpi",          up,   driven),
-	TEGRA_MAP_MUXCONF("uab",   "ulpi",          up,   driven),
-	TEGRA_MAP_MUXCONF("uac",   "rsvd4",         none, driven),
-	TEGRA_MAP_MUXCONF("uad",   "spdif",         up,   tristate),
-	TEGRA_MAP_MUXCONF("uca",   "uartc",         up,   tristate),
-	TEGRA_MAP_MUXCONF("ucb",   "uartc",         up,   tristate),
-	TEGRA_MAP_MUXCONF("uda",   "ulpi",          none, driven),
-	TEGRA_MAP_CONF("ck32",    none, na),
-	TEGRA_MAP_CONF("ddrc",    none, na),
-	TEGRA_MAP_CONF("pmca",    none, na),
-	TEGRA_MAP_CONF("pmcb",    none, na),
-	TEGRA_MAP_CONF("pmcc",    none, na),
-	TEGRA_MAP_CONF("pmcd",    none, na),
-	TEGRA_MAP_CONF("pmce",    none, na),
-	TEGRA_MAP_CONF("xm2c",    none, na),
-	TEGRA_MAP_CONF("xm2d",    none, na),
-	TEGRA_MAP_CONF("ls",      up,   na),
-	TEGRA_MAP_CONF("lc",      up,   na),
-	TEGRA_MAP_CONF("ld17_0",  down, na),
-	TEGRA_MAP_CONF("ld19_18", down, na),
-	TEGRA_MAP_CONF("ld21_20", down, na),
-	TEGRA_MAP_CONF("ld23_22", down, na),
-};
-
-static struct tegra_board_pinmux_conf conf = {
-	.maps = paz00_map,
-	.map_count = ARRAY_SIZE(paz00_map),
-};
-
-void paz00_pinmux_init(void)
-{
-	tegra_board_pinmux_init(&conf, NULL);
-}
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 4b64af5..5930551 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -17,72 +17,10 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/serial_8250.h>
-#include <linux/of_serial.h>
-#include <linux/clk.h>
-#include <linux/dma-mapping.h>
-#include <linux/gpio_keys.h>
-#include <linux/pda_power.h>
-#include <linux/io.h>
-#include <linux/input.h>
-#include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/rfkill-gpio.h>
 
-#include <asm/hardware/gic.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <asm/setup.h>
-
-#include <mach/iomap.h>
-#include <mach/irqs.h>
-#include <mach/sdhci.h>
-
-#include "board.h"
 #include "board-paz00.h"
-#include "clock.h"
-#include "devices.h"
-#include "gpio-names.h"
-
-static struct plat_serial8250_port debug_uart_platform_data[] = {
-	{
-		/* serial port on JP1 */
-		.membase	= IO_ADDRESS(TEGRA_UARTA_BASE),
-		.mapbase	= TEGRA_UARTA_BASE,
-		.irq		= INT_UARTA,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_FIXED_TYPE,
-		.type		= PORT_TEGRA,
-		.handle_break	= tegra_serial_handle_break,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= 216000000,
-	}, {
-		/* serial port on mini-pcie */
-		.membase	= IO_ADDRESS(TEGRA_UARTC_BASE),
-		.mapbase	= TEGRA_UARTC_BASE,
-		.irq		= INT_UARTC,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_FIXED_TYPE,
-		.type		= PORT_TEGRA,
-		.handle_break	= tegra_serial_handle_break,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= 216000000,
-	}, {
-		.flags		= 0
-	}
-};
-
-static struct platform_device debug_uart = {
-	.name = "serial8250",
-	.id = PLAT8250_DEV_PLATFORM,
-	.dev = {
-		.platform_data = debug_uart_platform_data,
-	},
-};
 
 static struct rfkill_gpio_platform_data wifi_rfkill_platform_data = {
 	.name		= "wifi_rfkill",
@@ -99,137 +37,7 @@ static struct platform_device wifi_rfkill_device = {
 	},
 };
 
-static struct gpio_led gpio_leds[] = {
-	{
-		.name			= "wifi-led",
-		.default_trigger	= "rfkill0",
-		.gpio			= TEGRA_WIFI_LED,
-	},
-};
-
-static struct gpio_led_platform_data gpio_led_info = {
-	.leds		= gpio_leds,
-	.num_leds	= ARRAY_SIZE(gpio_leds),
-};
-
-static struct platform_device leds_gpio = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &gpio_led_info,
-        },
-};
-
-static struct gpio_keys_button paz00_gpio_keys_buttons[] = {
-	{
-		.code		= KEY_POWER,
-		.gpio		= TEGRA_GPIO_POWERKEY,
-		.active_low	= 1,
-		.desc		= "Power",
-		.type		= EV_KEY,
-		.wakeup		= 1,
-	},
-};
-
-static struct gpio_keys_platform_data paz00_gpio_keys = {
-	.buttons	= paz00_gpio_keys_buttons,
-	.nbuttons	= ARRAY_SIZE(paz00_gpio_keys_buttons),
-};
-
-static struct platform_device gpio_keys_device = {
-	.name	= "gpio-keys",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &paz00_gpio_keys,
-	},
-};
-
-static struct platform_device *paz00_devices[] __initdata = {
-	&debug_uart,
-	&tegra_sdhci_device4,
-	&tegra_sdhci_device1,
-	&leds_gpio,
-	&gpio_keys_device,
-};
-
-static void paz00_i2c_init(void)
-{
-	platform_device_register(&tegra_i2c_device1);
-	platform_device_register(&tegra_i2c_device2);
-	platform_device_register(&tegra_i2c_device4);
-}
-
-static void paz00_usb_init(void)
-{
-	tegra_ehci2_ulpi_phy_config.reset_gpio = TEGRA_ULPI_RST;
-
-	platform_device_register(&tegra_ehci2_device);
-	platform_device_register(&tegra_ehci3_device);
-}
-
-static void __init tegra_paz00_fixup(struct tag *tags, char **cmdline,
-	struct meminfo *mi)
-{
-	mi->nr_banks = 1;
-	mi->bank[0].start = PHYS_OFFSET;
-	mi->bank[0].size = 448 * SZ_1M;
-}
-
-static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
-	/* name		parent		rate		enabled */
-	{ "uarta",	"pll_p",	216000000,	true },
-	{ "uartc",	"pll_p",	216000000,	true },
-
-	{ "usbd",	"clk_m",	12000000,	false },
-	{ "usb2",	"clk_m",	12000000,	false },
-	{ "usb3",	"clk_m",	12000000,	false },
-
-	{ NULL,		NULL,		0,		0},
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata1 = {
-	.cd_gpio	= TEGRA_GPIO_SD1_CD,
-	.wp_gpio	= TEGRA_GPIO_SD1_WP,
-	.power_gpio	= TEGRA_GPIO_SD1_POWER,
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata4 = {
-	.cd_gpio	= -1,
-	.wp_gpio	= -1,
-	.power_gpio	= -1,
-	.is_8bit	= 1,
-};
-
 void __init tegra_paz00_wifikill_init(void)
 {
 	platform_device_register(&wifi_rfkill_device);
 }
-
-static void __init tegra_paz00_init(void)
-{
-	tegra_clk_init_from_table(paz00_clk_init_table);
-
-	paz00_pinmux_init();
-
-	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
-	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
-
-	platform_add_devices(paz00_devices, ARRAY_SIZE(paz00_devices));
-	tegra_paz00_wifikill_init();
-
-	paz00_i2c_init();
-	paz00_usb_init();
-}
-
-MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
-	.atag_offset	= 0x100,
-	.fixup		= tegra_paz00_fixup,
-	.map_io         = tegra_map_common_io,
-	.init_early	= tegra20_init_early,
-	.init_irq       = tegra_init_irq,
-	.handle_irq	= gic_handle_irq,
-	.timer          = &tegra_timer,
-	.init_machine   = tegra_paz00_init,
-	.init_late	= tegra_init_late,
-	.restart	= tegra_assert_system_reset,
-MACHINE_END
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index 3c9f8da..25c08ec 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -17,24 +17,9 @@
 #ifndef _MACH_TEGRA_BOARD_PAZ00_H
 #define _MACH_TEGRA_BOARD_PAZ00_H
 
-#include <mach/gpio-tegra.h>
+#include "gpio-names.h"
 
-/* SDCARD */
-#define TEGRA_GPIO_SD1_CD		TEGRA_GPIO_PV5
-#define TEGRA_GPIO_SD1_WP		TEGRA_GPIO_PH1
-#define TEGRA_GPIO_SD1_POWER		TEGRA_GPIO_PV1
-
-/* ULPI */
-#define TEGRA_ULPI_RST			TEGRA_GPIO_PV0
-
-/* WIFI */
 #define TEGRA_WIFI_PWRN			TEGRA_GPIO_PK5
 #define TEGRA_WIFI_RST			TEGRA_GPIO_PD1
-#define TEGRA_WIFI_LED			TEGRA_GPIO_PD0
-
-/* WakeUp */
-#define TEGRA_GPIO_POWERKEY	TEGRA_GPIO_PJ7
-
-void paz00_pinmux_init(void);
 
 #endif
-- 
1.7.0.4
