From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:55 +0200
Subject: [PATCH 03/48] ARM: dts: r8a7793: Convert to new CPG/MSSR bindings
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <d77fe953768850557a1851d2c933b76b2083e4d5.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert the R-Car M2-N SoC from the old "Renesas R-Car Gen2 Clock Pulse
Generator (CPG)", "Renesas CPG DIV6 Clock", and "Renesas CPG Module Stop
(MSTP) Clocks" DT bindings to the new unified "Renesas Clock Pulse
Generator / Module Standby and Software Reset" DT bindings.

This simplifies the DTS files, and allows to add support for reset
control later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts |   4 +-
 arch/arm/boot/dts/r8a7793.dtsi     | 459 +++++++------------------------------
 2 files changed, 82 insertions(+), 381 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 76e3aca2029e..51b3ffac8efa 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -303,9 +303,7 @@
 	pinctrl-names = "default";
 	status = "okay";
 
-	clocks = <&mstp7_clks R8A7793_CLK_DU0>,
-		 <&mstp7_clks R8A7793_CLK_DU1>,
-		 <&mstp7_clks R8A7793_CLK_LVDS0>,
+	clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>, <&cpg CPG_MOD 726>,
 		 <&x13_clk>, <&x2_clk>;
 	clock-names = "du.0", "du.1", "lvds.0",
 		      "dclkin.0", "dclkin.1";
diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 497716b6fbe2..ef8009c01e66 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-#include <dt-bindings/clock/r8a7793-clock.h>
+#include <dt-bindings/clock/r8a7793-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/r8a7793-sysc.h>
@@ -43,7 +43,7 @@
 			reg = <0>;
 			clock-frequency = <1500000000>;
 			voltage-tolerance = <1>; /* 1% */
-			clocks = <&cpg_clocks R8A7793_CLK_Z>;
+			clocks = <&cpg CPG_CORE R8A7793_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
 			power-domains = <&sysc R8A7793_PD_CA15_CPU0>;
 
@@ -108,7 +108,7 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-		clocks = <&mstp4_clks R8A7793_CLK_INTC_SYS>;
+		clocks = <&cpg CPG_MOD 408>;
 		clock-names = "clk";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
@@ -122,7 +122,7 @@
 		gpio-ranges = <&pfc 0 0 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7793_CLK_GPIO0>;
+		clocks = <&cpg CPG_MOD 912>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -135,7 +135,7 @@
 		gpio-ranges = <&pfc 0 32 26>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7793_CLK_GPIO1>;
+		clocks = <&cpg CPG_MOD 911>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -148,7 +148,7 @@
 		gpio-ranges = <&pfc 0 64 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7793_CLK_GPIO2>;
+		clocks = <&cpg CPG_MOD 910>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -161,7 +161,7 @@
 		gpio-ranges = <&pfc 0 96 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7793_CLK_GPIO3>;
+		clocks = <&cpg CPG_MOD 909>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -174,7 +174,7 @@
 		gpio-ranges = <&pfc 0 128 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7793_CLK_GPIO4>;
+		clocks = <&cpg CPG_MOD 908>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -187,7 +187,7 @@
 		gpio-ranges = <&pfc 0 160 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7793_CLK_GPIO5>;
+		clocks = <&cpg CPG_MOD 907>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -200,7 +200,7 @@
 		gpio-ranges = <&pfc 0 192 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7793_CLK_GPIO6>;
+		clocks = <&cpg CPG_MOD 905>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -213,7 +213,7 @@
 		gpio-ranges = <&pfc 0 224 26>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7793_CLK_GPIO7>;
+		clocks = <&cpg CPG_MOD 904>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -223,7 +223,7 @@
 				"renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp5_clks R8A7793_CLK_THERMAL>;
+		clocks = <&cpg CPG_MOD 522>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#thermal-sensor-cells = <0>;
 	};
@@ -241,7 +241,7 @@
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7793_CLK_CMT0>;
+		clocks = <&cpg CPG_MOD 124>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 
@@ -261,7 +261,7 @@
 			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7793_CLK_CMT1>;
