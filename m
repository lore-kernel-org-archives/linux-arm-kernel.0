From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:54 +0200
Subject: [PATCH 02/48] ARM: dts: r8a7792: Convert to new CPG/MSSR bindings
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <762dbc444ca240580f7eda5b9152d147cca608b3.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert the R-Car V2H SoC from the old "Renesas R-Car Gen2 Clock Pulse
Generator (CPG)" and "Renesas CPG Module Stop (MSTP) Clocks" DT bindings
to the new unified "Renesas Clock Pulse Generator / Module Standby and
Software Reset" DT bindings.

This simplifies the DTS files, and allows to add support for reset
control later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792-blanche.dts |   3 +-
 arch/arm/boot/dts/r8a7792-wheat.dts   |   3 +-
 arch/arm/boot/dts/r8a7792.dtsi        | 333 +++++++---------------------------
 3 files changed, 63 insertions(+), 276 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index f3ea43b7b724..9b67dca6c9ef 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -310,8 +310,7 @@
 	pinctrl-0 = <&du0_pins &du1_pins>;
 	pinctrl-names = "default";
 
-	clocks = <&mstp7_clks R8A7792_CLK_DU0>, <&mstp7_clks R8A7792_CLK_DU1>,
-		 <&x1_clk>, <&x2_clk>;
+	clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>, <&x1_clk>, <&x2_clk>;
 	clock-names = "du.0", "du.1", "dclkin.0", "dclkin.1";
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/r8a7792-wheat.dts b/arch/arm/boot/dts/r8a7792-wheat.dts
index c24f26fdab1f..b9471b67b728 100644
--- a/arch/arm/boot/dts/r8a7792-wheat.dts
+++ b/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -305,8 +305,7 @@
 	pinctrl-0 = <&du0_pins &du1_pins>;
 	pinctrl-names = "default";
 
-	clocks = <&mstp7_clks R8A7792_CLK_DU0>, <&mstp7_clks R8A7792_CLK_DU1>,
-		 <&osc2_clk>;
+	clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>, <&osc2_clk>;
 	clock-names = "du.0", "du.1", "dclkin.0";
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 2623f39bed2b..a209787d899a 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-#include <dt-bindings/clock/r8a7792-clock.h>
+#include <dt-bindings/clock/r8a7792-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/r8a7792-sysc.h>
@@ -46,7 +46,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 			clock-frequency = <1000000000>;
-			clocks = <&z_clk>;
+			clocks = <&cpg CPG_CORE R8A7792_CLK_Z>;
 			power-domains = <&sysc R8A7792_PD_CA15_CPU0>;
 			next-level-cache = <&L2_CA15>;
 		};
@@ -92,7 +92,7 @@
 			      <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
 				      IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&mstp4_clks R8A7792_CLK_INTC_SYS>;
+			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
@@ -106,7 +106,7 @@
 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp4_clks R8A7792_CLK_IRQC>;
+			clocks = <&cpg CPG_MOD 407>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -153,7 +153,7 @@
 			gpio-ranges = <&pfc 0 0 29>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO0>;
+			clocks = <&cpg CPG_MOD 912>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -167,7 +167,7 @@
 			gpio-ranges = <&pfc 0 32 23>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO1>;
+			clocks = <&cpg CPG_MOD 911>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -181,7 +181,7 @@
 			gpio-ranges = <&pfc 0 64 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO2>;
+			clocks = <&cpg CPG_MOD 910>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -195,7 +195,7 @@
 			gpio-ranges = <&pfc 0 96 28>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO3>;
+			clocks = <&cpg CPG_MOD 909>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -209,7 +209,7 @@
 			gpio-ranges = <&pfc 0 128 17>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO4>;
+			clocks = <&cpg CPG_MOD 908>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -223,7 +223,7 @@
 			gpio-ranges = <&pfc 0 160 17>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO5>;
+			clocks = <&cpg CPG_MOD 907>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -237,7 +237,7 @@
 			gpio-ranges = <&pfc 0 192 17>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO6>;
+			clocks = <&cpg CPG_MOD 905>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -251,7 +251,7 @@
 			gpio-ranges = <&pfc 0 224 17>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO7>;
