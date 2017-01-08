From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 08 Jan 2017 15:03:26 +0000
Subject: [PATCH 4/4] ARM: dts: imx6*-hummingboard2: convert to more
 conventional vmmc-supply
In-Reply-To: <20170108150201.GS14217@n2100.armlinux.org.uk>
References: <20170108150201.GS14217@n2100.armlinux.org.uk>
Message-ID: <E1cQF0I-0003NN-S7@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 88833d757f7b..66098a5fdd8d 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -75,6 +75,18 @@
 			regulator-always-on;
 		};
 
+		reg_usdhc2_vmmc: reg-usdhc2-vmmc {
+			compatible = "regulator-fixed";
+			gpio = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_hummingboard2_vmmc>;
+			regulator-boot-on;
+			regulator-max-microvolt = <3300000>;
+			regulator-min-microvolt = <3300000>;
+			regulator-name = "usdhc2_vmmc";
+			startup-delay-us = <1000>;
+		};
+
 		reg_usbh1_vbus: usb-h1-vbus {
 			compatible = "regulator-fixed";
 			enable-active-high;
@@ -122,11 +134,6 @@
 		};
 	};
 
-	usdhc2_pwrseq: usdhc2_pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
-	};
-
 	sound-sgtl5000 {
 		audio-codec = <&sgtl5000>;
 		audio-routing =
@@ -388,7 +395,6 @@
 
 		pinctrl_hummingboard2_usdhc2_aux: hummingboard2-usdhc2-aux {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
 				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT 0x1b071
 				MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30 0x1b0b0
 			>;
@@ -427,6 +433,12 @@
 			>;
 		};
 
+		pinctrl_hummingboard2_vmmc: hummingboard2-vmmc {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
+			>;
+		};
+
 		pinctrl_hummingboard2_usdhc3: hummingboard2-usdhc3 {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
@@ -526,7 +538,7 @@
 		&pinctrl_hummingboard2_usdhc2_aux
 		&pinctrl_hummingboard2_usdhc2_200mhz
 	>;
-	mmc-pwrseq = <&usdhc2_pwrseq>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
 	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.7.4
