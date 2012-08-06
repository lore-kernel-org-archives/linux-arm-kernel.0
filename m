From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  6 Aug 2012 15:32:14 -0600
Subject: [PATCH 3/3] ARM: tegra: remove board (but not DT) support for Harmony
In-Reply-To: <1344288734-24131-1-git-send-email-swarren@wwwdotorg.org>
References: <1344288734-24131-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1344288734-24131-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Harmony can be booted using device tree with equal functionality as when
booted using a board file. Remove as much of the board file as is
possible, since it's no longer needed.

Two special-cases are still left in board-dt-tegra20.c, since the Tegra
PCIe driver doesn't support device tree yet, and the Harmony .dts file
doesn't yet describe regulators which are needed for PCIe. This logic is
now enabled unconditionally rather than via CONFIG_MACH_HARMONY. While
this is more code than other boards, it's still unlikely to be much of a
problem, and both regulators and PCIe should be supported via device tree
in the near future, allowing the remaining code to be removed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig                |    6 -
 arch/arm/mach-tegra/Makefile               |    6 +-
 arch/arm/mach-tegra/board-dt-tegra20.c     |    6 +-
 arch/arm/mach-tegra/board-harmony-pinmux.c |  156 ----------------------
 arch/arm/mach-tegra/board-harmony-power.c  |   34 ++---
 arch/arm/mach-tegra/board-harmony.c        |  197 ----------------------------
 arch/arm/mach-tegra/board-harmony.h        |   13 --
 7 files changed, 19 insertions(+), 399 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/board-harmony-pinmux.c
 delete mode 100644 arch/arm/mach-tegra/board-harmony.c

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index f6e79ed..d3e73ec 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -60,12 +60,6 @@ config TEGRA_AHB
 
 comment "Tegra board type"
 
-config MACH_HARMONY
-       bool "Harmony board"
-       depends on ARCH_TEGRA_2x_SOC
-       help
-         Support for nVidia Harmony development platform
-
 choice
         prompt "Default low-level debug console UART"
         default TEGRA_DEBUG_UART_NONE
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 1c2b473..6273853 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -26,9 +26,7 @@ obj-$(CONFIG_USB_SUPPORT)		+= usb_phy.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-dt-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
 
-obj-$(CONFIG_MACH_HARMONY)              += board-harmony.o
-obj-$(CONFIG_MACH_HARMONY)              += board-harmony-pinmux.o
-obj-$(CONFIG_MACH_HARMONY)              += board-harmony-pcie.o
-obj-$(CONFIG_MACH_HARMONY)              += board-harmony-power.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-harmony-pcie.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-harmony-power.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 1d6c9df..d9eeae6 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -107,7 +107,6 @@ static void __init trimslice_init(void)
 #endif
 }
 
-#ifdef CONFIG_MACH_HARMONY
 static void __init harmony_init(void)
 {
 	int ret;
@@ -118,11 +117,12 @@ static void __init harmony_init(void)
 		return;
 	}
 
+#ifdef CONFIG_TEGRA_PCI
 	ret = harmony_pcie_init();
 	if (ret)
 		pr_err("harmony_pcie_init() failed: %d\n", ret);
-}
 #endif
