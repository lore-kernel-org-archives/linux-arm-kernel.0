From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:42 +0100
Subject: [PATCH 6/9] ARM: sun5i: a13: Merge common controllers into the common
 DTSI
In-Reply-To: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7702aa87fa95a6904a8130aea56c962d7ddb2fd3.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers found in the A13 DTSI actually apply to all of the sun5i
family. Move those into the common DTSI so that all SoCs can benefit from
it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 139 +--------------------------------
 arch/arm/boot/dts/sun5i.dtsi     | 140 ++++++++++++++++++++++++++++++++-
 2 files changed, 140 insertions(+), 139 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index fb2ddb9a04c9..6f8c508e8e70 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -52,21 +52,6 @@
 / {
 	interrupt-parent = <&intc>;
 
-	chosen {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		framebuffer at 0 {
-			compatible = "allwinner,simple-framebuffer",
-				     "simple-framebuffer";
-			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&ccu CLK_AHB_LCD>, <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
-				 <&ccu CLK_TCON_CH0>, <&ccu CLK_DRAM_DE_BE>;
-			status = "disabled";
-		};
-	};
-
 	thermal-zones {
 		cpu_thermal {
 			/* milliseconds */
@@ -105,44 +90,6 @@
 	};
 
 	soc at 01c00000 {
-		tcon0: lcd-controller at 01c0c000 {
-			compatible = "allwinner,sun5i-a13-tcon";
-			reg = <0x01c0c000 0x1000>;
-			interrupts = <44>;
-			resets = <&ccu RST_LCD>;
-			reset-names = "lcd";
-			clocks = <&ccu CLK_AHB_LCD>,
-				 <&ccu CLK_TCON_CH0>,
-				 <&ccu CLK_TCON_CH1>;
-			clock-names = "ahb",
-				      "tcon-ch0",
-				      "tcon-ch1";
-			clock-output-names = "tcon-pixel-clock";
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				tcon0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					tcon0_in_be0: endpoint at 0 {
-						reg = <0>;
-						remote-endpoint = <&be0_out_tcon0>;
-					};
-				};
-
-				tcon0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-			};
-		};
-
 		pwm: pwm at 01c20e00 {
 			compatible = "allwinner,sun5i-a13-pwm";
 			reg = <0x01c20e00 0xc>;
@@ -151,74 +98,6 @@
 			status = "disabled";
 		};
 
-		fe0: display-frontend at 01e00000 {
-			compatible = "allwinner,sun5i-a13-display-frontend";
-			reg = <0x01e00000 0x20000>;
-			interrupts = <47>;
-			clocks = <&ccu CLK_DE_FE>, <&ccu CLK_DE_FE>,
-				 <&ccu CLK_DRAM_DE_FE>;
-			clock-names = "ahb", "mod",
-				      "ram";
-			resets = <&ccu RST_DE_FE>;
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fe0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					fe0_out_be0: endpoint at 0 {
-						reg = <0>;
-						remote-endpoint = <&be0_in_fe0>;
-					};
-				};
-			};
-		};
-
-		be0: display-backend at 01e60000 {
-			compatible = "allwinner,sun5i-a13-display-backend";
-			reg = <0x01e60000 0x10000>;
-			clocks = <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
-				 <&ccu CLK_DRAM_DE_BE>;
-			clock-names = "ahb", "mod",
-				      "ram";
-			resets = <&ccu RST_DE_BE>;
-			status = "disabled";
-
-			assigned-clocks = <&ccu CLK_DE_BE>;
-			assigned-clock-rates = <300000000>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				be0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					be0_in_fe0: endpoint at 0 {
-						reg = <0>;
-						remote-endpoint = <&fe0_out_be0>;
-					};
-				};
-
-				be0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					be0_out_tcon0: endpoint at 0 {
-						reg = <0>;
-						remote-endpoint = <&tcon0_in_be0>;
-					};
-				};
-			};
-		};
 	};
 };
 
@@ -244,22 +123,4 @@
 
 &pio {
 	compatible = "allwinner,sun5i-a13-pinctrl";
-
-	lcd_rgb666_pins: lcd_rgb666 at 0 {
-		pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
-		       "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
-		       "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
-		       "PD24", "PD25", "PD26", "PD27";
-		function = "lcd0";
-	};
-
-	uart1_pins_a: uart1 at 0 {
-		pins = "PE10", "PE11";
-		function = "uart1";
-	};
-
-	uart1_pins_b: uart1 at 1 {
-		pins = "PG3", "PG4";
-		function = "uart1";
-	};
 };
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index d4888e0a0a13..f27ca0be5835 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -64,6 +64,21 @@
 		};
 	};
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer at 0 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0";
+			clocks = <&ccu CLK_AHB_LCD>, <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
+				 <&ccu CLK_TCON_CH0>, <&ccu CLK_DRAM_DE_BE>;
+			status = "disabled";
+		};
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -156,6 +171,44 @@
 			#size-cells = <0>;
 		};
 
+		tcon0: lcd-controller at 01c0c000 {
+			compatible = "allwinner,sun5i-a13-tcon";
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <44>;
+			resets = <&ccu RST_LCD>;
+			reset-names = "lcd";
+			clocks = <&ccu CLK_AHB_LCD>,
+				 <&ccu CLK_TCON_CH0>,
+				 <&ccu CLK_TCON_CH1>;
+			clock-names = "ahb",
+				      "tcon-ch0",
+				      "tcon-ch1";
+			clock-output-names = "tcon-pixel-clock";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon0_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon0_in_be0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&be0_out_tcon0>;
+					};
+				};
+
+				tcon0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -296,6 +349,14 @@
 				function = "lcd0";
 			};
 
+			lcd_rgb666_pins: lcd_rgb666 at 0 {
+				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				       "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+				       "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
@@ -336,6 +397,16 @@
 				function = "spi2";
 			};
 
+			uart1_pins_a: uart1 at 0 {
+				pins = "PE10", "PE11";
+				function = "uart1";
+			};
+
+			uart1_pins_b: uart1 at 1 {
+				pins = "PG3", "PG4";
+				function = "uart1";
+			};
+
 			uart2_pins_a: uart2 at 0 {
 				pins = "PD2", "PD3";
 				function = "uart2";
@@ -457,5 +528,74 @@
 			interrupts = <82>, <83>;
 			clocks = <&ccu CLK_AHB_HSTIMER>;
 		};
+
+		fe0: display-frontend at 01e00000 {
+			compatible = "allwinner,sun5i-a13-display-frontend";
+			reg = <0x01e00000 0x20000>;
+			interrupts = <47>;
+			clocks = <&ccu CLK_DE_FE>, <&ccu CLK_DE_FE>,
+				 <&ccu CLK_DRAM_DE_FE>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_DE_FE>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fe0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					fe0_out_be0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&be0_in_fe0>;
+					};
+				};
+			};
+		};
+
+		be0: display-backend at 01e60000 {
+			compatible = "allwinner,sun5i-a13-display-backend";
+			reg = <0x01e60000 0x10000>;
+			clocks = <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
+				 <&ccu CLK_DRAM_DE_BE>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_DE_BE>;
+			status = "disabled";
+
+			assigned-clocks = <&ccu CLK_DE_BE>;
+			assigned-clock-rates = <300000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				be0_in: port at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					be0_in_fe0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&fe0_out_be0>;
+					};
+				};
+
+				be0_out: port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					be0_out_tcon0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&tcon0_in_be0>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
git-series 0.8.11
