From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  6 Aug 2012 15:32:12 -0600
Subject: [PATCH 1/3] ARM: tegra: remove board (but not DT) support for
 TrimSlice
Message-ID: <1344288734-24131-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

TrimSlice can be booted using device tree with equal functionality as
when booted using a board file. Remove the board file since it's no
longer needed.

One special-case is still left in board-dt-tegra20.c, since the Tegra
PCIe driver doesn't support device tree yet. This logic is now enabled
by CONFIG_TEGRA_PCI rather than via CONFIG_MACH_TRIMSLICE. The extra
cases where it's enabled (.configs which did not enable TrimSlice
support) shouldn't impact much since the amount of code is tiny.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
These patches might need some slight context updates depending on if/how
board-dt-tegra20.c gets updated in v3.6-rc2 to fix the Trimslice PCIe
issue. Perhaps a simple merge will work for that anyway. Either way, the
basic concept of these patches is going to stand...

 arch/arm/mach-tegra/Kconfig                  |    7 -
 arch/arm/mach-tegra/Makefile                 |    3 -
 arch/arm/mach-tegra/board-dt-tegra20.c       |    6 +-
 arch/arm/mach-tegra/board-trimslice-pinmux.c |  155 ----------------------
 arch/arm/mach-tegra/board-trimslice.c        |  183 --------------------------
 arch/arm/mach-tegra/board-trimslice.h        |   30 ----
 6 files changed, 2 insertions(+), 382 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-trimslice-pinmux.c
 delete mode 100644 arch/arm/mach-tegra/board-trimslice.c
 delete mode 100644 arch/arm/mach-tegra/board-trimslice.h

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 9077aaa..41bc73c 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -72,13 +72,6 @@ config MACH_PAZ00
        help
          Support for the Toshiba AC100/Dynabook AZ netbook
 
-config MACH_TRIMSLICE
-       bool "TrimSlice board"
-       depends on ARCH_TEGRA_2x_SOC
-       select TEGRA_PCI
-       help
-         Support for CompuLab TrimSlice platform
-
 choice
         prompt "Default low-level debug console UART"
         default TEGRA_DEBUG_UART_NONE
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index c3d7303..88ddb75 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -33,6 +33,3 @@ obj-$(CONFIG_MACH_HARMONY)              += board-harmony-power.o
 
 obj-$(CONFIG_MACH_PAZ00)		+= board-paz00.o
 obj-$(CONFIG_MACH_PAZ00)		+= board-paz00-pinmux.o
-
-obj-$(CONFIG_MACH_TRIMSLICE)            += board-trimslice.o
-obj-$(CONFIG_MACH_TRIMSLICE)            += board-trimslice-pinmux.o
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index b4e7cc1..422e89e 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -96,16 +96,16 @@ static void __init tegra_dt_init(void)
 				tegra20_auxdata_lookup, NULL);
 }
 
-#ifdef CONFIG_MACH_TRIMSLICE
 static void __init trimslice_init(void)
 {
+#ifdef CONFIG_TEGRA_PCI
 	int ret;
 
 	ret = tegra_pcie_init(true, true);
 	if (ret)
 		pr_err("tegra_pci_init() failed: %d\n", ret);
-}
 #endif
+}
 
 #ifdef CONFIG_MACH_HARMONY
 static void __init harmony_init(void)
