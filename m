From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 06 Oct 2016 00:38:18 +0300
Subject: [PATCH v3 04/11] ARM: dts: r8a7743: initial SoC device tree
In-Reply-To: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
Message-ID: <2883940.Oo8sg10L7m@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The  initial R8A7743 SoC device tree including CPU cores, GIC, timer, SYSC,
CPG, and the required clock descriptions.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- changed  the R8A7743 clock header #include;
- replaced the multiple clock nodes with the single CPG node, updated the
  "clocks" property in the CPU0 node, updated the patch description.

Changes in version 2:
- added the IRQC and Ether clocks.

 arch/arm/boot/dts/r8a7743.dtsi |  125 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7743.dtsi
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7743.dtsi
@@ -0,0 +1,125 @@
+/*
+ * Device Tree Source for the r8a7743 SoC
+ *
+ * Copyright (C) 2016 Cogent Embedded Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r8a7743-cpg-mssr.h>
+#include <dt-bindings/power/r8a7743-sysc.h>
+
+/ {
+	compatible = "renesas,r8a7743";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+			clock-frequency = <1500000000>;
+			clocks = <&cpg CPG_CORE R8A7743_CLK_Z>;
+			power-domains = <&sysc R8A7743_PD_CA15_CPU0>;
+			next-level-cache = <&L2_CA15>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1500000000>;
+			power-domains = <&sysc R8A7743_PD_CA15_CPU1>;
+			next-level-cache = <&L2_CA15>;
+		};
+
+		L2_CA15: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
+			cache-unified;
+			cache-level = <2>;
+			power-domains = <&sysc R8A7743_PD_CA15_SCU>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller at f1001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0xf1001000 0 0x1000>,
+			      <0 0xf1002000 0 0x1000>,
+			      <0 0xf1004000 0 0x2000>,
+			      <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9
+				     (GIC_CPU_MASK_SIMPLE(2) |
+				      IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		timer {
+			compatible = "arm,armv7-timer";
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
+				      IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
+				      IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
+				      IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
+				      IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7743-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7743-sysc";
+			reg = <0 0xe6180000 0 0x0200>;
+			#power-domain-cells = <1>;
+		};
+	};
+
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overriden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External USB clock - can be overridden by the board */
+	usb_extal_clk: usb_extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+};
