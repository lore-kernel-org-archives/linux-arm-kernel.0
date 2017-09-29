From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:56 +0200
Subject: [PATCH 04/48] ARM: dts: r8a7794: Convert to new CPG/MSSR bindings
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <58d6c357b1f7851d632bb70de3a9ada219f201c2.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert the R-Car E2 SoC from the old "Renesas R-Car Gen2 Clock Pulse
Generator (CPG)", "Renesas CPG DIV6 Clock", and "Renesas CPG Module Stop
(MSTP) Clocks" DT bindings to the new unified "Renesas Clock Pulse
Generator / Module Standby and Software Reset" DT bindings.

This simplifies the DTS files, and allows to add support for reset
control later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts  |   3 +-
 arch/arm/boot/dts/r8a7794-silk.dts |   3 +-
 arch/arm/boot/dts/r8a7794.dtsi     | 528 ++++++-------------------------------
 3 files changed, 82 insertions(+), 452 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index f1eea13cdf44..e45f92b5eb11 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -167,8 +167,7 @@
 	pinctrl-names = "default";
 	status = "okay";
 
-	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-		 <&mstp7_clks R8A7794_CLK_DU1>,
+	clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>,
 		 <&x13_clk>, <&x2_clk>;
 	clock-names = "du.0", "du.1", "dclkin.0", "dclkin.1";
 
diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 4cb5278d104d..edfad0e5ac53 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -423,8 +423,7 @@
 	pinctrl-names = "default";
 	status = "okay";
 
-	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-		 <&mstp7_clks R8A7794_CLK_DU1>,
+	clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>,
 		 <&x2_clk>, <&x3_clk>;
 	clock-names = "du.0", "du.1", "dclkin.0", "dclkin.1";
 
diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 26535414203a..ebd44d9982be 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -9,7 +9,7 @@
  * kind, whether express or implied.
  */
 
-#include <dt-bindings/clock/r8a7794-clock.h>
+#include <dt-bindings/clock/r8a7794-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/r8a7794-sysc.h>
@@ -43,7 +43,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0>;
 			clock-frequency = <1000000000>;
-			clocks = <&z2_clk>;
+			clocks = <&cpg CPG_CORE R8A7794_CLK_Z2>;
 			power-domains = <&sysc R8A7794_PD_CA7_CPU0>;
 			next-level-cache = <&L2_CA7>;
 		};
@@ -75,7 +75,7 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-		clocks = <&mstp4_clks R8A7794_CLK_INTC_SYS>;
+		clocks = <&cpg CPG_MOD 408>;
 		clock-names = "clk";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
@@ -89,7 +89,7 @@
 		gpio-ranges = <&pfc 0 0 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7794_CLK_GPIO0>;
+		clocks = <&cpg CPG_MOD 912>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -102,7 +102,7 @@
 		gpio-ranges = <&pfc 0 32 26>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7794_CLK_GPIO1>;
+		clocks = <&cpg CPG_MOD 911>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -115,7 +115,7 @@
 		gpio-ranges = <&pfc 0 64 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7794_CLK_GPIO2>;
+		clocks = <&cpg CPG_MOD 910>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -128,7 +128,7 @@
 		gpio-ranges = <&pfc 0 96 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7794_CLK_GPIO3>;
+		clocks = <&cpg CPG_MOD 909>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -141,7 +141,7 @@
 		gpio-ranges = <&pfc 0 128 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7794_CLK_GPIO4>;
+		clocks = <&cpg CPG_MOD 908>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -154,7 +154,7 @@
 		gpio-ranges = <&pfc 0 160 28>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7794_CLK_GPIO5>;
+		clocks = <&cpg CPG_MOD 907>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -167,7 +167,7 @@
 		gpio-ranges = <&pfc 0 192 26>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7794_CLK_GPIO6>;
