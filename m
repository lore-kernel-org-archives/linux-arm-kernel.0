From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:53 +0200
Subject: [PATCH 01/48] ARM: dts: r8a7790: Convert to new CPG/MSSR bindings
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <5802c420636559ffd37095d2886f6964d9b55b11.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert the R-Car H2 SoC from the old "Renesas R-Car Gen2 Clock Pulse
Generator (CPG)", "Renesas CPG DIV6 Clock", and "Renesas CPG Module Stop
(MSTP) Clocks" DT bindings to the new unified "Renesas Clock Pulse
Generator / Module Standby and Software Reset" DT bindings.

This simplifies the DTS files, and allows to add support for reset
control later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts |   7 +-
 arch/arm/boot/dts/r8a7790.dtsi      | 557 +++++++-----------------------------
 2 files changed, 99 insertions(+), 465 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index ba100a6f67ca..e3d27783b6b5 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -316,11 +316,8 @@
 	pinctrl-names = "default";
 	status = "okay";
 
-	clocks = <&mstp7_clks R8A7790_CLK_DU0>,
-		 <&mstp7_clks R8A7790_CLK_DU1>,
-		 <&mstp7_clks R8A7790_CLK_DU2>,
-		 <&mstp7_clks R8A7790_CLK_LVDS0>,
-		 <&mstp7_clks R8A7790_CLK_LVDS1>,
+	clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>, <&cpg CPG_MOD 722>,
+		 <&cpg CPG_MOD 726>, <&cpg CPG_MOD 725>,
 		 <&x13_clk>, <&x2_clk>;
 	clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1",
 		      "dclkin.0", "dclkin.1";
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 16358bf8d1db..5a31dfc0c316 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -10,7 +10,7 @@
  * kind, whether express or implied.
  */
 
-#include <dt-bindings/clock/r8a7790-clock.h>
+#include <dt-bindings/clock/r8a7790-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/r8a7790-sysc.h>
@@ -52,7 +52,7 @@
 			reg = <0>;
 			clock-frequency = <1300000000>;
 			voltage-tolerance = <1>; /* 1% */
-			clocks = <&cpg_clocks R8A7790_CLK_Z>;
+			clocks = <&cpg CPG_CORE R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7790_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
@@ -185,7 +185,7 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		clocks = <&mstp4_clks R8A7790_CLK_INTC_SYS>;
+		clocks = <&cpg CPG_MOD 408>;
 		clock-names = "clk";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
@@ -199,7 +199,7 @@
 		gpio-ranges = <&pfc 0 0 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7790_CLK_GPIO0>;
+		clocks = <&cpg CPG_MOD 912>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -212,7 +212,7 @@
 		gpio-ranges = <&pfc 0 32 30>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
+		clocks = <&cpg CPG_MOD 911>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -225,7 +225,7 @@
 		gpio-ranges = <&pfc 0 64 30>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7790_CLK_GPIO2>;
+		clocks = <&cpg CPG_MOD 910>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -238,7 +238,7 @@
 		gpio-ranges = <&pfc 0 96 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7790_CLK_GPIO3>;
+		clocks = <&cpg CPG_MOD 909>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -251,7 +251,7 @@
 		gpio-ranges = <&pfc 0 128 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7790_CLK_GPIO4>;
+		clocks = <&cpg CPG_MOD 908>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -264,7 +264,7 @@
 		gpio-ranges = <&pfc 0 160 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7790_CLK_GPIO5>;
+		clocks = <&cpg CPG_MOD 907>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -274,7 +274,7 @@
 				"renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
+		clocks = <&cpg CPG_MOD 522>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#thermal-sensor-cells = <0>;
 	};
@@ -292,7 +292,7 @@
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
+		clocks = <&cpg CPG_MOD 124>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
@@ -312,7 +312,7 @@
 			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
+		clocks = <&cpg CPG_MOD 329>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
@@ -330,7 +330,7 @@
 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R8A7790_CLK_IRQC>;
+		clocks = <&cpg CPG_MOD 407>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -358,7 +358,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
+		clocks = <&cpg CPG_MOD 219>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -389,7 +389,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
+		clocks = <&cpg CPG_MOD 218>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -418,7 +418,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12";
-		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC0>;
+		clocks = <&cpg CPG_MOD 502>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -447,7 +447,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12";
-		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC1>;
+		clocks = <&cpg CPG_MOD 501>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -460,7 +460,7 @@
 		interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
 			      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
