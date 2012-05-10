From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 16:42:13 +0800
Subject: [PATCH 6/6] ARM: dts: enable audio support for imx28-evk
In-Reply-To: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1336639333-11561-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   41 +++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |   23 +++++++++++++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index c4b717f..a07fc92 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -41,10 +41,31 @@
 		};
 
 		apbx at 80040000 {
+			saif0: saif at 80042000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&saif0_pins_a>;
+				status = "okay";
+			};
+
+			saif1: saif at 80046000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&saif1_pins_a>;
+				fsl,saif-master = <&saif0>;
+				status = "okay";
+			};
+
 			i2c0: i2c at 80058000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&i2c0_pins_a>;
 				status = "okay";
+
+				sgtl5000: codec at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+					VDDA-supply = <&reg_3p3v>;
+					VDDIO-supply = <&reg_3p3v>;
+
+				};
 			};
 
 			duart: serial at 80074000 {
@@ -70,4 +91,24 @@
 			status = "okay";
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx28-evk-sgtl5000",
+			     "fsl,mxs-audio-sgtl5000";
+		model = "imx28-evk-sgtl5000";
+		saif-controllers = <&saif0 &saif1>;
+		audio-codec = <&sgtl5000>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index fd73fc2..4634cb8 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -20,6 +20,8 @@
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
 		gpio4 = &gpio4;
+		saif0 = &saif0;
+		saif1 = &saif1;
 	};
 
 	cpus {
@@ -212,6 +214,23 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
 				};
+
+				saif0_pins_a: saif0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x3140 0x3150 0x3160 0x3170>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				saif1_pins_a: saif1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x31a0>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -319,8 +338,10 @@
 			};
 
 			saif0: saif at 80042000 {
+				compatible = "fsl,imx28-saif";
 				reg = <0x80042000 2000>;
 				interrupts = <59 80>;
+				fsl,saif-dma-channel = <4>;
 				status = "disabled";
 			};
 
@@ -330,8 +351,10 @@
 			};
 
 			saif1: saif at 80046000 {
+				compatible = "fsl,imx28-saif";
 				reg = <0x80046000 2000>;
 				interrupts = <58 81>;
+				fsl,saif-dma-channel = <5>;
 				status = "disabled";
 			};
 
-- 
1.7.5.4