+			clocks = <&cpg CPG_MOD 904>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -265,7 +265,7 @@
 			gpio-ranges = <&pfc 0 256 17>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO8>;
+			clocks = <&cpg CPG_MOD 921>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -279,7 +279,7 @@
 			gpio-ranges = <&pfc 0 288 17>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO9>;
+			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -293,7 +293,7 @@
 			gpio-ranges = <&pfc 0 320 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO10>;
+			clocks = <&cpg CPG_MOD 914>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -307,7 +307,7 @@
 			gpio-ranges = <&pfc 0 352 30>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7792_CLK_GPIO11>;
+			clocks = <&cpg CPG_MOD 913>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -336,7 +336,7 @@
 					  "ch4", "ch5", "ch6", "ch7",
 					  "ch8", "ch9", "ch10", "ch11",
 					  "ch12", "ch13", "ch14";
-			clocks = <&mstp2_clks R8A7792_CLK_SYS_DMAC0>;
+			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
@@ -368,7 +368,7 @@
 					  "ch4", "ch5", "ch6", "ch7",
 					  "ch8", "ch9", "ch10", "ch11",
 					  "ch12", "ch13", "ch14";
-			clocks = <&mstp2_clks R8A7792_CLK_SYS_DMAC1>;
+			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
@@ -380,8 +380,8 @@
 				     "renesas,rcar-gen2-scif", "renesas,scif";
 			reg = <0 0xe6e60000 0 64>;
 			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R8A7792_CLK_SCIF0>, <&zs_clk>,
-				 <&scif_clk>;
+			clocks = <&cpg CPG_MOD 721>,
+				 <&cpg CPG_CORE R8A7792_CLK_ZS>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
 			       <&dmac1 0x29>, <&dmac1 0x2a>;
@@ -395,8 +395,8 @@
 				     "renesas,rcar-gen2-scif", "renesas,scif";
 			reg = <0 0xe6e68000 0 64>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R8A7792_CLK_SCIF1>, <&zs_clk>,
-				 <&scif_clk>;
+			clocks = <&cpg CPG_MOD 720>,
+				 <&cpg CPG_CORE R8A7792_CLK_ZS>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
 			       <&dmac1 0x2d>, <&dmac1 0x2e>;
@@ -410,8 +410,8 @@
 				     "renesas,rcar-gen2-scif", "renesas,scif";
 			reg = <0 0xe6e58000 0 64>;
 			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R8A7792_CLK_SCIF2>, <&zs_clk>,
-				 <&scif_clk>;
+			clocks = <&cpg CPG_MOD 719>,
+				 <&cpg CPG_CORE R8A7792_CLK_ZS>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
 			       <&dmac1 0x2b>, <&dmac1 0x2c>;
@@ -425,8 +425,8 @@
 				     "renesas,rcar-gen2-scif", "renesas,scif";
 			reg = <0 0xe6ea8000 0 64>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R8A7792_CLK_SCIF3>, <&zs_clk>,
-				 <&scif_clk>;
+			clocks = <&cpg CPG_MOD 718>,
+				 <&cpg CPG_CORE R8A7792_CLK_ZS>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
 			       <&dmac1 0x2f>, <&dmac1 0x30>;
@@ -440,8 +440,8 @@
 				     "renesas,rcar-gen2-hscif", "renesas,hscif";
 			reg = <0 0xe62c0000 0 96>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R8A7792_CLK_HSCIF0>, <&zs_clk>,
-				 <&scif_clk>;
+			clocks = <&cpg CPG_MOD 717>,
+				 <&cpg CPG_CORE R8A7792_CLK_ZS>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
 			       <&dmac1 0x39>, <&dmac1 0x3a>;
@@ -455,8 +455,8 @@
 				     "renesas,rcar-gen2-hscif", "renesas,hscif";
 			reg = <0 0xe62c8000 0 96>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R8A7792_CLK_HSCIF1>, <&zs_clk>,
-				 <&scif_clk>;
+			clocks = <&cpg CPG_MOD 716>,
+				 <&cpg CPG_CORE R8A7792_CLK_ZS>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
 			       <&dmac1 0x4d>, <&dmac1 0x4e>;
@@ -490,7 +490,7 @@
 			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
 			       <&dmac1 0xcd>, <&dmac1 0xce>;
 			dma-names = "tx", "rx", "tx", "rx";
