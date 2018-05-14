From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 14 May 2018 15:29:36 -0300
Subject: [PATCH 2/2] ARM: dts: iimx51-eukrea-mbimxsd51-baseboard: Fix USB PHY
 duplicate unit-address
In-Reply-To: <1526322576-5838-1-git-send-email-festevam@gmail.com>
References: <1526322576-5838-1-git-send-email-festevam@gmail.com>
Message-ID: <1526322576-5838-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently the following DTC warning is seen with W=1:

arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb: Warning (unique_unit_address): /usbphy/usbphy at 0: duplicate unit-address (also used in node /usbphy/usbh1phy at 0)

Fix it by moving the USB PHY node outside of simple-bus and drop the
unneeded unit-address.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 .../arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index b3d952f..29b0b7b 100644
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
+	usbh1phy: usbphy {
+		compatible = "usb-nop-xceiv";
+		clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
+		clock-names = "main_clk";
+		clock-frequency = <19200000>;
+		#phy-cells = <0>;
 	};
 };
 
-- 
2.7.4
