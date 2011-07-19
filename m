From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 19 Jul 2011 10:24:46 +0800
Subject: [PATCH 3/7] ARM: mmp: support DT on both dkb and brownstone
In-Reply-To: <1311042290-20253-3-git-send-email-haojian.zhuang@marvell.com>
References: <2011071901>
	<1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1311042290-20253-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new boards.c to support both TTC-DKB and MMP2-BROWNSTONE. While
CONFIG_MMP_USE_OF is selected, original ttc_dkb.c and brownstone.c won't be
compiled.

While everything moving to DT in ARCH-MMP, original ttc_dkb.c and brownstone.c
will be abandoned.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 .../devicetree/bindings/arm/marvell/boards.txt     |    7 +
 arch/arm/boot/dts/mmp2-brownstone.dts              |  242 ++++++++++++++++++++
 arch/arm/boot/dts/ttc-dkb.dts                      |   80 +++++++
 arch/arm/mach-mmp/Makefile                         |    4 +
 arch/arm/mach-mmp/boards.c                         |  159 +++++++++++++
 5 files changed, 492 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/boards.txt
 create mode 100644 arch/arm/boot/dts/mmp2-brownstone.dts
 create mode 100644 arch/arm/boot/dts/ttc-dkb.dts
 create mode 100644 arch/arm/mach-mmp/boards.c

