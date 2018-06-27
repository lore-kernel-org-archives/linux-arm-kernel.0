From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 27 Jun 2018 16:36:45 +0800
Subject: [PATCH] ARM: dts: imx6sll-evk: enable usdhc3 slot
Message-ID: <1530088605-9264-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6SLL EVK board, SD3 slot can be used for
WiFi and other SD accessories, enable it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 2217c40..9013f03 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -84,6 +84,17 @@
 		gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	reg_sd3_vmmc: regulator-sd3-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_sd3_vmmc>;
+		regulator-name = "SD3_WIFI";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio4 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &cpu0 {
@@ -218,6 +229,18 @@
 	status = "okay";
 };
 
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	vmmc-supply = <&reg_sd3_vmmc>;
+	status = "okay";
+};
+
 &usbotg1 {
 	vbus-supply = <&reg_usb_otg1_vbus>;
 	pinctrl-names = "default";
@@ -261,6 +284,12 @@
 		>;
 	};
 
+	pinctrl_reg_sd3_vmmc: sd3vmmcgrp {
+		fsl,pins = <
+			MX6SLL_PAD_KEY_COL6__GPIO4_IO04 0x17059
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SLL_PAD_UART1_TXD__UART1_DCE_TX 0x1b0b1
@@ -301,6 +330,42 @@
 		>;
 	};
 
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6SLL_PAD_SD3_CMD__SD3_CMD		0x17061
+			MX6SLL_PAD_SD3_CLK__SD3_CLK		0x13061
+			MX6SLL_PAD_SD3_DATA0__SD3_DATA0		0x17061
+			MX6SLL_PAD_SD3_DATA1__SD3_DATA1		0x17061
+			MX6SLL_PAD_SD3_DATA2__SD3_DATA2		0x17061
+			MX6SLL_PAD_SD3_DATA3__SD3_DATA3		0x17061
+			MX6SLL_PAD_REF_CLK_32K__GPIO3_IO22	0x17059
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+		fsl,pins = <
+			MX6SLL_PAD_SD3_CMD__SD3_CMD		0x170a1
+			MX6SLL_PAD_SD3_CLK__SD3_CLK		0x130a1
+			MX6SLL_PAD_SD3_DATA0__SD3_DATA0		0x170a1
+			MX6SLL_PAD_SD3_DATA1__SD3_DATA1		0x170a1
+			MX6SLL_PAD_SD3_DATA2__SD3_DATA2		0x170a1
+			MX6SLL_PAD_SD3_DATA3__SD3_DATA3		0x170a1
+			MX6SLL_PAD_REF_CLK_32K__GPIO3_IO22	0x17059
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+		fsl,pins = <
+			MX6SLL_PAD_SD3_CMD__SD3_CMD		0x170e9
+			MX6SLL_PAD_SD3_CLK__SD3_CLK		0x130f9
+			MX6SLL_PAD_SD3_DATA0__SD3_DATA0		0x170e9
+			MX6SLL_PAD_SD3_DATA1__SD3_DATA1		0x170e9
+			MX6SLL_PAD_SD3_DATA2__SD3_DATA2		0x170e9
+			MX6SLL_PAD_SD3_DATA3__SD3_DATA3		0x170e9
+			MX6SLL_PAD_REF_CLK_32K__GPIO3_IO22	0x17059
+		>;
+	};
+
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
 			MX6SLL_PAD_EPDC_PWR_COM__USB_OTG1_ID 0x17059
-- 
2.7.4
