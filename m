From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Mon, 20 Apr 2015 11:13:38 +0200
Subject: [PATCH] ARM: at91/dt: kizbox: update and rename to at91-kizbox
Message-ID: <1429521218-9752-1-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort nodes, rename to match Atmel naming convention and update the features
below:
 - command-line,
 - use proper serial uart,
 - rename leds and gpio-keys,
 - update to pwm-leds and
 - fix gpio-key level.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/Makefile        |   2 +-
 arch/arm/boot/dts/at91-kizbox.dts | 159 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kizbox.dts      | 150 -----------------------------------
 3 files changed, 160 insertions(+), 151 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kizbox.dts
 delete mode 100644 arch/arm/boot/dts/kizbox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d2b559d..32568fb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -18,9 +18,9 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
 	tny_a9263.dtb \
 	usb_a9263.dtb \
 	at91-foxg20.dtb \
+	at91-kizbox.dtb \
 	at91sam9g20ek.dtb \
 	at91sam9g20ek_2mmc.dtb \
-	kizbox.dtb \
 	tny_a9g20.dtb \
 	usb_a9g20.dtb \
 	usb_a9g20_lpw.dtb \
diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
new file mode 100644
index 0000000..b567b5f
--- /dev/null
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -0,0 +1,159 @@
+/*
+ * at91-kizbox.dts - Device Tree file for Overkiz Kizbox board
+ *
+ * Copyright (C) 2012-2014 Boris BREZILLON <b.brezillon@overkiz.com>
+ *               2014-2015 Ga?l PORTAY <g.portay@overkiz.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+/dts-v1/;
+#include "at91sam9g20.dtsi"
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "Overkiz Kizbox";
+	compatible = "overkiz,kizbox", "atmel,at91sam9g20", "atmel,at91sam9";
+
+	chosen {
+		bootargs = "ubi.mtd=ubi";
+		linux,stdout-path = &dbgu;
+	};
+
+	memory {
+		reg = <0x20000000 0x2000000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <18432000>;
+		};
+
+		main_xtal {
+			clock-frequency = <18432000>;
+		};
+	};
+
+	ahb {
+		apb {
+			macb0: ethernet at fffc4000 {
+				phy-mode = "mii";
+				pinctrl-0 = <&pinctrl_macb_rmii
+				             &pinctrl_macb_rmii_mii_alt>;
+				status = "okay";
+			};
+
+			usart3: serial at fffd0000 {
+				status = "okay";
+			};
+
+			dbgu: serial at fffff200 {
+				status = "okay";
+			};
+
+			watchdog at fffffd40 {
+				timeout-sec = <15>;
+				atmel,max-heartbeat-sec = <16>;
+				atmel,min-heartbeat-sec = <0>;
+				status = "okay";
+			};
+		};
+
+		usb0: ohci at 00500000 {
+			num-ports = <1>;
+			status = "okay";
+		};
+
+		nand0: nand at 40000000 {
+			nand-bus-width = <8>;
+			nand-ecc-mode = "soft";
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
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset {
+			label = "PB_RST";
+			gpios = <&pioB 30 GPIO_ACTIVE_HIGH>;
+			linux,code = <0x100>;
+			gpio-key,wakeup;
+		};
+
+		user {
+			label = "PB_USER";
+			gpios = <&pioB 31 GPIO_ACTIVE_HIGH>;
+			linux,code = <0x101>;
+			gpio-key,wakeup;
+		};
+	};
+
+	i2c at 0 {
+		status = "okay";
+
+		rtc: pcf8563 at 51 {
+			compatible = "nxp,pcf8563";
+			reg = <0x51>;
+		};
+	};
+
+	pwm_leds {
+		compatible = "pwm-leds";
+
+		network_green {
+			label = "pwm:green:network";
+			pwms = <&tcb_pwm 2 10000000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+
+		network_red {
+			label = "pwm:red:network";
+			pwms = <&tcb_pwm 3 10000000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+
+		user_green {
+			label = "pwm:green:user";
+			pwms = <&tcb_pwm 0 10000000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+
+		user_red {
+			label = "pwm:red:user";
+			pwms = <&tcb_pwm 1 10000000 PWM_POLARITY_INVERTED>;
+			max-brightness = <255>;
+			linux,default-trigger = "default-on";
+		};
+	};
+
+	tcb_pwm: pwm {
+		compatible = "atmel,tcb-pwm";
+		#pwm-cells = <3>;
+		tc-block = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tcb1_tioa0
+			     &pinctrl_tcb1_tioa1
+			     &pinctrl_tcb1_tioa2
+			     &pinctrl_tcb1_tiob0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
deleted file mode 100644
index e83e4f9..0000000
--- a/arch/arm/boot/dts/kizbox.dts
+++ /dev/null
@@ -1,150 +0,0 @@
-/*
- * kizbox.dts - Device Tree file for Overkiz Kizbox board
- *
- * Copyright (C) 2012 Boris BREZILLON <linux-arm@overkiz.com>
- *
- * Licensed under GPLv2.
- */
-/dts-v1/;
-#include "at91sam9g20.dtsi"
-
-/ {
-
-	model = "Overkiz kizbox";
-	compatible = "overkiz,kizbox", "atmel,at91sam9g20", "atmel,at91sam9";
-
-	chosen {
-		bootargs = "panic=5 ubi.mtd=1 rootfstype=ubifs root=ubi0:root";
-	};
-
-	memory {
-		reg = <0x20000000 0x2000000>;
-	};
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <18432000>;
-		};
-
-		main_xtal {
-			clock-frequency = <18432000>;
-		};
-	};
-
-	ahb {
-		apb {
-			dbgu: serial at fffff200 {
-				status = "okay";
-			};
-
-			usart0: serial at fffb0000 {
-				status = "okay";
-			};
-
-			usart1: serial at fffb4000 {
-				status = "okay";
-			};
-
-			macb0: ethernet at fffc4000 {
-				phy-mode = "mii";
-				pinctrl-0 = <&pinctrl_macb_rmii
-				             &pinctrl_macb_rmii_mii_alt>;
-				status = "okay";
-			};
-
-			watchdog at fffffd40 {
-				timeout-sec = <15>;
-				atmel,max-heartbeat-sec = <16>;
-				atmel,min-heartbeat-sec = <0>;
-				status = "okay";
-			};
-		};
-
-		nand0: nand at 40000000 {
-			nand-bus-width = <8>;
-			nand-ecc-mode = "soft";
-			status = "okay";
-
-			bootloaderkernel at 0 {
-				label = "bootloader-kernel";
-				reg = <0x0 0xc0000>;
-			};
-
-			ubi at c0000 {
-				label = "ubi";
-				reg = <0xc0000 0x7f40000>;
-			};
-
-		};
-
-		usb0: ohci at 00500000 {
-			num-ports = <1>;
-			status = "okay";
-		};
-	};
-
-	i2c at 0 {
-		status = "okay";
-
-		pcf8563 at 51 {
-			/* nxp pcf8563 rtc */
-			compatible = "nxp,pcf8563";
-			reg = <0x51>;
-		};
-
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led1g {
-			label = "led1:green";
-			gpios = <&pioB 0 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
-		};
-
-		led1r {
-			label = "led1:red";
-			gpios = <&pioB 1 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
-		};
-
-		led2g {
-			label = "led2:green";
-			gpios = <&pioB 2 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
-			default-state = "on";
-		};
-
-		led2r {
-			label = "led2:red";
-			gpios = <&pioB 3 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "none";
-		};
-	};
-
-	gpio_keys {
-		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reset {
-			label = "reset";
-			gpios = <&pioB 30 GPIO_ACTIVE_LOW>;
-			linux,code = <0x100>;
-			gpio-key,wakeup;
-		};
-
-		mode {
-			label = "mode";
-			gpios = <&pioB 31 GPIO_ACTIVE_LOW>;
-			linux,code = <0x101>;
-			gpio-key,wakeup;
-		};
-	};
-};
-- 
1.9.1
