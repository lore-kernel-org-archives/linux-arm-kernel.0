From: gcembed@gmail.com (=?UTF-8?Q?Ga=c3=abtan_Carlier?=)
Date: Thu, 18 Jan 2018 10:26:32 +0100
Subject: [PATCH] ARM: dts: mxs: add imx28 DNET01 board
Message-ID: <325f427c-352b-e3d0-fa2f-3055f02d8c3f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The patch adds support of imx28 DNET01 board

Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
---
 arch/arm/boot/dts/imx28-dnet01.dts | 184 +++++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-dnet01.dts

diff --git a/arch/arm/boot/dts/imx28-dnet01.dts b/arch/arm/boot/dts/imx28-dnet01.dts
new file mode 100644
index 0000000..c502ca7
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-dnet01.dts
@@ -0,0 +1,184 @@
+/*
+ * Copyright (C) 2018 Gaetan Carlier <gcembed@gmail.com>
+ *
+ * based on imx28-m28evk.dts
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx28.dtsi"
+
+/ {
+	model = "Domintell DNET01";
+	compatible = "domintell,dnet01", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+
+			dcp: dcp at 80028000 {
+				/*
+				 * Driver is not fully implemented.
+				 * [PATCH] crypto: mxs-dcp - Initialize .statesize fields
+				 * https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg17078.html
+				 */
+				status = "disable";
+			};
+
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_8bit_pins_a
+					     &mmc0_sck_cfg>;
+				bus-width = <8>;
+				vmmc-supply = <&reg_3p3v>;
+				broken-cd;
+				disable-wp;
+				cap-mmc-highspeed;
+				non-removable;
+				status = "okay";
+			};
+
+			ssp2: ssp at 80014000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "disable";
+			};
+		};
+
+		apbx at 80040000 {
+			mxs_rtc: rtc at 80056000 {
+				/*
+				 * Overrides default state from imx28.dtsi
+				 * Internal RTC must be disable as a high
+				 * precision I2C is connected.
+				 */
+				status = "disabled";
+			};
+
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+
+				eeprom: eeprom at 57 {
+					compatible = "atmel,24c01";
+					reg = <0x57>;
+					pagesize = <8>;
+					readonly = <1>;
+				};
+
+				mcp7941x_rtc: rtc at 6f {
+					compatible = "dallas,mcp7941x";
+					reg = <0x6f>;
+					ds_type = "mcp7941x";
+				};
+			};
+
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+
+			auart4: serial at 80072000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart4_2pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>;
+			phy-supply = <&reg_3p3v>;
+			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-duration = <100>;
+			status = "okay";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3p3v: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		stm32rdyrx {
+			/* Used to indicate that i.MX is ready to receive data from STM32 */
+			label = "stm32rdyrx";
+			gpios = <&gpio2 27 0>;
+			linux,default-trigger = "none";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		stm32err {
+			/* SPI_ERR : Used by STM32 that RS485 bus is busy or if sending of data has failed */
+			label = "STM32 error-busy";
+			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
+			/* KEY_F23 0xC1 = 193 */
+			linux,code = <193>;
+			debounce-interval = <0>;
+		};
+	};
+};
+
+&pinctrl {
+	pinctrl_gpio: gpiokeygrp {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_RDN__GPIO_0_24
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_ENABLE>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_CE0N__GPIO_0_16
+			MX28_PAD_SSP3_SS0__GPIO_2_27
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+       };
+};
-- 
2.1.4
