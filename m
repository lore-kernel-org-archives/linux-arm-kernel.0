From: mhei@heimpold.de (Michael Heimpold)
Date: Sat, 22 Oct 2016 21:22:30 +0200
Subject: [PATCH 7/7] ARM: dts: add support for Duckbill 2 series devices
In-Reply-To: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
Message-ID: <1477164150-13553-8-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/Makefile                     |   4 +
 arch/arm/boot/dts/imx28-duckbill-2-485.dts     |  70 +++++++++++++++++
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts | 100 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts     |  63 ++++++++++++++++
 arch/arm/boot/dts/imx28-duckbill-2.dts         |  46 ++++++++++++
 5 files changed, 283 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-485.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-spi.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5a366c4..510e6f3 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -459,6 +459,10 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-cfa10056.dtb \
 	imx28-cfa10057.dtb \
 	imx28-cfa10058.dtb \
+	imx28-duckbill-2-485.dtb \
+	imx28-duckbill-2.dtb \
+	imx28-duckbill-2-enocean.dtb \
+	imx28-duckbill-2-spi.dtb \
 	imx28-duckbill-485.dtb \
 	imx28-duckbill.dtb \
 	imx28-duckbill-enocean.dtb \
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-485.dts b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
new file mode 100644
index 0000000..6c7429d
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-2-485.dts
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2015-2016 I2SE GmbH <info@i2se.com>
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
+#include <dt-bindings/gpio/gpio.h>
+#include "imx28-duckbill-2-common.dtsi"
+
+/ {
+	model = "I2SE Duckbill 2 485";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc2_4bit_pins_b
+					&mmc2_cd_cfg &mmc2_sck_cfg_b>;
+				bus-width = <4>;
+				vmmc-supply = <&reg_3p3v>;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+				rs485_led_pins: rs485_led_pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_I2C0_SCL__GPIO_3_24
+						MX28_PAD_I2C0_SDA__GPIO_3_25
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_2pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	rs485_leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rs485_led_pins>;
+
+		rs485_red {
+			label = "duckbill:red:rs485";
+			gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
+		};
+
+		rs485_green {
+			label = "duckbill:green:rs485";
+			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
new file mode 100644
index 0000000..f71944d3
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2015-2016 I2SE GmbH <info@i2se.com>
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
+#include <dt-bindings/input/input.h>
+#include "imx28-duckbill-2-common.dtsi"
+
+/ {
+	model = "I2SE Duckbill 2 EnOcean";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc2_4bit_pins_b
+					&mmc2_cd_cfg &mmc2_sck_cfg_b>;
+				bus-width = <4>;
+				vmmc-supply = <&reg_3p3v>;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+				enocean_led_pins: enocean_led_pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART0_CTS__GPIO_3_2
+						MX28_PAD_I2C0_SCL__GPIO_3_24
+						MX28_PAD_I2C0_SDA__GPIO_3_25
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				enocean_button: enocean_button at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART0_RTS__GPIO_3_3
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_2pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	enocean_leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&enocean_led_pins>;
+
+		enocean_blue {
+			label = "duckbill:blue:enocean";
+			gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
+		};
+
+		enocean_red {
+			label = "duckbill:red:enocean";
+			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
+		};
+
+		enocean_green {
+			label = "duckbill:green:enocean";
+			gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&enocean_button>;
+
+		enocean {
+			label = "EnOcean";
+			linux,code = <KEY_NEW>;
+			gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
new file mode 100644
index 0000000..e5c7d00
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2015 I2SE GmbH <info@i2se.com>
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
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx28-duckbill-2-common.dtsi"
+
+/ {
+	model = "I2SE Duckbill 2 SPI";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	aliases {
+		ethernet1 = &qca7000;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "okay";
+
+				qca7000: ethernet at 0 {
+					compatible = "qca,qca7000";
+					pinctrl-names = "default";
+					pinctrl-0 = <&qca7000_pins>;
+					reg = <0>;
+					interrupt-parent = <&gpio3>;
+					interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+					spi-cpha;
+					spi-cpol;
+					spi-max-frequency = <8000000>;
+				};
+			};
+
+			pinctrl at 80018000 {
+				qca7000_pins: qca7000-pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART0_RTS__GPIO_3_3    /* Interrupt */
+						MX28_PAD_LCD_D13__GPIO_1_13      /* QCA7K reset */
+						MX28_PAD_LCD_D14__GPIO_1_14      /* GPIO 0 */
+						MX28_PAD_LCD_D15__GPIO_1_15      /* GPIO 1 */
+						MX28_PAD_LCD_D18__GPIO_1_18      /* GPIO 2 */
+						MX28_PAD_LCD_D21__GPIO_1_21      /* GPIO 3 */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx28-duckbill-2.dts b/arch/arm/boot/dts/imx28-duckbill-2.dts
new file mode 100644
index 0000000..207e263
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-2.dts
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2015-2016 I2SE GmbH <info@i2se.com>
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
+#include "imx28-duckbill-2-common.dtsi"
+
+/ {
+	model = "I2SE Duckbill 2";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc2_4bit_pins_b
+					&mmc2_cd_cfg &mmc2_sck_cfg_b>;
+				bus-width = <4>;
+				vmmc-supply = <&reg_3p3v>;
+				status = "okay";
+			};
+		};
+
+		apbx at 80040000 {
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+			};
+
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_2pins_a>;
+				status = "okay";
+			};
+		};
+	};
+};
-- 
2.7.4
