From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:23 +0900
Subject: [PATCH 07/11] ARM: shmobile: kzm9g-reference: Remove board C code and
 DT file
In-Reply-To: <cover.1425518682.git.horms+renesas@verge.net.au>
References: <cover.1425518682.git.horms+renesas@verge.net.au>
Message-ID: <7a91cc14f3ff6c70855d25fe7b7c0592ab023050.1425518682.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the sh73a0 generic multiplatform case has the same feature set
as the kzm9g DT reference board code, we get rid of the latter.
DT reference code in the future shall make use of the sh73a0
multiplatform support code with the generic SoC machine vector.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 398 ---------------------
 arch/arm/mach-shmobile/Kconfig                     |  14 -
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  62 ----
 arch/arm/mach-shmobile/include/mach/zboot.h        |   2 +-
 8 files changed, 2 insertions(+), 481 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 51147cb..c69f127 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -57,8 +57,6 @@ Boards:
     compatible = "renesas,kzm9d", "renesas,emev2"
   - Kyoto Microcomputer Co. KZM-A9-GT
     compatible = "renesas,kzm9g", "renesas,sh73a0"
-  - Kyoto Microcomputer Co. KZM-A9-GT - Reference Device Tree Implementation
-    compatible = "renesas,kzm9g-reference", "renesas,sh73a0"
   - Lager (RTP0RC7790SEB00010S)
     compatible = "renesas,lager", "renesas,r8a7790"
   - Mackerel (R0P7372LC0016RL, AP4 EVM 2nd)
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 287ebca..aa26d13 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -471,8 +471,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen.dtb \
 	sh7372-mackerel.dtb \
