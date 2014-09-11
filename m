From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:15 +0900
Subject: [PATCH 2/3] ARM: shmobile: Initial r8a7794 SoC device tree
In-Reply-To: <cover.1410396013.git.horms+renesas@verge.net.au>
References: <cover.1410396013.git.horms+renesas@verge.net.au>
Message-ID: <0dce5454d5c258582a7da5590332d9e085886bf7.1410396013.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[uli: reduced to minimum, added cmt, enabled scif2, split off board part]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 531 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7794-clock.h |  80 +++++
 2 files changed, 611 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7794.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7794-clock.h

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
new file mode 100644
index 0000000..d4e8bce
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -0,0 +1,531 @@
+/*
+ * Device Tree Source for the r8a7794 SoC
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2014 Ulrich Hecht
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <dt-bindings/clock/r8a7794-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "renesas,r8a7794";
+	interrupt-parent = <&gic>;
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
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			clock-frequency = <1000000000>;
+		};
+	};
+
+	gic: interrupt-controller at f1001000 {
+		compatible = "arm,cortex-a7-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0 0xf1001000 0 0x1000>,
+			<0 0xf1002000 0 0x1000>,
+			<0 0xf1004000 0 0x2000>,
+			<0 0xf1006000 0 0x2000>;
+		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	cmt0: timer at ffca0000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xffca0000 0 0x1004>;
+		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7794_CLK_CMT0>;
+		clock-names = "fck";
+
+		renesas,channels-mask = <0x60>;
+
+		status = "disabled";
+	};
+
+	cmt1: timer at e6130000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xe6130000 0 0x1004>;
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7794_CLK_CMT1>;
+		clock-names = "fck";
+
+		renesas,channels-mask = <0xff>;
+
+		status = "disabled";
+	};
+
+	irqc0: interrupt-controller at e61c0000 {
+		compatible = "renesas,irqc-r8a7794", "renesas,irqc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0 0xe61c0000 0 0x200>;
+		interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 12 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 15 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		reg = <0 0xe6c40000 0 64>;
+		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		reg = <0 0xe6c50000 0 64>;
+		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7794_CLK_SCIFA1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa2: serial at e6c60000 {
+		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		reg = <0 0xe6c60000 0 64>;
+		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7794_CLK_SCIFA2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa3: serial at e6c70000 {
+		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		reg = <0 0xe6c70000 0 64>;
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7794_CLK_SCIFA3>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa4: serial at e6c78000 {
+		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		reg = <0 0xe6c78000 0 64>;
+		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7794_CLK_SCIFA4>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa5: serial at e6c80000 {
+		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		reg = <0 0xe6c80000 0 64>;
+		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7794_CLK_SCIFA5>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb0: serial at e6c20000 {
+		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		reg = <0 0xe6c20000 0 64>;
+		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7794_CLK_SCIFB0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb1: serial at e6c30000 {
+		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		reg = <0 0xe6c30000 0 64>;
+		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7794_CLK_SCIFB1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb2: serial at e6ce0000 {
+		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		reg = <0 0xe6ce0000 0 64>;
+		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7794_CLK_SCIFB2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif0: serial at e6e60000 {
+		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		reg = <0 0xe6e60000 0 64>;
+		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif1: serial at e6e68000 {
+		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		reg = <0 0xe6e68000 0 64>;
+		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif2: serial at e6e58000 {
+		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		reg = <0 0xe6e58000 0 64>;
+		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif3: serial at e6ea8000 {
+		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		reg = <0 0xe6ea8000 0 64>;
+		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif4: serial at e6ee0000 {
+		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		reg = <0 0xe6ee0000 0 64>;
+		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif5: serial at e6ee8000 {
+		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		reg = <0 0xe6ee8000 0 64>;
+		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif0: serial at e62c0000 {
+		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		reg = <0 0xe62c0000 0 96>;
+		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif1: serial at e62c8000 {
+		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		reg = <0 0xe62c8000 0 96>;
+		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif2: serial at e62d0000 {
+		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		reg = <0 0xe62d0000 0 96>;
+		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* External root clock */
+		extal_clk: extal_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overriden by the board. */
+			clock-frequency = <0>;
+			clock-output-names = "extal";
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at e6150000 {
+			compatible = "renesas,r8a7794-cpg-clocks",
+				     "renesas,rcar-gen2-cpg-clocks";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "main", "pll0", "pll1", "pll3",
+					     "lb", "qspi", "sdh", "sd0", "z";
+		};
+
+		/* Fixed factor clocks */
+		pll1_div2_clk: pll1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pll1_div2";
+		};
+		zg_clk: zg_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <6>;
+			clock-mult = <1>;
+			clock-output-names = "zg";
+		};
+		zx_clk: zx_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <3>;
+			clock-mult = <1>;
+			clock-output-names = "zx";
+		};
+		zs_clk: zs_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <6>;
+			clock-mult = <1>;
+			clock-output-names = "zs";
+		};
+		hp_clk: hp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+			clock-output-names = "hp";
+		};
+		i_clk: i_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "i";
+		};
+		b_clk: b_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+			clock-output-names = "b";
+		};
+		p_clk: p_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+			clock-output-names = "p";
+		};
+		cl_clk: cl_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <48>;
+			clock-mult = <1>;
+			clock-output-names = "cl";
+		};
+		m2_clk: m2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "m2";
+		};
+		imp_clk: imp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "imp";
+		};
+		rclk_clk: rclk_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <(48 * 1024)>;
+			clock-mult = <1>;
+			clock-output-names = "rclk";
+		};
+		oscclk_clk: oscclk_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <(12 * 1024)>;
+			clock-mult = <1>;
+			clock-output-names = "oscclk";
+		};
+		zb3_clk: zb3_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "zb3";
+		};
+		zb3d2_clk: zb3d2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "zb3d2";
+		};
+		ddr_clk: ddr_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "ddr";
+		};
+		mp_clk: mp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-div = <15>;
+			clock-mult = <1>;
+			clock-output-names = "mp";
+		};
+		cp_clk: cp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <48>;
+			clock-mult = <1>;
+			clock-output-names = "cp";
+		};
+
+		acp_clk: acp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&extal_clk>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "acp";
+		};
+
+		/* Gate clocks */
+		mstp0_clks: mstp0_clks at e6150130 {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
+			clocks = <&mp_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7794_CLK_MSIOF0>;
+			clock-output-names = "msiof0";
+		};
+		mstp1_clks: mstp1_clks at e6150134 {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
+			clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
+				 <&cp_clk>,
+				 <&zs_clk>, <&zs_clk>, <&zs_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7794_CLK_TMU1 R8A7794_CLK_TMU3 R8A7794_CLK_TMU2
+				R8A7794_CLK_CMT0 R8A7794_CLK_TMU0
+			>;
+			clock-output-names =
+				"tmu1", "tmu3", "tmu2", "cmt0", "tmu0";
+		};
+		mstp2_clks: mstp2_clks at e6150138 {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
+				 <&mp_clk>, <&mp_clk>, <&mp_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7794_CLK_SCIFA2 R8A7794_CLK_SCIFA1 R8A7794_CLK_SCIFA0
+				R8A7794_CLK_MSIOF2 R8A7794_CLK_SCIFB0 R8A7794_CLK_SCIFB1
+				R8A7794_CLK_MSIOF1 R8A7794_CLK_SCIFB2
+			>;
+			clock-output-names =
+				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
+				"scifb1", "msiof1", "scifb2";
+		};
+		mstp3_clks: mstp3_clks at e615013c {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+			clocks = <&rclk_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7794_CLK_CMT1
+			>;
+			clock-output-names =
+				"cmt1";
+		};
+		mstp7_clks: mstp7_clks at e615014c {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+			clocks = <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
+				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
+				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
+				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
+				R8A7794_CLK_SCIF0
+			>;
+			clock-output-names =
+				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
+				"scif3", "scif2", "scif1", "scif0";
+		};
+		mstp8_clks: mstp8_clks at e6150990 {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+			clocks = <&p_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7794_CLK_ETHER
+			>;
+			clock-output-names =
+				"ether";
+		};
+		mstp11_clks: mstp11_clks at e615099c {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7794_CLK_SCIFA3 R8A7794_CLK_SCIFA4 R8A7794_CLK_SCIFA5
+			>;
+			clock-output-names = "scifa3", "scifa4", "scifa5";
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
new file mode 100644
index 0000000..9ac1043
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright 2013 Ideas On Board SPRL
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7794_H__
+#define __DT_BINDINGS_CLOCK_R8A7794_H__
+
+/* CPG */
+#define R8A7794_CLK_MAIN		0
+#define R8A7794_CLK_PLL0		1
+#define R8A7794_CLK_PLL1		2
+#define R8A7794_CLK_PLL3		3
+#define R8A7794_CLK_LB			4
+#define R8A7794_CLK_QSPI		5
+#define R8A7794_CLK_SDH			6
+#define R8A7794_CLK_SD0			7
+#define R8A7794_CLK_Z			8
+
+/* MSTP0 */
+#define R8A7794_CLK_MSIOF0		0
+
+/* MSTP1 */
+#define R8A7794_CLK_TMU1		11
+#define R8A7794_CLK_TMU3		21
+#define R8A7794_CLK_TMU2		22
+#define R8A7794_CLK_CMT0		24
+#define R8A7794_CLK_TMU0		25
+
+/* MSTP2 */
+#define R8A7794_CLK_SCIFA2		2
+#define R8A7794_CLK_SCIFA1		3
+#define R8A7794_CLK_SCIFA0		4
+#define R8A7794_CLK_MSIOF2		5
+#define R8A7794_CLK_SCIFB0		6
+#define R8A7794_CLK_SCIFB1		7
+#define R8A7794_CLK_MSIOF1		8
+#define R8A7794_CLK_SCIFB2		16
+
+/* MSTP3 */
+#define R8A7794_CLK_CMT1		29
+
+/* MSTP5 */
+#define R8A7794_CLK_THERMAL		22
+#define R8A7794_CLK_PWM			23
+
+/* MSTP7 */
+#define R8A7794_CLK_HSCIF2		13
+#define R8A7794_CLK_SCIF5		14
+#define R8A7794_CLK_SCIF4		15
+#define R8A7794_CLK_HSCIF1		16
+#define R8A7794_CLK_HSCIF0		17
+#define R8A7794_CLK_SCIF3		18
+#define R8A7794_CLK_SCIF2		19
+#define R8A7794_CLK_SCIF1		20
+#define R8A7794_CLK_SCIF0		21
+
+/* MSTP8 */
+#define R8A7794_CLK_ETHER		13
+
+/* MSTP9 */
+#define R8A7794_CLK_GPIO6		5
+#define R8A7794_CLK_GPIO5		7
+#define R8A7794_CLK_GPIO4		8
+#define R8A7794_CLK_GPIO3		9
+#define R8A7794_CLK_GPIO2		10
+#define R8A7794_CLK_GPIO1		11
+#define R8A7794_CLK_GPIO0		12
+
+/* MSTP11 */
+#define R8A7794_CLK_SCIFA3		6
+#define R8A7794_CLK_SCIFA4		7
+#define R8A7794_CLK_SCIFA5		8
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7794_H__ */
-- 
2.0.1
