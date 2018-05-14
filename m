From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 14 May 2018 15:29:35 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Fix USB PHY duplicate
 unit-address
Message-ID: <1526322576-5838-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently the following DTC warning is seen with W=1:

arch/arm/boot/dts/imx51-babbage.dtb: Warning (unique_unit_address): /usbphy/usbphy at 0: duplicate unit-address (also used in node /usbphy/usbh1phy at 0)

Fix it by moving the USB PHY node outside of simple-bus and drop the
unneeded unit-address.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index b8ca73d..de46906 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -170,20 +170,13 @@
 		mux-ext-port = <3>;
 	};
 
-	usbphy {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "simple-bus";
-
-		usbh1phy: usbh1phy at 0 {
-			compatible = "usb-nop-xceiv";
-			reg = <0>;
-			clocks = <&clk_usb>;
-			clock-names = "main_clk";
-			reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
-			vcc-supply = <&vusb_reg>;
-			#phy-cells = <0>;
-		};
+	usbh1phy: usbphy1 {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clk_usb>;
+		clock-names = "main_clk";
+		reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&vusb_reg>;
+		#phy-cells = <0>;
 	};
 };
 
-- 
2.7.4
