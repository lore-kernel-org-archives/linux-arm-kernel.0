From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jul 2014 15:23:48 +0200
Subject: [PATCH 6/6 v4] ARM: realview: basic device tree implementation
In-Reply-To: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1406294628-16079-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements basic device tree boot support for the RealView
platforms, with a basic device tree for ARM PB1176 as an example.

The implementation is done with a new DT-specific board file
using only pre-existing bindings for the basic IRQ, timer and
serial port drivers. A new compatible type is added to the GIC
for the ARM1176.

This implementation uses the MFD syscon handle from day one to
access the system controller registers, and register the devices
using the SoC bus.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Switch the LEDs to usa a new syscon-LEDs driver so we can
  use the syscon as a hub for all these registers
- Split out the SoC driver to its own file in drivers/soc
ChangeLog v2->v3:
- Rename uart at 0x12345678 to serial at 0x12345678 in DTS file
- Drop static remapping for the LEDs, using my new invention
  syscon-leds instead
- Drop the hunk selecting ARM_DMA_MEM_BUFFERABLE for the DT
  version of the RealView platform. We think this is a local
  optimization we can live without.
- Split off the reset driver to a separate syscon-based reset
  driver in drivers/power/reset, add separate device tree
  bindings for this driver.
- To make sure the reset driver is always available for this
  system a few extra select statements are needed in Kconfig
- Split off the SoC bus driver to an easily identifiable chunk
  inside the mach-realview/realview-dt.c file. This *can* be
  spun off as a separate driver under drivers/soc for example
  but we need some separate discussion on this subject.
- Augment the SoC driver to display some system info so it's
  clear why this driver is there.
- Drop surplus string "with device tree" from machine
  description in the DTS file.
- Move the new GIC compatible string in alphabetic order.
ChangeLog v1->v2:
- Adjust timer clock names to be the same as the example in the
  device tree binding.
- Remove all memory fixup code - this should be handled by the
  device tree specification of memory areas or by special MM hacks
  for the RealView PBX.
- Fix the documentation around syscon to specify that it can be in
  any node, need not be the root node.
- Switch device tree license to the BSD license, taken from
  arch/powerpc/boot/dts/p1024rdb_32b.dts
- Add a hunk for the new compatible string to
  Documentation/devicetree/bindings/arm/gic.txt
- Move the clocks out of the SoC node, certainly the xtal is not
  sitting on the SoC...
- Sort the selects in Kconfig alphabetically
- Use IS_ENABLED() for the l2x0 code snippet
- Instead of checking the board variant in the reset routine to
  figure out how to tweak the reset controller, have a compatible
  string for each syscon variant, map it to an enum that provides a
  unique type ID and that way figure out how to handle it in a maybe
  more elegant way.
- Open issue: what do to with the l2x0 stuff?
---
 Documentation/devicetree/bindings/arm/arm-boards |  66 +++++++
 Documentation/devicetree/bindings/arm/gic.txt    |   1 +
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts        | 240 +++++++++++++++++++++++
 arch/arm/mach-realview/Kconfig                   |  13 ++
 arch/arm/mach-realview/Makefile                  |   1 +
 arch/arm/mach-realview/realview-dt.c             |  72 +++++++
 drivers/irqchip/irq-gic.c                        |   1 +
 8 files changed, 395 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
 create mode 100644 arch/arm/mach-realview/realview-dt.c

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 3509707f9320..d2399e6f1378 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -86,3 +86,69 @@ Interrupt controllers:
 	compatible = "arm,versatile-sic";
 	interrupt-controller;
 	#interrupt-cells = <1>;
