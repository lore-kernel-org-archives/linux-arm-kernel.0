From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  1 Oct 2014 09:32:16 +0200
Subject: [PATCH 2/2] ARM: realview: add device tree and bindings for PB1176
Message-ID: <1412148736-24560-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a first example, add device tree and bindings for the
RealView PB1176.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- Split in two patches.
---
 Documentation/devicetree/bindings/arm/arm-boards |  65 ++++++
 Documentation/devicetree/bindings/arm/gic.txt    |   1 +
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts        | 247 +++++++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index c554ed3d44fb..556c8665fdbf 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -92,3 +92,68 @@ Required nodes:
 - core-module: the root node to the Versatile platforms must have
   a core-module with regs and the compatible strings
   "arm,core-module-versatile", "syscon"
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
+   "arm,realview-eb-soc", "simple-bus"
+   "arm,realview-pb1176-soc", "simple-bus"
+   "arm,realview-pb11mp-soc", "simple-bus"
+   "arm,realview-pba8-soc", "simple-bus"
+   "arm,realview-pbx-soc", "simple-bus"
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
+		compatible = "arm,realview-pb1176-soc", "simple-bus";
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
index c7d2fa156678..b38608af66db 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -17,6 +17,7 @@ Main node required properties:
 	"arm,cortex-a7-gic"
 	"arm,arm11mp-gic"
 	"brcm,brahma-b15-gic"
+	"arm,arm1176jzf-devchip-gic"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source.  The type shall be a <u32> and the value shall be 3.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3ddeb9..e55d28eed151 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -344,6 +344,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8084-mtp.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb
+dtb-$(CONFIG_ARCH_REALVIEW) += arm-realview-pb1176.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3066a-bqcurie2.dtb \
 	rk3188-radxarock.dtb \
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
new file mode 100644
index 000000000000..3135939cd13f
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -0,0 +1,247 @@
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
+		compatible = "arm,realview-pb1176-soc", "simple-bus";
+		regmap = <&syscon>;
+		ranges;
+
+		syscon: syscon at 10000000 {
+			compatible = "arm,realview-pb1176-syscon", "syscon";
+			reg = <0x10000000 0x1000>;
+
+			led at 08.0 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x01>;
+				label = "versatile:0";
+				linux,default-trigger = "heartbeat";
+				default-state = "on";
+			};
+			led at 08.1 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x02>;
+				label = "versatile:1";
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+			led at 08.2 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x04>;
+				label = "versatile:2";
+				linux,default-trigger = "cpu0";
+				default-state = "off";
+			};
+			led at 08.3 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x08>;
+				label = "versatile:3";
+				default-state = "off";
+			};
+			led at 08.4 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x10>;
+				label = "versatile:4";
+				default-state = "off";
+			};
+			led at 08.5 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x20>;
+				label = "versatile:5";
+				default-state = "off";
+			};
+			led at 08.6 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x40>;
+				label = "versatile:6";
+				default-state = "off";
+			};
+			led at 08.7 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x80>;
+				label = "versatile:7";
+				default-state = "off";
+			};
+		};
+
+		/* Primary DevChip GIC synthesized with the CPU */
+		intc_dc1176: interrupt-controller at 10120000 {
+			compatible = "arm,arm1176jzf-devchip-gic", "arm,arm11mp-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10121000 0x1000>,
+			      <0x10120000 0x100>;
+		};
+
+		/* This GIC on the board is cascaded off the DevChip GIC */
+		intc_pb1176: interrupt-controller at 10040000 {
+			compatible = "arm,arm1176jzf-devchip-gic", "arm,arm11mp-gic";
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
+			/*
+			 * Override default cache size, sets and
+			 * associativity as these may be erroneously set
+			 * up by boot loader(s).
+			 */
+			arm,override-auxreg;
+			cache-size = <131072>; // 128kB
+			cache-sets = <512>;
+			cache-line-size = <32>;
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
-- 
1.9.3
