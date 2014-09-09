From: tharvey@gateworks.com (Tim Harvey)
Date: Mon,  8 Sep 2014 23:07:30 -0700
Subject: [PATCH 5/6] ARM: dts: imx: ventana: cleanup pinctrl groups
In-Reply-To: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
References: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1410242851-30765-6-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the conventions for pinctrl:
 - grouping pinctrl in logical alphabatized groups
 - remove any pinctrl not being used by a driver or needed by user
 - move iomuxc to bottom of file for readability

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 157 +++++++++++++-----------
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 123 ++++++++++---------
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 210 ++++++++++++++++---------------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 224 +++++++++++++++++----------------
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 225 ++++++++++++++++++----------------
 5 files changed, 491 insertions(+), 448 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index eb28f63..822ffb2 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -38,6 +38,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		led0: user1 {
 			label = "user1";
@@ -65,6 +67,8 @@
 
 	pps {
 		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 		gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
@@ -337,27 +341,64 @@
 	};
 };
 
-&iomuxc {
+&ldb {
+	status = "okay";
+};
+
+&pcie {
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
+		compatible = "marvell,sky2";
+	};
+};
+
+&ssi1 {
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
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
 
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&iomuxc {
 	imx6q-gw5400-a {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x0001b0b0 /* OTG_PWR_EN */
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19    0x0001b0b0 /* SPINOR_CS0# */
-				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x0001b0b0 /* PCIE IRQ */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x0001b0b0 /* PCIE RST */
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000130b0 /* AUD4_MCK */
-				MX6QDL_PAD_GPIO_5__GPIO1_IO05     0x0001b0b0 /* GPS_PPS */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x0001b0b0 /* TOUCH_IRQ# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x0001b0b0 /* user1 led */
-				MX6QDL_PAD_KEY_COL2__GPIO4_IO10   0x0001b0b0 /* user2 led */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x0001b0b0 /* user3 led */
-				MX6QDL_PAD_SD1_DAT0__GPIO1_IO16   0x4001b0b0 /* USBHUB_RST# */
-				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21   0x4001b0b0 /* MIPI_DIO */
-			 >;
-		};
 
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
@@ -365,6 +406,7 @@
 				MX6QDL_PAD_SD2_DAT3__AUD4_TXC		0x130b0
 				MX6QDL_PAD_SD2_DAT2__AUD4_TXD		0x110b0
 				MX6QDL_PAD_SD2_DAT1__AUD4_TXFS		0x130b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0 /* AUD4_MCK */
 			>;
 		};
 
@@ -373,6 +415,7 @@
 				MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
 				MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x100b1
 				MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x100b1
+				MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x1b0b0 /* SPINOR_CS0# */
 			>;
 		};
 
@@ -397,6 +440,14 @@
 			>;
 		};
 
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0 /* user1 led */
+				MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0 /* user2 led */
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0 /* user3 led */
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
@@ -418,6 +469,19 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x1b0b0 /* PCIE IRQ */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0 /* PCIE RST */
+			>;
+		};
+
+		pinctrl_pps: ppsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_5__GPIO1_IO05		0x1b0b0 /* GPS_PPS */
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
@@ -442,6 +506,7 @@
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
 			>;
 		};
 
@@ -457,59 +522,3 @@
 		};
 	};
 };
