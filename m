From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon,  7 Apr 2014 16:29:27 +0200
Subject: [PATCH 4/4] ARM: dts: imx6: edmqmx6: add second STMPE
In-Reply-To: <1396880967-16319-1-git-send-email-l.stach@pengutronix.de>
References: <1396880967-16319-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1396880967-16319-4-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 38 +++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index e7762e456cbe..e4ae38fd0269 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -19,7 +19,10 @@
 	compatible = "dmo,imx6q-edmqmx6", "fsl,imx6q";
 
 	aliases {
-		gpio7 = &stmpe_gpio;
+		gpio7 = &stmpe_gpio1;
+		gpio8 = &stmpe_gpio2;
+		stmpe-i2c0 = &stmpe1;
+		stmpe-i2c1 = &stmpe2;
 	};
 
 	memory {
@@ -67,23 +70,23 @@
 
 		led-blue {
 			label = "blue";
-			gpios = <&stmpe_gpio 8 GPIO_ACTIVE_HIGH>;
+			gpios = <&stmpe_gpio1 8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		led-green {
 			label = "green";
-			gpios = <&stmpe_gpio 9 GPIO_ACTIVE_HIGH>;
+			gpios = <&stmpe_gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
 
 		led-pink {
 			label = "pink";
-			gpios = <&stmpe_gpio 10 GPIO_ACTIVE_HIGH>;
+			gpios = <&stmpe_gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
 
 		led-red {
 			label = "red";
-			gpios = <&stmpe_gpio 11 GPIO_ACTIVE_HIGH>;
+			gpios = <&stmpe_gpio1 11 GPIO_ACTIVE_HIGH>;
 		};
 	};
 };
@@ -101,7 +104,8 @@
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2
-		     &pinctrl_stmpe>;
+		     &pinctrl_stmpe1
+		     &pinctrl_stmpe2>;
 	status = "okay";
 
 	pmic: pfuze100 at 08 {
@@ -207,13 +211,25 @@
 		};
 	};
 
-	stmpe: stmpe1601 at 40 {
+	stmpe1: stmpe1601 at 40 {
 		compatible = "st,stmpe1601";
 		reg = <0x40>;
 		interrupts = <30 0>;
 		interrupt-parent = <&gpio3>;
 
-		stmpe_gpio: stmpe_gpio {
+		stmpe_gpio1: stmpe_gpio {
+			#gpio-cells = <2>;
+			compatible = "st,stmpe-gpio";
+		};
+	};
+
+	stmpe2: stmpe1601 at 44 {
+		compatible = "st,stmpe1601";
+		reg = <0x44>;
+		interrupts = <2 0>;
+		interrupt-parent = <&gpio5>;
+
+		stmpe_gpio2: stmpe_gpio {
 			#gpio-cells = <2>;
 			compatible = "st,stmpe-gpio";
 		};
@@ -275,10 +291,14 @@
 			>;
 		};
 
-		pinctrl_stmpe: stmpegrp {
+		pinctrl_stmpe1: stmpe1grp {
 			fsl,pins = <MX6QDL_PAD_EIM_D30__GPIO3_IO30 0x80000000>;
 		};
 
+		pinctrl_stmpe2: stmpe2grp {
+			fsl,pins = <MX6QDL_PAD_EIM_A25__GPIO5_IO02 0x80000000>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
-- 
1.9.1
