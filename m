From: mhei@heimpold.de (Michael Heimpold)
Date: Sun, 22 Jan 2017 23:22:43 +0100
Subject: [PATCH v2 8/9] ARM: dts: add support for I2SE Duckbill 2 SPI
In-Reply-To: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
References: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
Message-ID: <1485123764-14754-9-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This machine is based on I2SE's Duckbill 2 board and is sold as part of I2SE's
PLC Bundle for IoT. This is a development kit for Homeplug Green PHY based
powerline products based on Qualcomms QCA7000 chip.

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts | 199 +++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-spi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d7fcb4dc..d2d2486 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -478,6 +478,7 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-duckbill-2-485.dts \
 	imx28-duckbill-2.dtb \
 	imx28-duckbill-2-enocean.dts \
+	imx28-duckbill-2-spi.dts \
 	imx28-duckbill.dtb \
 	imx28-eukrea-mbmx283lc.dtb \
 	imx28-eukrea-mbmx287lc.dtb \
diff --git a/arch/arm/boot/dts/imx28-duckbill-2-spi.dts b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
new file mode 100644
index 0000000..738eaa7
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-2-spi.dts
@@ -0,0 +1,199 @@
+/*
+ * Copyright (C) 2015-2017 I2SE GmbH <info@i2se.com>
+ * Copyright (C) 2016 Michael Heimpold <mhei@heimpold.de>
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
+#include <dt-bindings/gpio/gpio.h>
+#include "imx28.dtsi"
+
+/ {
+	model = "I2SE Duckbill 2 SPI";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	aliases {
+		ethernet1 = &qca7000;
+	};
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_8bit_pins_a
+					&mmc0_cd_cfg &mmc0_sck_cfg>;
+				bus-width = <8>;
+				vmmc-supply = <&reg_3p3v>;
+				status = "okay";
+				non-removable;
+			};
+
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
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_LCD_D17__GPIO_1_17    /* Revision detection */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				mac0_phy_reset_pin: mac0-phy-reset at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_GPMI_ALE__GPIO_0_26    /* PHY Reset */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				mac0_phy_int_pin: mac0-phy-int at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_GPMI_D07__GPIO_0_7    /* PHY Interrupt */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				led_pins: led at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SAIF0_MCLK__GPIO_3_20
+						MX28_PAD_SAIF0_LRCLK__GPIO_3_21
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				qca7000_pins: qca7000 at 0 {
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
+
+		apbx at 80040000 {
+			lradc at 80050000 {
+				status = "okay";
+			};
+
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			status = "okay";
+			dr_mode = "peripheral";
+		};
+
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>, <&mac0_phy_reset_pin>;
+			phy-supply = <&reg_3p3v>;
+			phy-reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+			phy-reset-duration = <25>;
+			phy-handle = <&ethphy>;
+			status = "okay";
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ethphy: ethernet-phy at 0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&mac0_phy_int_pin>;
+					interrupt-parent = <&gpio0>;
+					interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+					max-speed = <100>;
+				};
+			};
+		};
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		status-red {
+			label = "duckbill:red:status";
+			gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		status-green {
+			label = "duckbill:green:status";
+			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
-- 
2.7.4
