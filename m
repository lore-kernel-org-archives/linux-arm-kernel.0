From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 29 Oct 2016 01:17:55 +0300
Subject: [PATCH 04/11] ARM: dts: r8a7745: initial SoC device tree
In-Reply-To: <4121805.SRTmqJtRfv@wasted.cogentembedded.com>
References: <4121805.SRTmqJtRfv@wasted.cogentembedded.com>
Message-ID: <4144867.5S9itKOJEU@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The  initial R8A7745 SoC device tree including CPU0, GIC, timer, SYSC, RST,
CPG, and the required clock descriptions.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7745.dtsi |  120 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7745.dtsi
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7745.dtsi
@@ -0,0 +1,120 @@
+/*
+ * Device Tree Source for the r8a7745 SoC
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
+#include <dt-bindings/clock/r8a7745-cpg-mssr.h>
+#include <dt-bindings/power/r8a7745-sysc.h>
+
+/ {
+	compatible = "renesas,r8a7745";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			clock-frequency = <1000000000>;
+			clocks = <&cpg CPG_CORE R8A7745_CLK_Z2>;
+			power-domains = <&sysc R8A7745_PD_CA7_CPU0>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		L2_CA7: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
+			cache-unified;
+			cache-level = <2>;
+			power-domains = <&sysc R8A7745_PD_CA7_SCU>;
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
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
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
+			compatible = "renesas,r8a7745-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7745-sysc";
+			reg = <0 0xe6180000 0 0x200>;
+			#power-domain-cells = <1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7745-rst";
+			reg = <0 0xe6160000 0 0x100>;
+		};
+	};
+
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
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
