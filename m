From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Jun 2016 10:34:57 +0100
Subject: [PATCH 1/2] ARM: dts: apq8064: rename db600c to SD_600eval
Message-ID: <1465551298-21457-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has been renamed recently and announced at
https://eragon.einfochips.com/products/sd-600eval.html

So rename this board files so that it reflects actual product in market.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/Makefile                         |   2 +-
 .../boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi   |  52 ---
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts    | 349 ---------------------
 .../dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi    |  52 +++
 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 349 +++++++++++++++++++++
 5 files changed, 402 insertions(+), 402 deletions(-)
 delete mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
 delete mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 488a943..66e182c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -573,7 +573,7 @@ dtb-$(CONFIG_ARCH_PRIMA2) += \
 dtb-$(CONFIG_ARCH_OXNAS) += \
 	wd-mbwe.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
-	qcom-apq8064-arrow-db600c.dtb \
+	qcom-apq8064-arrow-sd-600eval.dtb \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
 	qcom-apq8064-sony-xperia-yuga.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
deleted file mode 100644
index a3efb97..0000000
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
+++ /dev/null
@@ -1,52 +0,0 @@
-&tlmm_pinmux {
-	card_detect: card-detect {
-		mux {
-			pins = "gpio26";
-			function = "gpio";
-			bias-disable;
-		};
-	};
-
-	pcie_pins: pcie-pinmux {
-		mux {
-			pins = "gpio27";
-			function = "gpio";
-		};
-		conf {
-			pins = "gpio27";
-			drive-strength = <12>;
-			bias-disable;
-		};
-	};
-
-	user_leds: user-leds {
-		mux {
-			pins = "gpio3", "gpio7", "gpio10", "gpio11";
-			function = "gpio";
-		};
-
-		conf {
-			pins = "gpio3", "gpio7", "gpio10", "gpio11";
-			function = "gpio";
-			output-low;
-		};
-	};
-
-	magneto_pins: magneto-pins {
-		mux {
-			pins = "gpio31", "gpio48";
-			function = "gpio";
-			bias-disable;
-		};
-	};
-};
-
-&pm8921_mpps {
-	mpp_leds: mpp-leds {
-		pinconf {
-			pins = "mpp7", "mpp8";
-			function = "digital";
-			output-low;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
deleted file mode 100644
index e01b27e..0000000
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
+++ /dev/null
@@ -1,349 +0,0 @@
-#include "qcom-apq8064-v2.0.dtsi"
-#include "qcom-apq8064-arrow-db600c-pins.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-
-/ {
-	model = "Arrow Electronics, APQ8064 DB600c";
-	compatible = "arrow,db600c", "qcom,apq8064";
-
-	aliases {
-		serial0 = &gsbi7_serial;
-		serial1 = &gsbi1_serial;
-		i2c0 = &gsbi2_i2c;
-		i2c1 = &gsbi3_i2c;
-		i2c2 = &gsbi4_i2c;
-		i2c3 = &gsbi7_i2c;
-		spi0 = &gsbi5_spi;
-	};
-
-	regulators {
-		compatible = "simple-bus";
-		vph: regulator-fixed at 1 {
-			compatible = "regulator-fixed";
-			regulator-min-microvolt = <4500000>;
-			regulator-max-microvolt = <4500000>;
-			regulator-name = "VPH";
-			regulator-type = "voltage";
-			regulator-boot-on;
-		};
-
-		/* on board fixed 3.3v supply */
-		vcc3v3: vcc3v3 {
-			compatible = "regulator-fixed";
-			regulator-name = "VCC3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-	};
-
-	soc {
-		rpm at 108000 {
-			regulators {
-				vdd_s1-supply = <&vph>;
-				vdd_s2-supply = <&vph>;
-				vdd_s3-supply = <&vph>;
-				vdd_s4-supply = <&vph>;
-				vdd_s5-supply = <&vph>;
-				vdd_s6-supply = <&vph>;
-				vdd_s7-supply = <&vph>;
-				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
-				vdd_l3_l15_l17-supply = <&vph>;
-				vdd_l4_l14-supply = <&vph>;
-				vdd_l5_l8_l16-supply = <&vph>;
-				vdd_l6_l7-supply = <&vph>;
-				vdd_l9_l11-supply = <&vph>;
-				vdd_l10_l22-supply = <&vph>;
-				vdd_l21_l23_l29-supply = <&vph>;
-				vdd_l24-supply = <&pm8921_s1>;
-				vdd_l25-supply = <&pm8921_s1>;
-				vdd_l26-supply = <&pm8921_s7>;
-				vdd_l27-supply = <&pm8921_s7>;
-				vdd_l28-supply = <&pm8921_s7>;
-				vin_lvs1_3_6-supply = <&pm8921_s4>;
-				vin_lvs2-supply = <&pm8921_s1>;
-				vin_lvs4_5_7-supply = <&pm8921_s4>;
-
-				s1 {
-					regulator-always-on;
-					regulator-min-microvolt = <1225000>;
-					regulator-max-microvolt = <1225000>;
-					qcom,switch-mode-frequency = <3200000>;
-					bias-pull-down;
-				};
-
-				s3 {
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1400000>;
-					qcom,switch-mode-frequency = <4800000>;
-				};
-
-				s4 {
-					regulator-min-microvolt	= <1800000>;
-					regulator-max-microvolt	= <1800000>;
-					qcom,switch-mode-frequency = <3200000>;
-					bias-pull-down;
-					regulator-always-on;
-				};
-
-				s7 {
-					regulator-min-microvolt = <1300000>;
-					regulator-max-microvolt = <1300000>;
-					qcom,switch-mode-frequency = <3200000>;
-				 };
-
-				l3 {
-					regulator-min-microvolt = <3050000>;
-					regulator-max-microvolt = <3300000>;
-					bias-pull-down;
-				};
-
-				l4 {
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1800000>;
-					bias-pull-down;
-				};
-
-				l5 {
-					regulator-min-microvolt = <2750000>;
-					regulator-max-microvolt = <3000000>;
-					bias-pull-down;
-					regulator-boot-on;
-					regulator-always-on;
-				};
-
-				l6 {
-					regulator-min-microvolt = <2950000>;
-					regulator-max-microvolt = <2950000>;
-					bias-pull-down;
-				};
-
-				l23 {
-					regulator-min-microvolt = <1700000>;
-					regulator-max-microvolt = <1900000>;
-					bias-pull-down;
-				};
-
-				lvs6 {
-					bias-pull-down;
-				};
-
-				lvs7 {
-					bias-pull-down;
-				};
-			};
-		};
-
-		gsbi at 12440000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_UART_W_FC>;
-			serial at 12450000 {
-				label = "LS-UART1";
-				status = "okay";
-				pinctrl-names = "default";
-				pinctrl-0 = <&gsbi1_uart_4pins>;
-			};
-		};
-
-		gsbi at 12480000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_I2C>;
-			i2c at 124a0000 {
-				/* On Low speed expansion and Sensors */
-				label = "LS-I2C0";
-				status = "okay";
-				lis3mdl_mag at 1e {
-					compatible = "st,lis3mdl-magn";
-					reg = <0x1e>;
-					vdd-supply = <&vcc3v3>;
-					vddio-supply = <&pm8921_s4>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&magneto_pins>;
-					interrupt-parent = <&tlmm_pinmux>;
-
-					st,drdy-int-pin = <2>;
-					interrupts = <48 IRQ_TYPE_EDGE_RISING>, /* DRDY line */
-						     <31 IRQ_TYPE_EDGE_RISING>; /* INT */
-				};
-			};
-		};
-
-		gsbi at 16200000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_I2C>;
-			i2c at 16280000 {
-			/* On Low speed expansion */
-				status = "okay";
-				label = "LS-I2C1";
-				clock-frequency = <200000>;
-				eeprom at 52 {
-					compatible = "atmel,24c128";
-					reg = <0x52>;
-					pagesize = <64>;
-				};
-			};
-		};
-
-		gsbi at 16300000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_I2C>;
-			i2c at 16380000 {
-				/* On High speed expansion */
-				label = "HS-CAM-I2C3";
-				status = "okay";
-			};
-		};
-
-		gsbi at 1a200000 {
-			status = "okay";
-			spi at 1a280000 {
-				/* On Low speed expansion */
-				label = "LS-SPI0";
-				status = "okay";
-			};
-		};
-
-		/* DEBUG UART  */
-		gsbi at 16600000 {
-			status = "okay";
-			qcom,mode = <GSBI_PROT_I2C_UART>;
-			serial at 16640000 {
-				label = "LS-UART0";
-				status = "okay";
-				pinctrl-names = "default";
-				pinctrl-0 = <&gsbi7_uart_2pins>;
-			};
-
-			i2c at 16680000 {
-				/* On High speed expansion */
-				status = "okay";
-				label = "HS-CAM-I2C2";
-			};
-		};
-
-		leds {
-			pinctrl-names = "default";
-			pinctrl-0 = <&user_leds>, <&mpp_leds>;
-
-			compatible = "gpio-leds";
-
-			user-led0 {
-				label = "user0-led";
-				gpios = <&tlmm_pinmux 3 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "heartbeat";
-				default-state = "off";
-			};
-
-			user-led1 {
-				label = "user1-led";
-				gpios = <&tlmm_pinmux 7 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "mmc0";
-				default-state = "off";
-			};
-
-			user-led2 {
-				label = "user2-led";
-				gpios = <&tlmm_pinmux 10 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "mmc1";
-				default-state = "off";
-			};
-
-			user-led3 {
-				label = "user3-led";
-				gpios = <&tlmm_pinmux 11 GPIO_ACTIVE_HIGH>;
-				linux,default-trigger = "none";
-				default-state = "off";
-			};
-
-			wifi-led {
-				label = "WiFi-led";
-				gpios = <&pm8921_mpps 7 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
-
-			bt-led {
-				label = "BT-led";
-				gpios = <&pm8921_mpps 8 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
-		};
-
-		pci at 1b500000 {
-			status = "okay";
-			vdda-supply = <&pm8921_s3>;
-			vdda_phy-supply = <&pm8921_lvs6>;
-			vdda_refclk-supply = <&vcc3v3>;
-			pinctrl-0 = <&pcie_pins>;
-			pinctrl-names = "default";
-			perst-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
-		};
-
-		phy at 1b400000 {
-			status = "okay";
-		};
-
-		sata at 29000000 {
-			status	= "okay";
-			target-supply	= <&pm8921_lvs7>;
-		};
-
-		/* OTG */
-		phy at 12500000 {
-			status		= "okay";
-			dr_mode		= "peripheral";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l4>;
-		};
-
-		phy at 12520000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l23>;
-		};
-
-		phy at 12530000 {
-			status		= "okay";
-			vddcx-supply	= <&pm8921_s3>;
-			v3p3-supply	= <&pm8921_l3>;
-			v1p8-supply	= <&pm8921_l23>;
-		};
-
-		gadget at 12500000 {
-			status = "okay";
-		};
-
-		/* OTG */
-		usb at 12500000 {
-			status = "okay";
-		};
-
-		usb at 12520000 {
-			status = "okay";
-		};
-
-		usb at 12530000 {
-			status = "okay";
-		};
-
-		amba {
-			/* eMMC */
-			sdcc at 12400000 {
-				status = "okay";
-				vmmc-supply = <&pm8921_l5>;
-				vqmmc-supply = <&pm8921_s4>;
-			};
-
-			/* External micro SD card */
-			sdcc at 12180000 {
-				status = "okay";
-				vmmc-supply = <&pm8921_l6>;
-				pinctrl-names	= "default";
-				pinctrl-0	= <&card_detect>;
-				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_HIGH>;
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi
new file mode 100644
index 0000000..a3efb97
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi
@@ -0,0 +1,52 @@
+&tlmm_pinmux {
+	card_detect: card-detect {
+		mux {
+			pins = "gpio26";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
+	pcie_pins: pcie-pinmux {
+		mux {
+			pins = "gpio27";
+			function = "gpio";
+		};
+		conf {
+			pins = "gpio27";
+			drive-strength = <12>;
+			bias-disable;
+		};
+	};
+
+	user_leds: user-leds {
+		mux {
+			pins = "gpio3", "gpio7", "gpio10", "gpio11";
+			function = "gpio";
+		};
+
+		conf {
+			pins = "gpio3", "gpio7", "gpio10", "gpio11";
+			function = "gpio";
+			output-low;
+		};
+	};
+
+	magneto_pins: magneto-pins {
+		mux {
+			pins = "gpio31", "gpio48";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+};
+
+&pm8921_mpps {
+	mpp_leds: mpp-leds {
+		pinconf {
+			pins = "mpp7", "mpp8";
+			function = "digital";
+			output-low;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
new file mode 100644
index 0000000..7df0108
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
@@ -0,0 +1,349 @@
+#include "qcom-apq8064-v2.0.dtsi"
+#include "qcom-apq8064-arrow-sd-600eval-pins.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Arrow Electronics, APQ8064 SD_600eval";
+	compatible = "arrow,sd_600eval", "qcom,apq8064";
+
+	aliases {
+		serial0 = &gsbi7_serial;
+		serial1 = &gsbi1_serial;
+		i2c0 = &gsbi2_i2c;
+		i2c1 = &gsbi3_i2c;
+		i2c2 = &gsbi4_i2c;
+		i2c3 = &gsbi7_i2c;
+		spi0 = &gsbi5_spi;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		vph: regulator-fixed at 1 {
+			compatible = "regulator-fixed";
+			regulator-min-microvolt = <4500000>;
+			regulator-max-microvolt = <4500000>;
+			regulator-name = "VPH";
+			regulator-type = "voltage";
+			regulator-boot-on;
+		};
+
+		/* on board fixed 3.3v supply */
+		vcc3v3: vcc3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "VCC3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+	};
+
+	soc {
+		rpm at 108000 {
+			regulators {
+				vdd_s1-supply = <&vph>;
+				vdd_s2-supply = <&vph>;
+				vdd_s3-supply = <&vph>;
+				vdd_s4-supply = <&vph>;
+				vdd_s5-supply = <&vph>;
+				vdd_s6-supply = <&vph>;
+				vdd_s7-supply = <&vph>;
+				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+				vdd_l3_l15_l17-supply = <&vph>;
+				vdd_l4_l14-supply = <&vph>;
+				vdd_l5_l8_l16-supply = <&vph>;
+				vdd_l6_l7-supply = <&vph>;
+				vdd_l9_l11-supply = <&vph>;
+				vdd_l10_l22-supply = <&vph>;
+				vdd_l21_l23_l29-supply = <&vph>;
+				vdd_l24-supply = <&pm8921_s1>;
+				vdd_l25-supply = <&pm8921_s1>;
+				vdd_l26-supply = <&pm8921_s7>;
+				vdd_l27-supply = <&pm8921_s7>;
+				vdd_l28-supply = <&pm8921_s7>;
+				vin_lvs1_3_6-supply = <&pm8921_s4>;
+				vin_lvs2-supply = <&pm8921_s1>;
+				vin_lvs4_5_7-supply = <&pm8921_s4>;
+
+				s1 {
+					regulator-always-on;
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+				};
+
+				s3 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1400000>;
+					qcom,switch-mode-frequency = <4800000>;
+				};
+
+				s4 {
+					regulator-min-microvolt	= <1800000>;
+					regulator-max-microvolt	= <1800000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+					regulator-always-on;
+				};
+
+				s7 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <3200000>;
+				 };
+
+				l3 {
+					regulator-min-microvolt = <3050000>;
+					regulator-max-microvolt = <3300000>;
+					bias-pull-down;
+				};
+
+				l4 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				l5 {
+					regulator-min-microvolt = <2750000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				l6 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				l23 {
+					regulator-min-microvolt = <1700000>;
+					regulator-max-microvolt = <1900000>;
+					bias-pull-down;
+				};
+
+				lvs6 {
+					bias-pull-down;
+				};
+
+				lvs7 {
+					bias-pull-down;
+				};
+			};
+		};
+
+		gsbi at 12440000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_UART_W_FC>;
+			serial at 12450000 {
+				label = "LS-UART1";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&gsbi1_uart_4pins>;
+			};
+		};
+
+		gsbi at 12480000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C>;
+			i2c at 124a0000 {
+				/* On Low speed expansion and Sensors */
+				label = "LS-I2C0";
+				status = "okay";
+				lis3mdl_mag at 1e {
+					compatible = "st,lis3mdl-magn";
+					reg = <0x1e>;
+					vdd-supply = <&vcc3v3>;
+					vddio-supply = <&pm8921_s4>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&magneto_pins>;
+					interrupt-parent = <&tlmm_pinmux>;
+
+					st,drdy-int-pin = <2>;
+					interrupts = <48 IRQ_TYPE_EDGE_RISING>, /* DRDY line */
+						     <31 IRQ_TYPE_EDGE_RISING>; /* INT */
+				};
+			};
+		};
+
+		gsbi at 16200000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C>;
+			i2c at 16280000 {
+			/* On Low speed expansion */
+				status = "okay";
+				label = "LS-I2C1";
+				clock-frequency = <200000>;
+				eeprom at 52 {
+					compatible = "atmel,24c128";
+					reg = <0x52>;
+					pagesize = <64>;
+				};
+			};
+		};
+
+		gsbi at 16300000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C>;
+			i2c at 16380000 {
+				/* On High speed expansion */
+				label = "HS-CAM-I2C3";
+				status = "okay";
+			};
+		};
+
+		gsbi at 1a200000 {
+			status = "okay";
+			spi at 1a280000 {
+				/* On Low speed expansion */
+				label = "LS-SPI0";
+				status = "okay";
+			};
+		};
+
+		/* DEBUG UART  */
+		gsbi at 16600000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C_UART>;
+			serial at 16640000 {
+				label = "LS-UART0";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&gsbi7_uart_2pins>;
+			};
+
+			i2c at 16680000 {
+				/* On High speed expansion */
+				status = "okay";
+				label = "HS-CAM-I2C2";
+			};
+		};
+
+		leds {
+			pinctrl-names = "default";
+			pinctrl-0 = <&user_leds>, <&mpp_leds>;
+
+			compatible = "gpio-leds";
+
+			user-led0 {
+				label = "user0-led";
+				gpios = <&tlmm_pinmux 3 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "heartbeat";
+				default-state = "off";
+			};
+
+			user-led1 {
+				label = "user1-led";
+				gpios = <&tlmm_pinmux 7 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+
+			user-led2 {
+				label = "user2-led";
+				gpios = <&tlmm_pinmux 10 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc1";
+				default-state = "off";
+			};
+
+			user-led3 {
+				label = "user3-led";
+				gpios = <&tlmm_pinmux 11 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "none";
+				default-state = "off";
+			};
+
+			wifi-led {
+				label = "WiFi-led";
+				gpios = <&pm8921_mpps 7 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+			};
+
+			bt-led {
+				label = "BT-led";
+				gpios = <&pm8921_mpps 8 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+			};
+		};
+
+		pci at 1b500000 {
+			status = "okay";
+			vdda-supply = <&pm8921_s3>;
+			vdda_phy-supply = <&pm8921_lvs6>;
+			vdda_refclk-supply = <&vcc3v3>;
+			pinctrl-0 = <&pcie_pins>;
+			pinctrl-names = "default";
+			perst-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
+		};
+
+		phy at 1b400000 {
+			status = "okay";
+		};
+
+		sata at 29000000 {
+			status	= "okay";
+			target-supply	= <&pm8921_lvs7>;
+		};
+
+		/* OTG */
+		phy at 12500000 {
+			status		= "okay";
+			dr_mode		= "peripheral";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l4>;
+		};
+
+		phy at 12520000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+		};
+
+		phy at 12530000 {
+			status		= "okay";
+			vddcx-supply	= <&pm8921_s3>;
+			v3p3-supply	= <&pm8921_l3>;
+			v1p8-supply	= <&pm8921_l23>;
+		};
+
+		gadget at 12500000 {
+			status = "okay";
+		};
+
+		/* OTG */
+		usb at 12500000 {
+			status = "okay";
+		};
+
+		usb at 12520000 {
+			status = "okay";
+		};
+
+		usb at 12530000 {
+			status = "okay";
+		};
+
+		amba {
+			/* eMMC */
+			sdcc at 12400000 {
+				status = "okay";
+				vmmc-supply = <&pm8921_l5>;
+				vqmmc-supply = <&pm8921_s4>;
+			};
+
+			/* External micro SD card */
+			sdcc at 12180000 {
+				status = "okay";
+				vmmc-supply = <&pm8921_l6>;
+				pinctrl-names	= "default";
+				pinctrl-0	= <&card_detect>;
+				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_HIGH>;
+			};
+		};
+	};
+};
-- 
2.8.3
