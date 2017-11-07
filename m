From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Tue, 7 Nov 2017 16:31:23 -0200
Subject: [PATCH] ARM: dts: imx7d-pico-pi: Separate into cpu and baseboard dts
Message-ID: <1510079483-24012-1-git-send-email-vanessa.maegima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Separate the old imx7d-pico into cpu (imx7d-pico.dtsi) and baseboard
(imx7d-pico-pi.dts) dts so the same cpu dtsi can be used in different
baseboards variants.

Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
---
 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/imx7d-pico-pi.dts                | 171 +++++++++++++++++++++
 .../boot/dts/{imx7d-pico.dts => imx7d-pico.dtsi}   | 124 ---------------
 3 files changed, 172 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7d-pico-pi.dts
 rename arch/arm/boot/dts/{imx7d-pico.dts => imx7d-pico.dtsi} (71%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index eff87a3..b2b5bc8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -488,7 +488,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-eval-v3.dtb \
 	imx7d-nitrogen7.dtb \
-	imx7d-pico.dtb \
+	imx7d-pico-pi.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
 	imx7d-sdb-sht11.dtb \
diff --git a/arch/arm/boot/dts/imx7d-pico-pi.dts b/arch/arm/boot/dts/imx7d-pico-pi.dts
new file mode 100644
index 0000000..38ccbbb3f
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-pico-pi.dts
@@ -0,0 +1,171 @@
+/*
+ * Copyright 2017 NXP
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "imx7d-pico.dtsi"
+
+/ {
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx7-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		};
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
+			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+	assigned-clock-rates = <0>, <100000000>;
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	codec: sgtl5000 at 0a {
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		compatible = "fsl,sgtl5000";
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_vref_1v8>;
+	};
+};
+
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
+			  <&clks IMX7D_SAI1_ROOT_CLK>;
+	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
+	assigned-clock-rates = <0>, <24576000>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
+			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
+			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
+			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
+			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
+			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
+			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX7D_PAD_UART1_TX_DATA__I2C1_SDA	0x4000007f
+			MX7D_PAD_UART1_RX_DATA__I2C1_SCL	0x4000007f
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
+			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
+		>;
+	};
+
+	pinctrl_usbotg1_pwr: usbotg_pwr {
+		fsl,pins = <
+			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx7d-pico.dts b/arch/arm/boot/dts/imx7d-pico.dtsi
similarity index 71%
rename from arch/arm/boot/dts/imx7d-pico.dts
rename to arch/arm/boot/dts/imx7d-pico.dtsi
index e78c2c9..12d1dc6 100644
--- a/arch/arm/boot/dts/imx7d-pico.dts
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -89,62 +89,6 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
-
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "imx7-sgtl5000";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&dailink_master>;
-		simple-audio-card,frame-master = <&dailink_master>;
-		simple-audio-card,cpu {
-			sound-dai = <&sai1>;
-		};
-
-		dailink_master: simple-audio-card,codec {
-			sound-dai = <&codec>;
-			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
-		};
-	};
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1>;
-	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
-			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
-	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
-	assigned-clock-rates = <0>, <100000000>;
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy at 1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			status = "okay";
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	codec: sgtl5000 at 0a {
-		#sound-dai-cells = <0>;
-		reg = <0x0a>;
-		compatible = "fsl,sgtl5000";
-		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
-		VDDA-supply = <&reg_2p5v>;
-		VDDIO-supply = <&reg_vref_1v8>;
-	};
 };
 
 &i2c4 {
@@ -242,35 +186,6 @@
 	};
 };
 
-&sai1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sai1>;
-	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
-			  <&clks IMX7D_SAI1_ROOT_CLK>;
-	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
-	assigned-clock-rates = <0>, <24576000>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
-	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
-	status = "okay";
-};
-
-&usbotg1 {
-	vbus-supply = <&reg_usb_otg1_vbus>;
-	status = "okay";
-};
-
-&usbotg2 {
-	vbus-supply = <&reg_usb_otg2_vbus>;
-	dr_mode = "host";
-	status = "okay";
-};
-
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -293,32 +208,6 @@
 };
 
 &iomuxc {
-	pinctrl_enet1: enet1grp {
-		fsl,pins = <
-			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
-			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
-			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
-			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
-			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
-			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
-			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
-			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
-			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
-			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
-			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
-			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
-			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
-			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX7D_PAD_UART1_TX_DATA__I2C1_SDA	0x4000007f
-			MX7D_PAD_UART1_RX_DATA__I2C1_SCL	0x4000007f
-		>;
-	};
-
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
@@ -335,19 +224,6 @@
 		>;
 	};
 
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
-			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
-		>;
-	};
-
-	pinctrl_usbotg1_pwr: usbotg_pwr {
-		fsl,pins = <
-			MX7D_PAD_UART3_TX_DATA__GPIO4_IO5	0x14
-		>;
-	};
-
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
-- 
2.7.4
