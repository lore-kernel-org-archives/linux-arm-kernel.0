From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 30 Sep 2016 01:25:42 +0300
Subject: [PATCH RFC v2 5/12] ARM: dts: r8a7743: initial SoC device tree
In-Reply-To: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
References: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
Message-ID: <30745799.9Kqd9vtaYp@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial R8A7743 SoC device tree including CPU cores, GIC, timer, SYSC,
and the required  clock descriptions.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- added the IRQC and Ether clocks.

 arch/arm/boot/dts/r8a7743.dtsi |  235 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7743.dtsi
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7743.dtsi
@@ -0,0 +1,235 @@
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
+#include <dt-bindings/clock/r8a7743-clock.h>
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
+			clocks = <&cpg_clocks R8A7743_CLK_Z>;
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
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7743-sysc";
+			reg = <0 0xe6180000 0 0x0200>;
+			#power-domain-cells = <1>;
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at e6150000 {
+			compatible = "renesas,r8a7743-cpg-clocks",
+				     "renesas,rcar-gen2-cpg-clocks";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk &usb_extal_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "main", "pll0", "pll1", "pll3",
+					     "lb", "qspi", "sdh", "sd0", "z",
+					     "rcan";
+			#power-domain-cells = <0>;
+		};
+
+		/* Fixed factor clocks */
+		pll1_div2_clk: pll1_div2 {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7743_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+		zs_clk: zs {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7743_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <6>;
+			clock-mult = <1>;
+		};
+		p_clk: p {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7743_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+		};
+		mp_clk: mp {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-div = <15>;
+			clock-mult = <1>;
+		};
+		cp_clk: cp {
+			compatible = "fixed-factor-clock";
+			clocks = <&extal_clk>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+
+		/* Gate clocks */
+		mstp2_clks: mstp2_clks at e6150138 {
+			compatible = "renesas,r8a7743-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
+				 <&mp_clk>, <&mp_clk>, <&zs_clk>, <&zs_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7743_CLK_SCIFA2 R8A7743_CLK_SCIFA1
+				R8A7743_CLK_SCIFA0 R8A7743_CLK_SCIFB0
+				R8A7743_CLK_SCIFB1 R8A7743_CLK_SCIFB2
+				R8A7743_CLK_SYS_DMAC1 R8A7743_CLK_SYS_DMAC0
+			>;
+			clock-output-names =
+				"scifa2", "scifa1", "scifa0",
+				"scifb0", "scifb1", "scifb2",
+				"sys-dmac1", "sys-dmac0";
+		};
+		mstp4_clks: mstp4_clks at e6150140 {
+			compatible = "renesas,r8a7743-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+			clocks = <&cp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7743_CLK_IRQC>;
+			clock-output-names = "irqc";
+		};
+		mstp7_clks: mstp7_clks at e615014c {
+			compatible = "renesas,r8a7743-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+			clocks = <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
+				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				 <&p_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7743_CLK_HSCIF2 R8A7743_CLK_SCIF5
+				R8A7743_CLK_SCIF4 R8A7743_CLK_HSCIF1
+				R8A7743_CLK_HSCIF0 R8A7743_CLK_SCIF3
+				R8A7743_CLK_SCIF2 R8A7743_CLK_SCIF1
+				R8A7743_CLK_SCIF0
+			>;
+			clock-output-names =
+				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
+				"scif3", "scif2", "scif1", "scif0";
+		};
+		mstp8_clks: mstp8_clks at e6150990 {
+			compatible = "renesas,r8a7743-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+			clocks = <&p_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7743_CLK_ETHER>;
+			clock-output-names = "ether";
+		};
+		mstp11_clks: mstp11_clks at e615099c {
+			compatible = "renesas,r8a7743-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7743_CLK_SCIFA3 R8A7743_CLK_SCIFA4
+				R8A7743_CLK_SCIFA5
+			>;
+			clock-output-names = "scifa3", "scifa4", "scifa5";
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
