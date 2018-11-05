From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Mon, 5 Nov 2018 11:43:42 +0100
Subject: [PATCH v2] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless
 SOM variant
In-Reply-To: <1541414622-18795-1-git-send-email-alex.gonzalez@digi.com>
References: <1541414622-18795-1-git-send-email-alex.gonzalez@digi.com>
Message-ID: <1541414622-18795-2-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wireless variants of the ConnecCore 6UL SOM include a Qualcomm
QCA6564 wireless chip with dual WiFi and Bluetooth.

Both the ConnectCore 6UL SBC Express and Pro boards fit a wireless SOM.

The Wifi is connected through the SDIO interface on usdhc1 and the
Bluetooth is connected via uart1.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
index c71a84da1af0..ef26b2389c8f 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
@@ -161,6 +161,25 @@
 	};
 };
 
+/* UART1 (Bluetooth) */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* USDHC1 (Wireless) */
+&usdhc1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_wifibt_ctrl>;
+	pinctrl-1 = <&pinctrl_usdhc1_sleep &pinctrl_wifibt_ctrl_sleep>;
+	non-removable;
+	no-1-8-v;
+	bus-width = <4>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_gpmi_nand: gpmigrp {
 		fsl,pins = <
@@ -188,6 +207,51 @@
 			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
 			>;
 		};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX   0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX   0x1b0b1
+			MX6UL_PAD_UART1_RTS_B__UART1_DCE_RTS    0x1b0b1
+			MX6UL_PAD_UART1_CTS_B__UART1_DCE_CTS    0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD           0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK           0x17051
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0       0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1       0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2       0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3       0x17059
+		>;
+	};
+
+	pinctrl_usdhc1_sleep: usdhc1grp-sleep {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__GPIO2_IO16           0x3000
+			MX6UL_PAD_SD1_CLK__GPIO2_IO17           0x3000
+			MX6UL_PAD_SD1_DATA0__GPIO2_IO18         0x3000
+			MX6UL_PAD_SD1_DATA1__GPIO2_IO19         0x3000
+			MX6UL_PAD_SD1_DATA2__GPIO2_IO20         0x3000
+			MX6UL_PAD_SD1_DATA3__GPIO2_IO21         0x3000
+		>;
+	};
+
+	pinctrl_wifibt_ctrl: wifibt-ctrl-grp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x08a0
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x08a0
+		>;
+	};
+
+	pinctrl_wifibt_ctrl_sleep: wifibt-ctrl-grp-sleep {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x3000
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x3000
+		>;
+	};
 };
 
 &reg_arm {