+		clocks = <&cpg CPG_MOD 905>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -176,7 +176,7 @@
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7794_CLK_CMT0>;
+		clocks = <&cpg CPG_MOD 124>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 
@@ -196,7 +196,7 @@
 			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7794_CLK_CMT1>;
+		clocks = <&cpg CPG_MOD 329>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 
@@ -228,7 +228,7 @@
 			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R8A7794_CLK_IRQC>;
+		clocks = <&cpg CPG_MOD 407>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -261,7 +261,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC0>;
+		clocks = <&cpg CPG_MOD 219>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -292,7 +292,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC1>;
+		clocks = <&cpg CPG_MOD 218>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -320,7 +320,7 @@
 				  "ch0", "ch1", "ch2", "ch3", "ch4", "ch5",
 				  "ch6", "ch7", "ch8", "ch9", "ch10", "ch11",
 				  "ch12";
-		clocks = <&mstp5_clks R8A7794_CLK_AUDIO_DMAC0>;
+		clocks = <&cpg CPG_MOD 502>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -332,7 +332,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
+		clocks = <&cpg CPG_MOD 204>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
 		       <&dmac1 0x21>, <&dmac1 0x22>;
@@ -346,7 +346,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7794_CLK_SCIFA1>;
+		clocks = <&cpg CPG_MOD 203>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
 		       <&dmac1 0x25>, <&dmac1 0x26>;
@@ -360,7 +360,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7794_CLK_SCIFA2>;
+		clocks = <&cpg CPG_MOD 202>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
 		       <&dmac1 0x27>, <&dmac1 0x28>;
@@ -374,7 +374,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7794_CLK_SCIFA3>;
+		clocks = <&cpg CPG_MOD 1106>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
 		       <&dmac1 0x1b>, <&dmac1 0x1c>;
@@ -388,7 +388,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7794_CLK_SCIFA4>;
+		clocks = <&cpg CPG_MOD 1107>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
 		       <&dmac1 0x1f>, <&dmac1 0x20>;
@@ -402,7 +402,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7794_CLK_SCIFA5>;
+		clocks = <&cpg CPG_MOD 1108>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>,
 		       <&dmac1 0x23>, <&dmac1 0x24>;
@@ -416,7 +416,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7794_CLK_SCIFB0>;
+		clocks = <&cpg CPG_MOD 206>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
@@ -430,7 +430,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7794_CLK_SCIFB1>;
+		clocks = <&cpg CPG_MOD 207>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
@@ -444,7 +444,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7794_CLK_SCIFB2>;
+		clocks = <&cpg CPG_MOD 216>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
@@ -458,7 +458,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 721>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
@@ -473,7 +473,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 720>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
@@ -488,7 +488,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 719>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
@@ -503,7 +503,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 718>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
@@ -518,7 +518,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 715>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
@@ -533,7 +533,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 714>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
@@ -548,7 +548,7 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 717>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
@@ -563,7 +563,7 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 716>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
@@ -578,7 +578,7 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 713>, <&cpg CPG_CORE R8A7794_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
@@ -610,7 +610,7 @@
 		compatible = "renesas,ether-r8a7794";
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7794_CLK_ETHER>;
+		clocks = <&cpg CPG_MOD 813>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
@@ -623,7 +623,7 @@
 			     "renesas,etheravb-rcar-gen2";
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7794_CLK_ETHERAVB>;
+		clocks = <&cpg CPG_MOD 812>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -635,7 +635,7 @@
 		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_I2C0>;
+		clocks = <&cpg CPG_MOD 931>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -647,7 +647,7 @@
 		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_I2C1>;
+		clocks = <&cpg CPG_MOD 930>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -659,7 +659,7 @@
 		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_I2C2>;
+		clocks = <&cpg CPG_MOD 929>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -671,7 +671,7 @@
 		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_I2C3>;
+		clocks = <&cpg CPG_MOD 928>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -683,7 +683,7 @@
 		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_I2C4>;
