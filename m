From: mhei@heimpold.de (Michael Heimpold)
Date: Sat, 22 Oct 2016 21:22:27 +0200
Subject: [PATCH 4/7] ARM: dts: add I2SE Duckbill common definitions
In-Reply-To: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
References: <1477164150-13553-1-git-send-email-mhei@heimpold.de>
Message-ID: <1477164150-13553-5-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/imx28-duckbill-2-common.dtsi | 110 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-duckbill-base.dtsi     |  88 ++++++++++++++++++++
 arch/arm/boot/dts/imx28-duckbill-common.dtsi   |  80 ++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-base.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-common.dtsi

diff --git a/arch/arm/boot/dts/imx28-duckbill-2-common.dtsi b/arch/arm/boot/dts/imx28-duckbill-2-common.dtsi
new file mode 100644
index 0000000..3354f8f
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-2-common.dtsi
@@ -0,0 +1,110 @@
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
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "imx28-duckbill-base.dtsi"
+
+/ {
+	model = "I2SE Duckbill 2";
+	compatible = "i2se,duckbill", "fsl,imx28";
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
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				mac0_phy_reset_pin: mac0_phy_reset_pin at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_GPMI_ALE__GPIO_0_26    /* PHY Reset */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				mac0_phy_int_pin: mac0_phy_int_pin at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_GPMI_D07__GPIO_0_7    /* PHY Interrupt */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				status_led_pins: status_led_pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SAIF0_MCLK__GPIO_3_20
+						MX28_PAD_SAIF0_LRCLK__GPIO_3_21
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		mac0: ethernet at 800f0000 {
+			phy-reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
+			phy-handle = <&ethphy>;
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ethphy: ethernet-phy at 0 {
+						compatible = "ethernet-phy-ieee802.3-c22";
+						reg = <0>;
+						pinctrl-names = "default";
+						pinctrl-0 = <&mac0_phy_int_pin>;
+						interrupt-parent = <&gpio0>;
+						interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+						max-speed = <100>;
+				};
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&status_led_pins>;
+
+		status_red {
+			label = "duckbill:red:status";
+			gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		status_green {
+			label = "duckbill:green:status";
+			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx28-duckbill-base.dtsi b/arch/arm/boot/dts/imx28-duckbill-base.dtsi
new file mode 100644
index 0000000..b64efd5
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-base.dtsi
@@ -0,0 +1,88 @@
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
+#include "imx28.dtsi"
+
+/ {
+	model = "I2SE Duckbill";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog_pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_LCD_D17__GPIO_1_17    /* Revision detection */
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
+			phy-reset-duration = <25>;
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
+};
diff --git a/arch/arm/boot/dts/imx28-duckbill-common.dtsi b/arch/arm/boot/dts/imx28-duckbill-common.dtsi
new file mode 100644
index 0000000..167b53f
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-duckbill-common.dtsi
@@ -0,0 +1,80 @@
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
+#include <dt-bindings/gpio/gpio.h>
+#include "imx28-duckbill-base.dtsi"
+
+/ {
+	model = "I2SE Duckbill";
+	compatible = "i2se,duckbill", "fsl,imx28";
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a
+					&mmc0_cd_cfg &mmc0_sck_cfg>;
+				bus-width = <4>;
+				vmmc-supply = <&reg_3p3v>;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+				mac0_phy_reset_pin: mac0_phy_reset_pin at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP0_DATA7__GPIO_2_7    /* PHY Reset */
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				status_led_pins: status_led_pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_AUART1_RX__GPIO_3_4
+						MX28_PAD_AUART1_TX__GPIO_3_5
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		mac0: ethernet at 800f0000 {
+			phy-reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&status_led_pins>;
+
+		status_red {
+			label = "duckbill:red:status";
+			gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		status_green {
+			label = "duckbill:green:status";
+			gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
-- 
2.7.4
