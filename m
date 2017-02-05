From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  5 Feb 2017 19:49:43 +0100
Subject: [PATCH 7/9] ARM: sun5i: a10s: Merge common controllers into the
 common DTSI
In-Reply-To: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <8334959b360ad45043703bc128d3d096e33d1bc3.1486320544.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers found in the A10s DTSI actually apply to all of the sun5i
family. Move those into the common DTSI so that all SoCs can benefit from
it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 70 +--------------------------------
 arch/arm/boot/dts/sun5i.dtsi      | 62 ++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 5122d1179e59..074485782a4a 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -70,45 +70,9 @@
 				 <&ccu CLK_DE_BE>, <&ccu CLK_HDMI>;
 			status = "disabled";
 		};
-
-		framebuffer at 0 {
-			compatible = "allwinner,simple-framebuffer",
-				     "simple-framebuffer";
-			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&ccu CLK_AHB_LCD>, <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
-				 <&ccu CLK_TCON_CH0>, <&ccu CLK_DRAM_DE_BE>;
-			status = "disabled";
-		};
-
-		framebuffer at 1 {
-			compatible = "allwinner,simple-framebuffer",
-				     "simple-framebuffer";
-			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&ccu CLK_AHB_TVE>, <&ccu CLK_AHB_LCD>,
-				 <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
-				 <&ccu CLK_TCON_CH1>, <&ccu CLK_DRAM_DE_BE>;
-			status = "disabled";
-		};
 	};
 
 	soc at 01c00000 {
-		emac: ethernet at 01c0b000 {
-			compatible = "allwinner,sun4i-a10-emac";
-			reg = <0x01c0b000 0x1000>;
-			interrupts = <55>;
-			clocks = <&ccu CLK_AHB_EMAC>;
-			allwinner,sram = <&emac_sram 1>;
-			status = "disabled";
-		};
-
-		mdio: mdio at 01c0b080 {
-			compatible = "allwinner,sun4i-a10-mdio";
-			reg = <0x01c0b080 0x14>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
 		pwm: pwm at 01c20e00 {
 			compatible = "allwinner,sun5i-a10s-pwm";
 			reg = <0x01c20e00 0xc>;
@@ -116,26 +80,6 @@
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
-
-		uart0: serial at 01c28000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28000 0x400>;
-			interrupts = <1>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_APB1_UART0>;
-			status = "disabled";
-		};
-
-		uart2: serial at 01c28800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28800 0x400>;
-			interrupts = <3>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&ccu CLK_APB1_UART2>;
-			status = "disabled";
-		};
 	};
 };
 
@@ -165,15 +109,6 @@
 		function = "emac";
 	};
 
-	emac_pins_a: emac0 at 0 {
-		pins = "PD6", "PD7", "PD10",
-				"PD11", "PD12", "PD13", "PD14",
-				"PD15", "PD18", "PD19", "PD20",
-				"PD21", "PD22", "PD23", "PD24",
-				"PD25", "PD26", "PD27";
-		function = "emac";
-	};
-
 	mmc1_pins_a: mmc1 at 0 {
 		pins = "PG3", "PG4", "PG5",
 				 "PG6", "PG7", "PG8";
@@ -193,9 +128,4 @@
 };
 
 &sram_a {
-	emac_sram: sram-section at 8000 {
-		compatible = "allwinner,sun4i-a10-sram-a3-a4";
-		reg = <0x8000 0x4000>;
-		status = "disabled";
-	};
 };
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index f27ca0be5835..9ba0c0302183 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -77,6 +77,16 @@
 				 <&ccu CLK_TCON_CH0>, <&ccu CLK_DRAM_DE_BE>;
 			status = "disabled";
 		};
+
+		framebuffer at 1 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0-tve0";
+			clocks = <&ccu CLK_AHB_TVE>, <&ccu CLK_AHB_LCD>,
+				 <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
+				 <&ccu CLK_TCON_CH1>, <&ccu CLK_DRAM_DE_BE>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
@@ -120,6 +130,12 @@
 				ranges = <0 0x00000000 0xc000>;
 			};
 
+			emac_sram: sram-section at 8000 {
+				compatible = "allwinner,sun4i-a10-sram-a3-a4";
+				reg = <0x8000 0x4000>;
+				status = "disabled";
+			};
+
 			sram_d: sram at 00010000 {
 				compatible = "mmio-sram";
 				reg = <0x00010000 0x1000>;
@@ -171,6 +187,23 @@
 			#size-cells = <0>;
 		};
 
+		emac: ethernet at 01c0b000 {
+			compatible = "allwinner,sun4i-a10-emac";
+			reg = <0x01c0b000 0x1000>;
+			interrupts = <55>;
+			clocks = <&ccu CLK_AHB_EMAC>;
+			allwinner,sram = <&emac_sram 1>;
+			status = "disabled";
+		};
+
+		mdio: mdio at 01c0b080 {
+			compatible = "allwinner,sun4i-a10-mdio";
+			reg = <0x01c0b080 0x14>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		tcon0: lcd-controller at 01c0c000 {
 			compatible = "allwinner,sun5i-a13-tcon";
 			reg = <0x01c0c000 0x1000>;
@@ -326,6 +359,15 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			emac_pins_a: emac0 at 0 {
+				pins = "PD6", "PD7", "PD10",
+				       "PD11", "PD12", "PD13", "PD14",
+				       "PD15", "PD18", "PD19", "PD20",
+				       "PD21", "PD22", "PD23", "PD24",
+				       "PD25", "PD26", "PD27";
+				function = "emac";
+			};
+
 			i2c0_pins_a: i2c0 at 0 {
 				pins = "PB0", "PB1";
 				function = "i2c0";
@@ -472,6 +514,16 @@
 			#thermal-sensor-cells = <0>;
 		};
 
+		uart0: serial at 01c28000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28000 0x400>;
+			interrupts = <1>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_APB1_UART0>;
+			status = "disabled";
+		};
+
 		uart1: serial at 01c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
@@ -482,6 +534,16 @@
 			status = "disabled";
 		};
 
+		uart2: serial at 01c28800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28800 0x400>;
+			interrupts = <3>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_APB1_UART2>;
+			status = "disabled";
+		};
+
 		uart3: serial at 01c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
-- 
git-series 0.8.11
