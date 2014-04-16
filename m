From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Apr 2014 14:10:16 -0300
Subject: [PATCH 2/3] ARM: dts: imx27: Place the usb phy nodes in the board dts
 files
In-Reply-To: <1397668217-17551-1-git-send-email-festevam@gmail.com>
References: <1397668217-17551-1-git-send-email-festevam@gmail.com>
Message-ID: <1397668217-17551-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

It is not a good approach to have the USB PHY nodes inside imx27.dtsi since
the USB PHYs on mx27 are not internal to the SoC.

Place the USB PHY nodes in the board dts files instead.

Also, each board may have a different clock source for the USB PHY, so do not
hardcode it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Applies on top of "[PATCH] ARM: dts: imx27-phytec-phycore-som: Move PMIC IRQ GPIO into a separate pin group"

 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  |  5 +---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 36 ++++++++++++++++++++++---
 arch/arm/boot/dts/imx27.dtsi                    | 22 ---------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 8b4181b..7c23649 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -268,14 +268,11 @@
 	dr_mode = "host";
 	phy_type = "ulpi";
 	vbus-supply = <&reg_5v0>;
+	fsl,usbphy = <&usbphy2>;
 	disable-over-current;
 	status = "okay";
 };
 
-&usbphy2 {
-	vcc-supply = <&reg_5v0>;
-};
-
 &weim {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_weim>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 33c5dc2..c48b9f8 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -20,6 +20,15 @@
 		reg = <0xa0000000 0x08000000>;
 	};
 
+	clocks {
+		clk_26M: codec_clock {
+			compatible = "fixed-clock";
+			reg = <0>;
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -41,6 +50,28 @@
 			regulator-max-microvolt = <5000000>;
 		};
 	};
+
+	usbphy {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usbphy at 0 {
+			compatible = "usb-nop-xceiv";
+			reg = <0>;
+			vcc-supply = <&sw3_reg>;
+			clocks = <&clk_26M>;
+			clock-names = "main_clk";
+		};
+
+		usbphy2: usbphy at 2 {
+			compatible = "usb-nop-xceiv";
+			reg = <0>;
+			vcc-supply = <&reg_5v0>;
+			clocks = <&clk_26M>;
+			clock-names = "main_clk";
+		};
+	};
 };
 
 &audmux {
@@ -307,14 +338,11 @@
 	pinctrl-0 = <&pinctrl_usbotg>;
 	dr_mode = "otg";
 	phy_type = "ulpi";
+	fsl,usbphy = <&usbphy0>;
 	vbus-supply = <&sw3_reg>;
 	status = "okay";
 };
 
-&usbphy0 {
-	vcc-supply = <&sw3_reg>;
-};
-
 &weim {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 948354e..b2c103e 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -72,26 +72,6 @@
 		};
 	};
 
-	usbphy {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usbphy0: usbphy at 0 {
-			compatible = "usb-nop-xceiv";
-			reg = <0>;
-			clocks = <&clks 75>;
-			clock-names = "main_clk";
-		};
-
-		usbphy2: usbphy at 2 {
-			compatible = "usb-nop-xceiv";
-			reg = <2>;
-			clocks = <&clks 75>;
-			clock-names = "main_clk";
-		};
-	};
-
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -467,7 +447,6 @@
 				interrupts = <56>;
 				clocks = <&clks 75>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
 			};
 
@@ -486,7 +465,6 @@
 				interrupts = <55>;
 				clocks = <&clks 75>;
 				fsl,usbmisc = <&usbmisc 2>;
-				fsl,usbphy = <&usbphy2>;
 				status = "disabled";
 			};
 
-- 
1.8.3.2
