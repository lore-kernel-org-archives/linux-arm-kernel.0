From: smoch@web.de (Soeren Moch)
Date: Mon, 27 Oct 2014 20:10:51 +0100
Subject: [PATCH v4 2/2] ARM: dts: add initial support for TBS2910 Matrix ARM
 mini PC
In-Reply-To: <1414437051-3666-1-git-send-email-smoch@web.de>
References: <1414437051-3666-1-git-send-email-smoch@web.de>
Message-ID: <1414437051-3666-3-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TBS2910 is a i.MX6Q based board. For additional details refer to
http://www.tbsdtv.com/products/tbs2910-matrix-arm-mini-pc.html

Signed-off-by: Soeren Moch <smoch@web.de>
Reviewed-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>

Changes in v2:
- add tbs vendor prefix to vendor-prefixes.txt
- use GPIO_ACTIVE_{HIGH,LOW}
- add led label and default-state="keep"
- whitespace cleanup

Changes in v3:
- split vendor prefix addition into separate patch
- dual-licensed: GPL or X11
- move iomuxc node to the bottom to improve readability
- remove snvs_poweroff node, not in mainline yet
- whitespace cleanup, hope I got it right now

Changes in v4:
- remove 'regulator-always-on' properties
- remove pinctrl hog_grp and add pins to associated peripheral nodes
- configure pad control settings for all used pins
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/imx6q-tbs2910.dts | 429 ++++++++++++++++++++++++++++++++++++
 2 files changed, 430 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-tbs2910.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..f6ad478 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -230,6 +230,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-sbc6x.dtb \
+	imx6q-tbs2910.dtb \
 	imx6q-udoo.dtb \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
new file mode 100644
index 0000000..d2a5743
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -0,0 +1,429 @@
+/*
+ * Copyright 2014 Soeren Moch <smoch@web.de>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "TBS2910 Matrix ARM mini PC";
+	compatible = "tbs,imx6q-tbs2910", "fsl,imx6q";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+
+	fan {
+		compatible = "gpio-fan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_fan>;
+		gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <0    0
+				      3000 1>;
+	};
+
+	ir_recv {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio3 18 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ir>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		blue {
+			label = "blue_status_led";
+			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_2p5v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+		};
+
+		reg_3p3v: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		reg_5p0v: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "5P0V";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
+	};
+
+	sound-sgtl5000 {
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "On-board Codec";
+		mux-ext-port = <3>;
+		mux-int-port = <1>;
+		ssi-controller = <&ssi1>;
+	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "On-board SPDIF";
+		spdif-controller = <&spdif>;
+		spdif-out;
+	};
+};
+
+&audmux {
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	sgtl5000: sgtl5000 at 0a {
+		clocks = <&clks 201>;
+		compatible = "fsl,sgtl5000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sgtl5000>;
+		reg = <0x0a>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	rtc: ds1307 at 68 {
+		compatible = "dallas,ds1307";
+		reg = <0x68>;
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif>;
+	status = "okay";
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_5p0v>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_5p0v>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 0 GPIO_ACTIVE_HIGH>;
+	wp-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	status = "okay";
+};
+
+&iomuxc {
+	imx6q-tbs2910 {
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
+				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25    0x1b059
+			>;
+		};
+
+		pinctrl_hdmi: hdmigrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL        0x4001b8b1
+				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA        0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL         0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA         0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_3__I2C3_SCL           0x4001b8b1
+				MX6QDL_PAD_GPIO_6__I2C3_SDA           0x4001b8b1
+			>;
+		};
+
+		pinctrl_ir: irgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D18__GPIO3_IO18        0x17059
+			>;
+		};
+
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12        0x17059
+			>;
+		};
+
+		pinctrl_sgtl5000: sgtl5000grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD        0x130b0
+				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC        0x130b0
+				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD        0x110b0
+				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS       0x130b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1          0x130b0
+			>;
+		};
+
+		pinctrl_spdif: spdifgrp {
+			fsl,pins = <MX6QDL_PAD_GPIO_19__SPDIF_OUT     0x13091
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA  0x1b0b1
+				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA  0x1b0b1
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D26__UART2_TX_DATA     0x1b0b1
+				MX6QDL_PAD_EIM_D27__UART2_RX_DATA     0x1b0b1
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID     0x17059
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD           0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK           0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0        0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1        0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2        0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3        0x17059
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02       0x17059
+			>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD           0x17059
+				MX6QDL_PAD_SD3_CLK__SD3_CLK           0x10059
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0        0x17059
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1        0x17059
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2        0x17059
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3        0x17059
+				MX6QDL_PAD_NANDF_D0__GPIO2_IO00       0x17059
+				MX6QDL_PAD_NANDF_D1__GPIO2_IO01       0x17059
+			>;
+		};
+
+		pinctrl_usdhc4: usdhc4grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_CMD__SD4_CMD           0x17059
+				MX6QDL_PAD_SD4_CLK__SD4_CLK           0x10059
+				MX6QDL_PAD_SD4_DAT0__SD4_DATA0        0x17059
+				MX6QDL_PAD_SD4_DAT1__SD4_DATA1        0x17059
+				MX6QDL_PAD_SD4_DAT2__SD4_DATA2        0x17059
+				MX6QDL_PAD_SD4_DAT3__SD4_DATA3        0x17059
+				MX6QDL_PAD_SD4_DAT4__SD4_DATA4        0x17059
+				MX6QDL_PAD_SD4_DAT5__SD4_DATA5        0x17059
+				MX6QDL_PAD_SD4_DAT6__SD4_DATA6        0x17059
+				MX6QDL_PAD_SD4_DAT7__SD4_DATA7        0x17059
+			>;
+		};
+	};
+
+	gpio_fan {
+		pinctrl_gpio_fan: gpiofangrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D28__GPIO3_IO28        0x130b1
+			>;
+		};
+	};
+
+	gpio_leds {
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02         0x130b1
+			>;
+		};
+	};
+};
-- 
1.9.1