diff --git a/Documentation/devicetree/bindings/arm/marvell/boards.txt b/Documentation/devicetree/bindings/arm/marvell/boards.txt
new file mode 100644
index 0000000..219e134
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/boards.txt
@@ -0,0 +1,7 @@
+TTC(pxa910) "DKB" evalutation board
+Required root node properties:
+	- compatible = "mrvl,ttc-dkb", "mrvl,pxa910-dkb";
+
+mmp2(armada610) "Brownstone" evalutation board
+Required root node properties:
+	- compatible = "mrvl,mmp2-brownstone", "mrvl,armada610-brownstone";
diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
new file mode 100644
index 0000000..4e14388
--- /dev/null
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -0,0 +1,242 @@
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Marvell MMP2 Brownstone";
+	compatible = "mrvl,mmp2-brownstone", "mrvl,armada610-brownstone";
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:192.168.1.101::255.255.255.0::eth0:on";
+		linux,stdout-path = &uart2;
+	};
+
+	soc at d4000000 {
+		compatible = "mrvl,mmp2", "mrvl,armada610", "simple-bus";
+		device_type = "soc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mmp_intc: interrupt-controller at d4282000 {
+			compatible = "mrvl,mmp-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* reg: <offset & size> */
+			reg = <0xd4282000 0x400>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			intc-numbers = <64>;
+			/* enable bits in conf register */
+			intc-enable-mask = <0x20>;
+		};
+
+		mux_intc4: interrupt-controller at d4282150 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4282150 0>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&mmp_intc>;
+			interrupts = <4>;
+			intc-numbers = <2>;
+			intc-status = <0x150>;
+			intc-mask = <0x168>;
+			/* mfp register & interrupt index */
+			intc-mfp-edge = <0xd401e2c4 1>;
+		};
+
+		mux_intc5: interrupt-controller at d4282154 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4282154 0>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&mmp_intc>;
+			interrupts = <5>;
+			intc-numbers = <2>;
+			intc-status = <0x154>;
+			intc-mask = <0x16c>;
+		};
+
+		mux_intc9: interrupt-controller at d4282180 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4282180 0>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&mmp_intc>;
+			interrupts = <9>;
+			intc-numbers = <3>;
+			intc-status = <0x180>;
+			intc-mask = <0x17c>;
+		};
+
+		mux_intc17: interrupt-controller at d4282158 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4282158 0>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&mmp_intc>;
+			interrupts = <17>;
+			intc-numbers = <5>;
+			intc-status = <0x158>;
+			intc-mask = <0x170>;
+		};
+
+		mux_intc35: interrupt-controller at d428215c {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd428215c 0>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&mmp_intc>;
+			interrupts = <35>;
+			intc-numbers = <15>;
+			intc-status = <0x15c>;
+			intc-mask = <0x174>;
+		};
+
+		mux_intc51: interrupt-controller at d4282160 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4282160 0>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&mmp_intc>;
+			interrupts = <51>;
+			intc-numbers = <2>;
+			intc-status = <0x160>;
+			intc-mask = <0x178>;
+		};
+
+		mux_intc55: interrupt-controller at d4282188 {
+			compatible = "mrvl,mux-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xd4282188 0>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&mmp_intc>;
+			interrupts = <55>;
+			intc-numbers = <2>;
+			intc-status = <0x188>;
+			intc-mask = <0x184>;
+		};
+
+		i2c0: i2c at d4011000 {
+			compatible = "mrvl,pxa255-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xd4011000 0x60>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <7>;
+			interrupt-parent = <&mmp_intc>;
+		};
+
+		i2c1: i2c at d4031000 {
+			compatible = "mrvl,pxa255-i2c";
+			reg = <0xd4031000 0x60>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <0>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		i2c2: i2c at d4032000 {
+			compatible = "mrvl,pxa255-i2c";
+			reg = <0xd4032000 0x60>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <1>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		i2c3: i2c at d4033000 {
+			compatible = "mrvl,pxa255-i2c";
+			reg = <0xd4033000 0x60>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <2>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		i2c4: i2c at d4033800 {
+			compatible = "mrvl,pxa255-i2c";
+			reg = <0xd4033800 0x60>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <3>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		i2c5: i2c at d4034000 {
+			compatible = "mrvl,pxa255-i2c";
+			reg = <0xd4034000 0x60>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <4>;
+			interrupt-parent = <&mux_intc17>;
+		};
+
+		uart0: uart at d4030000 {
+			compatible = "mrvl,pxa270-serial";
+			reg = <0xd4030000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <27>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <26000000>;
+			current-speed = <115200>;
+		};
+
+		uart1: uart at d4017000 {
+			compatible = "mrvl,pxa270-serial";
+			reg = <0xd4017000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <28>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <26000000>;
+			current-speed = <115200>;
+		};
+
+		uart2: uart at d4018000 {
+			compatible = "mrvl,pxa270-serial";
+			reg = <0xd4018000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <24>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <26000000>;
+			current-speed = <38400>;
+		};
+
+		uart3: uart at d4016000 {
+			compatible = "mrvl,pxa270-serial";
+			reg = <0xd4016000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <46>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <26000000>;
+			current-speed = <115200>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ttc-dkb.dts b/arch/arm/boot/dts/ttc-dkb.dts
new file mode 100644
index 0000000..ff8df4f
--- /dev/null
+++ b/arch/arm/boot/dts/ttc-dkb.dts
@@ -0,0 +1,80 @@
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Marvell TTC DKB";
+	compatible = "mrvl,ttc-dkb", "mrvl,pxa910-dkb";
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:192.168.1.101::255.255.255.0::eth0:on";
+		linux,stdout-path = &uart0;
+	};
+
+	soc at d4000000 {
+		compatible = "mrvl,pxa910", "simple-bus";
+		device_type = "soc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0xd4000000 0xd4000000 0x00200000	/* APB */
+			0xd4200000 0xd4200000 0x00200000>;	/* AXI */
+
+		mmp_intc: interrupt-controller at d4282000 {
+			compatible = "mrvl,mmp-intc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* reg: <offset & size> */
+			reg = <0xd4282000 0x400>;
+
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			intc-numbers = <64>;
+			/* enable bits in conf register */
+			intc-enable-mask = <0x51>;
+		};
+
+		i2c0: i2c at d4011000 {
+			compatible = "mrvl,pxa255-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xd4011000 0x60>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <7>;
+			interrupt-parent = <&mmp_intc>;
+		};
+
+		i2c1: i2c at d4037000 {
+			compatible = "mrvl,pxa255-i2c";
+			reg = <0xd4037000 0x60>;
+			i2c-polling = <0>;
+			i2c-frequency = "fast";
+			interrupts = <54>;
+			interrupt-parent = <&mmp_intc>;
+		};
+
+		uart0: uart at d4017000 {
+			compatible = "mrvl,pxa270-serial";
+			reg = <0xd4017000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <27>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <14745600>;
+			current-speed = <115200>;
+		};
+
+		uart1: uart at d4018000 {
+			compatible = "mrvl,pxa270-serial";
+			reg = <0xd4018000 0x1000>;
+			reg-shift = <2>;
+			interrupts = <28>;
+			interrupt-parent = <&mmp_intc>;
+			clock-frequency = <14745600>;
+			current-speed = <115200>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index e7862ea..6c39bbd 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -12,6 +12,9 @@ obj-$(CONFIG_CPU_PXA910)	+= pxa910.o irq-pxa168.o
 obj-$(CONFIG_CPU_MMP2)		+= mmp2.o irq-mmp2.o
 
 # board support
+ifeq ($(CONFIG_MMP_USE_OF),y)
+obj-$(CONFIG_OF)		+= boards.o
+else
 obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
 obj-$(CONFIG_MACH_ZYLONITE2)	+= aspenite.o
 obj-$(CONFIG_MACH_AVENGERS_LITE)+= avengers_lite.o
@@ -21,3 +24,4 @@ obj-$(CONFIG_MACH_BROWNSTONE)	+= brownstone.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) += jasper.o
 obj-$(CONFIG_MACH_TETON_BGA)	+= teton_bga.o
+endif
diff --git a/arch/arm/mach-mmp/boards.c b/arch/arm/mach-mmp/boards.c
new file mode 100644
index 0000000..31c8e84
--- /dev/null
+++ b/arch/arm/mach-mmp/boards.c
@@ -0,0 +1,159 @@
+/*
+ *  linux/arch/arm/mach-mmp/boards.c
+ *
+ *  Support for the Multiple Marvell Development Platforms.
+ *
+ *  Copyright (C) 2009-2011 Marvell International Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/pxa-i2c.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/pxa910.h>
+#include <mach/mmp2.h>
+#include <mach/mfp-mmp2.h>
+
+#include "common.h"
+
+static struct of_device_id of_bus_ids[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static struct of_dev_auxdata ttc_dkb_auxdata_lookup[] __initdata = {
+	{}
+};
+
+static void __init ttc_dkb_init(void)
+{
+	if (of_platform_populate(NULL, of_bus_ids, ttc_dkb_auxdata_lookup,
+		NULL) < 0)
+		BUG();
+}
+
+static const char *ttc_dkb_dt_match[] __initdata = {
+	"mrvl,ttc-dkb",
+	NULL,
+};
+
+#ifdef CONFIG_CPU_PXA910
+MACHINE_START(TTC_DKB, "PXA910-based TTC-DKB Development Platform")
+	.map_io		= mmp_map_io,
+	.init_irq	= mmp_init_intc,
+	.timer		= &pxa910_timer,
+	.init_machine	= ttc_dkb_init,
+	.dt_compat	= ttc_dkb_dt_match,
+MACHINE_END
+#endif
+
+static unsigned long brownstone_pin_config[] __initdata = {
+	/* UART1 */
+	GPIO29_UART1_RXD,
+	GPIO30_UART1_TXD,
+
+	/* UART3 */
+	GPIO51_UART3_RXD,
+	GPIO52_UART3_TXD,
+
+	/* DFI */
+	GPIO168_DFI_D0,
+	GPIO167_DFI_D1,
+	GPIO166_DFI_D2,
+	GPIO165_DFI_D3,
+	GPIO107_DFI_D4,
+	GPIO106_DFI_D5,
+	GPIO105_DFI_D6,
+	GPIO104_DFI_D7,
+	GPIO111_DFI_D8,
+	GPIO164_DFI_D9,
+	GPIO163_DFI_D10,
+	GPIO162_DFI_D11,
+	GPIO161_DFI_D12,
+	GPIO110_DFI_D13,
+	GPIO109_DFI_D14,
+	GPIO108_DFI_D15,
+	GPIO143_ND_nCS0,
+	GPIO144_ND_nCS1,
+	GPIO147_ND_nWE,
+	GPIO148_ND_nRE,
+	GPIO150_ND_ALE,
+	GPIO149_ND_CLE,
+	GPIO112_ND_RDY0,
+	GPIO160_ND_RDY1,
+
+	/* PMIC */
+	PMIC_PMIC_INT | MFP_LPM_EDGE_FALL,
+
+	/* MMC0 */
+	GPIO131_MMC1_DAT3 | MFP_PULL_HIGH,
+	GPIO132_MMC1_DAT2 | MFP_PULL_HIGH,
+	GPIO133_MMC1_DAT1 | MFP_PULL_HIGH,
+	GPIO134_MMC1_DAT0 | MFP_PULL_HIGH,
+	GPIO136_MMC1_CMD | MFP_PULL_HIGH,
+	GPIO139_MMC1_CLK,
+	GPIO140_MMC1_CD | MFP_PULL_LOW,
+	GPIO141_MMC1_WP | MFP_PULL_LOW,
+
+	/* MMC1 */
+	GPIO37_MMC2_DAT3 | MFP_PULL_HIGH,
+	GPIO38_MMC2_DAT2 | MFP_PULL_HIGH,
+	GPIO39_MMC2_DAT1 | MFP_PULL_HIGH,
+	GPIO40_MMC2_DAT0 | MFP_PULL_HIGH,
+	GPIO41_MMC2_CMD | MFP_PULL_HIGH,
+	GPIO42_MMC2_CLK,
+
+	/* MMC2 */
+	GPIO165_MMC3_DAT7 | MFP_PULL_HIGH,
+	GPIO162_MMC3_DAT6 | MFP_PULL_HIGH,
+	GPIO166_MMC3_DAT5 | MFP_PULL_HIGH,
+	GPIO163_MMC3_DAT4 | MFP_PULL_HIGH,
+	GPIO167_MMC3_DAT3 | MFP_PULL_HIGH,
+	GPIO164_MMC3_DAT2 | MFP_PULL_HIGH,
+	GPIO168_MMC3_DAT1 | MFP_PULL_HIGH,
+	GPIO111_MMC3_DAT0 | MFP_PULL_HIGH,
+	GPIO112_MMC3_CMD | MFP_PULL_HIGH,
+	GPIO151_MMC3_CLK,
+
+	/* 5V regulator */
+	GPIO89_GPIO,
+};
+
+static struct of_dev_auxdata brownstone_auxdata_lookup[] __initdata = {
+	{}
+};
+
+static void __init brownstone_init(void)
+{
+	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
+
+	if (of_platform_populate(NULL, of_bus_ids, brownstone_auxdata_lookup,
+		NULL) < 0)
+		BUG();
+}
+
+static const char *brownstone_dt_match[] __initdata = {
+	"mrvl,mmp2-brownstone",
+	NULL,
+};
+
+#ifdef CONFIG_CPU_MMP2
+MACHINE_START(BROWNSTONE, "Brownstone Development Platform")
+	.map_io		= mmp_map_io,
+	.init_irq	= mmp_init_intc,
+	.timer		= &mmp2_timer,
+	.init_machine	= brownstone_init,
+	.dt_compat	= brownstone_dt_match,
+MACHINE_END
+#endif
-- 
1.5.6.5
