From: breno.lima@nxp.com (Breno Lima)
Date: Mon, 23 Jan 2017 18:26:54 -0200
Subject: [PATCH v3 3/3] ARM: dts: udoo_neo: Add Bluetooth support
In-Reply-To: <1485203214-29608-1-git-send-email-breno.lima@nxp.com>
References: <1485203214-29608-1-git-send-email-breno.lima@nxp.com>
Message-ID: <1485203214-29608-3-git-send-email-breno.lima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Udoo Neo has a TI WL1831 Bluetooth chip connected to the UART3 port.

Add support for it.

Signed-off-by: Breno Lima <breno.lima@nxp.com>
---
Changes since v2:
- Patch version number fixed.

 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index efdfd85..49f466f 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -107,6 +107,18 @@
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	reg_bt: regulator-bt {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_bt_reg>;
+		enable-active-high;
+		gpio = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+		regulator-name = "bt_reg";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
 };
 
 &cpu0 {
@@ -219,6 +231,11 @@
 };
 
 &iomuxc {
+	pinctrl_bt_reg: btreggrp {
+		fsl,pins =
+			<MX6SX_PAD_KEY_ROW2__GPIO2_IO_17        0x15059>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins =
 			<MX6SX_PAD_ENET1_CRS__GPIO2_IO_1	0xa0b1>,
@@ -256,6 +273,14 @@
 			<MX6SX_PAD_GPIO1_IO07__UART2_RX		0x1b0b1>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins =
+			<MX6SX_PAD_SD3_DATA4__UART3_RX          0x13059>,
+			<MX6SX_PAD_SD3_DATA5__UART3_TX          0x13059>,
+			<MX6SX_PAD_SD3_DATA6__UART3_RTS_B       0x13059>,
+			<MX6SX_PAD_SD3_DATA7__UART3_CTS_B       0x13059>;
+	};
+
 	pinctrl_uart5: uart5grp {
 		fsl,pins =
 			<MX6SX_PAD_SD4_DATA4__UART5_RX		0x1b0b1>,
@@ -334,6 +359,13 @@
 	status = "disabled";
 };
 
+&uart3 { /* Bluetooth */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
 /* Arduino serial */
 &uart5 {
 	pinctrl-names = "default";
-- 
2.7.4