-
-&ldb {
-	status = "okay";
-};
-
-&pcie {
-	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
-	};
-};
-
-&ssi1 {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	status = "okay";
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbh1 {
-	vbus-supply = <&reg_usb_h1_vbus>;
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	cd-gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_3p3v>;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 2853a10..f2867c4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -27,6 +27,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		led0: user1 {
 			label = "user1";
@@ -48,6 +50,8 @@
 
 	pps {
 		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
 		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
@@ -163,24 +167,51 @@
 	status = "okay";
 };
 
-&iomuxc {
+&pcie {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio1 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
 
-	imx6qdl-gw51xx {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_A19__GPIO2_IO19   0x4001b0b0 /* MEZZ_DIO0 */
-				MX6QDL_PAD_EIM_A20__GPIO2_IO18   0x4001b0b0 /* MEZZ_DIO1 */
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x0001b0b0 /* OTG_PWR_EN */
-				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x0001b0b0 /* GPS_PPS */
-				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x0001b0b0 /* PHY Reset */
-				MX6QDL_PAD_GPIO_0__GPIO1_IO00    0x0001b0b0 /* PCIE_RST# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x0001b0b0 /* user1 led */
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07  0x0001b0b0 /* user2 led */
-			 >;
-		};
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
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
 
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&iomuxc {
+	imx6qdl-gw51xx {
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
 				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
@@ -199,6 +230,14 @@
 				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
 				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
 				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0 /* PHY Reset */
+			>;
+		};
+
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
 			>;
 		};
 
@@ -244,6 +283,18 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
+			>;
+		};
+
+		pinctrl_pps: ppsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
@@ -275,48 +326,8 @@
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
 			>;
 		};
 	};
 };
-
-&pcie {
-	reset-gpio = <&gpio1 0 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	status = "okay";
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbh1 {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 26b1395..6d137b4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -36,6 +36,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		led0: user1 {
 			label = "user1";
@@ -63,6 +65,8 @@
 
 	pps {
 		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
 		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
@@ -233,39 +237,96 @@
 	};
 };
 
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
+&ldb {
+	status = "okay";
 
-	imx6qdl-gw52xx {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_A19__GPIO2_IO19   0x4001b0b0 /* MEZZ_DIO0 */
-				MX6QDL_PAD_EIM_A20__GPIO2_IO18   0x4001b0b0 /* MEZZ_DIO1 */
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x0001b0b0 /* OTG_PWR_EN */
-				MX6QDL_PAD_EIM_D31__GPIO3_IO31   0x0001b0b0 /* VIDDEC_PDN# */
-				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30 0x0001b0b0 /* PHY Reset */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x0001b0b0 /* PCIE_RST# */
-				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27 0x4001b0b0 /* GPS_PWDN */
-				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26 0x0001b0b0 /* GPS_PPS */
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1     0x000130b0 /* AUD4_MCK */
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02    0x4001b0b0 /* USB_SEL_PCI */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12   0x0001b0b0 /* TOUCH_IRQ# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x0001b0b0 /* user1 led */
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07  0x0001b0b0 /* user2 led */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15  0x0001b0b0 /* user3 led */
-				MX6QDL_PAD_SD2_CMD__GPIO1_IO11   0x0001b0b0 /* LVDS_TCH# */
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00  0x0001b0b0 /* SD3_CD# */
-				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11  0x4001b0b0 /* UART2_EN# */
-			 >;
+	lvds-channel at 0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+			};
 		};
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
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
 
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&iomuxc {
+	imx6qdl-gw52xx {
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
 				MX6QDL_PAD_SD2_DAT3__AUD4_TXC		0x130b0
 				MX6QDL_PAD_SD2_DAT2__AUD4_TXD		0x110b0
 				MX6QDL_PAD_SD2_DAT1__AUD4_TXFS		0x130b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x130b0 /* AUD4_MCK */
 			>;
 		};
 
@@ -287,6 +348,15 @@
 				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
 				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
 				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0 /* PHY Reset */
+			>;
+		};
+
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x1b0b0
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07  0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15  0x1b0b0
 			>;
 		};
 
@@ -332,6 +402,18 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0 /* PCIE_RST# */
+			>;
+		};
+
+		pinctrl_pps: ppsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
+			>;
+		};
+
 		pinctrl_pwm4: pwm4grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
@@ -362,6 +444,7 @@
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0 /* OTG_PWR_EN */
 			>;
 		};
 
@@ -373,85 +456,8 @@
 				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00	0x1b0b0 /* CD */
 			>;
 		};
 	};
 };
-
-&ldb {
-	status = "okay";
-
-	lvds-channel at 0 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-			};
-		};
-	};
-};
-
-&pcie {
-	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
-	status = "okay";
-};
-
-&ssi1 {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	status = "okay";
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbh1 {
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
-	vmmc-supply = <&reg_3p3v>;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index e6e298b..cade1bd 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -37,6 +37,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		led0: user1 {
 			label = "user1";
@@ -64,6 +66,8 @@
 
 	pps {
 		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
 		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
@@ -240,41 +244,101 @@
 	};
 };
 
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
+&ldb {
+	status = "okay";
 
-	imx6qdl-gw53xx {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_A19__GPIO2_IO19    0x4001b0b0 /* PCIE6EXP_DIO0 */
-				MX6QDL_PAD_EIM_A20__GPIO2_IO18    0x4001b0b0 /* PCIE6EXP_DIO1 */
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x0001b0b0 /* OTG_PWR_EN */
-				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27  0x4001b0b0 /* GPS_SHDN */
-				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26  0x0001b0b0 /* GPS_PPS */
-				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x0001b0b0 /* PCIE IRQ */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x0001b0b0 /* PCIE RST */
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000130b0 /* AUD4_MCK */
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02     0x4001b0b0 /* CAN_STBY */
-				MX6QDL_PAD_GPIO_8__GPIO1_IO08     0x0001b0b0 /* PMIC_IRQ# */
-				MX6QDL_PAD_GPIO_9__GPIO1_IO09     0x4001b0b0 /* HUB_RST# */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x4001b0b0 /* PCIE_WDIS# */
-				MX6QDL_PAD_GPIO_19__GPIO4_IO05    0x0001b0b0 /* ACCEL_IRQ# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x0001b0b0 /* user1 led */
-				MX6QDL_PAD_KEY_COL4__GPIO4_IO14   0x0001b0b0 /* USBOTG_OC# */
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x0001b0b0 /* user2 led */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x0001b0b0 /* user3 led */
-				MX6QDL_PAD_SD2_CMD__GPIO1_IO11    0x0001b0b0 /* TOUCH_IRQ# */
-				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00   0x0001b0b0 /* SD3_DET# */
-			 >;
+	lvds-channel at 1 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+			};
 		};
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
+		compatible = "marvell,sky2";
+	};
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
 
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
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&iomuxc {
+	imx6qdl-gw53xx {
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
 				MX6QDL_PAD_SD2_DAT3__AUD4_TXC		0x130b0
 				MX6QDL_PAD_SD2_DAT2__AUD4_TXD		0x110b0
 				MX6QDL_PAD_SD2_DAT1__AUD4_TXFS		0x130b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0 /* AUD4_MCK */
 			>;
 		};
 
@@ -303,6 +367,15 @@
 			fsl,pins = <
 				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
 				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x4001b0b0 /* CAN_STBY */
+			>;
+		};
+
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x1b0b0
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x1b0b0
 			>;
 		};
 
