From: ping.bai@nxp.com (Bai Ping)
Date: Thu,  8 Mar 2018 18:03:44 +0800
Subject: [PATCH v4 2/2] ARM: dts: imx: Add basic dts support for imx6sll EVK
 board
In-Reply-To: <1520503424-22985-1-git-send-email-ping.bai@nxp.com>
References: <1520503424-22985-1-git-send-email-ping.bai@nxp.com>
Message-ID: <1520503424-22985-2-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dts file support for imx6sll EVK board.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 change v3->v4
 - update the license indentifier
 - remove leading zero of node
 - remove unused pin from hog group
---
 Documentation/devicetree/bindings/arm/fsl.txt |   4 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/imx6sll-evk.dts             | 372 ++++++++++++++++++++++++++
 3 files changed, 378 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sll-evk.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index cdb9dd7..8a1baa2 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -53,6 +53,10 @@ i.MX6 Quad SABRE Automotive Board
 Required root node properties:
     - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
 
+i.MX6SLL EVK board
+Required root node properties:
+    - compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
+
 Generic i.MX boards
 -------------------
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38..28bff8b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -505,6 +505,8 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
 	imx6sl-warp.dtb
+dtb-$(CONFIG_SOC_IMX6SLL) += \
+	imx6sll-evk.dtb
 dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-nitrogen6sx.dtb \
 	imx6sx-sabreauto.dtb \
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
new file mode 100644
index 0000000..892fbec
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -0,0 +1,372 @@
+//SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "imx6sll.dtsi"
+
+/ {
+	model = "Freescale i.MX6SLL EVK Board";
+	compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
+
+	memory at 80000000 {
+		reg = <0x80000000 0x80000000>;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	reg_usb_otg1_vbus: reg-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb_otg2_vbus: reg-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_aud3v: reg-aud3v {
+		compatible = "regulator-fixed";
+		regulator-name = "wm8962-supply-3v15";
+		regulator-min-microvolt = <3150000>;
+		regulator-max-microvolt = <3150000>;
+		regulator-boot-on;
+	};
+
+	reg_aud4v: reg-aud4v {
+		compatible = "regulator-fixed";
+		regulator-name = "wm8962-supply-4v2";
+		regulator-min-microvolt = <4325000>;
+		regulator-max-microvolt = <4325000>;
+		regulator-boot-on;
+	};
+
+	reg_lcd: reg-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-pwr";
+		gpio = <&gpio4 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_sd1_vmmc: reg-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "SD1_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&cpu0 {
+	arm-supply = <&sw1a_reg>;
+	soc-supply = <&sw1c_reg>;
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: pfuze100 at 8 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog0>, <&pinctrl_hog1>;
+
+	pinctrl_hog0: hog0grp {
+		pinmux = <
+			MX6SLL_PAD_KEY_ROW7__GPIO4_IO07
+			MX6SLL_PAD_GPIO4_IO22__GPIO4_IO22
+			MX6SLL_PAD_KEY_COL3__GPIO3_IO30
+			MX6SLL_PAD_KEY_COL4__GPIO4_IO00
+			MX6SLL_PAD_KEY_COL5__GPIO4_IO02
+		>;
+		slew-rate = <0x1>;
+		drive-strength = <0x3>;
+		fsl,pin-speed = <0x1>;
+		bias-pull-up = <0x1>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_hog1: hog1grp {
+		pinmux = <
+			/*
+			 * Must set the LVE of pad SD2_RESET, otherwise current
+			 * leakage through eMMC chip will pull high the VCCQ to
+			 * 2.6v, which will impact SD1 and SD3 SD3.0 voltage switch.
+			 */
+			MX6SLL_PAD_SD2_RESET__GPIO4_IO27
+		>;
+		slew-rate = <0x1>;
+		drive-strength = <0x3>;
+		fsl,pin-speed = <0x1>;
+		bias-pull-up = <0x1>;
+		input-schmitt-enable;
+		fsl,low-voltage-enable = <0x1>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		pinmux = <
+			MX6SLL_PAD_UART1_TXD__UART1_DCE_TX
+			MX6SLL_PAD_UART1_RXD__UART1_DCE_RX
+		>;
+		slew-rate = <0x1>;
+		drive-strength = <0x6>;
+		fsl,pin-speed = <0x2>;
+		bias-pull-up = <0x2>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_usdhc1_data: usdhc1datagrp {
+		pinmux = <
+			MX6SLL_PAD_SD1_CMD__SD1_CMD
+			MX6SLL_PAD_SD1_DATA0__SD1_DATA0
+			MX6SLL_PAD_SD1_DATA1__SD1_DATA1
+			MX6SLL_PAD_SD1_DATA2__SD1_DATA2
+			MX6SLL_PAD_SD1_DATA3__SD1_DATA3
+		>;
+		slew-rate = <0x1>;
+		drive-strength = <0x4>;
+		fsl,pin-speed = <0x1>;
+		bias-pull-up = <0x1>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_usdhc1_clk: usdhc1clkgrp {
+		pinmux = <MX6SLL_PAD_SD1_CLK__SD1_CLK>;
+		slew-rate = <0x1>;
+		drive-strength = <0x4>;
+		fsl,pin-speed = <0x1>;
+		bias-pull-down = <0x0>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_usdhc1_data_100mhz: usdhc1datagrp_100mhz {
+		pinmux = <
+			MX6SLL_PAD_SD1_CMD__SD1_CMD
+			MX6SLL_PAD_SD1_DATA0__SD1_DATA0
+			MX6SLL_PAD_SD1_DATA1__SD1_DATA1
+			MX6SLL_PAD_SD1_DATA2__SD1_DATA2
+			MX6SLL_PAD_SD1_DATA3__SD1_DATA3
+		>;
+		slew-rate = <0x1>;
+		drive-strength = <0x4>;
+		fsl,pin-speed = <0x2>;
+		bias-pull-up = <0x1>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_usdhc1_clk_100mhz: usdhc1clkgrp_100mhz {
+		pinmux = < MX6SLL_PAD_SD1_CLK__SD1_CLK>;
+		slew-rate = <0x1>;
+		drive-strength = <0x4>;
+		fsl,pin-speed = <0x2>;
+		bias-pull-down = <0x0>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_usdhc1_data_200mhz: usdhc1datagrp_200mhz {
+		pinmux = <
+			MX6SLL_PAD_SD1_CMD__SD1_CMD
+			MX6SLL_PAD_SD1_DATA0__SD1_DATA0
+			MX6SLL_PAD_SD1_DATA1__SD1_DATA1
+			MX6SLL_PAD_SD1_DATA2__SD1_DATA2
+			MX6SLL_PAD_SD1_DATA3__SD1_DATA3
+		>;
+		slew-rate = <0x1>;
+		drive-strength = <0x5>;
+		fsl,pin-speed = <0x3>;
+		bias-pull-up = <0x1>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_usdhc1_clk_200mhz: usdhc1clkgrp_200mhz {
+		pinmux = <MX6SLL_PAD_SD1_CLK__SD1_CLK>;
+		slew-rate = <0x1>;
+		drive-strength = <0x7>;
+		fsl,pin-speed = <0x3>;
+		bias-pull-down = <0x0>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		pinmux = <MX6SLL_PAD_EPDC_PWR_COM__USB_OTG1_ID>;
+		slew-rate = <0x1>;
+		drive-strength = <0x3>;
+		fsl,pin-speed = <0x1>;
+		bias-pull-up = <0x1>;
+		input-schmitt-enable;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		pinmux = <
+			MX6SLL_PAD_I2C1_SCL__I2C1_SCL
+			MX6SLL_PAD_I2C1_SDA__I2C1_SDA
+		>;
+		slew-rate = <0x1>;
+		drive-strength = <0x6>;
+		fsl,pin-speed = <0x2>;
+		drive-open-drain;
+		bias-pull-up = <0x2>;
+		input-schmitt-enable;
+		input-enable;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1_data>, <&pinctrl_usdhc1_clk>;
+	pinctrl-1 = <&pinctrl_usdhc1_data_100mhz>, <&pinctrl_usdhc1_clk_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_data_200mhz>, <&pinctrl_usdhc1_clk_200mhz>;
+	cd-gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+	keep-power-in-suspend;
+	wakeup-source;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
-- 
1.9.1
