From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 May 2012 15:44:50 -0600
Subject: [PATCH 3/3] ARM: tegra: remove Seaboard board files
In-Reply-To: <1337636690-28211-1-git-send-email-swarren@wwwdotorg.org>
References: <1337636690-28211-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1337636690-28211-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Seaboard device tree supports all the features that the Seaboard
board files support. Hence, there's no need to keep the board files
around any more; all users should convert to device tree.

MACH_KAEN and MACH_WARIO are also removed. While tegra-seaboard.dts
doesn't support those explicitly, it would be trivial to create device
trees for those boards if anyone cares.

The Seaboard device tree is now compiled if Tegra2 support is enabled,
rather than when Seaboard support is enabled.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig                 |   22 --
 arch/arm/mach-tegra/Makefile                |    3 -
 arch/arm/mach-tegra/board-seaboard-pinmux.c |  197 -----------------
 arch/arm/mach-tegra/board-seaboard.c        |  306 ---------------------------
 arch/arm/mach-tegra/board-seaboard.h        |   47 ----
 5 files changed, 0 insertions(+), 575 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-seaboard-pinmux.c
 delete mode 100644 arch/arm/mach-tegra/board-seaboard.c
 delete mode 100644 arch/arm/mach-tegra/board-seaboard.h

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 621466a..9077aaa 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -66,27 +66,12 @@ config MACH_HARMONY
        help
          Support for nVidia Harmony development platform
 
-config MACH_KAEN
-       bool "Kaen board"
-       depends on ARCH_TEGRA_2x_SOC
-       select MACH_SEABOARD
-       help
-         Support for the Kaen version of Seaboard
-
 config MACH_PAZ00
        bool "Paz00 board"
        depends on ARCH_TEGRA_2x_SOC
        help
          Support for the Toshiba AC100/Dynabook AZ netbook
 
-config MACH_SEABOARD
-       bool "Seaboard board"
-       depends on ARCH_TEGRA_2x_SOC
-       help
-         Support for nVidia Seaboard development platform. It will
-	 also be included for some of the derivative boards that
-	 have large similarities with the seaboard design.
-
 config MACH_TRIMSLICE
        bool "TrimSlice board"
        depends on ARCH_TEGRA_2x_SOC
@@ -94,13 +79,6 @@ config MACH_TRIMSLICE
        help
          Support for CompuLab TrimSlice platform
 
-config MACH_WARIO
-       bool "Wario board"
-       depends on ARCH_TEGRA_2x_SOC
-       select MACH_SEABOARD
-       help
-         Support for the Wario version of Seaboard
-
 choice
         prompt "Default low-level debug console UART"
         default TEGRA_DEBUG_UART_NONE
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 60a0213..1f6f237 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -33,8 +33,5 @@ obj-$(CONFIG_MACH_HARMONY)              += board-harmony-power.o
 obj-$(CONFIG_MACH_PAZ00)		+= board-paz00.o
 obj-$(CONFIG_MACH_PAZ00)		+= board-paz00-pinmux.o
 
