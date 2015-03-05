From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:00 +0900
Subject: [PATCH 08/13] ARM: shmobile: ape6evm-reference: Remove board C code
 and DT file
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <8ba1f188d605a1b3dca8073d43e9dfba654775b2.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Now that the r8a73a4 generic multiplatform case has the same features as the
APE6EVM DT reference board code, we get rid of the latter.  DT reference
code in the future shall make use of the r8a73a4 multiplatform support code
with the generic SoC machine vector.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[geert: Update Documentation/devicetree/bindings/arm/shmobile.txt]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 arch/arm/boot/dts/Makefile                         |   1 -
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    | 156 ---------------------
 arch/arm/mach-shmobile/Kconfig                     |  12 --
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |  61 --------
 7 files changed, 234 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 51147cb..18a8591 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -37,8 +37,6 @@ Boards:
     compatible = "renesas,alt", "renesas,r8a7794"
   - APE6-EVM
     compatible = "renesas,ape6evm", "renesas,r8a73a4"
-  - APE6-EVM - Reference Device Tree Implementation
-    compatible = "renesas,ape6evm-reference", "renesas,r8a73a4"
   - Atmark Techno Armadillo-800 EVA
     compatible = "renesas,armadillo800eva"
   - BOCK-W
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..d3e6cf3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -465,7 +465,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a73a4-ape6evm.dtb \
-	r8a73a4-ape6evm-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
deleted file mode 100644
index b3d8f84..0000000
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- * Device Tree Source for the APE6EVM board
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/dts-v1/;
-#include "r8a73a4.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "APE6EVM";
-	compatible = "renesas,ape6evm-reference", "renesas,r8a73a4";
-
-	aliases {
-		serial0 = &scifa0;
-	};
-
-	chosen {
-		bootargs = "ignore_loglevel rw";
-		stdout-path = &scifa0;
-	};
-
-	memory at 40000000 {
-		device_type = "memory";
-		reg = <0 0x40000000 0 0x40000000>;
-	};
-
-	memory at 200000000 {
-		device_type = "memory";
-		reg = <2 0x00000000 0 0x40000000>;
-	};
-
-	vcc_mmc0: regulator at 0 {
-		compatible = "regulator-fixed";
-		regulator-name = "MMC0 Vcc";
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-		regulator-always-on;
-	};
-
-	vcc_sdhi0: regulator at 1 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "SDHI0 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&pfc 76 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	/* Common 3.3V rail, used by several devices on APE6EVM */
-	ape6evm_fixed_3v3: regulator at 2 {
-		compatible = "regulator-fixed";
-		regulator-name = "3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	lbsc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0x20000000>;
-	};
-};
-
-&i2c5 {
-	status = "okay";
-	vdd_dvfs: max8973 at 1b {
-		compatible = "maxim,max8973";
-		reg = <0x1b>;
-
-		regulator-min-microvolt = <935000>;
-		regulator-max-microvolt = <1200000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-};
-
-&cpu0 {
-	cpu0-supply = <&vdd_dvfs>;
-	operating-points = <
-		/* kHz  uV */
-		1950000 1115000
-		1462500  995000
-	>;
-	voltage-tolerance = <1>; /* 1% */
-};
-
-&cmt1 {
-	status = "okay";
-};
-
-&pfc {
-	scifa0_pins: serial0 {
-		renesas,groups = "scifa0_data";
-		renesas,function = "scifa0";
-	};
-
-	mmc0_pins: mmc {
-		renesas,groups = "mmc0_data8", "mmc0_ctrl";
-		renesas,function = "mmc0";
-	};
-
-	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
-		renesas,function = "sdhi0";
-	};
-
-	sdhi1_pins: sd1 {
-		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
-		renesas,function = "sdhi1";
-	};
-};
-
-&mmcif0 {
-	vmmc-supply = <&vcc_mmc0>;
-	bus-width = <8>;
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	status = "okay";
-};
-
-&scifa0 {
-	pinctrl-0 = <&scifa0_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&sdhi0 {
-	vmmc-supply = <&vcc_sdhi0>;
-	bus-width = <4>;
-	toshiba,mmc-wrprotect-disable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhi0_pins>;
-	status = "okay";
-};
-
-&sdhi1 {
-	vmmc-supply = <&ape6evm_fixed_3v3>;
-	bus-width = <4>;
-	broken-cd;
-	toshiba,mmc-wrprotect-disable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhi1_pins>;
-	status = "okay";
-};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2f36c85..f8977e7 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -142,18 +142,6 @@ config MACH_APE6EVM
 	select SMSC_PHY if SMSC911X
 	select USE_OF
 
-config MACH_APE6EVM_REFERENCE
-	bool "APE6EVM board - Reference Device Tree Implementation"
-	depends on ARCH_R8A73A4
-	select SMSC_PHY if SMSC911X
-	select USE_OF
-	---help---
-	   Use reference implementation of APE6EVM board support
-	   which makes a greater use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_MACKEREL
 	bool "mackerel board"
 	depends on ARCH_SH7372
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d53996e..40f82ee 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -59,7 +59,6 @@ ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
-obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 02532be..e67a6c9 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -1,7 +1,6 @@
 # per-board load address for uImage
 loadaddr-y	:=
 loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
-loadaddr-$(CONFIG_MACH_APE6EVM_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
deleted file mode 100644
index dd5bc63..0000000
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * APE6EVM board support
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/of_platform.h>
-#include <linux/pinctrl/machine.h>
-#include <linux/platform_device.h>
-#include <linux/sh_clk.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "r8a73a4.h"
-
-static void __init ape6evm_add_standard_devices(void)
-{
-#ifndef CONFIG_COMMON_CLK
-	struct clk *parent;
-	struct clk *mp;
-
-	r8a73a4_clock_init();
-
-	/* MP clock parent = extal2 */
-	parent      = clk_get(NULL, "extal2");
-	mp          = clk_get(NULL, "mp");
-	BUG_ON(IS_ERR(parent) || IS_ERR(mp));
-
-	clk_set_parent(mp, parent);
-	clk_put(parent);
-	clk_put(mp);
-#endif
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static const char *ape6evm_boards_compat_dt[] __initdata = {
-	"renesas,ape6evm-reference",
-	NULL,
-};
-
-DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= shmobile_init_delay,
-	.init_machine	= ape6evm_add_standard_devices,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= ape6evm_boards_compat_dt,
-MACHINE_END
-- 
2.1.4
