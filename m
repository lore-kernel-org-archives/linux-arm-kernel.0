From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue,  3 Jul 2018 10:05:54 -0300
Subject: [PATCH v3] ARM: dts: imx51: Fix USB PHY duplicate unit-address
Message-ID: <1530623154-11091-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the following DTC warnings are seen with W=1:

arch/arm/boot/dts/imx51-babbage.dtb: Warning (unique_unit_address): /usbphy/usbphy at 0: duplicate unit-address (also used in node /usbphy/usbh1phy at 0)
arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb: Warning (unique_unit_address): /usbphy/usbphy at 0: duplicate unit-address (also used in node /usbphy/usbh1phy at 0)

Fix it by moving the USB PHY nodes outside of simple-bus and drop the
unneeded unit-address, which matches the bindings documentation
at Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt

While at it rename the USB PHY node to usbphy1 for consistency.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- Name the node as usbphy1 for consistency (Shawn).

 arch/arm/boot/dts/imx51-babbage.dts                | 27 ++++++++--------------
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 21 ++++++-----------
 arch/arm/boot/dts/imx51.dtsi                       | 17 ++++----------
 3 files changed, 22 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 4fb0d4d..a4a6d4a 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -170,22 +170,15 @@
 		mux-ext-port = <3>;
 	};
 
-	usbphy {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "simple-bus";
-
-		usbh1phy: usbh1phy at 0 {
-			compatible = "usb-nop-xceiv";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usbh1reg>;
-			reg = <0>;
-			clocks = <&clk_usb>;
-			clock-names = "main_clk";
-			reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
-			vcc-supply = <&vusb_reg>;
-			#phy-cells = <0>;
-		};
+	usbphy1: usbphy1 {
+		compatible = "usb-nop-xceiv";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbh1reg>;
+		clocks = <&clk_usb>;
+		clock-names = "main_clk";
+		reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&vusb_reg>;
+		#phy-cells = <0>;
 	};
 };
 
@@ -431,7 +424,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh1>;
 	vbus-supply = <&reg_hub_reset>;
-	fsl,usbphy = <&usbh1phy>;
+	fsl,usbphy = <&usbphy1>;
 	phy_type = "ulpi";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index b3d952f..e9e819f 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -83,19 +83,12 @@
 		fsl,mux-ext-port = <3>;
 	};
 
-	usbphy {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "simple-bus";
-
-		usbh1phy: usbh1phy at 0 {
-			compatible = "usb-nop-xceiv";
-			reg = <0>;
-			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
-			clock-names = "main_clk";
-			clock-frequency = <19200000>;
-			#phy-cells = <0>;
-		};
+	usbphy1: usbphy1 {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
+		clock-names = "main_clk";
+		clock-frequency = <19200000>;
+		#phy-cells = <0>;
 	};
 };
 
@@ -275,7 +268,7 @@
 &usbh1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh1>;
-	fsl,usbphy = <&usbh1phy>;
+	fsl,usbphy = <&usbphy1>;
 	dr_mode = "host";
 	phy_type = "ulpi";
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 5bb727a..66e4187 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -93,18 +93,11 @@
 		};
 	};
 
-	usbphy {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "simple-bus";
-
-		usbphy0: usbphy at 0 {
-			compatible = "usb-nop-xceiv";
-			reg = <0>;
-			clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
-			clock-names = "main_clk";
-			#phy-cells = <0>;
-		};
+	usbphy0: usbphy0 {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
+		clock-names = "main_clk";
+		#phy-cells = <0>;
 	};
 
 	display-subsystem {
-- 
2.7.4
