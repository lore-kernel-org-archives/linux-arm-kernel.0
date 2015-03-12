From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 12 Mar 2015 19:07:12 -0300
Subject: [PATCH] ARM: dts: imx6sl-warp: Add BCM4330 support
Message-ID: <1426198032-21072-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Warp has a Murata chip based on a BCM4330 that provides Wifi and Bluetooth 
functionality.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-warp.dts | 71 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 8adc843..64f7dec 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -47,6 +47,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "imx6sl.dtsi"
 
 / {
@@ -90,6 +91,14 @@
 			regulator-max-microvolt = <1800000>;
 		};
 	};
+
+	usdhc3_pwrseq: usdhc3_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>, 	/* WL_REG_ON */
+			      <&gpio3 25 GPIO_ACTIVE_LOW>, 	/* BT_REG_ON */
+			      <&gpio4 4 GPIO_ACTIVE_LOW>, 	/* BT_WAKE */
+			      <&gpio4 6 GPIO_ACTIVE_LOW>; 	/* BT_RST_N */
+	};
 };
 
 &uart1 {
@@ -98,6 +107,13 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
@@ -127,6 +143,19 @@
 	status = "okay";
 };
 
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <4>;
+	non-removable;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	status = "okay";
+};
+
 &iomuxc {
 	imx6sl-warp {
 		pinctrl_uart1: uart1grp {
@@ -136,6 +165,15 @@
 			>;
 		};
 
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX6SL_PAD_EPDC_D12__UART2_RX_DATA	0x41b0b1
+				MX6SL_PAD_EPDC_D13__UART2_TX_DATA	0x41b0b1
+				MX6SL_PAD_EPDC_D14__UART2_RTS_B		0x4130B1
+				MX6SL_PAD_EPDC_D15__UART2_CTS_B		0x4130B1
+			>;
+		};
+
 		pinctrl_uart3: uart3grp {
 			fsl,pins = <
 				MX6SL_PAD_AUD_RXC__UART3_RX_DATA	0x41b0b1
@@ -187,5 +225,38 @@
 				MX6SL_PAD_SD2_DAT7__SD2_DATA7		0x4170f9
 			>;
 		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6SL_PAD_SD3_CMD__SD3_CMD		0x417059
+				MX6SL_PAD_SD3_CLK__SD3_CLK		0x410059
+				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x417059
+				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x417059
+				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x417059
+				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x417059
+			>;
+		};
+
+		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+			fsl,pins = <
+				MX6SL_PAD_SD3_CMD__SD3_CMD		0x4170b9
+				MX6SL_PAD_SD3_CLK__SD3_CLK		0x4100b9
+				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x4170b9
+				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x4170b9
+				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x4170b9
+				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x4170b9
+			>;
+		};
+
+		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+			fsl,pins = <
+				MX6SL_PAD_SD3_CMD__SD3_CMD		0x4170f9
+				MX6SL_PAD_SD3_CLK__SD3_CLK		0x4100f9
+				MX6SL_PAD_SD3_DAT0__SD3_DATA0		0x4170f9
+				MX6SL_PAD_SD3_DAT1__SD3_DATA1		0x4170f9
+				MX6SL_PAD_SD3_DAT2__SD3_DATA2		0x4170f9
+				MX6SL_PAD_SD3_DAT3__SD3_DATA3		0x4170f9
+			>;
+		};
 	};
 };
-- 
1.9.1