-	sh73a0-kzm9g.dtb \
-	sh73a0-kzm9g-reference.dtb
+	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
deleted file mode 100644
index bf365f7..0000000
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ /dev/null
@@ -1,398 +0,0 @@
-/*
- * Device Tree Source for the KZM-A9-GT board
- *
- * Copyright (C) 2012 Horms Solutions Ltd.
- *
- * Based on sh73a0-kzm9g.dts
- * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/dts-v1/;
-#include "sh73a0.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	model = "KZM-A9-GT";
-	compatible = "renesas,kzm9g-reference", "renesas,sh73a0";
-
-	aliases {
-		serial4 = &scifa4;
-	};
-
-	cpus {
-		cpu at 0 {
-			cpu0-supply = <&vdd_dvfs>;
-			operating-points = <
-				/* kHz  uV */
-				1196000 1315000
-				 598000 1175000
-				 398667 1065000
-			>;
-			voltage-tolerance = <1>; /* 1% */
-		};
-	};
-
-	chosen {
-		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel rw";
-		stdout-path = &scifa4;
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x40000000 0x20000000>;
-	};
-
-	reg_1p8v: regulator at 0 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	reg_3p3v: regulator at 1 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	vmmc_sdhi0: regulator at 2 {
-		compatible = "regulator-fixed";
-		regulator-name = "SDHI0 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&pfc 15 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vmmc_sdhi2: regulator at 3 {
-		compatible = "regulator-fixed";
-		regulator-name = "SDHI2 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&pfc 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	lan9220 at 10000000 {
-		compatible = "smsc,lan9220", "smsc,lan9115";
-		reg = <0x10000000 0x100>;
-		phy-mode = "mii";
-		interrupt-parent = <&irqpin0>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		reg-io-width = <4>;
-		smsc,irq-push-pull;
-		smsc,save-mac-address;
-		vddvario-supply = <&reg_1p8v>;
-		vdd33a-supply = <&reg_3p3v>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		led1 {
-			gpios = <&pfc 20 GPIO_ACTIVE_LOW>;
-			label = "LED1";
-		};
-		led2 {
-			gpios = <&pfc 21 GPIO_ACTIVE_LOW>;
-			label = "LED2";
-		};
-		led3 {
-			gpios = <&pfc 22 GPIO_ACTIVE_LOW>;
-			label = "LED3";
-		};
-		led4 {
-			gpios = <&pfc 23 GPIO_ACTIVE_LOW>;
-			label = "LED4";
-		};
-	};
-
-	keyboard {
-		compatible = "gpio-keys";
-
-		back-key {
-			gpios = <&pcf8575 8 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_BACK>;
-			label = "SW3";
-		};
-
-		right-key {
-			gpios = <&pcf8575 9 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_RIGHT>;
-			label = "SW2-R";
-		};
-
-		left-key {
-			gpios = <&pcf8575 10 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_LEFT>;
-			label = "SW2-L";
-		};
-
-		enter-key {
-			gpios = <&pcf8575 11 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_ENTER>;
-			label = "SW2-P";
-		};
-
-		up-key {
-			gpios = <&pcf8575 12 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_UP>;
-			label = "SW2-U";
-		};
-
-		down-key {
-			gpios = <&pcf8575 13 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_DOWN>;
-			label = "SW2-D";
-		};
-
-		home-key {
-			gpios = <&pcf8575 14 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_HOME>;
-			label = "SW1";
-		};
-	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,format = "left_j";
-		simple-audio-card,cpu {
-			sound-dai = <&sh_fsi2 0>;
-		};
-		simple-audio-card,codec {
-			sound-dai = <&ak4648>;
-			bitclock-master;
-			frame-master;
-			system-clock-frequency = <11289600>;
-		};
-	};
-};
-
-&cmt1 {
-	status = "okay";
-};
-
-&extal2_clk {
-	clock-frequency = <48000000>;
-};
-
-&i2c0 {
-	status = "okay";
-
-	compass at c {
-		compatible = "asahi-kasei,ak8975";
-		reg = <0x0c>;
-		interrupt-parent = <&irqpin3>;
-		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-	};
-
-	ak4648: codec at 12 {
-		compatible = "asahi-kasei,ak4648";
-		reg = <0x12>;
-		#sound-dai-cells = <0>;
-	};
-
-	accelerometer at 1d {
-		compatible = "adi,adxl34x";
-		reg = <0x1d>;
-		interrupt-parent = <&irqpin3>;
-		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
-			     <3 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	rtc at 32 {
-		compatible = "ricoh,r2025sd";
-		reg = <0x32>;
-	};
-
-	as3711 at 40 {
-		compatible = "ams,as3711";
-		reg = <0x40>;
-
-		regulators {
-			vdd_dvfs: sd1 {
-				regulator-name = "1.315V CPU";
-				regulator-min-microvolt = <1050000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-			sd2 {
-				regulator-name = "1.8V";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-			sd4 {
-				regulator-name = "1.215V";
-				regulator-min-microvolt = <1215000>;
-				regulator-max-microvolt = <1235000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-			ldo2 {
-				regulator-name = "2.8V CPU";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-			ldo3 {
-				regulator-name = "3.0V CPU";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-			ldo4 {
-				regulator-name = "2.8V";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-			ldo5 {
-				regulator-name = "2.8V #2";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-			ldo7 {
-				regulator-name = "1.15V CPU";
-				regulator-min-microvolt = <1150000>;
-				regulator-max-microvolt = <1150000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-			ldo8 {
-				regulator-name = "1.15V CPU #2";
-				regulator-min-microvolt = <1150000>;
-				regulator-max-microvolt = <1150000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-		};
-	};
-};
-
-&i2c1 {
-	status = "okay";
-
-	touchscreen at 55 {
-		compatible = "sitronix,st1232";
-		reg = <0x55>;
-		interrupt-parent = <&irqpin1>;
-		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
-	};
-};
-
-&i2c3 {
-	pinctrl-0 = <&i2c3_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	pcf8575: gpio at 20 {
-		compatible = "nxp,pcf8575";
-		reg = <0x20>;
-		interrupt-parent = <&irqpin2>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-};
-
-&mmcif {
-	pinctrl-0 = <&mmcif_pins>;
-	pinctrl-names = "default";
-
-	bus-width = <8>;
-	vmmc-supply = <&reg_1p8v>;
-	status = "okay";
-};
-
-&pfc {
-	i2c3_pins: i2c3 {
-		renesas,groups = "i2c3_1";
-		renesas,function = "i2c3";
-	};
-
-	mmcif_pins: mmc {
-		mux {
-			renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
-			renesas,function = "mmc0";
-		};
-		cfg {
-			renesas,groups = "mmc0_data8_0";
-			renesas,pins = "PORT279";
-			bias-pull-up;
-		};
-	};
-
-	scifa4_pins: serial4 {
-		renesas,groups = "scifa4_data", "scifa4_ctrl";
-		renesas,function = "scifa4";
-	};
-
-	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd", "sdhi0_wp";
-		renesas,function = "sdhi0";
-	};
-
-	sdhi2_pins: sd2 {
-		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
-		renesas,function = "sdhi2";
-	};
-
-	fsia_pins: sounda {
-		renesas,groups = "fsia_mclk_in", "fsia_sclk_in",
-				 "fsia_data_in", "fsia_data_out";
-		renesas,function = "fsia";
-	};
-};
-
-&scifa4 {
-	pinctrl-0 = <&scifa4_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&sdhi0 {
-	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-names = "default";
-
-	vmmc-supply = <&vmmc_sdhi0>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&sdhi2 {
-	pinctrl-0 = <&sdhi2_pins>;
-	pinctrl-names = "default";
-
-	vmmc-supply = <&vmmc_sdhi2>;
-	bus-width = <4>;
-	broken-cd;
-	status = "okay";
-};
-
-&sh_fsi2 {
-	pinctrl-0 = <&fsia_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8ee2f28..f4108d8 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -214,20 +214,6 @@ config MACH_KZM9G
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select USE_OF
 
-config MACH_KZM9G_REFERENCE
-	bool "KZM-A9-GT board - Reference Device Tree Implementation"
-	depends on ARCH_SH73A0
-	select ARCH_REQUIRE_GPIOLIB
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SND_SOC_AK4642 if SND_SIMPLE_CARD
-	select USE_OF
-	---help---
-	   Use reference implementation of KZM-A9-GT board support
-	   which makes as greater use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 comment "Renesas ARM SoCs System Configuration"
 
 config CPU_HAS_INTEVT
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index b400f5f..7b9ed9e 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -66,7 +66,6 @@ obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o intc-sh73a0.o
-obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
 
 # Framework support
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 02532be..6ef0e2b 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -6,7 +6,6 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
-loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
 loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
 
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
deleted file mode 100644
index 2e82e44..0000000
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * KZM-A9-GT board support - Reference Device Tree Implementation
- *
- * Copyright (C) 2012	Horms Solutions Ltd.
- *
- * Based on board-kzm9g.c
- * Copyright (C) 2012	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/input.h>
-#include <linux/of_platform.h>
-
-#include <asm/hardware/cache-l2x0.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "sh73a0.h"
-
-static void __init kzm_init(void)
-{
-	sh73a0_add_standard_devices_dt();
-
-#ifdef CONFIG_CACHE_L2X0
-	/* Shared attribute override enable, 64K*8way */
-	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
-#endif
-}
-
-#define RESCNT2 IOMEM(0xe6188020)
-static void kzm9g_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel((1 << 31), RESCNT2);
-}
-
-static const char *kzm9g_boards_compat_dt[] __initdata = {
-	"renesas,kzm9g-reference",
-	NULL,
-};
-
-DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
-	.smp		= smp_ops(sh73a0_smp_ops),
-	.map_io		= sh73a0_map_io,
-	.init_early	= shmobile_init_delay,
-	.init_machine	= kzm_init,
-	.init_late	= shmobile_init_late,
-	.restart	= kzm9g_restart,
-	.dt_compat	= kzm9g_boards_compat_dt,
-MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/zboot.h b/arch/arm/mach-shmobile/include/mach/zboot.h
index 727cc78..219bbcf 100644
--- a/arch/arm/mach-shmobile/include/mach/zboot.h
+++ b/arch/arm/mach-shmobile/include/mach/zboot.h
@@ -12,7 +12,7 @@
 #ifdef CONFIG_MACH_MACKEREL
 #define MEMORY_START	0x40000000
 #include "mach/head-mackerel.txt"
-#elif defined(CONFIG_MACH_KZM9G) || defined(CONFIG_MACH_KZM9G_REFERENCE)
+#elif defined(CONFIG_MACH_KZM9G)
 #define MEMORY_START	0x43000000
 #include "mach/head-kzm9g.txt"
 #else
-- 
2.1.4