@@ -135,9 +135,7 @@ static struct {
 	char *machine;
 	void (*init)(void);
 } board_init_funcs[] = {
-#ifdef CONFIG_MACH_TRIMSLICE
 	{ "compulab,trimslice", trimslice_init },
-#endif
 #ifdef CONFIG_MACH_HARMONY
 	{ "nvidia,harmony", harmony_init },
 #endif
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
deleted file mode 100644
index 7b39511..0000000
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- * arch/arm/mach-tegra/board-trimslice-pinmux.c
- *
- * Copyright (C) 2011 CompuLab, Ltd.
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
-#include <linux/kernel.h>
-
-#include "board-trimslice.h"
-#include "board-pinmux.h"
-
-static struct pinctrl_map trimslice_map[] = {
-	TEGRA_MAP_MUXCONF("ata",   "ide",           none, tristate),
-	TEGRA_MAP_MUXCONF("atb",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("atc",   "nand",          none, tristate),
-	TEGRA_MAP_MUXCONF("atd",   "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("ate",   "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("cdev1", "plla_out",      none, driven),
-	TEGRA_MAP_MUXCONF("cdev2", "pllp_out4",     down, tristate),
-	TEGRA_MAP_MUXCONF("crtp",  "crt",           none, tristate),
-	TEGRA_MAP_MUXCONF("csus",  "vi_sensor_clk", down, tristate),
-	TEGRA_MAP_MUXCONF("dap1",  "dap1",          none, driven),
-	TEGRA_MAP_MUXCONF("dap2",  "dap2",          none, tristate),
-	TEGRA_MAP_MUXCONF("dap3",  "dap3",          none, tristate),
-	TEGRA_MAP_MUXCONF("dap4",  "dap4",          none, tristate),
-	TEGRA_MAP_MUXCONF("ddc",   "i2c2",          up,   driven),
-	TEGRA_MAP_MUXCONF("dta",   "vi",            none, tristate),
-	TEGRA_MAP_MUXCONF("dtb",   "vi",            none, tristate),
-	TEGRA_MAP_MUXCONF("dtc",   "vi",            none, tristate),
-	TEGRA_MAP_MUXCONF("dtd",   "vi",            none, tristate),
-	TEGRA_MAP_MUXCONF("dte",   "vi",            none, tristate),
-	TEGRA_MAP_MUXCONF("dtf",   "i2c3",          up,   driven),
-	TEGRA_MAP_MUXCONF("gma",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("gmb",   "nand",          none, tristate),
-	TEGRA_MAP_MUXCONF("gmc",   "sflash",        none, driven),
-	TEGRA_MAP_MUXCONF("gmd",   "sflash",        none, driven),
-	TEGRA_MAP_MUXCONF("gme",   "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("gpu",   "uarta",         none, driven),
-	TEGRA_MAP_MUXCONF("gpu7",  "rtck",          none, driven),
-	TEGRA_MAP_MUXCONF("gpv",   "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("hdint", "hdmi",          na,   tristate),
-	TEGRA_MAP_MUXCONF("i2cp",  "i2cp",          none, tristate),
-	TEGRA_MAP_MUXCONF("irrx",  "uartb",         up,   tristate),
-	TEGRA_MAP_MUXCONF("irtx",  "uartb",         up,   tristate),
-	TEGRA_MAP_MUXCONF("kbca",  "kbc",           up,   tristate),
-	TEGRA_MAP_MUXCONF("kbcb",  "kbc",           up,   tristate),
-	TEGRA_MAP_MUXCONF("kbcc",  "kbc",           up,   tristate),
-	TEGRA_MAP_MUXCONF("kbcd",  "kbc",           up,   tristate),
-	TEGRA_MAP_MUXCONF("kbce",  "kbc",           up,   tristate),
-	TEGRA_MAP_MUXCONF("kbcf",  "kbc",           up,   tristate),
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
-	TEGRA_MAP_MUXCONF("ldc",   "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("ldi",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhp0",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhp1",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhp2",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lhs",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lm0",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lm1",   "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lpp",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lpw0",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lpw1",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lpw2",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lsc0",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lsc1",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lsck",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lsda",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lsdi",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lspi",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lvp0",  "displaya",      na,   tristate),
-	TEGRA_MAP_MUXCONF("lvp1",  "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("lvs",   "displaya",      na,   driven),
-	TEGRA_MAP_MUXCONF("owc",   "rsvd2",         up,   tristate),
-	TEGRA_MAP_MUXCONF("pmc",   "pwr_on",        na,   tristate),
-	TEGRA_MAP_MUXCONF("pta",   "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("rm",    "i2c1",          up,   driven),
-	TEGRA_MAP_MUXCONF("sdb",   "pwm",           na,   driven),
-	TEGRA_MAP_MUXCONF("sdc",   "pwm",           up,   driven),
-	TEGRA_MAP_MUXCONF("sdd",   "pwm",           up,   driven),
-	TEGRA_MAP_MUXCONF("sdio1", "sdio1",         none, driven),
-	TEGRA_MAP_MUXCONF("slxa",  "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("slxc",  "sdio3",         none, tristate),
-	TEGRA_MAP_MUXCONF("slxd",  "sdio3",         none, tristate),
-	TEGRA_MAP_MUXCONF("slxk",  "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("spdi",  "spdif",         none, tristate),
-	TEGRA_MAP_MUXCONF("spdo",  "spdif",         none, tristate),
-	TEGRA_MAP_MUXCONF("spia",  "spi2",          down, tristate),
-	TEGRA_MAP_MUXCONF("spib",  "spi2",          down, tristate),
-	TEGRA_MAP_MUXCONF("spic",  "spi2",          up,   tristate),
-	TEGRA_MAP_MUXCONF("spid",  "spi1",          down, tristate),
-	TEGRA_MAP_MUXCONF("spie",  "spi1",          up,   tristate),
-	TEGRA_MAP_MUXCONF("spif",  "spi1",          down, tristate),
-	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      up,   tristate),
-	TEGRA_MAP_MUXCONF("spih",  "spi2_alt",      up,   tristate),
-	TEGRA_MAP_MUXCONF("uaa",   "ulpi",          up,   tristate),
-	TEGRA_MAP_MUXCONF("uab",   "ulpi",          up,   tristate),
-	TEGRA_MAP_MUXCONF("uac",   "rsvd2",         none, driven),
-	TEGRA_MAP_MUXCONF("uad",   "irda",          up,   tristate),
-	TEGRA_MAP_MUXCONF("uca",   "uartc",         up,   tristate),
-	TEGRA_MAP_MUXCONF("ucb",   "uartc",         up,   tristate),
-	TEGRA_MAP_MUXCONF("uda",   "ulpi",          none, tristate),
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
-	.maps = trimslice_map,
-	.map_count = ARRAY_SIZE(trimslice_map),
-};
-
-void trimslice_pinmux_init(void)
-{
-	tegra_board_pinmux_init(&conf, NULL);
-}
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
deleted file mode 100644
index 776aa95..0000000
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- * arch/arm/mach-tegra/board-trimslice.c
- *
- * Copyright (C) 2011 CompuLab, Ltd.
- * Author: Mike Rapoport <mike@compulab.co.il>
- *
- * Based on board-harmony.c
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
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/serial_8250.h>
-#include <linux/of_serial.h>
-#include <linux/io.h>
-#include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <linux/platform_data/tegra_usb.h>
-
-#include <asm/hardware/gic.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/setup.h>
-
-#include <mach/iomap.h>
-#include <mach/sdhci.h>
-
-#include "board.h"
-#include "clock.h"
-#include "devices.h"
-#include "gpio-names.h"
-
-#include "board-trimslice.h"
-
-static struct plat_serial8250_port debug_uart_platform_data[] = {
-	{
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
-		.flags		= 0
-	}
-};
-
-static struct platform_device debug_uart = {
-	.name	= "serial8250",
-	.id	= PLAT8250_DEV_PLATFORM,
-	.dev	= {
-		.platform_data	= debug_uart_platform_data,
-	},
-};
-static struct tegra_sdhci_platform_data sdhci_pdata1 = {
-	.cd_gpio	= -1,
-	.wp_gpio	= -1,
-	.power_gpio	= -1,
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata4 = {
-	.cd_gpio	= TRIMSLICE_GPIO_SD4_CD,
-	.wp_gpio	= TRIMSLICE_GPIO_SD4_WP,
-	.power_gpio	= -1,
-};
-
-static struct platform_device trimslice_audio_device = {
-	.name	= "tegra-snd-trimslice",
-	.id	= 0,
-};
-
-static struct platform_device *trimslice_devices[] __initdata = {
-	&debug_uart,
-	&tegra_sdhci_device1,
-	&tegra_sdhci_device4,
-	&tegra_i2s_device1,
-	&tegra_das_device,
-	&trimslice_audio_device,
-};
-
-static struct i2c_board_info trimslice_i2c3_board_info[] = {
-	{
-		I2C_BOARD_INFO("tlv320aic23", 0x1a),
-	},
-	{
-		I2C_BOARD_INFO("em3027", 0x56),
-	},
-};
-
-static void trimslice_i2c_init(void)
-{
-	platform_device_register(&tegra_i2c_device1);
-	platform_device_register(&tegra_i2c_device2);
-	platform_device_register(&tegra_i2c_device3);
-
-	i2c_register_board_info(2, trimslice_i2c3_board_info,
-				ARRAY_SIZE(trimslice_i2c3_board_info));
-}
-
-static void trimslice_usb_init(void)
-{
-	struct tegra_ehci_platform_data *pdata;
-
-	pdata = tegra_ehci1_device.dev.platform_data;
-	pdata->vbus_gpio = TRIMSLICE_GPIO_USB1_MODE;
-
-	tegra_ehci2_ulpi_phy_config.reset_gpio = TEGRA_GPIO_PV0;
-
-	platform_device_register(&tegra_ehci3_device);
-	platform_device_register(&tegra_ehci2_device);
-	platform_device_register(&tegra_ehci1_device);
-}
-
-static void __init tegra_trimslice_fixup(struct tag *tags, char **cmdline,
-	struct meminfo *mi)
-{
-	mi->nr_banks = 2;
-	mi->bank[0].start = PHYS_OFFSET;
-	mi->bank[0].size = 448 * SZ_1M;
-	mi->bank[1].start = SZ_512M;
-	mi->bank[1].size = SZ_512M;
-}
-
-static __initdata struct tegra_clk_init_table trimslice_clk_init_table[] = {
-	/* name		parent		rate		enabled */
-	{ "uarta",	"pll_p",	216000000,	true },
-	{ "pll_a",	"pll_p_out1",	56448000,	true },
-	{ "pll_a_out0",	"pll_a",	11289600,	true },
-	{ "cdev1",	NULL,		0,		true },
-	{ "i2s1",	"pll_a_out0",	11289600,	false},
-	{ NULL,		NULL,		0,		0},
-};
-
-static int __init tegra_trimslice_pci_init(void)
-{
-	if (!machine_is_trimslice())
-		return 0;
-
-	return tegra_pcie_init(true, true);
-}
-subsys_initcall(tegra_trimslice_pci_init);
-
-static void __init tegra_trimslice_init(void)
-{
-	tegra_clk_init_from_table(trimslice_clk_init_table);
-
-	trimslice_pinmux_init();
-
-	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
-	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
-
-	platform_add_devices(trimslice_devices, ARRAY_SIZE(trimslice_devices));
-
-	trimslice_i2c_init();
-	trimslice_usb_init();
-}
-
-MACHINE_START(TRIMSLICE, "trimslice")
-	.atag_offset	= 0x100,
-	.fixup		= tegra_trimslice_fixup,
-	.map_io         = tegra_map_common_io,
-	.init_early	= tegra20_init_early,
-	.init_irq       = tegra_init_irq,
-	.handle_irq	= gic_handle_irq,
-	.timer          = &tegra_timer,
-	.init_machine   = tegra_trimslice_init,
-	.init_late	= tegra_init_late,
-	.restart	= tegra_assert_system_reset,
-MACHINE_END
diff --git a/arch/arm/mach-tegra/board-trimslice.h b/arch/arm/mach-tegra/board-trimslice.h
deleted file mode 100644
index 50f128d..0000000
--- a/arch/arm/mach-tegra/board-trimslice.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * arch/arm/mach-tegra/board-trimslice.h
- *
- * Copyright (C) 2011 CompuLab, Ltd.
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
-#ifndef _MACH_TEGRA_BOARD_TRIMSLICE_H
-#define _MACH_TEGRA_BOARD_TRIMSLICE_H
-
-#include <mach/gpio-tegra.h>
-
-#define TRIMSLICE_GPIO_SD4_CD	TEGRA_GPIO_PP1	/* mmc4 cd */
-#define TRIMSLICE_GPIO_SD4_WP	TEGRA_GPIO_PP2	/* mmc4 wp */
-
-#define TRIMSLICE_GPIO_USB1_MODE	TEGRA_GPIO_PV2 /* USB1 mode */
-#define TRIMSLICE_GPIO_USB2_RST		TEGRA_GPIO_PV0 /* USB2 PHY reset */
-
-void trimslice_pinmux_init(void);
-
-#endif
-- 
1.7.0.4
