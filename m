From: ps.report@gmx.net (Peter Seiderer)
Date: Thu, 21 May 2015 19:45:03 +0200
Subject: [PATCH v2] ARM: dts: nitrogen6x: add CAN support
Message-ID: <1432230303-3414-1-git-send-email-ps.report@gmx.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulator stuff copied from imx6qdl-tx6.dtsi, pin configuration
taken from Boundary Devices linux kernel tree ([1] and [2]).

[1] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.10.17_1.0.2_ga/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
[2] https://github.com/boundarydevices/linux-imx6/blob/boundary-imx_3.10.17_1.0.2_ga/arch/arm/boot/dts/imx6qdl.dtsi

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
---
v2:
 - fix imx6qdl-nitrogen6x.dtsi url
 - use real PAD settings (suggested by Fabio Estevam)
 - remove _1 suffix (suggested by Shawn Guo)
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index fd096dc..d40092e 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -54,6 +54,17 @@
 			gpio = <&gpio3 22 0>;
 			enable-active-high;
 		};
+
+		reg_can_xcvr: regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "CAN XCVR";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_can_xcvr>;
+			gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	gpio-keys {
@@ -138,6 +149,13 @@
 	status = "okay";
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	xceiver-supply = <&reg_can_xcvr>;
+	status = "okay";
+};
+
 &ecspi1 {
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 0>;
@@ -234,6 +252,20 @@
 			>;
 		};
 
+		pinctrl_can1: can1grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b0
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b0
+			>;
+		};
+
+		pinctrl_can_xcvr: can-xcvrgrp {
+			fsl,pins = <
+				/* Flexcan XCVR enable */
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
+			>;
+		};
+
 		pinctrl_ecspi1: ecspi1grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
-- 
2.1.4