-		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC0>;
+		clocks = <&cpg CPG_MOD 330>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
@@ -472,7 +472,7 @@
 		interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
 			      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
-		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC1>;
+		clocks = <&cpg CPG_MOD 331>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
@@ -484,7 +484,7 @@
 		compatible = "renesas,i2c-r8a7790", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
+		clocks = <&cpg CPG_MOD 931>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
@@ -496,7 +496,7 @@
 		compatible = "renesas,i2c-r8a7790", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
+		clocks = <&cpg CPG_MOD 930>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
@@ -508,7 +508,7 @@
 		compatible = "renesas,i2c-r8a7790", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
+		clocks = <&cpg CPG_MOD 929>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
@@ -520,7 +520,7 @@
 		compatible = "renesas,i2c-r8a7790", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
+		clocks = <&cpg CPG_MOD 928>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
@@ -533,7 +533,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
+		clocks = <&cpg CPG_MOD 318>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -548,7 +548,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
+		clocks = <&cpg CPG_MOD 323>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -563,7 +563,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe6520000 0 0x425>;
 		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
+		clocks = <&cpg CPG_MOD 300>;
 		dmas = <&dmac0 0x69>, <&dmac0 0x6a>,
 		       <&dmac1 0x69>, <&dmac1 0x6a>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -578,7 +578,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
+		clocks = <&cpg CPG_MOD 926>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>,
 		       <&dmac1 0x77>, <&dmac1 0x78>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -590,7 +590,7 @@
 		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
+		clocks = <&cpg CPG_MOD 315>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -604,7 +604,7 @@
 		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
+		clocks = <&cpg CPG_MOD 305>;
 		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>,
 		       <&dmac1 0xe1>, <&dmac1 0xe2>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -623,7 +623,7 @@
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		clocks = <&cpg CPG_MOD 314>;
 		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
 		       <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -636,7 +636,7 @@
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		clocks = <&cpg CPG_MOD 313>;
 		dmas = <&dmac0 0xc9>, <&dmac0 0xca>,
 		       <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -649,7 +649,7 @@
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		clocks = <&cpg CPG_MOD 312>;
 		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
 		       <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -662,7 +662,7 @@
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		clocks = <&cpg CPG_MOD 311>;
 		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
 		       <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -676,7 +676,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
+		clocks = <&cpg CPG_MOD 204>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
 		       <&dmac1 0x21>, <&dmac1 0x22>;
@@ -690,7 +690,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
+		clocks = <&cpg CPG_MOD 203>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
 		       <&dmac1 0x25>, <&dmac1 0x26>;
@@ -704,7 +704,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
+		clocks = <&cpg CPG_MOD 202>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
 		       <&dmac1 0x27>, <&dmac1 0x28>;
@@ -718,7 +718,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
+		clocks = <&cpg CPG_MOD 206>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
@@ -732,7 +732,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
+		clocks = <&cpg CPG_MOD 207>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
@@ -746,7 +746,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
+		clocks = <&cpg CPG_MOD 216>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
@@ -760,7 +760,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 721>, <&cpg CPG_CORE R8A7790_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
@@ -775,7 +775,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 720>, <&cpg CPG_CORE R8A7790_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
@@ -790,7 +790,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e56000 0 64>;
 		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_SCIF2>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 310>, <&cpg CPG_CORE R8A7790_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
@@ -805,7 +805,7 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 717>, <&cpg CPG_CORE R8A7790_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
@@ -820,7 +820,7 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 716>, <&cpg CPG_CORE R8A7790_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
@@ -852,7 +852,7 @@
 		compatible = "renesas,ether-r8a7790";
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7790_CLK_ETHER>;
+		clocks = <&cpg CPG_MOD 813>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
@@ -865,7 +865,7 @@
 			     "renesas,etheravb-rcar-gen2";
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7790_CLK_ETHERAVB>;
+		clocks = <&cpg CPG_MOD 812>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -876,7 +876,7 @@
 		compatible = "renesas,sata-r8a7790", "renesas,rcar-gen2-sata";
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
+		clocks = <&cpg CPG_MOD 815>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -885,7 +885,7 @@
 		compatible = "renesas,sata-r8a7790", "renesas,rcar-gen2-sata";
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
+		clocks = <&cpg CPG_MOD 814>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -894,7 +894,7 @@
 		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-gen2-usbhs";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		clocks = <&cpg CPG_MOD 704>;
 		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
 		dma-names = "ch0", "ch1", "ch2", "ch3";