+		clocks = <&cpg CPG_MOD 329>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 
@@ -285,7 +285,7 @@
 			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R8A7793_CLK_IRQC>;
+		clocks = <&cpg CPG_MOD 407>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
@@ -313,7 +313,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC0>;
+		clocks = <&cpg CPG_MOD 219>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -344,7 +344,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC1>;
+		clocks = <&cpg CPG_MOD 218>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -373,7 +373,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12";
-		clocks = <&mstp5_clks R8A7793_CLK_AUDIO_DMAC0>;
+		clocks = <&cpg CPG_MOD 502>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -402,7 +402,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12";
-		clocks = <&mstp5_clks R8A7793_CLK_AUDIO_DMAC1>;
+		clocks = <&cpg CPG_MOD 501>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
@@ -416,7 +416,7 @@
 		compatible = "renesas,i2c-r8a7793", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_I2C0>;
+		clocks = <&cpg CPG_MOD 931>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
@@ -428,7 +428,7 @@
 		compatible = "renesas,i2c-r8a7793", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_I2C1>;
+		clocks = <&cpg CPG_MOD 930>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
@@ -440,7 +440,7 @@
 		compatible = "renesas,i2c-r8a7793", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_I2C2>;
+		clocks = <&cpg CPG_MOD 929>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
@@ -452,7 +452,7 @@
 		compatible = "renesas,i2c-r8a7793", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_I2C3>;
+		clocks = <&cpg CPG_MOD 928>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
@@ -464,7 +464,7 @@
 		compatible = "renesas,i2c-r8a7793", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_I2C4>;
+		clocks = <&cpg CPG_MOD 927>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
@@ -477,7 +477,7 @@
 		compatible = "renesas,i2c-r8a7793", "renesas,rcar-gen2-i2c";
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_I2C5>;
+		clocks = <&cpg CPG_MOD 925>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
@@ -491,7 +491,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_IICDVFS>;
+		clocks = <&cpg CPG_MOD 926>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>,
 		       <&dmac1 0x77>, <&dmac1 0x78>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -506,7 +506,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7793_CLK_IIC0>;
+		clocks = <&cpg CPG_MOD 318>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -521,7 +521,7 @@
 			     "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7793_CLK_IIC1>;
+		clocks = <&cpg CPG_MOD 323>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -538,7 +538,7 @@
 		compatible = "renesas,sdhi-r8a7793";
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
+		clocks = <&cpg CPG_MOD 314>;
 		dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
 		       <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -551,7 +551,7 @@
 		compatible = "renesas,sdhi-r8a7793";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7793_CLK_SDHI1>;
+		clocks = <&cpg CPG_MOD 312>;
 		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
 		       <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -564,7 +564,7 @@
 		compatible = "renesas,sdhi-r8a7793";
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7793_CLK_SDHI2>;
+		clocks = <&cpg CPG_MOD 311>;
 		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
 		       <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -577,7 +577,7 @@
 		compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
+		clocks = <&cpg CPG_MOD 315>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -592,7 +592,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7793_CLK_SCIFA0>;
+		clocks = <&cpg CPG_MOD 204>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
 		       <&dmac1 0x21>, <&dmac1 0x22>;
@@ -606,7 +606,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7793_CLK_SCIFA1>;
+		clocks = <&cpg CPG_MOD 203>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
 		       <&dmac1 0x25>, <&dmac1 0x26>;
@@ -620,7 +620,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7793_CLK_SCIFA2>;
+		clocks = <&cpg CPG_MOD 202>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
 		       <&dmac1 0x27>, <&dmac1 0x28>;
@@ -634,7 +634,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7793_CLK_SCIFA3>;
+		clocks = <&cpg CPG_MOD 1106>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
 		       <&dmac1 0x1b>, <&dmac1 0x1c>;
@@ -648,7 +648,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7793_CLK_SCIFA4>;
+		clocks = <&cpg CPG_MOD 1107>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
 		       <&dmac1 0x1f>, <&dmac1 0x20>;
