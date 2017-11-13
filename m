From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 13 Nov 2017 01:25:23 +0000
Subject: [RFC PATCH 3/3] arm64: dts: allwinner: enhance A64 .dtsi with new
 pinctrl binding
In-Reply-To: <20171113012523.2328-1-andre.przywara@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
Message-ID: <20171113012523.2328-4-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhance the existing pinctrl DT nodes for the Allwinner A64 SoC to
include the new properties the generic, DT-based binding introduced.
This allows any generic driver to support this SoC as well.
The DT nodes stay fully compatible with the old binding, so existing
drivers continue to work without restrictions.
But on top of that new DT users can directly use the information here
and can do without a hardcoded table.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8c8db1b057df..58fdae32240a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -269,7 +269,8 @@
 		};
 
 		pio: pinctrl at 1c20800 {
-			compatible = "allwinner,sun50i-a64-pinctrl";
+			compatible = "allwinner,sun50i-a64-pinctrl",
+				     "allwinner,sunxi-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
@@ -279,16 +280,22 @@
 			#gpio-cells = <3>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
+			allwinner,gpio-pins = <0 10 17 25 18 7 14 12>;
+			allwinner,irq-pin-map = <0 0 1 0 6 10>,
+						<1 0 6 0 6 14>,
+						<2 0 7 0 6 12>;
 
 			i2c1_pins: i2c1_pins {
 				pins = "PH2", "PH3";
 				function = "i2c1";
+				pinmux = <2>;
 			};
 
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
 				function = "mmc0";
+				pinmux = <2>;
 				drive-strength = <30>;
 				bias-pull-up;
 			};
@@ -297,6 +304,7 @@
 				pins = "PG0", "PG1", "PG2", "PG3",
 				       "PG4", "PG5";
 				function = "mmc1";
+				pinmux = <2>;
 				drive-strength = <30>;
 				bias-pull-up;
 			};
@@ -306,6 +314,7 @@
 				       "PC10","PC11", "PC12", "PC13",
 				       "PC14", "PC15", "PC16";
 				function = "mmc2";
+				pinmux = <3>;
 				drive-strength = <30>;
 				bias-pull-up;
 			};
@@ -314,6 +323,7 @@
 				pins = "PD10", "PD11", "PD13", "PD14", "PD17",
 				       "PD18", "PD19", "PD20", "PD22", "PD23";
 				function = "emac";
+				pinmux = <4>;
 				drive-strength = <40>;
 			};
 
@@ -322,42 +332,50 @@
 				       "PD13", "PD15", "PD16", "PD17", "PD18",
 				       "PD19", "PD20", "PD21", "PD22", "PD23";
 				function = "emac";
+				pinmux = <4>;
 				drive-strength = <40>;
 			};
 
 			uart0_pins_a: uart0 at 0 {
 				pins = "PB8", "PB9";
 				function = "uart0";
+				pinmux = <4>;
 			};
 
 			uart1_pins: uart1_pins {
 				pins = "PG6", "PG7";
 				function = "uart1";
+				pinmux = <2>;
 			};
 
 			uart1_rts_cts_pins: uart1_rts_cts_pins {
 				pins = "PG8", "PG9";
 				function = "uart1";
+				pinmux = <2>;
 			};
 
 			uart2_pins: uart2-pins {
 				pins = "PB0", "PB1";
 				function = "uart2";
+				pinmux = <2>;
 			};
 
 			uart3_pins: uart3-pins {
 				pins = "PD0", "PD1";
 				function = "uart3";
+				pinmux = <3>;
 			};
 
 			uart4_pins: uart4-pins {
 				pins = "PD2", "PD3";
 				function = "uart4";
+				pinmux = <3>;
 			};
 
 			uart4_rts_cts_pins: uart4-rts-cts-pins {
 				pins = "PD4", "PD5";
 				function = "uart4";
+				pinmux = <3>;
 			};
 		};
 
@@ -487,7 +505,8 @@
 		};
 
 		r_pio: pinctrl at 01f02c00 {
-			compatible = "allwinner,sun50i-a64-r-pinctrl";
+			compatible = "allwinner,sun50i-a64-r-pinctrl",
+				     "allwinner,sunxi-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
@@ -496,10 +515,14 @@
 			#gpio-cells = <3>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
+			allwinner,gpio-pins = <13>;
+			allwinner,port-base = <11>;
+			allwinner,irq-pin-map = <0 0 11 0 6 13>;
 
 			r_rsb_pins: rsb at 0 {
 				pins = "PL0", "PL1";
 				function = "s_rsb";
+				pinmux = <2>;
 			};
 		};
 
-- 
2.14.1