-			clocks = <&mstp3_clks R8A7792_CLK_SDHI0>;
+			clocks = <&cpg CPG_MOD 314>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
@@ -500,7 +500,7 @@
 				     "renesas,rcar-gen2-jpu";
 			reg = <0 0xfe980000 0 0x10300>;
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp1_clks R8A7792_CLK_JPU>;
+			clocks = <&cpg CPG_MOD 106>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -509,7 +509,7 @@
 				     "renesas,etheravb-rcar-gen2";
 			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp8_clks R8A7792_CLK_ETHERAVB>;
+			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -522,7 +522,7 @@
 				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6508000 0 0x40>;
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_I2C0>;
+			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
@@ -535,7 +535,7 @@
 				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6518000 0 0x40>;
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_I2C1>;
+			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
@@ -548,7 +548,7 @@
 				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6530000 0 0x40>;
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_I2C2>;
+			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
@@ -561,7 +561,7 @@
 				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6540000 0 0x40>;
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_I2C3>;
+			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
@@ -574,7 +574,7 @@
 				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6520000 0 0x40>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_I2C4>;
+			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
@@ -587,7 +587,7 @@
 				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6528000 0 0x40>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_I2C5>;
+			clocks = <&cpg CPG_MOD 925>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			#address-cells = <1>;
@@ -599,7 +599,7 @@
 			compatible = "renesas,qspi-r8a7792", "renesas,qspi";
 			reg = <0 0xe6b10000 0 0x2c>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_QSPI_MOD>;
+			clocks = <&cpg CPG_MOD 917>;
 			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
 			       <&dmac1 0x17>, <&dmac1 0x18>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -615,7 +615,7 @@
 				     "renesas,rcar-gen2-msiof";
 			reg = <0 0xe6e20000 0 0x0064>;
 			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp0_clks R8A7792_CLK_MSIOF0>;
+			clocks = <&cpg CPG_MOD 000>;
 			dmas = <&dmac0 0x51>, <&dmac0 0x52>,
 			       <&dmac1 0x51>, <&dmac1 0x52>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -630,7 +630,7 @@
 				     "renesas,rcar-gen2-msiof";
 			reg = <0 0xe6e10000 0 0x0064>;
 			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp2_clks R8A7792_CLK_MSIOF1>;
+			clocks = <&cpg CPG_MOD 208>;
 			dmas = <&dmac0 0x55>, <&dmac0 0x56>,
 			       <&dmac1 0x55>, <&dmac1 0x56>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -646,8 +646,8 @@
 			reg-names = "du";
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R8A7792_CLK_DU0>,
-				 <&mstp7_clks R8A7792_CLK_DU1>;
+			clocks = <&cpg CPG_MOD 724>,
+				 <&cpg CPG_MOD 723>;
 			clock-names = "du.0", "du.1";
 			status = "disabled";
 
@@ -673,8 +673,8 @@
 				     "renesas,rcar-gen2-can";
 			reg = <0 0xe6e80000 0 0x1000>;
 			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_CAN0>,
-				 <&rcan_clk>, <&can_clk>;
+			clocks = <&cpg CPG_MOD 916>,
+				 <&cpg CPG_CORE R8A7792_CLK_RCAN>, <&can_clk>;
 			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
@@ -685,8 +685,8 @@
 				     "renesas,rcar-gen2-can";
 			reg = <0 0xe6e88000 0 0x1000>;
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7792_CLK_CAN1>,
-				 <&rcan_clk>, <&can_clk>;
+			clocks = <&cpg CPG_MOD 915>,
+				 <&cpg CPG_CORE R8A7792_CLK_RCAN>, <&can_clk>;
 			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
@@ -697,7 +697,7 @@
 				     "renesas,rcar-gen2-vin";
 			reg = <0 0xe6ef0000 0 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp8_clks R8A7792_CLK_VIN0>;
+			clocks = <&cpg CPG_MOD 811>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
@@ -707,7 +707,7 @@
 				     "renesas,rcar-gen2-vin";
 			reg = <0 0xe6ef1000 0 0x1000>;
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp8_clks R8A7792_CLK_VIN1>;
+			clocks = <&cpg CPG_MOD 810>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
@@ -717,7 +717,7 @@
 				     "renesas,rcar-gen2-vin";
 			reg = <0 0xe6ef2000 0 0x1000>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp8_clks R8A7792_CLK_VIN2>;