+}
 
 static void __init paz00_init(void)
 {
@@ -134,9 +134,7 @@ static struct {
 	void (*init)(void);
 } board_init_funcs[] = {
 	{ "compulab,trimslice", trimslice_init },
-#ifdef CONFIG_MACH_HARMONY
 	{ "nvidia,harmony", harmony_init },
-#endif
 	{ "compal,paz00", paz00_init },
 };
 
diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
deleted file mode 100644
index 83d420f..0000000
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- * arch/arm/mach-tegra/board-harmony-pinmux.c
- *
- * Copyright (C) 2010 Google, Inc.
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
-#include "board-harmony.h"
-#include "board-pinmux.h"
-
-static struct pinctrl_map harmony_map[] = {
-	TEGRA_MAP_MUXCONF("ata",   "ide",           none, driven),
-	TEGRA_MAP_MUXCONF("atb",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("atc",   "nand",          none, driven),
-	TEGRA_MAP_MUXCONF("atd",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("ate",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("cdev1", "plla_out",      none, driven),
-	TEGRA_MAP_MUXCONF("cdev2", "pllp_out4",     down, tristate),
-	TEGRA_MAP_MUXCONF("crtp",  "crt",           none, tristate),
-	TEGRA_MAP_MUXCONF("csus",  "vi_sensor_clk", down, tristate),
-	TEGRA_MAP_MUXCONF("dap1",  "dap1",          none, driven),
-	TEGRA_MAP_MUXCONF("dap2",  "dap2",          none, tristate),
-	TEGRA_MAP_MUXCONF("dap3",  "dap3",          none, tristate),
-	TEGRA_MAP_MUXCONF("dap4",  "dap4",          none, tristate),
-	TEGRA_MAP_MUXCONF("ddc",   "i2c2",          up,   driven),
-	TEGRA_MAP_MUXCONF("dta",   "sdio2",         up,   driven),
-	TEGRA_MAP_MUXCONF("dtb",   "rsvd1",         none, driven),
-	TEGRA_MAP_MUXCONF("dtc",   "rsvd1",         none, tristate),
-	TEGRA_MAP_MUXCONF("dtd",   "sdio2",         up,   driven),
-	TEGRA_MAP_MUXCONF("dte",   "rsvd1",         none, tristate),
-	TEGRA_MAP_MUXCONF("dtf",   "i2c3",          none, tristate),
-	TEGRA_MAP_MUXCONF("gma",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("gmb",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("gmc",   "uartd",         none, driven),
-	TEGRA_MAP_MUXCONF("gmd",   "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("gme",   "sdio4",         none, driven),
-	TEGRA_MAP_MUXCONF("gpu",   "gmi",           none, tristate),
-	TEGRA_MAP_MUXCONF("gpu7",  "rtck",          none, driven),
-	TEGRA_MAP_MUXCONF("gpv",   "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("hdint", "hdmi",          na,   tristate),
-	TEGRA_MAP_MUXCONF("i2cp",  "i2cp",          none, driven),
-	TEGRA_MAP_MUXCONF("irrx",  "uarta",         up,   tristate),
-	TEGRA_MAP_MUXCONF("irtx",  "uarta",         up,   tristate),
-	TEGRA_MAP_MUXCONF("kbca",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcb",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcc",  "kbc",           up,   driven),
-	TEGRA_MAP_MUXCONF("kbcd",  "kbc",           up,   driven),
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
-	TEGRA_MAP_MUXCONF("owc",   "rsvd2",         na,   tristate),
-	TEGRA_MAP_MUXCONF("pmc",   "pwr_on",        na,   driven),
-	TEGRA_MAP_MUXCONF("pta",   "hdmi",          none, driven),
-	TEGRA_MAP_MUXCONF("rm",    "i2c1",          none, driven),
-	TEGRA_MAP_MUXCONF("sdb",   "pwm",           na,   tristate),
-	TEGRA_MAP_MUXCONF("sdc",   "pwm",           up,   driven),
-	TEGRA_MAP_MUXCONF("sdd",   "pwm",           up,   tristate),
-	TEGRA_MAP_MUXCONF("sdio1", "sdio1",         none, tristate),
-	TEGRA_MAP_MUXCONF("slxa",  "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("slxc",  "spdif",         none, tristate),
-	TEGRA_MAP_MUXCONF("slxd",  "spdif",         none, tristate),
-	TEGRA_MAP_MUXCONF("slxk",  "pcie",          none, driven),
-	TEGRA_MAP_MUXCONF("spdi",  "rsvd2",         none, tristate),
-	TEGRA_MAP_MUXCONF("spdo",  "rsvd2",         none, tristate),
-	TEGRA_MAP_MUXCONF("spia",  "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("spib",  "gmi",           none, driven),
-	TEGRA_MAP_MUXCONF("spic",  "gmi",           up,   tristate),
-	TEGRA_MAP_MUXCONF("spid",  "spi1",          down, tristate),
-	TEGRA_MAP_MUXCONF("spie",  "spi1",          up,   tristate),
-	TEGRA_MAP_MUXCONF("spif",  "spi1",          down, tristate),
-	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      none, tristate),
-	TEGRA_MAP_MUXCONF("spih",  "spi2_alt",      up,   tristate),
-	TEGRA_MAP_MUXCONF("uaa",   "ulpi",          up,   tristate),
-	TEGRA_MAP_MUXCONF("uab",   "ulpi",          up,   tristate),
-	TEGRA_MAP_MUXCONF("uac",   "rsvd2",         none, tristate),
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
-	.maps = harmony_map,
-	.map_count = ARRAY_SIZE(harmony_map),
-};
-
-void harmony_pinmux_init(void)
-{
-	tegra_board_pinmux_init(&conf, NULL);
-}
diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
index b7344be..8f9cf77 100644
--- a/arch/arm/mach-tegra/board-harmony-power.c
+++ b/arch/arm/mach-tegra/board-harmony-power.c
@@ -120,29 +120,25 @@ static struct i2c_board_info __initdata harmony_regulators[] = {
 
 int __init harmony_regulator_init(void)
 {
+	struct device_node *np;
+	struct i2c_adapter *adapter;
+
 	regulator_register_always_on(0, "vdd_sys",
 		NULL, 0, 5000000);
 
-	if (machine_is_harmony()) {
-		i2c_register_board_info(3, harmony_regulators, 1);
-	} else { /* Harmony, booted using device tree */
-		struct device_node *np;
-		struct i2c_adapter *adapter;
-
-		np = of_find_node_by_path("/i2c at 7000d000");
-		if (np == NULL) {
-			pr_err("Could not find device_node for DVC I2C\n");
-			return -ENODEV;
-		}
-
-		adapter = of_find_i2c_adapter_by_node(np);
-		if (!adapter) {
-			pr_err("Could not find i2c_adapter for DVC I2C\n");
-			return -ENODEV;
-		}
-
-		i2c_new_device(adapter, harmony_regulators);
+	np = of_find_node_by_path("/i2c at 7000d000");
+	if (np == NULL) {
+		pr_err("Could not find device_node for DVC I2C\n");
+		return -ENODEV;
+	}
+
+	adapter = of_find_i2c_adapter_by_node(np);
+	if (!adapter) {
+		pr_err("Could not find i2c_adapter for DVC I2C\n");
+		return -ENODEV;
 	}
 
+	i2c_new_device(adapter, harmony_regulators);
+
 	return 0;
 }
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
deleted file mode 100644
index e65e837..0000000
--- a/arch/arm/mach-tegra/board-harmony.c
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * arch/arm/mach-tegra/board-harmony.c
- *
- * Copyright (C) 2010 Google, Inc.
- * Copyright (C) 2011 NVIDIA, Inc.
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
-#include <linux/clk.h>
-#include <linux/dma-mapping.h>
-#include <linux/pda_power.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-
-#include <sound/wm8903.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <asm/hardware/gic.h>
-#include <asm/setup.h>
-
-#include <mach/tegra_wm8903_pdata.h>
-#include <mach/iomap.h>
-#include <mach/irqs.h>
-#include <mach/sdhci.h>
-
-#include "board.h"
-#include "board-harmony.h"
-#include "clock.h"
-#include "devices.h"
-#include "gpio-names.h"
-
-static struct plat_serial8250_port debug_uart_platform_data[] = {
-	{
-		.membase	= IO_ADDRESS(TEGRA_UARTD_BASE),
-		.mapbase	= TEGRA_UARTD_BASE,
-		.irq		= INT_UARTD,
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
-
-static struct tegra_wm8903_platform_data harmony_audio_pdata = {
-	.gpio_spkr_en		= TEGRA_GPIO_SPKR_EN,
-	.gpio_hp_det		= TEGRA_GPIO_HP_DET,
-	.gpio_hp_mute		= -1,
-	.gpio_int_mic_en	= TEGRA_GPIO_INT_MIC_EN,
-	.gpio_ext_mic_en	= TEGRA_GPIO_EXT_MIC_EN,
-};
-
-static struct platform_device harmony_audio_device = {
-	.name	= "tegra-snd-wm8903",
-	.id	= 0,
-	.dev	= {
-		.platform_data  = &harmony_audio_pdata,
-	},
-};
-
-static struct wm8903_platform_data harmony_wm8903_pdata = {
-	.irq_active_low = 0,
-	.micdet_cfg = 0,
-	.micdet_delay = 100,
-	.gpio_base = HARMONY_GPIO_WM8903(0),
-	.gpio_cfg = {
-		0,
-		0,
-		WM8903_GPIO_CONFIG_ZERO,
-		0,
-		0,
-	},
-};
-
-static struct i2c_board_info __initdata wm8903_board_info = {
-	I2C_BOARD_INFO("wm8903", 0x1a),
-	.platform_data = &harmony_wm8903_pdata,
-};
-
-static void __init harmony_i2c_init(void)
-{
-	platform_device_register(&tegra_i2c_device1);
-	platform_device_register(&tegra_i2c_device2);
-	platform_device_register(&tegra_i2c_device3);
-	platform_device_register(&tegra_i2c_device4);
-
-	wm8903_board_info.irq = gpio_to_irq(TEGRA_GPIO_CDC_IRQ);
-	i2c_register_board_info(0, &wm8903_board_info, 1);
-}
-
-static struct platform_device *harmony_devices[] __initdata = {
-	&debug_uart,
-	&tegra_sdhci_device1,
-	&tegra_sdhci_device2,
-	&tegra_sdhci_device4,
-	&tegra_ehci3_device,
-	&tegra_i2s_device1,
-	&tegra_das_device,
-	&harmony_audio_device,
-};
-
-static void __init tegra_harmony_fixup(struct tag *tags, char **cmdline,
-	struct meminfo *mi)
-{
-	mi->nr_banks = 2;
-	mi->bank[0].start = PHYS_OFFSET;
-	mi->bank[0].size = 448 * SZ_1M;
-	mi->bank[1].start = SZ_512M;
-	mi->bank[1].size = SZ_512M;
-}
-
-static __initdata struct tegra_clk_init_table harmony_clk_init_table[] = {
-	/* name		parent		rate		enabled */
-	{ "uartd",	"pll_p",	216000000,	true },
-	{ "pll_a",	"pll_p_out1",	56448000,	true },
-	{ "pll_a_out0",	"pll_a",	11289600,	true },
-	{ "cdev1",	NULL,		0,		true },
-	{ "i2s1",	"pll_a_out0",	11289600,	false},
-	{ "usb3",	"clk_m",	12000000,	true },
-	{ NULL,		NULL,		0,		0},
-};
-
-
-static struct tegra_sdhci_platform_data sdhci_pdata1 = {
-	.cd_gpio	= -1,
-	.wp_gpio	= -1,
-	.power_gpio	= -1,
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata2 = {
-	.cd_gpio	= TEGRA_GPIO_SD2_CD,
-	.wp_gpio	= TEGRA_GPIO_SD2_WP,
-	.power_gpio	= TEGRA_GPIO_SD2_POWER,
-};
-
-static struct tegra_sdhci_platform_data sdhci_pdata4 = {
-	.cd_gpio	= TEGRA_GPIO_SD4_CD,
-	.wp_gpio	= TEGRA_GPIO_SD4_WP,
-	.power_gpio	= TEGRA_GPIO_SD4_POWER,
-	.is_8bit	= 1,
-};
-
-static void __init tegra_harmony_init(void)
-{
-	tegra_clk_init_from_table(harmony_clk_init_table);
-
-	harmony_pinmux_init();
-
-	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
-	tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
-	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
-
-	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
-	harmony_i2c_init();
-	harmony_regulator_init();
-}
-
-MACHINE_START(HARMONY, "harmony")
-	.atag_offset	= 0x100,
-	.fixup		= tegra_harmony_fixup,
-	.map_io         = tegra_map_common_io,
-	.init_early	= tegra20_init_early,
-	.init_irq       = tegra_init_irq,
-	.handle_irq	= gic_handle_irq,
-	.timer          = &tegra_timer,
-	.init_machine   = tegra_harmony_init,
-	.init_late	= tegra_init_late,
-	.restart	= tegra_assert_system_reset,
-MACHINE_END
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 139d96c..7ae8708 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -20,22 +20,9 @@
 #include <mach/gpio-tegra.h>
 
 #define HARMONY_GPIO_TPS6586X(_x_)	(TEGRA_NR_GPIOS + (_x_))
-#define HARMONY_GPIO_WM8903(_x_)	(HARMONY_GPIO_TPS6586X(4) + (_x_))
 
-#define TEGRA_GPIO_SD2_CD		TEGRA_GPIO_PI5
-#define TEGRA_GPIO_SD2_WP		TEGRA_GPIO_PH1
-#define TEGRA_GPIO_SD2_POWER		TEGRA_GPIO_PT3
-#define TEGRA_GPIO_SD4_CD		TEGRA_GPIO_PH2
-#define TEGRA_GPIO_SD4_WP		TEGRA_GPIO_PH3
-#define TEGRA_GPIO_SD4_POWER		TEGRA_GPIO_PI6
-#define TEGRA_GPIO_CDC_IRQ		TEGRA_GPIO_PX3
-#define TEGRA_GPIO_SPKR_EN		HARMONY_GPIO_WM8903(2)
-#define TEGRA_GPIO_HP_DET		TEGRA_GPIO_PW2
-#define TEGRA_GPIO_INT_MIC_EN		TEGRA_GPIO_PX0
-#define TEGRA_GPIO_EXT_MIC_EN		TEGRA_GPIO_PX1
 #define TEGRA_GPIO_EN_VDD_1V05_GPIO	HARMONY_GPIO_TPS6586X(2)
 
-void harmony_pinmux_init(void);
 int harmony_regulator_init(void);
 
 #endif
-- 
1.7.0.4
