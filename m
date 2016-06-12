From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 13 Jun 2016 00:06:52 +0300
Subject: [PATCH v5 06/12] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
Message-ID: <56384208.oM2NLZQo9N@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial R8A7792 SoC device tree including CPU cores, GIC, timer, SYSC,
and the required  clock descriptions.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 5:
- removed the RCAN CPG clock;
- added Geert's tag.

Changes in version 4:
- fixed the CP clock divisor;
- indented the P clock's "compatible" prop correctly;
- removed leftover DU0/1 clock names from the MSTP7 clock node.

Changes in version 3:
- moved the fixed factor clocks under the "soc" node;
- added back the CPU1 node, adjusted the changelog.

Changes in version 2:
- explicitly included the IRQ header;
- removed the CPU1 node;
- removed the audio and PCIe bus clocks;
- removed the SDH, SD0, and SD1 CPG clocks;
- added RCAN and ADSP CPG clocks;
- removed the PLL1/2, Z2, ZS, I, B, P, CL, M2, RCLK, OSCCLK, ZB3, ZB3D2, DDR,
  and MP fixed factor clocks;
- fixed up the parent and divisor for the CP fixed factor clock;
- swapped  the SYS-DMAC0/1 clocks;
- removed  all gated clocks except the [H]SCIF, IRQC, and SYS-DMAC ones;
- created  the "soc" subnode, moving the SoC  device  nodes there;
- removed  the "clocks" node, moving its fixed clock  subnodes to the root and
  the MSTP subnodes into the "soc" node.

 arch/arm/boot/dts/r8a7792.dtsi |  179 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -0,0 +1,179 @@
+/*
+ * Device Tree Source for the r8a7792 SoC
+ *
+ * Copyright (C) 2016 Cogent Embedded Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/clock/r8a7792-clock.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/r8a7792-sysc.h>
+
+/ {
+	compatible = "renesas,r8a7792";
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
+			clock-frequency = <1000000000>;
+			clocks = <&cpg_clocks R8A7792_CLK_Z>;
+			power-domains = <&sysc R8A7792_PD_CA15_CPU0>;
+			next-level-cache = <&L2_CA15>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1000000000>;
+			power-domains = <&sysc R8A7792_PD_CA15_CPU1>;
+			next-level-cache = <&L2_CA15>;
+		};
+
+		L2_CA15: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
+			cache-unified;
+			cache-level = <2>;
+			power-domains = <&sysc R8A7792_PD_CA15_SCU>;
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
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7792-sysc";
+			reg = <0 0xe6180000 0 0x0200>;
+			#power-domain-cells = <1>;
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at e6150000 {
+			compatible = "renesas,r8a7792-cpg-clocks",
+				     "renesas,rcar-gen2-cpg-clocks";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "main", "pll0", "pll1", "pll3",
+					     "lb", "qspi", "z", "adsp";
+			#power-domain-cells = <0>;
+		};
+
+		/* Fixed factor clocks */
+		zs_clk: zs {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <6>;
+			clock-mult = <1>;
+		};
+		p_clk: p {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+		};
+		cp_clk: cp {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <48>;
+			clock-mult = <1>;
+		};
+
+		/* Gate clocks */
+		mstp2_clks: mstp2_clks at e6150138 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
+			clocks = <&zs_clk>, <&zs_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_SYS_DMAC1 R8A7792_CLK_SYS_DMAC0
+			>;
+			clock-output-names = "sys-dmac1", "sys-dmac0";
+		};
+		mstp4_clks: mstp4_clks at e6150140 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+			clocks = <&cp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7792_CLK_IRQC>;
+			clock-output-names = "irqc";
+		};
+		mstp7_clks: mstp7_clks at e615014c {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+			clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>,
+				 <&p_clk>, <&p_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_HSCIF1 R8A7792_CLK_HSCIF0
+				R8A7792_CLK_SCIF3 R8A7792_CLK_SCIF2
+				R8A7792_CLK_SCIF1 R8A7792_CLK_SCIF0
+			>;
+			clock-output-names = "hscif1", "hscif0", "scif3",
+					     "scif2", "scif1", "scif0";
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
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+};
