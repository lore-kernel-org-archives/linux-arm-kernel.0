From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 15 Apr 2013 23:14:43 +0200
Subject: [PATCH v5 6/6] ARM: dts: Add dts file for S3C6410-based Mini6410 board
In-Reply-To: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1366060483-20342-7-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic device tree sources for FriendlyARM Mini6410 board
based on Samsung S3C6410 SoC.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/s3c6410-mini6410.dts | 168 +++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 arch/arm/boot/dts/s3c6410-mini6410.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 11fef62..5885c37 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -138,6 +138,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 	hrefprev60.dtb \
 	hrefv60plus.dtb \
 	ccu9540.dtb
+dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	sh73a0-kzm9g.dtb \
diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
new file mode 100644
index 0000000..679b1bb
--- /dev/null
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -0,0 +1,168 @@
+/*
+ * Samsung's S3C6410 based Mini6410 board device tree source
+ *
+ * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Device tree source file for FriendlyARM Mini6410 board which is based on
+ * Samsung's S3C6410 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+/include/ "s3c6410.dtsi"
+
+/ {
+	model = "FriendlyARM Mini6410 board based on S3C6410";
+	compatible = "friendlyarm,mini6410", "samsung,s3c6410";
+
+	memory {
+		reg = <0x50000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttySAC0,115200n8 earlyprintk rootwait root=/dev/mmcblk0p1";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys>;
+		autorepeat;
+
+		button-k1 {
+			label = "K1";
+			gpios = <&gpn 0 1>;
+			linux,code = <2>;
+			debounce-interval = <20>;
+		};
+
+		button-k2 {
+			label = "K2";
+			gpios = <&gpn 1 1>;
+			linux,code = <3>;
+			debounce-interval = <20>;
+		};
+
+		button-k3 {
+			label = "K3";
+			gpios = <&gpn 2 1>;
+			linux,code = <4>;
+			debounce-interval = <20>;
+		};
+
+		button-k4 {
+			label = "K4";
+			gpios = <&gpn 3 1>;
+			linux,code = <5>;
+			debounce-interval = <20>;
+		};
+
+		button-k5 {
+			label = "K5";
+			gpios = <&gpn 4 1>;
+			linux,code = <6>;
+			debounce-interval = <20>;
+		};
+
+		button-k6 {
+			label = "K6";
+			gpios = <&gpn 5 1>;
+			linux,code = <7>;
+			debounce-interval = <20>;
+		};
+
+		button-k7 {
+			label = "K7";
+			gpios = <&gpl 11 1>;
+			linux,code = <8>;
+			debounce-interval = <20>;
+		};
+
+		button-k8 {
+			label = "K8";
+			gpios = <&gpl 12 1>;
+			linux,code = <9>;
+			debounce-interval = <20>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_leds>;
+
+		led-1 {
+			label = "LED1";
+			gpios = <&gpk 4 1>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-2 {
+			label = "LED2";
+			gpios = <&gpk 5 1>;
+			linux,default-trigger = "mmc0";
+		};
+
+		led-3 {
+			label = "LED3";
+			gpios = <&gpk 6 1>;
+		};
+
+		led-4 {
+			label = "LED4";
+			gpios = <&gpk 7 1>;
+		};
+	};
+};
+
+&pinctrl0 {
+	gpio_leds: gpio-leds {
+		samsung,pins = "gpk-4", "gpk-5", "gpk-6", "gpk-7";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+	};
+
+	gpio_keys: gpio-keys {
+		samsung,pins = "gpn-0", "gpn-1", "gpn-2", "gpn-3",
+				"gpn-4", "gpn-5", "gpl-11", "gpl-12";
+		samsung,pin-pud = <0>;
+	};
+};
+
+&pwm {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_data>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_data>, <&uart1_fctl>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_data>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_data>;
+	status = "okay";
+};
+
+&sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
+	bus-width = <4>;
+	status = "okay";
+};
-- 
1.8.1.5
