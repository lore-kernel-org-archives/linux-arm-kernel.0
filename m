From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Mon, 22 Aug 2016 15:58:28 -0300
Subject: [PATCH v2] ARM: dts: imx7s-warp: Add Bluetooth support
Message-ID: <1471892308-20409-1-git-send-email-vanessa.maegima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WaRP7 has a BCM43430 Bluetooth chip.

Add support for it.

Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
---
Changes since v1:
- Change the regulator name
- Use 'uart-has-rtscts' property

 arch/arm/boot/dts/imx7s-warp.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 92d9c85..9fe6336 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -66,6 +66,16 @@
 		startup-delay-us = <200000>;
 	};
 
+	reg_bt: regulator-bt {
+		compatible = "regulator-fixed";
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
@@ -228,6 +238,15 @@
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
@@ -302,6 +321,16 @@
 		>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__UART3_DCE_TX 0x79
+			MX7D_PAD_UART3_RX_DATA__UART3_DCE_RX 0x79
+			MX7D_PAD_UART3_CTS_B__UART3_DCE_CTS 0x79
+			MX7D_PAD_UART3_RTS_B__UART3_DCE_RTS 0x79
+			MX7D_PAD_SD2_DATA3__GPIO5_IO17 0x14 /*BT_REG_ON*/
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
-- 
2.7.4
