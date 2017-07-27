From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 27 Jul 2017 11:00:28 -0300
Subject: [PATCH] ARM: dts: imx7d-sdb: Add flexcan support
Message-ID: <1501164028-11849-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Flexcan.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 60b5019..44637ca 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -126,6 +126,16 @@
 		gpio = <&extended_io 7 GPIO_ACTIVE_LOW>;
 	};
 
+	reg_can2_3v3: regulator-can2-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-3v3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexcan2_reg>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 14 GPIO_ACTIVE_LOW>;
+	};
+
 	panel {
 		compatible = "innolux,at043tn24";
 		pinctrl-0 = <&pinctrl_backlight>;
@@ -219,6 +229,13 @@
 	status = "okay";
 };
 
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_3v3>;
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
@@ -484,6 +501,20 @@
 			>;
 		};
 
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
+				MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x59
+			>;
+		};
+
+		pinctrl_flexcan2_reg: flexcan2reggrp {
+			fsl,pins = <
+				MX7D_PAD_EPDC_DATA14__GPIO2_IO14	0x59	/* CAN_STBY */
+			>;
+		};
+
+
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
 				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
-- 
2.7.4
