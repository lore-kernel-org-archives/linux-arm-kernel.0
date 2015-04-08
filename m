From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Wed,  8 Apr 2015 10:10:51 +0200
Subject: [PATCH v2 2/2] ARM: at91/dt: add support for kizboxmini
In-Reply-To: <1428480651-5963-1-git-send-email-g.portay@overkiz.com>
References: <1428480651-5963-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1428480651-5963-3-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT file for Kizbox mini board.
This board is based on Atmel's AT91SAM9G25 SoC.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/at91-kizboxmini.dts | 129 ++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..9c11888 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
 	at91sam9rlek.dtb \
 	at91-ariag25.dtb \
 	at91-cosino_mega2560.dtb \
+	at91-kizboxmini.dtb \
 	at91sam9g15ek.dtb \
 	at91sam9g25ek.dtb \
 	at91sam9g35ek.dtb \
diff --git a/arch/arm/boot/dts/at91-kizboxmini.dts b/arch/arm/boot/dts/at91-kizboxmini.dts
new file mode 100644
index 0000000..b25cae4
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizboxmini.dts
@@ -0,0 +1,129 @@
+/*
+ * at91-kizboxmini.dts - Device Tree file for Overkiz Kizbox mini board
+ *
+ * Copyright (C) 2014 Ga?l PORTAY <g.portay@overkiz.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+#include "at91sam9g25.dtsi"
+#include "at91sam9x5.dtsi"
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "Overkiz Kizbox mini";
+	compatible = "overkiz,kizboxmini", "atmel,at91sam9g25", "atmel,at91sam9x5", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "ubi.mtd=ubi";
+		linux,stdout-path = &dbgu;
+	};
+
+	memory {
+		reg = <0x20000000 0x8000000>;
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
+			usart0: serial at f801c000 {
+				status = "okay";
+			};
+
+			macb0: ethernet at f802c000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			pwm0: pwm at f8034000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pwm0_pwm0_1
+					     &pinctrl_pwm0_pwm1_1>;
+				status = "okay";
+			};
+
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			watchdog at fffffe40 {
+				status = "okay";
+			};
+		};
+
+		usb0: ohci at 00600000 {
+			status = "okay";
+		};
+
+		usb1: ehci at 00700000 {
+			status = "okay";
+		};
+
+		nand0: nand at 40000000 {
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
+		green {
+			label = "pwm:green:user";
+			pwms = <&pwm0 0 10000000 0>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+
+		red {
+			label = "pwm:red:user";
+			pwms = <&pwm0 1 10000000 0>;
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
+			gpios = <&pioC 17 GPIO_ACTIVE_LOW>;
+			linux,code = <0x102>;
+			gpio-key,wakeup;
+		};
+
+		reset {
+			label = "PB_RST";
+			gpios = <&pioC 16 GPIO_ACTIVE_LOW>;
+			linux,code = <0x100>;
+			gpio-key,wakeup;
+		};
+	};
+};
-- 
1.9.1