@@ -911,7 +911,7 @@
 		reg = <0 0xe6590100 0 0x100>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		clocks = <&cpg CPG_MOD 704>;
 		clock-names = "usbhs";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -930,7 +930,7 @@
 		compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
+		clocks = <&cpg CPG_MOD 811>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -939,7 +939,7 @@
 		compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
+		clocks = <&cpg CPG_MOD 810>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -948,7 +948,7 @@
 		compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
+		clocks = <&cpg CPG_MOD 809>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -957,7 +957,7 @@
 		compatible = "renesas,vin-r8a7790", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef3000 0 0x1000>;
 		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
+		clocks = <&cpg CPG_MOD 808>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -966,7 +966,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe920000 0 0x8000>;
 		interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
+		clocks = <&cpg CPG_MOD 130>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -974,7 +974,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7790_CLK_VSP1_S>;
+		clocks = <&cpg CPG_MOD 131>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -982,7 +982,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU0>;
+		clocks = <&cpg CPG_MOD 128>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -990,7 +990,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU1>;
+		clocks = <&cpg CPG_MOD 127>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -1003,11 +1003,9 @@
 		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_DU0>,
-			 <&mstp7_clks R8A7790_CLK_DU1>,
-			 <&mstp7_clks R8A7790_CLK_DU2>,
-			 <&mstp7_clks R8A7790_CLK_LVDS0>,
-			 <&mstp7_clks R8A7790_CLK_LVDS1>;
+		clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>,
+			 <&cpg CPG_MOD 722>, <&cpg CPG_MOD 726>,
+			 <&cpg CPG_MOD 725>;
 		clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1";
 		status = "disabled";
 
@@ -1037,8 +1035,8 @@
 		compatible = "renesas,can-r8a7790", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e80000 0 0x1000>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7790_CLK_RCAN0>,
-			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
+		clocks = <&cpg CPG_MOD 916>, <&cpg CPG_CORE R8A7790_CLK_RCAN>,
+			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -1048,8 +1046,8 @@
 		compatible = "renesas,can-r8a7790", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e88000 0 0x1000>;
 		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7790_CLK_RCAN1>,
-			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
+		clocks = <&cpg CPG_MOD 915>, <&cpg CPG_CORE R8A7790_CLK_RCAN>,
+			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -1059,7 +1057,7 @@
 		compatible = "renesas,jpu-r8a7790", "renesas,rcar-gen2-jpu";
 		reg = <0 0xfe980000 0 0x10300>;
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7790_CLK_JPU>;
+		clocks = <&cpg CPG_MOD 106>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
@@ -1126,376 +1124,14 @@
 			clock-frequency = <0>;
 		};
 
-		/* Special CPG clocks */
-		cpg_clocks: cpg_clocks at e6150000 {
-			compatible = "renesas,r8a7790-cpg-clocks",
-				     "renesas,rcar-gen2-cpg-clocks";
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7790-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk &usb_extal_clk>;
-			#clock-cells = <1>;
-			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi", "sdh", "sd0", "sd1",
-					     "z", "rcan", "adsp";
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
 			#power-domain-cells = <0>;
 		};