@@ -662,7 +662,7 @@
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7793_CLK_SCIFA5>;
+		clocks = <&cpg CPG_MOD 1108>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>,
 		       <&dmac1 0x23>, <&dmac1 0x24>;
@@ -676,7 +676,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7793_CLK_SCIFB0>;
+		clocks = <&cpg CPG_MOD 206>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
@@ -690,7 +690,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7793_CLK_SCIFB1>;
+		clocks = <&cpg CPG_MOD 207>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
@@ -704,7 +704,7 @@
 			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7793_CLK_SCIFB2>;
+		clocks = <&cpg CPG_MOD 216>;
 		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
@@ -718,7 +718,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF0>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 721>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
@@ -733,7 +733,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF1>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 720>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
@@ -748,7 +748,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 719>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
@@ -763,7 +763,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 718>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
@@ -778,7 +778,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 715>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
@@ -793,7 +793,7 @@
 			     "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 714>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
@@ -808,7 +808,7 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_HSCIF0>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 717>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
@@ -823,7 +823,7 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_HSCIF1>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 716>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
@@ -838,7 +838,7 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_HSCIF2>, <&zs_clk>,
+		clocks = <&cpg CPG_MOD 713>, <&cpg CPG_CORE R8A7793_CLK_ZS>,
 			 <&scif_clk>;
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
@@ -870,7 +870,7 @@
 		compatible = "renesas,ether-r8a7793";
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7793_CLK_ETHER>;
+		clocks = <&cpg CPG_MOD 813>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
@@ -882,7 +882,7 @@
 		compatible = "renesas,vin-r8a7793", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7793_CLK_VIN0>;
+		clocks = <&cpg CPG_MOD 811>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -891,7 +891,7 @@
 		compatible = "renesas,vin-r8a7793", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7793_CLK_VIN1>;
+		clocks = <&cpg CPG_MOD 810>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -900,7 +900,7 @@
 		compatible = "renesas,vin-r8a7793", "renesas,rcar-gen2-vin";
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7793_CLK_VIN2>;
+		clocks = <&cpg CPG_MOD 809>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
@@ -909,7 +909,7 @@
 		compatible = "renesas,qspi-r8a7793", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_QSPI_MOD>;
+		clocks = <&cpg CPG_MOD 917>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
@@ -927,9 +927,9 @@
 		reg-names = "du", "lvds.0";
 		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_DU0>,
-			 <&mstp7_clks R8A7793_CLK_DU1>,
-			 <&mstp7_clks R8A7793_CLK_LVDS0>;
+		clocks = <&cpg CPG_MOD 724>,
+			 <&cpg CPG_MOD 723>,
+			 <&cpg CPG_MOD 726>;
 		clock-names = "du.0", "du.1", "lvds.0";
 		status = "disabled";
 
@@ -954,8 +954,8 @@
 		compatible = "renesas,can-r8a7793", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e80000 0 0x1000>;
 		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_RCAN0>,
-			 <&cpg_clocks R8A7793_CLK_RCAN>, <&can_clk>;
+		clocks = <&cpg CPG_MOD 916>, <&cpg CPG_CORE R8A7793_CLK_RCAN>,
+			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -965,8 +965,8 @@
 		compatible = "renesas,can-r8a7793", "renesas,rcar-gen2-can";
 		reg = <0 0xe6e88000 0 0x1000>;
 		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7793_CLK_RCAN1>,
-			 <&cpg_clocks R8A7793_CLK_RCAN>, <&can_clk>;
+		clocks = <&cpg CPG_MOD 915>, <&cpg CPG_CORE R8A7793_CLK_RCAN>,
+			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
@@ -1029,312 +1029,14 @@
 		};
 
 		/* Special CPG clocks */
-		cpg_clocks: cpg_clocks at e6150000 {
-			compatible = "renesas,r8a7793-cpg-clocks",
-				     "renesas,rcar-gen2-cpg-clocks";
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7793-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk &usb_extal_clk>;
-			#clock-cells = <1>;
-			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi", "sdh", "sd0", "z",
-					     "rcan", "adsp";
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
 			#power-domain-cells = <0>;
 		};