@@ -348,6 +421,19 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x1b0b0 /* PCIE IRQ */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x1b0b0 /* PCIE RST */
+			>;
+		};
+
+		pinctrl_pps: ppsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
+			>;
+		};
+
 		pinctrl_pwm4: pwm4grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
@@ -378,6 +464,8 @@
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* PWR_EN */
+				MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x1b0b0 /* OC */
 			>;
 		};
 
@@ -389,90 +477,8 @@
 				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0 /* CD */
 			>;
 		};
 	};
 };
-
-&ldb {
-	status = "okay";
-
-	lvds-channel at 1 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-			};
-		};
-	};
-};
-
-&pcie {
-	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
-	};
-};
-
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
-	status = "okay";
-};
-
-&ssi1 {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	status = "okay";
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbh1 {
-	vbus-supply = <&reg_usb_h1_vbus>;
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
-	vmmc-supply = <&reg_3p3v>;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index a366a93..cf13239 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -37,6 +37,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		led0: user1 {
 			label = "user1";
@@ -64,6 +66,8 @@
 
 	pps {
 		compatible = "pps-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pps>;
 		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		status = "okay";
 	};
@@ -329,35 +333,106 @@
 	};
 };
 
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
+&ldb {
+	status = "okay";
 
-	imx6qdl-gw54xx {
-		pinctrl_hog: hoggrp {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D22__GPIO3_IO22    0x0001b0b0 /* OTG_PWR_EN */
-				MX6QDL_PAD_EIM_D19__GPIO3_IO19    0x0001b0b0 /* SPINOR_CS0# */
-				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26  0x0001b0b0 /* GPS_PPS */
-				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x0001b0b0 /* PCIE IRQ */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x0001b0b0 /* PCIE RST */
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000130b0 /* AUD4_MCK */
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02     0x4001b0b0 /* CAN_STBY */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12    0x0001b0b0 /* TOUCH_IRQ# */
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x0001b0b0 /* user1 led */
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x0001b0b0 /* user2 led */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x0001b0b0 /* user3 led */
-				MX6QDL_PAD_SD1_DAT0__GPIO1_IO16   0x4001b0b0 /* USBHUB_RST# */
-				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21   0x4001b0b0 /* MIPI_DIO */
-			 >;
+	lvds-channel at 1 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <18>;
+		status = "okay";
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: hsd100pxn1 {
+				clock-frequency = <65000000>;
+				hactive = <1024>;
+				vactive = <768>;
+				hback-porch = <220>;
+				hfront-porch = <40>;
+				vback-porch = <21>;
+				vfront-porch = <7>;
+				hsync-len = <60>;
+				vsync-len = <10>;
+			};
 		};
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
+		compatible = "marvell,sky2";
+	};
+};
 
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&ssi2 {
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
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&iomuxc {
+	imx6qdl-gw54xx {
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x130b0
 				MX6QDL_PAD_SD2_DAT3__AUD4_TXC		0x130b0
 				MX6QDL_PAD_SD2_DAT2__AUD4_TXD		0x110b0
 				MX6QDL_PAD_SD2_DAT1__AUD4_TXFS		0x130b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0 /* AUD4_MCK */
 			>;
 		};
 
@@ -386,6 +461,15 @@
 			fsl,pins = <
 				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
 				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x4001b0b0 /* CAN_STBY */
+			>;
+		};
+
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
 			>;
 		};
 
@@ -431,6 +515,19 @@
 			>;
 		};
 
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x1b0b0 /* PCIE IRQ */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0 /* PCIE RST */
+			>;
+		};
+
+		pinctrl_pps: ppsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
+			>;
+		};
+
 		pinctrl_pwm4: pwm4grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
@@ -461,6 +558,7 @@
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+				MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* PWR_EN */
 			>;
 		};
 
@@ -476,90 +574,3 @@
 		};
 	};
 };
-
-&ldb {
-	status = "okay";
-
-	lvds-channel at 1 {
-		fsl,data-mapping = "spwg";
-		fsl,data-width = <18>;
-		status = "okay";
-
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
-			};
-		};
-	};
-};
-
-&pcie {
-	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
-	};
-};
-
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
-	status = "okay";
-};
-
-&ssi1 {
-	status = "okay";
-};
-
-&ssi2 {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	status = "okay";
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbh1 {
-	vbus-supply = <&reg_usb_h1_vbus>;
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	cd-gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
-	vmmc-supply = <&reg_3p3v>;
-	status = "okay";
-};
-- 
1.8.3.2
