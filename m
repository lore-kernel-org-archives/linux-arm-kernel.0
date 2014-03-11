From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 11 Mar 2014 15:24:07 -0300
Subject: [PATCH 2/2] ARM: dts: imx25-pdk: Add audio support
In-Reply-To: <1394562247-14898-1-git-send-email-fabio.estevam@freescale.com>
References: <1394562247-14898-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1394562247-14898-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx25pdk has a sgtl5000 codec connected to the I2C1 port.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 76 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 7a6d21f..ca3fea5 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -34,9 +34,48 @@
 			gpio = <&gpio2 3 0>;
 			enable-active-high;
 		};
+
+		reg_2p5v: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "2P5V";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+			regulator-always-on;
+		};
+
+		reg_3p3v: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+	};
+
+	sound {
+		compatible = "fsl,imx25-pdk-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx25-pdk-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <4>;
 	};
 };
 
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
@@ -54,8 +93,32 @@
 	status = "okay";
 };
 
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks 129>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
+
 &iomuxc {
 	imx25-pdk {
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <
+				MX25_PAD_RW__AUD4_TXFS			0xe0
+				MX25_PAD_OE__AUD4_TXC			0xe0
+				MX25_PAD_EB0__AUD4_TXD			0xe0
+				MX25_PAD_EB1__AUD4_RXD			0xe0
+			>;
+		};
+
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
 				MX25_PAD_SD1_CMD__SD1_CMD		0x80000000
@@ -85,6 +148,13 @@
 			>;
 		};
 
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX25_PAD_I2C1_CLK__I2C1_CLK		0x80000000
+				MX25_PAD_I2C1_DAT__I2C1_DAT		0x80000000
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX25_PAD_UART1_RTS__UART1_RTS		0xe0
@@ -101,6 +171,12 @@
 	status = "okay";
 };
 
+&ssi1 {
+	codec-handle = <&codec>;
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
1.8.1.2
