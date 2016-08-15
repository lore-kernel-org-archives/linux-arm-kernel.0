From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Aug 2016 13:47:33 -0300
Subject: [PATCH 2/3] ARM: dts: imx7s-warp: Add Wifi support
In-Reply-To: <1471279654-16711-1-git-send-email-festevam@gmail.com>
References: <1471279654-16711-1-git-send-email-festevam@gmail.com>
Message-ID: <1471279654-16711-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Warp7 has a BCM43430 Wifi chip connected to the USDHC1 port.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index b9b45b1..cf730c1 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -54,6 +54,18 @@
 		reg = <0x80000000 0x20000000>;
 	};
 
+	reg_brcm: regulator-brcm {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_brcm_reg>;
+		regulator-name = "brcm_reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <200000>;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "imx7-sgtl5000";
@@ -221,6 +233,17 @@
 	status = "okay";
 };
 
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	bus-width = <4>;
+	keep-power-in-suspend;
+	no-1-8-v;
+	non-removable;
+	vmmc-supply = <&reg_brcm>;
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -235,6 +258,12 @@
 };
 
 &iomuxc {
+	pinctrl_brcm_reg: brcmreggrp {
+		fsl,pins = <
+			MX7D_PAD_SD2_WP__GPIO5_IO10	0x14 /* WL_REG_ON */
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -266,6 +295,18 @@
 		>;
 	};
 
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK	0x19
+			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x59
+			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x59
+			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x59
+			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x59
+			MX7D_PAD_SD2_RESET_B__GPIO5_IO11 0x14 /* WL_HOST_WAKE */
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
-- 
2.7.4