+		clocks = <&cpg CPG_MOD 927>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -695,7 +695,7 @@
 		compatible = "renesas,i2c-r8a7794", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_I2C5>;
+		clocks = <&cpg CPG_MOD 925>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -708,7 +708,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7794_CLK_IIC0>;
+		clocks = <&cpg CPG_MOD 318>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -723,7 +723,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7794_CLK_IIC1>;
+		clocks = <&cpg CPG_MOD 323>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -737,7 +737,7 @@
 		compatible = "renesas,mmcif-r8a7794", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7794_CLK_MMCIF0>;
+		clocks = <&cpg CPG_MOD 315>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -750,7 +750,7 @@
 		compatible = "renesas,sdhi-r8a7794";
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
+		clocks = <&cpg CPG_MOD 314>;
 		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
 		       <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -763,7 +763,7 @@
 		compatible = "renesas,sdhi-r8a7794";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
+		clocks = <&cpg CPG_MOD 312>;
 		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
 		       <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -776,7 +776,7 @@
 		compatible = "renesas,sdhi-r8a7794";
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
+		clocks = <&cpg CPG_MOD 311>;
 		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
 		       <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -789,7 +789,7 @@
 		compatible = "renesas,qspi-r8a7794", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_QSPI_MOD>;
+		clocks = <&cpg CPG_MOD 917>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -804,7 +804,7 @@
 		compatible = "renesas,vin-r8a7794", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7794_CLK_VIN0>;
+		clocks = <&cpg CPG_MOD 811>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -813,7 +813,7 @@
 		compatible = "renesas,vin-r8a7794", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7794_CLK_VIN1>;
+		clocks = <&cpg CPG_MOD 810>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -824,7 +824,7 @@
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
+		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 
@@ -857,7 +857,7 @@
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
+		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 
@@ -888,7 +888,7 @@
 		compatible = "renesas,usbhs-r8a7794", "renesas,rcar-gen2-usbhs";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
+		clocks = <&cpg CPG_MOD 704>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
@@ -902,7 +902,7 @@
 		reg = <0 0xe6590100 0 0x100>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
+		clocks = <&cpg CPG_MOD 704>;
 		clock-names = "usbhs";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -921,7 +921,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7794_CLK_VSP1_S>;
+		clocks = <&cpg CPG_MOD 131>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -929,7 +929,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7794_CLK_VSP1_DU0>;
+		clocks = <&cpg CPG_MOD 128>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
@@ -939,8 +939,7 @@
 		reg-names = "du";
 		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-			 <&mstp7_clks R8A7794_CLK_DU1>;
+		clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>;
 		clock-names = "du.0", "du.1";
 		status = "disabled";
 
@@ -965,8 +964,8 @@
 		compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e80000 0 0x1000>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_RCAN0>,
-			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
+		clocks = <&cpg CPG_MOD 916>, <&cpg CPG_CORE R8A7794_CLK_RCAN>,
+			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -976,8 +975,8 @@
 		compatible = "renesas,can-r8a7794", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e88000 0 0x1000>;
 		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7794_CLK_RCAN1>,
-			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
+		clocks = <&cpg CPG_MOD 915>, <&cpg CPG_CORE R8A7794_CLK_RCAN>,
+			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -1040,370 +1039,14 @@
 			clock-frequency = <0>;
 		};
 
-		/* Special CPG clocks */
-		cpg_clocks: cpg_clocks at e6150000 {
-			compatible = "renesas,r8a7794-cpg-clocks",
-				     "renesas,rcar-gen2-cpg-clocks";
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7794-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk &usb_extal_clk>;
-			#clock-cells = <1>;
-			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi", "sdh", "sd0", "rcan";
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
 			#power-domain-cells = <0>;
 		};