+			clocks = <&cpg CPG_MOD 809>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
@@ -727,7 +727,7 @@
 				     "renesas,rcar-gen2-vin";
 			reg = <0 0xe6ef3000 0 0x1000>;
 			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp8_clks R8A7792_CLK_VIN3>;
+			clocks = <&cpg CPG_MOD 808>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
@@ -737,7 +737,7 @@
 				     "renesas,rcar-gen2-vin";
 			reg = <0 0xe6ef4000 0 0x1000>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp8_clks R8A7792_CLK_VIN4>;
+			clocks = <&cpg CPG_MOD 805>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
@@ -747,7 +747,7 @@
 				     "renesas,rcar-gen2-vin";
 			reg = <0 0xe6ef5000 0 0x1000>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp8_clks R8A7792_CLK_VIN5>;
+			clocks = <&cpg CPG_MOD 804>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
@@ -756,7 +756,7 @@
 			compatible = "renesas,vsp1";
 			reg = <0 0xfe928000 0 0x8000>;
 			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp1_clks R8A7792_CLK_VSP1_SY>;
+			clocks = <&cpg CPG_MOD 131>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -764,7 +764,7 @@
 			compatible = "renesas,vsp1";
 			reg = <0 0xfe930000 0 0x8000>;
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp1_clks R8A7792_CLK_VSP1DU0>;
+			clocks = <&cpg CPG_MOD 128>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
@@ -772,229 +772,18 @@
 			compatible = "renesas,vsp1";
 			reg = <0 0xfe938000 0 0x8000>;
 			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp1_clks R8A7792_CLK_VSP1DU1>;
+			clocks = <&cpg CPG_MOD 127>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
 		};
 
-		/* Special CPG clocks */
-		cpg_clocks: cpg_clocks at e6150000 {
-			compatible = "renesas,r8a7792-cpg-clocks",
-				     "renesas,rcar-gen2-cpg-clocks";
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7792-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
 			clocks = <&extal_clk>;
-			#clock-cells = <1>;
-			clock-output-names = "main", "pll0", "pll1", "pll3",
-					     "lb", "qspi";
+			clock-names = "extal";
+			#clock-cells = <2>;
 			#power-domain-cells = <0>;
 		};
