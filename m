From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Wed,  8 Apr 2015 10:17:56 +0200
Subject: [PATCH v2] ARM: at91/dt: add support for kizbox2
Message-ID: <1428481076-6704-1-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT file for Kizbox 2 board.
This board is based on Atmel's SAMA5D31 Cortex-A5 SoC.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes since v1:
- drop ek boards from compatible machine
- drop useless pmc node

 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/at91-kizbox2.dts | 217 +++++++++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-kizbox2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c11888..d2b559d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -37,6 +37,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
 	at91sam9x25ek.dtb \
 	at91sam9x35ek.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
+	at91-kizbox2.dtb \
 	at91-sama5d3_xplained.dtb \
 	sama5d31ek.dtb \
 	sama5d33ek.dtb \
diff --git a/arch/arm/boot/dts/at91-kizbox2.dts b/arch/arm/boot/dts/at91-kizbox2.dts
new file mode 100644
index 0000000..3f52835
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox2.dts
@@ -0,0 +1,217 @@
+/*
+ * at91-kizbox2.dts - Device Tree file for Overkiz Kizbox 2 board
+ *
+ * Copyright (C) 2014 Ga?l PORTAY <g.portay@overkiz.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+#include "sama5d31.dtsi"
+#include "sama5d3_emac.dtsi"
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "Overkiz Kizbox 2";
+	compatible = "overkiz,kizbox2", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
+
+	chosen {
+		bootargs = "ubi.mtd=ubi";
+		linux,stdout-path = &dbgu;
+	};
+
+	memory {
+		reg = <0x20000000 0x10000000>;
+	};
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		apb {
+			i2c1: i2c at f0018000 {
+				status = "okay";
+
+				pmic: act8865 at 5b {
+					compatible = "active-semi,act8865";
+					reg = <0x5b>;
+					status = "okay";
+
+					regulators {
+						vcc_1v8_reg: DCDC_REG1 {
+							regulator-name = "VCC_1V8";
+							regulator-min-microvolt = <1800000>;
+							regulator-max-microvolt = <1800000>;
+							regulator-always-on;
+						};
+
+						vcc_1v2_reg: DCDC_REG2 {
+							regulator-name = "VCC_1V2";
+							regulator-min-microvolt = <1200000>;
+							regulator-max-microvolt = <1200000>;
+							regulator-always-on;
+						};
+
+						vcc_3v3_reg: DCDC_REG3 {
+							regulator-name = "VCC_3V3";
+							regulator-min-microvolt = <3300000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-always-on;
+						};
+
+						vddfuse_reg: LDO_REG1 {
+							regulator-name = "FUSE_2V5";
+							regulator-min-microvolt = <2500000>;
+							regulator-max-microvolt = <2500000>;
+						};
+
+						vddana_reg: LDO_REG2 {
+							regulator-name = "VDDANA";
+							regulator-min-microvolt = <3300000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-always-on;
+						};
+
+						vled_reg: LDO_REG3 {
+							regulator-name = "VLED";
+							regulator-min-microvolt = <3300000>;
+							regulator-max-microvolt = <3300000>;
+							regulator-always-on;
+						};
+
+						v3v8_rf_reg: LDO_REG4 {
+							regulator-name = "V3V8_RF";
+							regulator-min-microvolt = <3800000>;
+							regulator-max-microvolt = <3800000>;
+							regulator-always-on;
+						};
+					};
+				};
+			};
+
+			usart0: serial at f001c000 {
+				status = "okay";
+			};
+
+			usart1: serial at f0020000 {
+				status = "okay";
+			};
+
+			pwm0: pwm at f002c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pwm0_pwmh0_1
+					     &pinctrl_pwm0_pwmh1_1
+					     &pinctrl_pwm0_pwmh2_0>;
+				status = "okay";
+			};
+
+			adc0: adc at f8018000 {
+				atmel,adc-vref = <3333>;
+				status = "okay";
+			};
+
+			usart2: serial at f8020000 {
+				status = "okay";
+			};
+
+			macb1: ethernet at f802c000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			dbgu: serial at ffffee00 {
+				status = "okay";
+			};
+
+			watchdog at fffffe40 {
+				status = "okay";
+			};
+		};
+
+		usb1: ohci at 00600000 {
+			status = "okay";
+		};
+
+		usb2: ehci at 00700000 {
+			status = "okay";
+		};
+
+		nand0: nand at 60000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			atmel,has-pmecc;
+			atmel,pmecc-cap = <4>;
+			atmel,pmecc-sector-size = <512>;
+			nand-on-flash-bbt;
+			status = "okay";
+
+			bootstrap at 0 {
+				label = "bootstrap";
+				reg = <0x0 0x20000>;
+			};
+
+			ubi at 20000 {
+				label = "ubi";
+				reg = <0x20000 0x7fe0000>;
+			};
+		};
+	};
+
+	pwm_leds {
+		compatible = "pwm-leds";
+
+		blue {
+			label = "pwm:blue:user";
+			pwms = <&pwm0 2 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+
+		green {
+			label = "pwm:green:user";
+			pwms = <&pwm0 1 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+
+		red {
+			label = "pwm:red:user";
+			pwms = <&pwm0 0 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		prog {
+			label = "PB_PROG";
+			gpios = <&pioE 27 GPIO_ACTIVE_LOW>;
+			linux,code = <0x102>;
+			gpio-key,wakeup;
+		};
+
+		reset {
+			label = "PB_RST";
+			gpios = <&pioE 29 GPIO_ACTIVE_LOW>;
+			linux,code = <0x100>;
+			gpio-key,wakeup;
+		};
+
+		user {
+			label = "PB_USER";
+			gpios = <&pioE 31 GPIO_ACTIVE_HIGH>;
+			linux,code = <0x101>;
+			gpio-key,wakeup;
+		};
+	};
+};
-- 
1.9.1