+
+
+ARM RealView Boards
+-------------------
+The RealView boards cover tailored evaluation boards that are used to explore
+the ARM11 and Cortex A-8 and Cortex A-9 processors.
+
+Required properties (in root node):
+	/* RealView Emulation Baseboard */
+	compatible = "arm,realview-eb";
+	 /* RealView Platform Baseboard for ARM1176JZF-S */
+	compatible = "arm,realview-pb1176";
+	/* RealView Platform Baseboard for ARM11 MPCore */
+	compatible = "arm,realview-pb11mp";
+	/* RealView Platform Baseboard for Cortex A-8 */
+	compatible = "arm,realview-pba8";
+	/* RealView Platform Baseboard Explore for Cortex A-9 */
+	compatible = "arm,realview-pbx";
+
+Required nodes:
+
+- soc: some node of the RealView platforms must be the SoC
+  node that contain the SoC-specific devices, withe the compatible
+  string set to one of these tuples:
+   "simple-bus", "arm,realview-eb-soc"
+   "simple-bus", "arm,realview-pb1176-soc"
+   "simple-bus", "arm,realview-pb11mp-soc"
+   "simple-bus", "arm,realview-pba8-soc"
+   "simple-bus", "arm,realview-pbx-soc"
+
+- syscon: some subnode of the RealView SoC node must be a
+  system controller node pointing to the control registers,
+  with the compatible string set to one of these tuples:
+   "arm,realview-eb-syscon", "syscon"
+   "arm,realview-pb1176-syscon", "syscon"
+   "arm,realview-pb11mp-syscon", "syscon"
+   "arm,realview-pba8-syscon", "syscon"
+   "arm,realview-pbx-syscon", "syscon"
+
+  Required properties for the system controller:
+  - regs: the location and size of the system controller registers,
+    one range of 0x1000 bytes.
+
+Example:
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "skeleton.dtsi"
+
+/ {
+	model = "ARM RealView PB1176 with device tree";
+	compatible = "arm,realview-pb1176";
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus", "arm,realview-pb1176-soc";
+		ranges;
+
+		syscon: syscon at 10000000 {
+			compatible = "arm,realview-syscon", "syscon";
+			reg = <0x10000000 0x1000>;
+		};
+
+	};
+};
diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 5573c08d3180..539420194efd 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -16,6 +16,7 @@ Main node required properties:
 	"arm,cortex-a9-gic"
 	"arm,cortex-a7-gic"
 	"arm,arm11mp-gic"
