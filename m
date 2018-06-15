From: ben.whitten@gmail.com (Ben Whitten)
Date: Fri, 15 Jun 2018 14:40:54 +0100
Subject: [PATCH v2 5/6] arm: dts: add support for Gatwick board based on WB50N
In-Reply-To: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
Message-ID: <1529070055-18701-5-git-send-email-ben.whitten@lairdtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the LoRa gateway from Laird, the RG1xx.
This board houses the WB50NBT CPU module along with a Semtech SX1301 based
concentrator card.
https://www.lairdtech.com/products/rg1xx-lora-gateway

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>

# Conflicts:
#	arch/arm/boot/dts/Makefile
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/at91-gatwick.dts | 121 +++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-gatwick.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 07823be..214d5d9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d2_ptc_ek.dtb \
 	at91-sama5d2_xplained.dtb \
 	at91-sama5d3_xplained.dtb \
+	at91-gatwick.dtb \
 	at91-tse850-3.dtb \
 	at91-wb50n.dtb \
 	sama5d31ek.dtb \
diff --git a/arch/arm/boot/dts/at91-gatwick.dts b/arch/arm/boot/dts/at91-gatwick.dts
new file mode 100644
index 0000000..5a81cab
--- /dev/null
+++ b/arch/arm/boot/dts/at91-gatwick.dts
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * at91-gatwick.dts - Device Tree file for the Gatwick board
+ *
+ *  Copyright (C) 2018 Laird
+ *
+ */
+/dts-v1/;
+#include "at91-wb50n.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Laird Workgroup Bridge 50N - Project Gatwick";
+	compatible = "laird,gatwick", "laird,wb50n", "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio>;
+
+		reset-button {
+			label = "Reset Button";
+			linux,code = <KEY_SETUP>;
+			gpios = <&pioE 31 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		ethernet {
+			label = "gatwick:yellow:ethernet";
+			gpios = <&pioA 10 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		wifi {
+			label = "gatwick:green:wifi";
+			gpios = <&pioA 28 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		ble {
+			label = "gatwick:blue:ble";
+			gpios = <&pioA 22 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		lora {
+			label = "gatwick:orange:lora";
+			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		blank {
+			label = "gatwick:green:blank";
+			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		user {
+			label = "gatwick:yellow:user";
+			gpios = <&pioA 12 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+};
+
+&pinctrl {
+	board {
+		pinctrl_key_gpio: key_gpio_0 {
+		  atmel,pins =
+			  <AT91_PIOE 31 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PE31 GPIO with pullup deglitch */
+	  };
+	};
+};
+
+&mmc0 {
+	status = "okay";
+};
+
+&macb1 {
+	status = "okay";
+};
+
+&dbgu {
+	status = "okay";
+};
+
+/* FTDI USART */
+&usart0 {
+	status = "okay";
+};
+
+/* GPS USART */
+&usart1 {
+	pinctrl-0 = <&pinctrl_usart1>;
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+
+	spidev at 0 {
+		compatible = "semtech,sx1301";
+		reg = <0>;
+		spi-max-frequency = <8000000>;
+	};
+};
+
+&usb1 {
+	status = "okay";
+	/delete-property/atmel,oc-gpio;
+};
+
+&usb2 {
+	status = "okay";
+};
-- 
2.7.4
