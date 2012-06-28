From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:45:06 +0800
Subject: [PATCH 10/11] ARM: dts: mxs: add pwm-backlight for imx23-evk and
 imx28-evk
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-11-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwm device and pwm-backlight for imx23-evk and imx28-evk.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23-evk.dts |   13 +++++++++++++
 arch/arm/boot/dts/imx23.dtsi    |   15 ++++++++++++++-
 arch/arm/boot/dts/imx28-evk.dts |   13 +++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |   15 ++++++++++++++-
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 9eca34f..3974959d 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -51,6 +51,12 @@
 		};
 
 		apbx at 80040000 {
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm2_pins_a>;
+				status = "okay";
+			};
+
 			auart0: serial at 8006c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&auart0_pins_a>;
@@ -76,4 +82,11 @@
 			gpio = <&gpio1 29 0>;
 		};
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 2 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index a94ba1d..22e1617 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -181,6 +181,16 @@
 					>;
 					fsl,pull-up = <0>;
 				};
+
+				pwm2_pins_a: pwm2 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x11c0 /* MX23_PAD_PWM2__PWM2 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -294,8 +304,11 @@
 				interrupts = <22>;
 			};
 
-			pwm at 80064000 {
+			pwm: pwm at 80064000 {
+				compatible = "fsl,imx23-pwm";
 				reg = <0x80064000 2000>;
+				#pwm-cells = <2>;
+				fsl,pwm-number = <5>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index a551295..d4fa97e 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -108,6 +108,12 @@
 				};
 			};
 
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm2_pins_a>;
+				status = "okay";
+			};
+
 			duart: serial at 80074000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
@@ -192,4 +198,11 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 2 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index f44ad99..2628513 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -386,6 +386,16 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				pwm2_pins_a: pwm2 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3120 /* MX28_PAD_PWM2__PWM_2 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -550,8 +560,11 @@
 				status = "disabled";
 			};
 
-			pwm at 80064000 {
+			pwm: pwm at 80064000 {
+				compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
 				reg = <0x80064000 2000>;
+				#pwm-cells = <2>;
+				fsl,pwm-number = <8>;
 				status = "disabled";
 			};
 
-- 
1.7.5.4