+	"arm,arm1176jzf-gic"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source.  The type shall be a <u32> and the value shall be 3.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index adb5ed9e269e..0a02ff749750 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -318,6 +318,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8084-mtp.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb
+dtb-$(CONFIG_ARCH_REALVIEW) += arm-realview-pb1176.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
 	s3c6410-smdk6410.dtb
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
new file mode 100644
index 000000000000..d80d0af24fa6
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -0,0 +1,240 @@
+/*
+ * Copyright 2014 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "skeleton.dtsi"
+
+/ {
+	model = "ARM RealView PB1176";
+	compatible = "arm,realview-pb1176";
+
+	chosen { };
+
+	aliases {
+		serial0 = &pb1176_serial0;
+		serial1 = &pb1176_serial1;
+		serial2 = &pb1176_serial2;
+		serial3 = &pb1176_serial3;
+	};
+
+	memory {
+		/* 128 MiB memory @ 0x0 */
+		reg = <0x00000000 0x08000000>;
+	};
+
+	xtal24mhz: xtal24mhz at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	timclk: timclk at 1M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <24>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	uartclk: uartclk at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	/* FIXME: this actually hangs off the PLL clocks */
+	pclk: pclk at 0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus", "arm,realview-pb1176-soc";
+		regmap = <&syscon>;
+		ranges;
+
+		syscon: syscon at 10000000 {
+			compatible = "arm,realview-pb1176-syscon", "syscon";
+			reg = <0x10000000 0x1000>;
+		};
+
+		reboot: reboot at 0x40 {
+			compatible = "arm,realview-pb1176-reboot";
+			regmap = <&syscon>;
+		};
+
+		leds: leds at 08 {
+			compatible = "syscon-leds";
+			regmap = <&syscon>;
+
+			led at bit0 {
+				offset = <0x08>;
+				mask = <0x01>;
+				label = "versatile:0";
+				linux,default-trigger = "heartbeat";
+				default-state = "on";
+			};
+			led at bit1 {
+				offset = <0x08>;
+				mask = <0x02>;
+				label = "versatile:1";
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+			led at bit2 {
+				offset = <0x08>;
+				mask = <0x04>;
+				label = "versatile:2";
+				linux,default-trigger = "cpu0";
+				default-state = "off";
+			};
+			led at bit3 {
+				offset = <0x08>;
+				mask = <0x08>;
+				label = "versatile:3";
+				default-state = "off";
+			};
+			led at bit4 {
+				offset = <0x08>;
+				mask = <0x10>;
+				label = "versatile:4";
+				default-state = "off";
+			};
+			led at bit5 {
+				offset = <0x08>;
+				mask = <0x20>;
+				label = "versatile:5";
+				default-state = "off";
+			};
+			led at bit6 {
+				offset = <0x08>;
+				mask = <0x40>;
+				label = "versatile:6";
+				default-state = "off";
+			};
+			led at bit7 {
+				offset = <0x08>;
+				mask = <0x80>;
+				label = "versatile:7";
+				default-state = "off";
+			};
+		};
+
+		/* Primary DevChip GIC synthesized with the CPU */
+		intc_dc1176: interrupt-controller at 10120000 {
+			compatible = "arm,arm1176jzf-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10121000 0x1000>,
+			      <0x10120000 0x100>;
+		};
+
+		/* This GIC on the board is cascaded off the DevChip GIC */
+		intc_pb1176: interrupt-controller at 10040000 {
+			compatible = "arm,arm1176jzf-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10041000 0x1000>,
+			      <0x10040000 0x100>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		L2: l2-cache {
+			compatible = "arm,l220-cache";
+			reg = <0x10110000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		pmu {
+			compatible = "arm,arm1176-pmu";
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		timer01: timer at 10104000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10104000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>, <0 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		timer23: timer at 10105000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10105000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+			arm,sp804-has-irq = <1>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		pb1176_serial0: serial at 1010c000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010c000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial1: serial at 1010d000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010d000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial2: serial at 1010e000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010e000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial3: serial at 1010f000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010f000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+	};
+};
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 9db2029aa632..565925f37dc5 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -1,6 +1,19 @@
 menu "RealView platform type"
 	depends on ARCH_REALVIEW
 
+config REALVIEW_DT
+	bool "Support RealView(R) Device Tree based boot"
+	select ARM_GIC
+	select MFD_SYSCON
+	select POWER_RESET
+	select POWER_RESET_VERSATILE
+	select POWER_SUPPLY
+	select SOC_REALVIEW
+	select USE_OF
+	help
+	  Include support for booting the ARM(R) RealView(R) evaluation
+	  boards using a device tree machine description.
+
 config MACH_REALVIEW_EB
 	bool "Support RealView(R) Emulation Baseboard"
 	select ARM_GIC
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index 541fa4c109ef..e07fdf7ae8a7 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y					:= core.o
+obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
 obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
diff --git a/arch/arm/mach-realview/realview-dt.c b/arch/arm/mach-realview/realview-dt.c
new file mode 100644
index 000000000000..ebee421e1a10
--- /dev/null
+++ b/arch/arm/mach-realview/realview-dt.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+#include "core.h"
+
+static void __init realview_dt_init_machine(void)
+{
+	int ret;
+
+#if IS_ENABLED(CONFIG_CACHE_L2X0)
+	if (of_machine_is_compatible("arm,realview-eb"))
+		/*
+		 * 1MB (128KB/way), 8-way associativity,
+		 * evmon/parity/share enabled
+		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
+		 */
+		l2x0_of_init(0x00790000, 0xfe000fff);
+	else if (of_machine_is_compatible("arm,realview-pb1176"))
+		/*
+		 * 128Kb (16Kb/way) 8-way associativity.
+		 * evmon/parity/share enabled.
+		 */
+		l2x0_of_init(0x00730000, 0xfe000fff);
+	else if (of_machine_is_compatible("arm,realview-pb11mp"))
+		/*
+		 * 1MB (128KB/way), 8-way associativity,
+		 * evmon/parity/share enabled
+		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
+		 */
+		l2x0_of_init(0x00730000, 0xfe000fff);
+	else if (of_machine_is_compatible("arm,realview-pbx"))
+		/*
+		 * 16KB way size, 8-way associativity, parity disabled
+		 * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... ....
+		 */
+		l2x0_of_init(0x02520000, 0xc0000fff);
+#endif
+
+	ret = of_platform_populate(NULL, of_default_bus_match_table,
+				   NULL, NULL);
+	if (ret) {
+		pr_crit("could not populate device tree\n");
+		return;
+	}
+}
+
+static const char *realview_dt_platform_compat[] __initconst = {
+	"arm,realview-eb",
+	"arm,realview-pb1176",
+	"arm,realview-pb11mp",
+	"arm,realview-pba8",
+	"arm,realview-pbx",
+	NULL,
+};
+
+DT_MACHINE_START(REALVIEW_DT, "ARM RealView Machine (Device Tree Support)")
+	.init_machine	= realview_dt_init_machine,
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_256M,
+#endif
+	.dt_compat	= realview_dt_platform_compat,
+MACHINE_END
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 7c131cf7cc13..8f2e1a97a92a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1075,6 +1075,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	return 0;
 }
 IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
+IRQCHIP_DECLARE(arm1176jzf_gic, "arm,arm1176jzf-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
-- 
1.9.3
