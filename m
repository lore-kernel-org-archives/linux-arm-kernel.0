From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 6 Feb 2013 14:10:43 +0800
Subject: [PATCH 1/1] ARM: dts: imx6q-sabresd: Add USB support
Message-ID: <1360131043-10631-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB support for imx6q sabresd board

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabresd.dts |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi        |    5 +++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index a424025..b0f5049 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -51,6 +51,18 @@
 		};
 
 		aips-bus at 02100000 { /* AIPS2 */
+			usb at 02184000 { /* USB OTG */
+				vbus-supply = <&reg_usb_otg_vbus>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usbotg_2>;
+				disable-over-current;
+				status = "okay";
+			};
+
+			usb at 02184200 { /* USB1 */
+				status = "okay";
+			};
+
 			ethernet at 02188000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_enet_1>;
@@ -91,4 +103,16 @@
 			linux,code = <114>; /* KEY_VOLUMEDOWN */
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		reg_usb_otg_vbus: usb_otg_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 22 0>;
+			enable-active-high;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d6265ca..9619ff8 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -705,6 +705,11 @@
 							1592 0x17059	/* MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID */
 						>;
 					};
+					pinctrl_usbotg_2: usbotggrp-2 {
+						fsl,pins = <
+							1591 0x17059	/* MX6Q_PAD_ENET_RX_ER__ANATOP_USBOTG_ID */
+						>;
+					};
 				};
 
 				usdhc2 {
-- 
1.7.0.4