-
-		/* Variable factor clocks */
-		sd2_clk: sd2 at e6150078 {
-			compatible = "renesas,r8a7793-div6-clock",
-				     "renesas,cpg-div6-clock";
-			reg = <0 0xe6150078 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		sd3_clk: sd3 at e615026c {
-			compatible = "renesas,r8a7793-div6-clock",
-				     "renesas,cpg-div6-clock";
-			reg = <0 0xe615026c 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-		mmc0_clk: mmc0 at e6150240 {
-			compatible = "renesas,r8a7793-div6-clock",
-				     "renesas,cpg-div6-clock";
-			reg = <0 0xe6150240 0 4>;
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-		};
-
-		/* Fixed factor clocks */
-		pll1_div2_clk: pll1_div2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-		zg_clk: zg {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <5>;
-			clock-mult = <1>;
-		};
-		zx_clk: zx {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <3>;
-			clock-mult = <1>;
-		};
-		zs_clk: zs {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <6>;
-			clock-mult = <1>;
-		};
-		hp_clk: hp {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <12>;
-			clock-mult = <1>;
-		};
-		p_clk: p {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <24>;
-			clock-mult = <1>;
-		};
-		m2_clk: m2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-		};
-		rclk_clk: rclk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <(48 * 1024)>;
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
-		mstp1_clks: mstp1_clks at e6150134 {
-			compatible = "renesas,r8a7793-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&zs_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
-				 <&zg_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>,
-				 <&p_clk>, <&p_clk>, <&rclk_clk>, <&cp_clk>,
-				 <&zs_clk>, <&zs_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_VCP0 R8A7793_CLK_VPC0
-				R8A7793_CLK_SSP1 R8A7793_CLK_TMU1
-				R8A7793_CLK_3DG R8A7793_CLK_2DDMAC
-				R8A7793_CLK_FDP1_1 R8A7793_CLK_FDP1_0
-				R8A7793_CLK_TMU3 R8A7793_CLK_TMU2
-				R8A7793_CLK_CMT0 R8A7793_CLK_TMU0
-				R8A7793_CLK_VSP1_DU1 R8A7793_CLK_VSP1_DU0
-				R8A7793_CLK_VSP1_S
-			>;
-			clock-output-names =
-				"vcp0", "vpc0", "ssp_dev", "tmu1",
-				"pvrsrvkm", "tddmac", "fdp1", "fdp0",
-				"tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
-				"vsp1-du0", "vsps";
-		};
-		mstp2_clks: mstp2_clks at e6150138 {
-			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
-			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>, <&mp_clk>, <&zs_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_SCIFA2 R8A7793_CLK_SCIFA1 R8A7793_CLK_SCIFA0
-				R8A7793_CLK_SCIFB0 R8A7793_CLK_SCIFB1 R8A7793_CLK_SCIFB2
-				R8A7793_CLK_SYS_DMAC1 R8A7793_CLK_SYS_DMAC0
-			>;
-			clock-output-names =
-				"scifa2", "scifa1", "scifa0", "scifb0",
-				"scifb1", "scifb2", "sys-dmac1", "sys-dmac0";
-		};
-		mstp3_clks: mstp3_clks at e615013c {
-			compatible = "renesas,r8a7793-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&cp_clk>, <&sd3_clk>, <&sd2_clk>,
-				 <&cpg_clocks R8A7793_CLK_SD0>, <&mmc0_clk>,
-				 <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>,
-				 <&rclk_clk>, <&hp_clk>, <&hp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_TPU0 R8A7793_CLK_SDHI2
-				R8A7793_CLK_SDHI1 R8A7793_CLK_SDHI0
-				R8A7793_CLK_MMCIF0 R8A7793_CLK_IIC0
-				R8A7793_CLK_PCIEC R8A7793_CLK_IIC1
-				R8A7793_CLK_SSUSB R8A7793_CLK_CMT1
-				R8A7793_CLK_USBDMAC0 R8A7793_CLK_USBDMAC1
-			>;
-			clock-output-names =
-				"tpu0", "sdhi2", "sdhi1", "sdhi0", "mmcif0",
-				"i2c7", "pciec", "i2c8", "ssusb", "cmt1",
-				"usbdmac0", "usbdmac1";
-		};
-		mstp4_clks: mstp4_clks at e6150140 {
-			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&cp_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_IRQC R8A7793_CLK_INTC_SYS
-			>;
-			clock-output-names = "irqc", "intc-sys";
-		};
-		mstp5_clks: mstp5_clks at e6150144 {
-			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7793_CLK_AUDIO_DMAC0 R8A7793_CLK_AUDIO_DMAC1
-					 R8A7793_CLK_THERMAL>;
-			clock-output-names = "audmac0", "audmac1", "thermal";
-		};
-		mstp7_clks: mstp7_clks at e615014c {
-			compatible = "renesas,r8a7793-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-			clocks = <&mp_clk>,  <&hp_clk>, <&zs_clk>, <&p_clk>,
-				 <&p_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
-				 <&p_clk>, <&p_clk>, <&p_clk>, <&zx_clk>,
-				 <&zx_clk>, <&zx_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_EHCI R8A7793_CLK_HSUSB
-				R8A7793_CLK_HSCIF2 R8A7793_CLK_SCIF5
-				R8A7793_CLK_SCIF4 R8A7793_CLK_HSCIF1
-				R8A7793_CLK_HSCIF0 R8A7793_CLK_SCIF3
-				R8A7793_CLK_SCIF2 R8A7793_CLK_SCIF1
-				R8A7793_CLK_SCIF0 R8A7793_CLK_DU1
-				R8A7793_CLK_DU0 R8A7793_CLK_LVDS0
-			>;
-			clock-output-names =
-				"ehci", "hsusb", "hscif2", "scif5", "scif4",
-				"hscif1", "hscif0", "scif3", "scif2",
-				"scif1", "scif0", "du1", "du0", "lvds0";
-		};
-		mstp8_clks: mstp8_clks at e6150990 {
-			compatible = "renesas,r8a7793-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&zx_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
-				 <&p_clk>, <&zs_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_IPMMU_SGX R8A7793_CLK_VIN2
-				R8A7793_CLK_VIN1 R8A7793_CLK_VIN0
-				R8A7793_CLK_ETHER R8A7793_CLK_SATA1
-				R8A7793_CLK_SATA0
-			>;
-			clock-output-names =
-				"ipmmu_sgx", "vin2", "vin1", "vin0", "ether",
-				"sata1", "sata0";
-		};
-		mstp9_clks: mstp9_clks at e6150994 {
-			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&p_clk>, <&p_clk>,
-				 <&cpg_clocks R8A7793_CLK_QSPI>, <&hp_clk>,
-				 <&cp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
-				 <&hp_clk>, <&hp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_GPIO7 R8A7793_CLK_GPIO6
-				R8A7793_CLK_GPIO5 R8A7793_CLK_GPIO4
-				R8A7793_CLK_GPIO3 R8A7793_CLK_GPIO2
-				R8A7793_CLK_GPIO1 R8A7793_CLK_GPIO0
-				R8A7793_CLK_QSPI_MOD R8A7793_CLK_RCAN1
-				R8A7793_CLK_RCAN0 R8A7793_CLK_I2C5
-				R8A7793_CLK_IICDVFS R8A7793_CLK_I2C4
-				R8A7793_CLK_I2C3 R8A7793_CLK_I2C2
-				R8A7793_CLK_I2C1 R8A7793_CLK_I2C0
-			>;
-			clock-output-names =
-				"gpio7", "gpio6", "gpio5", "gpio4",
-				"gpio3", "gpio2", "gpio1", "gpio0",
-				"rcan1", "rcan0", "qspi_mod", "i2c5",
-				"i2c6", "i2c4", "i2c3", "i2c2", "i2c1",
-				"i2c0";
-		};
-		mstp10_clks: mstp10_clks at e6150998 {
-			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
-			clocks = <&p_clk>,
-				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7793_CLK_SSI_ALL>, <&mstp10_clks R8A7793_CLK_SSI_ALL>,
-				<&p_clk>,
-				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>,
-				<&mstp10_clks R8A7793_CLK_SCU_ALL>, <&mstp10_clks R8A7793_CLK_SCU_ALL>;
-
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_SSI_ALL
-				R8A7793_CLK_SSI9 R8A7793_CLK_SSI8 R8A7793_CLK_SSI7 R8A7793_CLK_SSI6 R8A7793_CLK_SSI5
-				R8A7793_CLK_SSI4 R8A7793_CLK_SSI3 R8A7793_CLK_SSI2 R8A7793_CLK_SSI1 R8A7793_CLK_SSI0
-				R8A7793_CLK_SCU_ALL
-				R8A7793_CLK_SCU_DVC1 R8A7793_CLK_SCU_DVC0
-				R8A7793_CLK_SCU_CTU1_MIX1 R8A7793_CLK_SCU_CTU0_MIX0
-				R8A7793_CLK_SCU_SRC9 R8A7793_CLK_SCU_SRC8 R8A7793_CLK_SCU_SRC7 R8A7793_CLK_SCU_SRC6 R8A7793_CLK_SCU_SRC5
-				R8A7793_CLK_SCU_SRC4 R8A7793_CLK_SCU_SRC3 R8A7793_CLK_SCU_SRC2 R8A7793_CLK_SCU_SRC1 R8A7793_CLK_SCU_SRC0
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
-		mstp11_clks: mstp11_clks at e615099c {
-			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
-			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7793_CLK_SCIFA3 R8A7793_CLK_SCIFA4 R8A7793_CLK_SCIFA5
-			>;
-			clock-output-names = "scifa3", "scifa4", "scifa5";
-		};
 	};
 
 	rst: reset-controller at e6160000 {
@@ -1428,19 +1130,20 @@
 			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
 		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
-		clocks = <&mstp10_clks R8A7793_CLK_SSI_ALL>,
-			<&mstp10_clks R8A7793_CLK_SSI9>, <&mstp10_clks R8A7793_CLK_SSI8>,
-			<&mstp10_clks R8A7793_CLK_SSI7>, <&mstp10_clks R8A7793_CLK_SSI6>,
-			<&mstp10_clks R8A7793_CLK_SSI5>, <&mstp10_clks R8A7793_CLK_SSI4>,
-			<&mstp10_clks R8A7793_CLK_SSI3>, <&mstp10_clks R8A7793_CLK_SSI2>,
-			<&mstp10_clks R8A7793_CLK_SSI1>, <&mstp10_clks R8A7793_CLK_SSI0>,
-			<&mstp10_clks R8A7793_CLK_SCU_SRC9>, <&mstp10_clks R8A7793_CLK_SCU_SRC8>,
-			<&mstp10_clks R8A7793_CLK_SCU_SRC7>, <&mstp10_clks R8A7793_CLK_SCU_SRC6>,
-			<&mstp10_clks R8A7793_CLK_SCU_SRC5>, <&mstp10_clks R8A7793_CLK_SCU_SRC4>,
-			<&mstp10_clks R8A7793_CLK_SCU_SRC3>, <&mstp10_clks R8A7793_CLK_SCU_SRC2>,
-			<&mstp10_clks R8A7793_CLK_SCU_SRC1>, <&mstp10_clks R8A7793_CLK_SCU_SRC0>,
-			<&mstp10_clks R8A7793_CLK_SCU_DVC0>, <&mstp10_clks R8A7793_CLK_SCU_DVC1>,
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
+			 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+			 <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
+			 <&cpg CPG_CORE R8A7793_CLK_M2>;
 		clock-names = "ssi-all",
 				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
 				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
-- 
2.1.4
