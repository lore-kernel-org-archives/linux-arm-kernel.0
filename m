From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Wed, 24 Oct 2018 11:14:37 +0000
Subject: [PATCH V1 2/3] ARM: dts: imx6sx-sabreauto: Add flexcan support
In-Reply-To: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
References: <20181024111213.2724-1-qiangqing.zhang@nxp.com>
Message-ID: <20181024111213.2724-3-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The CAN transceiver on MX6SX Sabreauto board seems in sleep mode
by default after power up the board. User has to press the wakeup
key on ARD baseboard before using the transceiver, or it may not
work properly when power up the board at the first time(warm reset
does not have such issue).

This patch operates the wake pin too besides stby/en pins by chaining
them together in regulator mode.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 841a27f3198f..8f3319e7692f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -36,6 +36,35 @@
 		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	reg_can_wake: regulator-can-wake {
+		compatible = "regulator-fixed";
+		regulator-name = "can-wake";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&max7310_b 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can_en: regulator-can-en {
+		compatible = "regulator-fixed";
+		regulator-name = "can-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&max7310_b 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can_wake>;
+	};
+
+	reg_can_stby: regulator-can-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&max7310_b 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can_en>;
+	};
 };
 
 &anaclk2 {
@@ -75,6 +104,20 @@
 	status = "okay";
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can_stby>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -149,6 +192,20 @@
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6SX_PAD_QSPI1B_DQS__CAN1_TX   0x1b020
+			MX6SX_PAD_QSPI1A_SS1_B__CAN1_RX	0x1b020
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX6SX_PAD_QSPI1B_SS1_B__CAN2_RX 0x1b020
+			MX6SX_PAD_QSPI1A_DQS__CAN2_TX	0x1b020
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
-- 
2.17.1
