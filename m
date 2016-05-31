From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 01 Jun 2016 01:24:21 +0300
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
Message-ID: <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial R8A7792 SoC device tree including 2 CPU cores, GIC, timer, SYSC,
and the required  clock descriptions.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |  423 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 423 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -0,0 +1,423 @@
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
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/r8a7792-sysc.h>
+
+/ {
+	compatible = "renesas,r8a7792";
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
+	gic: interrupt-controller at f1001000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0 0xf1001000 0 0x1000>,
+		      <0 0xf1002000 0 0x1000>,
+		      <0 0xf1004000 0 0x2000>,
+		      <0 0xf1006000 0 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
+			      IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13
+			      (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			      (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			      (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			      (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	sysc: system-controller at e6180000 {
+		compatible = "renesas,r8a7792-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		#power-domain-cells = <1>;
+	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* External root clock */
+		extal_clk: extal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+		};
+
+		/* External PCIe clock - can be overridden by the board */
+		pcie_bus_clk: pcie_bus {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		/* External SCIF clock */
+		scif_clk: scif {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+		};
+
+		/*
+		 * The external audio clocks are configured as 0 Hz fixed
+		 * frequency clocks by default.  Boards that provide audio
+		 * clocks should override them.
+		 */
+		audio_clka: audio_clka {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+		audio_clkb: audio_clkb {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+		audio_clkc: audio_clkc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
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
+					     "lb", "qspi", "sdh", "sd0", "sd1",
+					     "z";
+			#power-domain-cells = <0>;
+		};
+
+		/* Fixed factor clocks */
+		pll1_div2_clk: pll1_div2 {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+		z2_clk: z2 {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+		zg_clk: zg {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <3>;
+			clock-mult = <1>;
+		};
+		zx_clk: zx {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <3>;
+			clock-mult = <1>;
+		};
+		zs_clk: zs {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <6>;
+			clock-mult = <1>;
+		};
+		hp_clk: hp {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+		};
+		i_clk: i {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+		b_clk: b {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+		};
+		p_clk: p {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+		};
+		cl_clk: cl {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <48>;
+			clock-mult = <1>;
+		};
+		m2_clk: m2 {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+		};
+		rclk_clk: rclk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <(48 * 1024)>;
+			clock-mult = <1>;
+		};
+		oscclk_clk: oscclk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <(12 * 1024)>;
+			clock-mult = <1>;
+		};
+		zb3_clk: zb3 {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+		};
+		zb3d2_clk: zb3d2 {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+		};
+		ddr_clk: ddr {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7792_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <8>;
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
+		mstp0_clks: mstp0_clks at e6150130 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
+			clocks = <&mp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7792_CLK_MSIOF0>;
+			clock-output-names = "msiof0";
+		};
+		mstp1_clks: mstp1_clks at e6150134 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
+			clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
+				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_TMU1 R8A7792_CLK_TMU3
+				R8A7792_CLK_TMU2 R8A7792_CLK_CMT0
+				R8A7792_CLK_TMU0 R8A7792_CLK_VSP1DU1
+				R8A7792_CLK_VSP1DU0 R8A7792_CLK_VSP1_SY
+			>;
+			clock-output-names = "tmu1", "tmu3", "tmu2", "cmt0",
+					     "tmu0", "vsp1du1", "vsp1du0",
+					     "vsp1-sy";
+		};
+		mstp2_clks: mstp2_clks at e6150138 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
+			clocks = <&mp_clk>, <&zs_clk>, <&zs_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_MSIOF1
+				R8A7792_CLK_SYS_DMAC0 R8A7792_CLK_SYS_DMAC1
+			>;
+			clock-output-names = "msiof1", "sys-dmac0", "sys-dmac1";
+		};
+		mstp3_clks: mstp3_clks at e615013c {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+			clocks = <&cp_clk>, <&cpg_clocks R8A7792_CLK_SD0>,
+				 <&rclk_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_TPU0 R8A7792_CLK_SDHI0
+				R8A7792_CLK_CMT1
+			>;
+			clock-output-names = "tpu0", "sdhi0", "cmt1";
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
+		mstp5_clks: mstp5_clks at e6150144 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+			clocks = <&hp_clk>, <&extal_clk>, <&p_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_AUDIO_DMAC0
+				R8A7792_CLK_THERMAL R8A7792_CLK_PWM
+			>;
+			clock-output-names = "thermal", "pwm", "audmac0";
+		};
+		mstp7_clks: mstp7_clks at e615014c {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+			clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>,
+				 <&p_clk>, <&p_clk>, <&zx_clk>, <&zx_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_HSCIF1 R8A7792_CLK_HSCIF0
+				R8A7792_CLK_SCIF3 R8A7792_CLK_SCIF2
+				R8A7792_CLK_SCIF1 R8A7792_CLK_SCIF0
+				R8A7792_CLK_DU1 R8A7792_CLK_DU0
+			>;
+			clock-output-names = "hscif1", "hscif0", "scif3",
+					     "scif2", "scif1", "scif0",
+					     "du1", "du0";
+		};
+		mstp8_clks: mstp8_clks at e6150990 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
+				 <&zg_clk>, <&zg_clk>, <&hp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_VIN5 R8A7792_CLK_VIN4
+				R8A7792_CLK_VIN3 R8A7792_CLK_VIN2
+				R8A7792_CLK_VIN1 R8A7792_CLK_VIN0
+				R8A7792_CLK_ETHERAVB
+			>;
+			clock-output-names = "vin5", "vin4", "vin3", "vin2",
+					     "vin1", "vin0", "etheravb";
+		};
+		mstp9_clks: mstp9_clks at e6150994 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&p_clk>, <&p_clk>,
+				 <&cpg_clocks R8A7792_CLK_QSPI>, <&cp_clk>,
+				 <&cp_clk>, <&hp_clk>, <&cp_clk>, <&hp_clk>,
+				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_GPIO7 R8A7792_CLK_GPIO6
+				R8A7792_CLK_GPIO5 R8A7792_CLK_GPIO4
+				R8A7792_CLK_GPIO3 R8A7792_CLK_GPIO2
+				R8A7792_CLK_GPIO1 R8A7792_CLK_GPIO0
+				R8A7792_CLK_GPIO11 R8A7792_CLK_GPIO10
+				R8A7792_CLK_CAN1 R8A7792_CLK_CAN0
+				R8A7792_CLK_QSPI_MOD R8A7792_CLK_GPIO9
+				R8A7792_CLK_GPIO8 R8A7792_CLK_I2C5
+				R8A7792_CLK_IICDVFS R8A7792_CLK_I2C4
+				R8A7792_CLK_I2C3 R8A7792_CLK_I2C2
+				R8A7792_CLK_I2C1 R8A7792_CLK_I2C0
+			>;
+			clock-output-names = "gpio7", "gpio6", "gpio5", "gpio4",
+					     "gpio3", "gpio2", "gpio1", "gpio0",
+					     "gpio11", "gpio10", "can1", "can0",
+					     "qspi_mod", "gpio9", "gpio8",
+					     "i2c5", "iic3", "i2c4", "i2c3",
+					     "i2c2", "i2c1", "i2c0";
+		};
+		mstp10_clks: mstp10_clks at e6150998 {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+			clocks = <&p_clk>, <&p_clk>, <&p_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7792_CLK_SSI_ALL
+				R8A7792_CLK_SSI4 R8A7792_CLK_SSI3
+			>;
+			clock-output-names = "ssi", "ssi4", "ssi3";
+		};
+	};
+};