-obj-$(CONFIG_MACH_SEABOARD)             += board-seaboard.o
-obj-$(CONFIG_MACH_SEABOARD)             += board-seaboard-pinmux.o
-
 obj-$(CONFIG_MACH_TRIMSLICE)            += board-trimslice.o
 obj-$(CONFIG_MACH_TRIMSLICE)            += board-trimslice-pinmux.o
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
deleted file mode 100644
index 11fc8a5..0000000
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * Copyright (C) 2010-2012 NVIDIA Corporation
- * Copyright (C) 2011 Google, Inc.
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
-#include "board-seaboard.h"
-#include "board-pinmux.h"
-
-static unsigned long seaboard_pincfg_drive_sdio1[] = {
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_HIGH_SPEED_MODE, 0),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_SCHMITT, 0),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_LOW_POWER_MODE, 3),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_DRIVE_DOWN_STRENGTH, 31),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_DRIVE_UP_STRENGTH, 31),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING, 3),
-	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_SLEW_RATE_RISING, 3),
-};
-
-static struct pinctrl_map common_map[] = {
-	TEGRA_MAP_MUXCONF("ata",   "ide",           none, driven),
-	TEGRA_MAP_MUXCONF("atb",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("atc",   "nand",          none, driven),
-	TEGRA_MAP_MUXCONF("atd",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("ate",   "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("cdev1", "plla_out",      none, driven),
-	TEGRA_MAP_MUXCONF("cdev2", "pllp_out4",     none, driven),
-	TEGRA_MAP_MUXCONF("crtp",  "crt",           up,   tristate),
-	TEGRA_MAP_MUXCONF("csus",  "vi_sensor_clk", none, tristate),
-	TEGRA_MAP_MUXCONF("dap1",  "dap1",          none, driven),
-	TEGRA_MAP_MUXCONF("dap2",  "dap2",          none, driven),
-	TEGRA_MAP_MUXCONF("dap3",  "dap3",          none, tristate),
-	TEGRA_MAP_MUXCONF("dap4",  "dap4",          none, driven),
-	TEGRA_MAP_MUXCONF("dta",   "vi",            down, driven),
-	TEGRA_MAP_MUXCONF("dtb",   "vi",            down, driven),
-	TEGRA_MAP_MUXCONF("dtc",   "vi",            down, driven),
-	TEGRA_MAP_MUXCONF("dtd",   "vi",            down, driven),
-	TEGRA_MAP_MUXCONF("dte",   "vi",            down, tristate),
-	TEGRA_MAP_MUXCONF("dtf",   "i2c3",          none, driven),
-	TEGRA_MAP_MUXCONF("gma",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("gmb",   "gmi",           up,   tristate),
-	TEGRA_MAP_MUXCONF("gmc",   "uartd",         none, driven),
-	TEGRA_MAP_MUXCONF("gme",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("gpu",   "pwm",           none, driven),
-	TEGRA_MAP_MUXCONF("gpu7",  "rtck",          none, driven),
-	TEGRA_MAP_MUXCONF("gpv",   "pcie",          none, tristate),
-	TEGRA_MAP_MUXCONF("hdint", "hdmi",          na,   tristate),
-	TEGRA_MAP_MUXCONF("i2cp",  "i2cp",          none, driven),
-	TEGRA_MAP_MUXCONF("irrx",  "uartb",         none, driven),
-	TEGRA_MAP_MUXCONF("irtx",  "uartb",         none, driven),
-	TEGRA_MAP_MUXCONF("kbca",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcb",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcc",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcd",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbce",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcf",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("lcsn",  "rsvd4",         na,   tristate),
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
-	TEGRA_MAP_MUXCONF("ldc",   "rsvd4",         na,   tristate),
-	TEGRA_MAP_MUXCONF("ldi",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhp0",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhp1",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhp2",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhs",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lm0",   "rsvd4",         na,   driven),
-	TEGRA_MAP_MUXCONF("lm1",   "crt",           na,   tristate),
-	TEGRA_MAP_MUXCONF("lpp",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lpw1",  "rsvd4",         na,   tristate),
-	TEGRA_MAP_MUXCONF("lsc0",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lsdi",  "rsvd4",         na,   tristate),
-	TEGRA_MAP_MUXCONF("lspi",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lvp0",  "rsvd4",         na,   tristate),
-	TEGRA_MAP_MUXCONF("lvp1",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lvs",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("owc",   "rsvd2",         none, tristate),
-	TEGRA_MAP_MUXCONF("pmc",   "pwr_on",        na,   driven),
-	TEGRA_MAP_MUXCONF("pta",   "hdmi",          none, driven),
-	TEGRA_MAP_MUXCONF("rm",    "i2c1",          none, driven),
-	TEGRA_MAP_MUXCONF("sdb",   "sdio3",         na,   driven),
-	TEGRA_MAP_MUXCONF("sdc",   "sdio3",         none, driven),
-	TEGRA_MAP_MUXCONF("sdd",   "sdio3",         none, driven),
-	TEGRA_MAP_MUXCONF("sdio1", "sdio1",         up,   driven),
-	TEGRA_MAP_MUXCONF("slxa",  "pcie",          up,   tristate),
-	TEGRA_MAP_MUXCONF("slxd",  "spdif",         none, driven),
-	TEGRA_MAP_MUXCONF("slxk",  "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("spdi",  "rsvd2",         none, driven),
-	TEGRA_MAP_MUXCONF("spdo",  "rsvd2",         none, driven),
-	TEGRA_MAP_MUXCONF("spib",  "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("spid",  "spi1",          none, tristate),
-	TEGRA_MAP_MUXCONF("spie",  "spi1",          none, tristate),
-	TEGRA_MAP_MUXCONF("spif",  "spi1",          down, tristate),
-	TEGRA_MAP_MUXCONF("spih",  "spi2_alt",      up,   tristate),
-	TEGRA_MAP_MUXCONF("uaa",   "ulpi",          up,   driven),
-	TEGRA_MAP_MUXCONF("uab",   "ulpi",          up,   driven),
-	TEGRA_MAP_MUXCONF("uac",   "rsvd2",         none, driven),
-	TEGRA_MAP_MUXCONF("uad",   "irda",          none, driven),
-	TEGRA_MAP_MUXCONF("uca",   "uartc",         none, driven),
-	TEGRA_MAP_MUXCONF("ucb",   "uartc",         none, driven),
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
-static struct pinctrl_map seaboard_map[] = {
-	TEGRA_MAP_MUXCONF("ddc",   "rsvd2",         none, tristate),
-	TEGRA_MAP_MUXCONF("gmd",   "sflash",        none, driven),
-	TEGRA_MAP_MUXCONF("lpw0",  "hdmi",          na,   driven),
-	TEGRA_MAP_MUXCONF("lpw2",  "hdmi",          na,   driven),
-	TEGRA_MAP_MUXCONF("lsc1",  "hdmi",          na,   tristate),
-	TEGRA_MAP_MUXCONF("lsck",  "hdmi",          na,   tristate),
-	TEGRA_MAP_MUXCONF("lsda",  "hdmi",          na,   tristate),
-	TEGRA_MAP_MUXCONF("slxc",  "spdif",         none, tristate),
-	TEGRA_MAP_MUXCONF("spia",  "gmi",           up,   tristate),
-	TEGRA_MAP_MUXCONF("spic",  "gmi",           up,   driven),
-	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      up,   tristate),
-	PIN_MAP_CONFIGS_GROUP_HOG_DEFAULT(PINMUX_DEV, "drive_sdio1", seaboard_pincfg_drive_sdio1),
-};
-
-static struct pinctrl_map ventana_map[] = {
-	TEGRA_MAP_MUXCONF("ddc",   "rsvd2",         none, driven),
-	TEGRA_MAP_MUXCONF("gmd",   "sflash",        none, tristate),
-	TEGRA_MAP_MUXCONF("lpw0",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lpw2",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lsc1",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lsck",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lsda",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("slxc",  "sdio3",         none, driven),
-	TEGRA_MAP_MUXCONF("spia",  "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("spic",  "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      none, tristate),
-};
-
-static struct tegra_board_pinmux_conf common_conf = {
-	.maps = common_map,
-	.map_count = ARRAY_SIZE(common_map),
-};
-
-static struct tegra_board_pinmux_conf seaboard_conf = {
-	.maps = seaboard_map,
-	.map_count = ARRAY_SIZE(seaboard_map),
-};
-
-static struct tegra_board_pinmux_conf ventana_conf = {
-	.maps = ventana_map,
-	.map_count = ARRAY_SIZE(ventana_map),
-};
-
-void seaboard_pinmux_init(void)
-{
-	tegra_board_pinmux_init(&common_conf, &seaboard_conf);
-}
-
-void ventana_pinmux_init(void)
-{
-	tegra_board_pinmux_init(&common_conf, &ventana_conf);
-}
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
deleted file mode 100644
index 71e9f3f..0000000
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ /dev/null
@@ -1,306 +0,0 @@
-/*
- * Copyright (c) 2010, 2011 NVIDIA Corporation.
- * Copyright (C) 2010, 2011 Google, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/serial_8250.h>
-#include <linux/of_serial.h>
-#include <linux/i2c.h>
-#include <linux/delay.h>
-#include <linux/input.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/platform_data/tegra_usb.h>
-
-#include <sound/wm8903.h>
-
-#include <mach/iomap.h>
-#include <mach/irqs.h>
-#include <mach/sdhci.h>
-#include <mach/tegra_wm8903_pdata.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/hardware/gic.h>
-
-#include "board.h"
-#include "board-seaboard.h"
-#include "clock.h"
-#include "devices.h"
-#include "gpio-names.h"
-
-static struct plat_serial8250_port debug_uart_platform_data[] = {
-	{
-		/* Memory and IRQ filled in before registration */
-		.flags		= UPF_BOOT_AUTOCONF | UPF_FIXED_TYPE,
-		.type		= PORT_TEGRA,
-		.handle_break	= tegra_serial_handle_break,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= 216000000,
-	}, {
-		.flags		= 0,
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
-
-static __initdata struct tegra_clk_init_table seaboard_clk_init_table[] = {
-	/* name		parent		rate		enabled */
-	{ "uartb",	"pll_p",	216000000,	true},
-	{ "uartd",	"pll_p",	216000000,	true},
-	{ "pll_a",	"pll_p_out1",	56448000,	true },
-	{ "pll_a_out0",	"pll_a",	11289600,	true },
-	{ "cdev1",	NULL,		0,		true },
-	{ "i2s1",	"pll_a_out0",	11289600,	false},
-	{ "usbd",	"clk_m",	12000000,	true},
-	{ "usb3",	"clk_m",	12000000,	true},
-	{ NULL,		NULL,		0,		0},
-};
-
-static struct gpio_keys_button seaboard_gpio_keys_buttons[] = {
-	{
-		.code		= SW_LID,
-		.gpio		= TEGRA_GPIO_LIDSWITCH,
-		.active_low	= 0,
-		.desc		= "Lid",
-		.type		= EV_SW,
-		.wakeup		= 1,
-		.debounce_interval = 1,
-	},
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
-static struct gpio_keys_platform_data seaboard_gpio_keys = {
-	.buttons	= seaboard_gpio_keys_buttons,
-	.nbuttons	= ARRAY_SIZE(seaboard_gpio_keys_buttons),
-};
-
-static struct platform_device seaboard_gpio_keys_device = {
-	.name		= "gpio-keys",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &seaboard_gpio_keys,
-	}
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata1 = {
-	.cd_gpio	= -1,
-	.wp_gpio	= -1,
-	.power_gpio	= -1,
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata3 = {
-	.cd_gpio	= TEGRA_GPIO_SD2_CD,
-	.wp_gpio	= TEGRA_GPIO_SD2_WP,
-	.power_gpio	= TEGRA_GPIO_SD2_POWER,
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata4 = {
-	.cd_gpio	= -1,
-	.wp_gpio	= -1,
-	.power_gpio	= -1,
-	.is_8bit	= 1,
-};
-
-static struct tegra_wm8903_platform_data seaboard_audio_pdata = {
-	.gpio_spkr_en		= TEGRA_GPIO_SPKR_EN,
-	.gpio_hp_det		= TEGRA_GPIO_HP_DET,
-	.gpio_hp_mute		= -1,
-	.gpio_int_mic_en	= -1,
-	.gpio_ext_mic_en	= -1,
-};
-
-static struct platform_device seaboard_audio_device = {
-	.name	= "tegra-snd-wm8903",
-	.id	= 0,
-	.dev	= {
-		.platform_data  = &seaboard_audio_pdata,
-	},
-};
-
-static struct platform_device *seaboard_devices[] __initdata = {
-	&debug_uart,
-	&tegra_pmu_device,
-	&tegra_sdhci_device4,
-	&tegra_sdhci_device3,
-	&tegra_sdhci_device1,
-	&seaboard_gpio_keys_device,
-	&tegra_i2s_device1,
-	&tegra_das_device,
-	&seaboard_audio_device,
-};
-
-static struct i2c_board_info __initdata isl29018_device = {
-	I2C_BOARD_INFO("isl29018", 0x44),
-};
-
-static struct i2c_board_info __initdata adt7461_device = {
-	I2C_BOARD_INFO("adt7461", 0x4c),
-};
-
-static struct wm8903_platform_data wm8903_pdata = {
-	.irq_active_low = 0,
-	.micdet_cfg = 0,
-	.micdet_delay = 100,
-	.gpio_base = SEABOARD_GPIO_WM8903(0),
-	.gpio_cfg = {
-		0,
-		0,
-		WM8903_GPIO_CONFIG_ZERO,
-		0,
-		0,
-	},
-};
-
-static struct i2c_board_info __initdata wm8903_device = {
-	I2C_BOARD_INFO("wm8903", 0x1a),
-	.platform_data = &wm8903_pdata,
-};
-
-static int seaboard_ehci_init(void)
-{
-	struct tegra_ehci_platform_data *pdata;
-
-	pdata = tegra_ehci1_device.dev.platform_data;
-	pdata->vbus_gpio = TEGRA_GPIO_USB1;
-
-	platform_device_register(&tegra_ehci1_device);
-	platform_device_register(&tegra_ehci3_device);
-
-	return 0;
-}
-
-static void __init seaboard_i2c_init(void)
-{
-	isl29018_device.irq = gpio_to_irq(TEGRA_GPIO_ISL29018_IRQ);
-	i2c_register_board_info(0, &isl29018_device, 1);
-
-	wm8903_device.irq = gpio_to_irq(TEGRA_GPIO_CDC_IRQ);
-	i2c_register_board_info(0, &wm8903_device, 1);
-
-	i2c_register_board_info(3, &adt7461_device, 1);
-
-	platform_device_register(&tegra_i2c_device1);
-	platform_device_register(&tegra_i2c_device2);
-	platform_device_register(&tegra_i2c_device3);
-	platform_device_register(&tegra_i2c_device4);
-}
-
-static void __init seaboard_common_init(void)
-{
-	seaboard_pinmux_init();
-
-	tegra_clk_init_from_table(seaboard_clk_init_table);
-
-	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
-	tegra_sdhci_device3.dev.platform_data = &sdhci_pdata3;
-	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
-
-	platform_add_devices(seaboard_devices, ARRAY_SIZE(seaboard_devices));
-
-	seaboard_ehci_init();
-}
-
-static void __init tegra_seaboard_init(void)
-{
-	/* Seaboard uses UARTD for the debug port. */
-	debug_uart_platform_data[0].membase = IO_ADDRESS(TEGRA_UARTD_BASE);
-	debug_uart_platform_data[0].mapbase = TEGRA_UARTD_BASE;
-	debug_uart_platform_data[0].irq = INT_UARTD;
-
-	seaboard_common_init();
-
-	seaboard_i2c_init();
-}
-
-static void __init tegra_kaen_init(void)
-{
-	/* Kaen uses UARTB for the debug port. */
-	debug_uart_platform_data[0].membase = IO_ADDRESS(TEGRA_UARTB_BASE);
-	debug_uart_platform_data[0].mapbase = TEGRA_UARTB_BASE;
-	debug_uart_platform_data[0].irq = INT_UARTB;
-
-	seaboard_audio_pdata.gpio_hp_mute = TEGRA_GPIO_KAEN_HP_MUTE;
-
-	seaboard_common_init();
-
-	seaboard_i2c_init();
-}
-
-static void __init tegra_wario_init(void)
-{
-	/* Wario uses UARTB for the debug port. */
-	debug_uart_platform_data[0].membase = IO_ADDRESS(TEGRA_UARTB_BASE);
-	debug_uart_platform_data[0].mapbase = TEGRA_UARTB_BASE;
-	debug_uart_platform_data[0].irq = INT_UARTB;
-
-	seaboard_common_init();
-
-	seaboard_i2c_init();
-}
-
-
-MACHINE_START(SEABOARD, "seaboard")
-	.atag_offset    = 0x100,
-	.map_io         = tegra_map_common_io,
-	.init_early     = tegra20_init_early,
-	.init_irq       = tegra_init_irq,
-	.handle_irq	= gic_handle_irq,
-	.timer          = &tegra_timer,
-	.init_machine   = tegra_seaboard_init,
-	.init_late	= tegra_init_late,
-	.restart	= tegra_assert_system_reset,
-MACHINE_END
-
-MACHINE_START(KAEN, "kaen")
-	.atag_offset    = 0x100,
-	.map_io         = tegra_map_common_io,
-	.init_early     = tegra20_init_early,
-	.init_irq       = tegra_init_irq,
-	.handle_irq	= gic_handle_irq,
-	.timer          = &tegra_timer,
-	.init_machine   = tegra_kaen_init,
-	.init_late	= tegra_init_late,
-	.restart	= tegra_assert_system_reset,
-MACHINE_END
-
-MACHINE_START(WARIO, "wario")
-	.atag_offset    = 0x100,
-	.map_io         = tegra_map_common_io,
-	.init_early     = tegra20_init_early,
-	.init_irq       = tegra_init_irq,
-	.handle_irq	= gic_handle_irq,
-	.timer          = &tegra_timer,
-	.init_machine   = tegra_wario_init,
-	.init_late	= tegra_init_late,
-	.restart	= tegra_assert_system_reset,
-MACHINE_END
diff --git a/arch/arm/mach-tegra/board-seaboard.h b/arch/arm/mach-tegra/board-seaboard.h
deleted file mode 100644
index 4c45d4c..0000000
--- a/arch/arm/mach-tegra/board-seaboard.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * arch/arm/mach-tegra/board-seaboard.h
- *
- * Copyright (C) 2010 Google, Inc.
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
-#ifndef _MACH_TEGRA_BOARD_SEABOARD_H
-#define _MACH_TEGRA_BOARD_SEABOARD_H
-
-#include <mach/gpio-tegra.h>
-
-#define SEABOARD_GPIO_TPS6586X(_x_)	(TEGRA_NR_GPIOS + (_x_))
-#define SEABOARD_GPIO_WM8903(_x_)	(SEABOARD_GPIO_TPS6586X(4) + (_x_))
-
-#define TEGRA_GPIO_SD2_CD		TEGRA_GPIO_PI5
-#define TEGRA_GPIO_SD2_WP		TEGRA_GPIO_PH1
-#define TEGRA_GPIO_SD2_POWER		TEGRA_GPIO_PI6
-#define TEGRA_GPIO_LIDSWITCH		TEGRA_GPIO_PC7
-#define TEGRA_GPIO_USB1			TEGRA_GPIO_PD0
-#define TEGRA_GPIO_POWERKEY		TEGRA_GPIO_PV2
-#define TEGRA_GPIO_BACKLIGHT		TEGRA_GPIO_PD4
-#define TEGRA_GPIO_LVDS_SHUTDOWN	TEGRA_GPIO_PB2
-#define TEGRA_GPIO_BACKLIGHT_PWM	TEGRA_GPIO_PU5
-#define TEGRA_GPIO_BACKLIGHT_VDD	TEGRA_GPIO_PW0
-#define TEGRA_GPIO_EN_VDD_PNL		TEGRA_GPIO_PC6
-#define TEGRA_GPIO_MAGNETOMETER		TEGRA_GPIO_PN5
-#define TEGRA_GPIO_ISL29018_IRQ		TEGRA_GPIO_PZ2
-#define TEGRA_GPIO_AC_ONLINE		TEGRA_GPIO_PV3
-#define TEGRA_GPIO_WWAN_PWR		SEABOARD_GPIO_TPS6586X(2)
-#define TEGRA_GPIO_CDC_IRQ		TEGRA_GPIO_PX3
-#define TEGRA_GPIO_SPKR_EN		SEABOARD_GPIO_WM8903(2)
-#define TEGRA_GPIO_HP_DET		TEGRA_GPIO_PX1
-#define TEGRA_GPIO_KAEN_HP_MUTE		TEGRA_GPIO_PA5
-
-void seaboard_pinmux_init(void);
-
-#endif
-- 
1.7.0.4