-
-		/* Fixed factor clocks */
-		pll1_div2_clk: pll1_div2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-		};
-		z_clk: z {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL0>;
-			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <1>;
-		};
-		zx_clk: zx {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <3>;
-			clock-mult = <1>;
-		};
-		zs_clk: zs {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <6>;
-			clock-mult = <1>;
-		};
-		hp_clk: hp {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <12>;
-			clock-mult = <1>;
-		};
-		p_clk: p {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <24>;
-			clock-mult = <1>;
-		};
-		cp_clk: cp {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <48>;
-			clock-mult = <1>;
-		};
-		mp_clk: mp {
-			compatible = "fixed-factor-clock";
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-			clock-div = <15>;
-			clock-mult = <1>;
-		};
-		m2_clk: m2 {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-		};
-		sd_clk: sd {
-			compatible = "fixed-factor-clock";
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-		};
-		rcan_clk: rcan {
-			compatible = "fixed-factor-clock";
-			clocks = <&pll1_div2_clk>;
-			#clock-cells = <0>;
-			clock-div = <49>;
-			clock-mult = <1>;
-		};
-		zg_clk: zg {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
-			#clock-cells = <0>;
-			clock-div = <5>;
-			clock-mult = <1>;
-		};
-
-		/* Gate clocks */
-		mstp0_clks: mstp0_clks at e6150130 {
-			compatible = "renesas,r8a7792-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
-			clocks = <&mp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <R8A7792_CLK_MSIOF0>;
-			clock-output-names = "msiof0";
-		};
-		mstp1_clks: mstp1_clks at e6150134 {
-			compatible = "renesas,r8a7792-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-			clocks = <&m2_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7792_CLK_JPU
-				R8A7792_CLK_VSP1DU1 R8A7792_CLK_VSP1DU0
-				R8A7792_CLK_VSP1_SY
-			>;
-			clock-output-names = "jpu", "vsp1du1", "vsp1du0",
-					     "vsp1-sy";
-		};
-		mstp2_clks: mstp2_clks at e6150138 {
-			compatible = "renesas,r8a7792-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
-			clocks = <&mp_clk>, <&zs_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7792_CLK_MSIOF1
-				R8A7792_CLK_SYS_DMAC1 R8A7792_CLK_SYS_DMAC0
-			>;
-			clock-output-names = "msiof1", "sys-dmac1", "sys-dmac0";
-		};
-		mstp3_clks: mstp3_clks at e615013c {
-			compatible = "renesas,r8a7792-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&sd_clk>;
-			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7792_CLK_SDHI0>;
-			clock-output-names = "sdhi0";
-		};
-		mstp4_clks: mstp4_clks at e6150140 {
-			compatible = "renesas,r8a7792-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&cp_clk>, <&zs_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7792_CLK_IRQC R8A7792_CLK_INTC_SYS
-			>;
-			clock-output-names = "irqc", "intc-sys";
-		};
-		mstp7_clks: mstp7_clks at e615014c {
-			compatible = "renesas,r8a7792-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-			clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>,
-				 <&p_clk>, <&p_clk>, <&zx_clk>, <&zx_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7792_CLK_HSCIF1 R8A7792_CLK_HSCIF0
-				R8A7792_CLK_SCIF3 R8A7792_CLK_SCIF2
-				R8A7792_CLK_SCIF1 R8A7792_CLK_SCIF0
-				R8A7792_CLK_DU1 R8A7792_CLK_DU0
-			>;
-			clock-output-names = "hscif1", "hscif0", "scif3",
-					     "scif2", "scif1", "scif0",
-					     "du1", "du0";
-		};
-		mstp8_clks: mstp8_clks at e6150990 {
-			compatible = "renesas,r8a7792-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
-			         <&zg_clk>, <&zg_clk>, <&hp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7792_CLK_VIN5 R8A7792_CLK_VIN4
-				R8A7792_CLK_VIN3 R8A7792_CLK_VIN2
-				R8A7792_CLK_VIN1 R8A7792_CLK_VIN0
-				R8A7792_CLK_ETHERAVB
-			>;
-			clock-output-names = "vin5", "vin4", "vin3", "vin2",
-					     "vin1", "vin0", "etheravb";
-		};
-		mstp9_clks: mstp9_clks at e6150994 {
-			compatible = "renesas,r8a7792-mstp-clocks",
-				     "renesas,cpg-mstp-clocks";
-			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-				 <&cp_clk>, <&cp_clk>, <&p_clk>, <&p_clk>,
-				 <&cpg_clocks R8A7792_CLK_QSPI>,
-				 <&cp_clk>, <&cp_clk>, <&hp_clk>, <&hp_clk>,
-				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
-			#clock-cells = <1>;
-			clock-indices = <
-				R8A7792_CLK_GPIO7 R8A7792_CLK_GPIO6
-				R8A7792_CLK_GPIO5 R8A7792_CLK_GPIO4
-				R8A7792_CLK_GPIO3 R8A7792_CLK_GPIO2
-				R8A7792_CLK_GPIO1 R8A7792_CLK_GPIO0
-				R8A7792_CLK_GPIO11 R8A7792_CLK_GPIO10
-				R8A7792_CLK_CAN1 R8A7792_CLK_CAN0
-				R8A7792_CLK_QSPI_MOD
-				R8A7792_CLK_GPIO9 R8A7792_CLK_GPIO8
-				R8A7792_CLK_I2C5 R8A7792_CLK_I2C4
-				R8A7792_CLK_I2C3 R8A7792_CLK_I2C2
-				R8A7792_CLK_I2C1 R8A7792_CLK_I2C0
-			>;
-			clock-output-names =
-				"gpio7", "gpio6", "gpio5", "gpio4",
-				"gpio3", "gpio2", "gpio1", "gpio0",
-				"gpio11", "gpio10", "can1", "can0",
-				"qspi_mod", "gpio9", "gpio8",
-				"i2c5", "i2c4", "i2c3", "i2c2",
-				"i2c1", "i2c0";
-		};
 	};
 
 	/* External root clock */
-- 
2.1.4
