From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Thu, 17 Aug 2017 15:25:20 -0300
Subject: [PATCH] ARM: dts: imx7d-pico: Add Wifi support
Message-ID: <1502994320-27614-1-git-send-email-vanessa.maegima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx7d-pico has an ap6212 wifi chip connected to usdhc2 port.

Add support for the usdhc2 port and to the WL_REG_ON regulator
so Wifi can be functional on this board.

Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
---
 arch/arm/boot/dts/imx7d-pico.dts | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dts b/arch/arm/boot/dts/imx7d-pico.dts
index e78c2c9..db9f345 100644
--- a/arch/arm/boot/dts/imx7d-pico.dts
+++ b/arch/arm/boot/dts/imx7d-pico.dts
@@ -52,6 +52,17 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	reg_ap6212: regulator-ap6212 {
+			compatible = "regulator-fixed";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_reg_ap6212>;
+			regulator-name = "AP6212";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+	};
+
 	reg_2p5v: regulator-2p5v {
 		compatible = "regulator-fixed";
 		regulator-name = "2P5V";
@@ -271,6 +282,17 @@
 	status = "okay";
 };
 
+&usdhc2 { /* Wifi SDIO */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	no-1-8-v;
+	non-removable;
+	keep-power-in-suspend;
+	wakeup-source;
+	vmmc-supply = <&reg_ap6212>;
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -326,6 +348,13 @@
 		>;
 	};
 
+	pinctrl_reg_ap6212: regap6212grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
+			MX7D_PAD_ECSPI1_SS0__GPIO4_IO19		0x59 /* WL_HOST_WAKE */
+		>;
+	};
+
 	pinctrl_sai1: sai1grp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK	0x1f
@@ -348,6 +377,17 @@
 		>;
 	};
 
+	pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX7D_PAD_SD2_CMD__SD2_CMD	0x59
+				MX7D_PAD_SD2_CLK__SD2_CLK	0x19
+				MX7D_PAD_SD2_DATA0__SD2_DATA0	0x59
+				MX7D_PAD_SD2_DATA1__SD2_DATA1	0x59
+				MX7D_PAD_SD2_DATA2__SD2_DATA2	0x59
+				MX7D_PAD_SD2_DATA3__SD2_DATA3	0x59
+			>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
-- 
2.7.4
