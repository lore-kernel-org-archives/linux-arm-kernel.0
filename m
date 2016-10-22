From: mhei@heimpold.de (Michael Heimpold)
Date: Sat, 22 Oct 2016 21:22:29 +0200
Subject: [PATCH 6/7] ARM: dts: add support for remaining members of Duckbill
 series
In-Reply-To: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
Message-ID: <1477164150-13553-7-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/Makefile                   |  3 +
 arch/arm/boot/dts/imx28-duckbill-485.dts     | 60 +++++++++++++++++++
 arch/arm/boot/dts/imx28-duckbill-enocean.dts | 90 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-duckbill-spi.dts     | 64 ++++++++++++++++++++
 4 files changed, 217 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-485.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-enocean.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-spi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..5a366c4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -459,7 +459,10 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-cfa10056.dtb \
 	imx28-cfa10057.dtb \
 	imx28-cfa10058.dtb \
+	imx28-duckbill-485.dtb \
 	imx28-duckbill.dtb \
+	imx28-duckbill-enocean.dtb \
+	imx28-duckbill-spi.dtb \
 	imx28-eukrea-mbmx283lc.dtb \
 	imx28-eukrea-mbmx287lc.dtb \
 	imx28-evk.dtb \
diff --git a/arch/arm/boot/dts/imx28-duckbill-485.dts b/arch/arm/boot/dts/imx28-duckbill-485.dts
new file mode 100644
index 0000000..a60d78a
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-485.dts
@@ -0,0 +1,60 @@
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
+#include <dt-bindings/gpio/gpio.h>
+#include "imx28-duckbill-common.dtsi"
+
+/ {
+	model = "I2SE Duckbill 485";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			pinctrl at 80018000 {
+				rs485_led_pins: rs485_led_pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP2_SCK__GPIO_2_16
+						MX28_PAD_SSP2_MISO__GPIO_2_18
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
+			gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
+		};
+
+		rs485_green {
+			label = "duckbill:green:rs485";
+			gpios = <&gpio2 18 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx28-duckbill-enocean.dts b/arch/arm/boot/dts/imx28-duckbill-enocean.dts
new file mode 100644
index 0000000..4602d13
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-enocean.dts
@@ -0,0 +1,90 @@
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
+#include <dt-bindings/input/input.h>
+#include "imx28-duckbill-common.dtsi"
+
+/ {
+	model = "I2SE Duckbill EnOcean";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			pinctrl at 80018000 {
+				enocean_led_pins: enocean_led_pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP2_SCK__GPIO_2_16
+						MX28_PAD_SSP2_MISO__GPIO_2_18
+						MX28_PAD_SSP2_SS0__GPIO_2_19
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				enocean_button: enocean_button at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP2_SS2__GPIO_2_21
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
+			gpios = <&gpio2 16 GPIO_ACTIVE_LOW>;
+		};
+
+		enocean_red {
+			label = "duckbill:red:enocean";
+			gpios = <&gpio2 18 GPIO_ACTIVE_LOW>;
+		};
+
+		enocean_green {
+			label = "duckbill:green:enocean";
+			gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
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
+			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx28-duckbill-spi.dts b/arch/arm/boot/dts/imx28-duckbill-spi.dts
new file mode 100644
index 0000000..5248d84
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-spi.dts
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2013-2014 Michael Heimpold <mhei@heimpold.de>
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
+#include "imx28-duckbill-common.dtsi"
+
+/ {
+	model = "I2SE Duckbill SPI";
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
-- 
2.7.4