-
-		/* Variable factor clocks */
-		sd2_clk: sd2 at e6150078 {
-			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe6150078 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		sd3_clk: sd3 at e615026c {
-			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe615026c 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		mmc0_clk: mmc0 at e6150240 {
-			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe6150240 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		mmc1_clk: mmc1 at e6150244 {
-			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe6150244 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		ssp_clk: ssp at e6150248 {
-			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe6150248 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		ssprs_clk: ssprs at e615024c {
-			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe615024c 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-
-		/* Fixed factor clocks */
-		pll1_div2_clk: pll1_div2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-		z2_clk: z2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-		zg_clk: zg {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <3>;
-			clock-mult = <1>;
-		};
-		zx_clk: zx {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <3>;
-			clock-mult = <1>;
-		};
-		zs_clk: zs {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <6>;
-			clock-mult = <1>;
-		};
-		hp_clk: hp {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <12>;
-			clock-mult = <1>;
-		};
-		i_clk: i {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-		b_clk: b {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <12>;
-			clock-mult = <1>;
-		};
-		p_clk: p {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <24>;
-			clock-mult = <1>;
-		};
-		cl_clk: cl {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <48>;
-			clock-mult = <1>;
-		};
-		m2_clk: m2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-		};
-		imp_clk: imp {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-		rclk_clk: rclk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <(48 * 1024)>;
-			clock-mult = <1>;
-		};
-		oscclk_clk: oscclk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <(12 * 1024)>;
-			clock-mult = <1>;
-		};
-		zb3_clk: zb3 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
-			#clock-cells = <0>;
-			clock-div = <4>;
-			clock-mult = <1>;
-		};
-		zb3d2_clk: zb3d2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-		};
-		ddr_clk: ddr {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
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
-			clocks = <&extal_clk>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-
-		/* Gate clocks */
-		mstp0_clks: mstp0_clks at e6150130 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
-			clocks = <&mp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7790_CLK_MSIOF0>;
-			clock-output-names = "msiof0";
-		};
-		mstp1_clks: mstp1_clks at e6150134 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&zs_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>, <&m2_clk>,
-				 <&zs_clk>, <&p_clk>, <&zg_clk>, <&zs_clk>, <&zs_clk>,
-				 <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
-				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7790_CLK_VCP1 R8A7790_CLK_VCP0 R8A7790_CLK_VPC1
-				R8A7790_CLK_VPC0 R8A7790_CLK_JPU R8A7790_CLK_SSP1
-				R8A7790_CLK_TMU1 R8A7790_CLK_3DG R8A7790_CLK_2DDMAC
-				R8A7790_CLK_FDP1_2 R8A7790_CLK_FDP1_1 R8A7790_CLK_FDP1_0
-				R8A7790_CLK_TMU3 R8A7790_CLK_TMU2 R8A7790_CLK_CMT0
-				R8A7790_CLK_TMU0 R8A7790_CLK_VSP1_DU1 R8A7790_CLK_VSP1_DU0
-				R8A7790_CLK_VSP1_R R8A7790_CLK_VSP1_S
-			>;
-			clock-output-names =
-				"vcp1", "vcp0", "vpc1", "vpc0", "jpu", "ssp1",
-				"tmu1", "3dg", "2ddmac", "fdp1-2", "fdp1-1",
-				"fdp1-0", "tmu3", "tmu2", "cmt0", "tmu0",
-				"vsp1-du1", "vsp1-du0", "vsp1-rt", "vsp1-sy";
-		};
-		mstp2_clks: mstp2_clks at e6150138 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
-			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&zs_clk>,
-				 <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
-				R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
-				R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
-				R8A7790_CLK_SYS_DMAC1 R8A7790_CLK_SYS_DMAC0
-			>;
-			clock-output-names =
-				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
-				"scifb1", "msiof1", "msiof3", "scifb2",
-				"sys-dmac1", "sys-dmac0";
-		};
-		mstp3_clks: mstp3_clks at e615013c {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&hp_clk>, <&cp_clk>, <&mmc1_clk>, <&p_clk>, <&sd3_clk>,
-				 <&sd2_clk>, <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>, <&mmc0_clk>,
-				 <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>,
-				 <&hp_clk>, <&hp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SCIF2 R8A7790_CLK_SDHI3
-				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0 R8A7790_CLK_MMCIF0
-				R8A7790_CLK_IIC0 R8A7790_CLK_PCIEC R8A7790_CLK_IIC1 R8A7790_CLK_SSUSB R8A7790_CLK_CMT1
-				R8A7790_CLK_USBDMAC0 R8A7790_CLK_USBDMAC1
-			>;
-			clock-output-names =
-				"iic2", "tpu0", "mmcif1", "scif2", "sdhi3",
-				"sdhi2", "sdhi1", "sdhi0", "mmcif0",
-				"iic0", "pciec", "iic1", "ssusb", "cmt1",
-				"usbdmac0", "usbdmac1";
-		};
-		mstp4_clks: mstp4_clks at e6150140 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&cp_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7790_CLK_IRQC R8A7790_CLK_INTC_SYS>;
-			clock-output-names = "irqc", "intc-sys";
-		};
-		mstp5_clks: mstp5_clks at e6150144 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&hp_clk>, <&hp_clk>, <&cpg_clocks R8A7790_CLK_ADSP>,
-				 <&extal_clk>, <&p_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7790_CLK_AUDIO_DMAC0 R8A7790_CLK_AUDIO_DMAC1
-				R8A7790_CLK_ADSP_MOD R8A7790_CLK_THERMAL
-				R8A7790_CLK_PWM
-			>;
-			clock-output-names = "audmac0", "audmac1", "adsp_mod",
-					     "thermal", "pwm";
-		};
-		mstp7_clks: mstp7_clks at e615014c {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-			clocks = <&mp_clk>, <&hp_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
-				 <&p_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>,
-				 <&zx_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7790_CLK_EHCI R8A7790_CLK_HSUSB R8A7790_CLK_HSCIF1
-				R8A7790_CLK_HSCIF0 R8A7790_CLK_SCIF1 R8A7790_CLK_SCIF0
-				R8A7790_CLK_DU2 R8A7790_CLK_DU1 R8A7790_CLK_DU0
-				R8A7790_CLK_LVDS1 R8A7790_CLK_LVDS0
-			>;
-			clock-output-names =
-				"ehci", "hsusb", "hscif1", "hscif0", "scif1",
-				"scif0", "du2", "du1", "du0", "lvds1", "lvds0";
-		};
-		mstp8_clks: mstp8_clks at e6150990 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&hp_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
-			         <&zg_clk>, <&hp_clk>, <&p_clk>, <&zs_clk>,
-				 <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7790_CLK_MLB R8A7790_CLK_VIN3 R8A7790_CLK_VIN2
-				R8A7790_CLK_VIN1 R8A7790_CLK_VIN0
-				R8A7790_CLK_ETHERAVB R8A7790_CLK_ETHER
-				R8A7790_CLK_SATA1 R8A7790_CLK_SATA0
-			>;
-			clock-output-names =
-				"mlb", "vin3", "vin2", "vin1", "vin0",
-				"etheravb", "ether", "sata1", "sata0";
-		};
-		mstp9_clks: mstp9_clks at e6150994 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>, <&cp_clk>,
-				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7790_CLK_GPIO5 R8A7790_CLK_GPIO4 R8A7790_CLK_GPIO3
-				R8A7790_CLK_GPIO2 R8A7790_CLK_GPIO1 R8A7790_CLK_GPIO0
-				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD R8A7790_CLK_IICDVFS
-				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1 R8A7790_CLK_I2C0
-			>;
-			clock-output-names =
-				"gpio5", "gpio4", "gpio3", "gpio2", "gpio1", "gpio0",
-				"rcan1", "rcan0", "qspi_mod", "iic3",
-				"i2c3", "i2c2", "i2c1", "i2c0";
-		};
-		mstp10_clks: mstp10_clks at e6150998 {
-			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
-			clocks = <&p_clk>,
-				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7790_CLK_SSI_ALL>, <&mstp10_clks R8A7790_CLK_SSI_ALL>,
-				<&p_clk>,
-				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7790_CLK_SCU_ALL>, <&mstp10_clks R8A7790_CLK_SCU_ALL>;
-
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7790_CLK_SSI_ALL
-				R8A7790_CLK_SSI9 R8A7790_CLK_SSI8 R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
-				R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2 R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
-				R8A7790_CLK_SCU_ALL
-				R8A7790_CLK_SCU_DVC1 R8A7790_CLK_SCU_DVC0
-				R8A7790_CLK_SCU_CTU1_MIX1 R8A7790_CLK_SCU_CTU0_MIX0
-				R8A7790_CLK_SCU_SRC9 R8A7790_CLK_SCU_SRC8 R8A7790_CLK_SCU_SRC7 R8A7790_CLK_SCU_SRC6 R8A7790_CLK_SCU_SRC5
-				R8A7790_CLK_SCU_SRC4 R8A7790_CLK_SCU_SRC3 R8A7790_CLK_SCU_SRC2 R8A7790_CLK_SCU_SRC1 R8A7790_CLK_SCU_SRC0
-			>;
-			clock-output-names =
-				"ssi-all",
-				"ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
-				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0",
-				"scu-all",
-				"scu-dvc1", "scu-dvc0",
-				"scu-ctu1-mix1", "scu-ctu0-mix0",
-				"scu-src9", "scu-src8", "scu-src7", "scu-src6", "scu-src5",
-				"scu-src4", "scu-src3", "scu-src2", "scu-src1", "scu-src0";
-		};
 	};
 
 	prr: chipid at ff000044 {
@@ -1518,7 +1154,7 @@
 		compatible = "renesas,qspi-r8a7790", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
+		clocks = <&cpg CPG_MOD 917>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -1534,7 +1170,7 @@
 			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
+		clocks = <&cpg CPG_MOD 0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>,
 		       <&dmac1 0x51>, <&dmac1 0x52>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -1549,7 +1185,7 @@
 			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
+		clocks = <&cpg CPG_MOD 208>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>,
 		       <&dmac1 0x55>, <&dmac1 0x56>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -1564,7 +1200,7 @@
 			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
+		clocks = <&cpg CPG_MOD 205>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>,
 		       <&dmac1 0x41>, <&dmac1 0x42>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -1579,7 +1215,7 @@
 			     "renesas,rcar-gen2-msiof";
 		reg = <0 0xe6c90000 0 0x0064>;
 		interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
+		clocks = <&cpg CPG_MOD 215>;
 		dmas = <&dmac0 0x45>, <&dmac0 0x46>,
 		       <&dmac1 0x45>, <&dmac1 0x46>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -1593,7 +1229,7 @@
 		compatible = "renesas,xhci-r8a7790", "renesas,rcar-gen2-xhci";
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
+		clocks = <&cpg CPG_MOD 328>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
@@ -1606,7 +1242,7 @@
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 
@@ -1639,7 +1275,7 @@
 		reg = <0 0xee0b0000 0 0xc00>,
 		      <0 0xee0a0000 0 0x1100>;
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 
@@ -1657,7 +1293,7 @@
 	pci2: pci at ee0d0000 {
 		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
-		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
@@ -1707,7 +1343,7 @@
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7790_CLK_PCIEC>, <&pcie_bus_clk>;
+		clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -1728,21 +1364,22 @@
 			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
 		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
-		clocks = <&mstp10_clks R8A7790_CLK_SSI_ALL>,
-			<&mstp10_clks R8A7790_CLK_SSI9>, <&mstp10_clks R8A7790_CLK_SSI8>,
-			<&mstp10_clks R8A7790_CLK_SSI7>, <&mstp10_clks R8A7790_CLK_SSI6>,
-			<&mstp10_clks R8A7790_CLK_SSI5>, <&mstp10_clks R8A7790_CLK_SSI4>,
-			<&mstp10_clks R8A7790_CLK_SSI3>, <&mstp10_clks R8A7790_CLK_SSI2>,
-			<&mstp10_clks R8A7790_CLK_SSI1>, <&mstp10_clks R8A7790_CLK_SSI0>,
-			<&mstp10_clks R8A7790_CLK_SCU_SRC9>, <&mstp10_clks R8A7790_CLK_SCU_SRC8>,
-			<&mstp10_clks R8A7790_CLK_SCU_SRC7>, <&mstp10_clks R8A7790_CLK_SCU_SRC6>,
-			<&mstp10_clks R8A7790_CLK_SCU_SRC5>, <&mstp10_clks R8A7790_CLK_SCU_SRC4>,
-			<&mstp10_clks R8A7790_CLK_SCU_SRC3>, <&mstp10_clks R8A7790_CLK_SCU_SRC2>,
-			<&mstp10_clks R8A7790_CLK_SCU_SRC1>, <&mstp10_clks R8A7790_CLK_SCU_SRC0>,
-			<&mstp10_clks R8A7790_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7790_CLK_SCU_CTU1_MIX1>,
-			<&mstp10_clks R8A7790_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7790_CLK_SCU_CTU1_MIX1>,
-			<&mstp10_clks R8A7790_CLK_SCU_DVC0>, <&mstp10_clks R8A7790_CLK_SCU_DVC1>,
-			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
+		clocks = <&cpg CPG_MOD 1005>,
+			 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+			 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+			 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+			 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+			 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+			 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+			 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+			 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+			 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+			 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+			 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+			 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+			 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+			 <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
+			 <&cpg CPG_CORE R8A7790_CLK_M2>;
 		clock-names = "ssi-all",
 				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
 				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
-- 
2.1.4
