From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Tue, 30 Aug 2016 17:23:04 -0300
Subject: [PATCH v3 3/3] ARM: dts: imx7s-warp: Add Bluetooth support
In-Reply-To: <1472588584-686-1-git-send-email-vanessa.maegima@nxp.com>
References: <1472588584-686-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <1472588584-686-3-git-send-email-vanessa.maegima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WaRP7 has a BCM43430 Bluetooth chip.

Add support for it.

Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
---
Change since v2:
- Add pinctrl entry for regulator

 arch/arm/boot/dts/imx7s-warp.dts | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index b3c75c1..17375a6 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -79,6 +79,18 @@
 		startup-delay-us = <200000>;
 	};
 
+	reg_bt: regulator-bt {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_bt_reg>;
+		enable-active-high;
+		gpio = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		regulator-name = "bt_reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "imx7-sgtl5000";
@@ -248,6 +260,15 @@
 	status = "okay";
 };
 
+&uart3  {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "peripheral";
 	status = "okay";
@@ -291,6 +312,12 @@
 		>;
 	};
 
+	pinctrl_bt_reg: btreggrp {
+		fsl,pins = <
+			MX7D_PAD_SD2_DATA3__GPIO5_IO17	0x14 /* BT_REG_ON */
+		>;
+	};
+
 	pinctrl_gpio: gpiogrp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_RGMII_RD1__GPIO7_IO1	0x14
@@ -335,6 +362,15 @@
 		>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__UART3_DCE_TX	0x79
+			MX7D_PAD_UART3_RX_DATA__UART3_DCE_RX	0x79
+			MX7D_PAD_UART3_CTS_B__UART3_DCE_CTS	0x79
+			MX7D_PAD_UART3_RTS_B__UART3_DCE_RTS	0x79
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
-- 
2.7.4