-		/* Variable factor clocks */
-		sd2_clk: sd2 at e6150078 {
-			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe6150078 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		sd3_clk: sd3 at e615026c {
-			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe615026c 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		mmc0_clk: mmc0 at e6150240 {
-			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe6150240 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-
-		/* Fixed factor clocks */
-		pll1_div2_clk: pll1_div2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-		z2_clk: z2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL0>;
-			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <1>;
-		};
-		zg_clk: zg {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <6>;
-			clock-mult = <1>;
-		};
-		zx_clk: zx {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <3>;
-			clock-mult = <1>;
-		};
-		zs_clk: zs {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <6>;
-			clock-mult = <1>;
-		};
-		hp_clk: hp {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <12>;
-			clock-mult = <1>;
-		};
-		i_clk: i {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-		b_clk: b {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <12>;
-			clock-mult = <1>;
-		};
-		p_clk: p {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <24>;
-			clock-mult = <1>;
-		};
-		cl_clk: cl {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <48>;
-			clock-mult = <1>;
-		};
-		m2_clk: m2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-		};
-		rclk_clk: rclk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <(48 * 1024)>;
-			clock-mult = <1>;
-		};
-		oscclk_clk: oscclk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <(12 * 1024)>;
-			clock-mult = <1>;
-		};
-		zb3_clk: zb3 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
-			#clock-cells = <0>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-		zb3d2_clk: zb3d2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-		};
-		ddr_clk: ddr {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-		};
-		mp_clk: mp {
-			compatible = "fixed-factor-clock";
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-			clock-div = <15>;
-			clock-mult = <1>;
-		};
-		cp_clk: cp {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <48>;
-			clock-mult = <1>;
-		};
-
-		acp_clk: acp {
-			compatible = "fixed-factor-clock";
-			clocks = <&extal_clk>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-
-		/* Gate clocks */
-		mstp0_clks: mstp0_clks at e6150130 {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
-			clocks = <&mp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7794_CLK_MSIOF0>;
-			clock-output-names = "msiof0";
-		};
-		mstp1_clks: mstp1_clks at e6150134 {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&zg_clk>, <&zs_clk>,
-				 <&zs_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>, <&cp_clk>,
-				 <&zs_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7794_CLK_VCP0 R8A7794_CLK_VPC0 R8A7794_CLK_TMU1
-				R8A7794_CLK_3DG R8A7794_CLK_2DDMAC R8A7794_CLK_FDP1_0
-				R8A7794_CLK_TMU3 R8A7794_CLK_TMU2 R8A7794_CLK_CMT0
-				R8A7794_CLK_TMU0 R8A7794_CLK_VSP1_DU0 R8A7794_CLK_VSP1_S
-			>;
-			clock-output-names =
-				"vcp0", "vpc0", "tmu1", "3dg", "2ddmac", "fdp1-0",
-				"tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du0", "vsps";
-		};
-		mstp2_clks: mstp2_clks at e6150138 {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
-			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&zs_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7794_CLK_SCIFA2 R8A7794_CLK_SCIFA1 R8A7794_CLK_SCIFA0
-				R8A7794_CLK_MSIOF2 R8A7794_CLK_SCIFB0 R8A7794_CLK_SCIFB1
-				R8A7794_CLK_MSIOF1 R8A7794_CLK_SCIFB2
-				R8A7794_CLK_SYS_DMAC1 R8A7794_CLK_SYS_DMAC0
-			>;
-			clock-output-names =
-				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
-				"scifb1", "msiof1", "scifb2",
-				"sys-dmac1", "sys-dmac0";
-		};
-		mstp3_clks: mstp3_clks at e615013c {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&sd3_clk>, <&sd2_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
-				 <&mmc0_clk>, <&hp_clk>, <&hp_clk>, <&rclk_clk>,
-				 <&hp_clk>, <&hp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-			        R8A7794_CLK_SDHI2 R8A7794_CLK_SDHI1 R8A7794_CLK_SDHI0
-				R8A7794_CLK_MMCIF0 R8A7794_CLK_IIC0
-				R8A7794_CLK_IIC1 R8A7794_CLK_CMT1
-				R8A7794_CLK_USBDMAC0 R8A7794_CLK_USBDMAC1
-			>;
-			clock-output-names =
-			        "sdhi2", "sdhi1", "sdhi0",
-				"mmcif0", "i2c6", "i2c7",
-				"cmt1", "usbdmac0", "usbdmac1";
-		};
-		mstp4_clks: mstp4_clks at e6150140 {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&cp_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7794_CLK_IRQC R8A7794_CLK_INTC_SYS>;
-			clock-output-names = "irqc", "intc-sys";
-		};
-		mstp5_clks: mstp5_clks at e6150144 {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&hp_clk>, <&p_clk>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7794_CLK_AUDIO_DMAC0
-					 R8A7794_CLK_PWM>;
-			clock-output-names = "audmac0", "pwm";
-		};
-		mstp7_clks: mstp7_clks at e615014c {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-			clocks = <&mp_clk>, <&hp_clk>,
-				 <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
-				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				 <&zx_clk>, <&zx_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7794_CLK_EHCI R8A7794_CLK_HSUSB
-				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
-				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
-				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
-				R8A7794_CLK_SCIF0
-				R8A7794_CLK_DU1 R8A7794_CLK_DU0
-			>;
-			clock-output-names =
-				"ehci", "hsusb",
-				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
-				"scif3", "scif2", "scif1", "scif0",
-				"du1", "du0";
-		};
-		mstp8_clks: mstp8_clks at e6150990 {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&zg_clk>, <&zg_clk>, <&hp_clk>, <&p_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7794_CLK_VIN1 R8A7794_CLK_VIN0
-				R8A7794_CLK_ETHERAVB R8A7794_CLK_ETHER
-			>;
-			clock-output-names =
-				"vin1", "vin0", "etheravb", "ether";
-		};
-		mstp9_clks: mstp9_clks at e6150994 {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&p_clk>,
-				 <&p_clk>, <&cpg_clocks R8A7794_CLK_QSPI>,
-				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
-				 <&hp_clk>, <&hp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7794_CLK_GPIO6 R8A7794_CLK_GPIO5
-					 R8A7794_CLK_GPIO4 R8A7794_CLK_GPIO3
-					 R8A7794_CLK_GPIO2 R8A7794_CLK_GPIO1
-					 R8A7794_CLK_GPIO0 R8A7794_CLK_RCAN1
-					 R8A7794_CLK_RCAN0 R8A7794_CLK_QSPI_MOD
-					 R8A7794_CLK_I2C5 R8A7794_CLK_I2C4
-					 R8A7794_CLK_I2C3 R8A7794_CLK_I2C2
-					 R8A7794_CLK_I2C1 R8A7794_CLK_I2C0>;
-			clock-output-names =
-				"gpio6", "gpio5", "gpio4", "gpio3", "gpio2",
-				"gpio1", "gpio0", "rcan1", "rcan0", "qspi_mod",
-				"i2c5", "i2c4", "i2c3", "i2c2", "i2c1", "i2c0";
-		};
-		mstp10_clks: mstp10_clks at e6150998 {
-			compatible = "renesas,r8a7794-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
-			clocks = <&p_clk>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-				 <&p_clk>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>,
-				 <&mstp10_clks R8A7794_CLK_SCU_ALL>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7794_CLK_SSI_ALL
-					 R8A7794_CLK_SSI9 R8A7794_CLK_SSI8
-					 R8A7794_CLK_SSI7 R8A7794_CLK_SSI6
-					 R8A7794_CLK_SSI5 R8A7794_CLK_SSI4
-					 R8A7794_CLK_SSI3 R8A7794_CLK_SSI2
-					 R8A7794_CLK_SSI1 R8A7794_CLK_SSI0
-					 R8A7794_CLK_SCU_ALL
-					 R8A7794_CLK_SCU_DVC1
-					 R8A7794_CLK_SCU_DVC0
-					 R8A7794_CLK_SCU_CTU1_MIX1
-					 R8A7794_CLK_SCU_CTU0_MIX0
-					 R8A7794_CLK_SCU_SRC6
-					 R8A7794_CLK_SCU_SRC5
-					 R8A7794_CLK_SCU_SRC4
-					 R8A7794_CLK_SCU_SRC3
-					 R8A7794_CLK_SCU_SRC2
-					 R8A7794_CLK_SCU_SRC1>;
-			clock-output-names = "ssi-all", "ssi9", "ssi8", "ssi7",
-					     "ssi6", "ssi5", "ssi4", "ssi3",
-					     "ssi2", "ssi1", "ssi0",
-					     "scu-all", "scu-dvc1", "scu-dvc0",
-					     "scu-ctu1-mix1", "scu-ctu0-mix0",
-					     "scu-src6", "scu-src5", "scu-src4",
-					     "scu-src3", "scu-src2", "scu-src1";
-		};
-		mstp11_clks: mstp11_clks at e615099c {
-			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
-			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7794_CLK_SCIFA3 R8A7794_CLK_SCIFA4 R8A7794_CLK_SCIFA5
-			>;
-			clock-output-names = "scifa3", "scifa4", "scifa5";
-		};
 	};
 
 	rst: reset-controller at e6160000 {
@@ -1490,31 +1133,20 @@
 			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri */
 		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
-		clocks = <&mstp10_clks R8A7794_CLK_SSI_ALL>,
-			 <&mstp10_clks R8A7794_CLK_SSI9>,
-			 <&mstp10_clks R8A7794_CLK_SSI8>,
-			 <&mstp10_clks R8A7794_CLK_SSI7>,
-			 <&mstp10_clks R8A7794_CLK_SSI6>,
-			 <&mstp10_clks R8A7794_CLK_SSI5>,
-			 <&mstp10_clks R8A7794_CLK_SSI4>,
-			 <&mstp10_clks R8A7794_CLK_SSI3>,
-			 <&mstp10_clks R8A7794_CLK_SSI2>,
-			 <&mstp10_clks R8A7794_CLK_SSI1>,
-			 <&mstp10_clks R8A7794_CLK_SSI0>,
-			 <&mstp10_clks R8A7794_CLK_SCU_SRC6>,
-			 <&mstp10_clks R8A7794_CLK_SCU_SRC5>,
-			 <&mstp10_clks R8A7794_CLK_SCU_SRC4>,
-			 <&mstp10_clks R8A7794_CLK_SCU_SRC3>,
-			 <&mstp10_clks R8A7794_CLK_SCU_SRC2>,
-			 <&mstp10_clks R8A7794_CLK_SCU_SRC1>,
-			 <&mstp10_clks R8A7794_CLK_SCU_CTU0_MIX0>,
-			 <&mstp10_clks R8A7794_CLK_SCU_CTU1_MIX1>,
-			 <&mstp10_clks R8A7794_CLK_SCU_CTU0_MIX0>,
-			 <&mstp10_clks R8A7794_CLK_SCU_CTU1_MIX1>,
-			 <&mstp10_clks R8A7794_CLK_SCU_DVC0>,
-			 <&mstp10_clks R8A7794_CLK_SCU_DVC1>,
+		clocks = <&cpg CPG_MOD 1005>,
+			 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+			 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+			 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+			 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+			 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+			 <&cpg CPG_MOD 1025>, <&cpg CPG_MOD 1026>,
+			 <&cpg CPG_MOD 1027>, <&cpg CPG_MOD 1028>,
+			 <&cpg CPG_MOD 1029>, <&cpg CPG_MOD 1030>,
+			 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+			 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+			 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 			 <&audio_clka>, <&audio_clkb>, <&audio_clkc>,
-			 <&m2_clk>;
+			 <&cpg CPG_CORE R8A7794_CLK_M2>;
 		clock-names = "ssi-all",
 			      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
 			      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
-- 
2.1.4
