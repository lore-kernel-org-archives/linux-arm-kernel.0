From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 8 Dec 2015 09:37:50 +0800
Subject: [PATCH 3/3] ARM: dts: imx6qdl-udoo.dtsi: fix onboard USB HUB property
In-Reply-To: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1449538670-7954-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current dts describes USB HUB's property at USB controller's
entry, it is improper. Fix it by using a generic USB HUB entry.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index 1211da8..9416d75 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -18,21 +18,12 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_usb_h1_vbus: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			enable-active-high;
-			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
-			gpio = <&gpio7 12 0>;
-		};
+	usb_hub1 {
+		compatible = "generic-onboard-hub";
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		clock-names = "external_clk";
+		hub-reset-gpios = <&gpio7 12 0>;
+		hub-reset-duration-us = <2>;
 	};
 };
 
@@ -119,10 +110,6 @@
 };
 
 &usbh1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbh>;
-	vbus-supply = <&reg_usb_h1_vbus>;
-	clocks = <&clks 201>;
 	status = "okay";
 };
 
-- 
1.9.1
