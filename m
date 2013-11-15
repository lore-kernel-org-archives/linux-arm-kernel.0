From: kasimling@gmail.com (Alex Ling)
Date: Fri, 15 Nov 2013 21:09:29 +0800
Subject: [PATCH] ARM: dts: add board dts file for EXYNOS4412 based TINY4412
 board
Message-ID: <1384520969-2450-1-git-send-email-kasimling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a minimal board dts file for EXYNOS4412 based FriendlyARM's
TINY4412 board. This patch including adds the node to support
peripherals like UART, SD card on SDMMC2 port, and this patch
adds GPIO connected LEDS and configure its properties like
following:
LED1: use 'heartbeat' trigger, blinking while the board is running.
LED4: use 'mmc0' trigger, on when mmc0 is accessing.
LED2 and LED3 can be controlled from userspace.

Signed-off-by: Alex Ling <kasimling@gmail.com>
---
 arch/arm/boot/dts/Makefile                |    1 +
 arch/arm/boot/dts/exynos4412-tiny4412.dts |   89 +++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-tiny4412.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 802720e..91671a2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -59,6 +59,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4412-odroidx.dtb \
 	exynos4412-origen.dtb \
 	exynos4412-smdk4412.dtb \
+	exynos4412-tiny4412.dtb \
 	exynos4412-trats2.dtb \
 	exynos5250-arndale.dtb \
 	exynos5250-smdk5250.dtb \
diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
new file mode 100644
index 0000000..78ace14
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -0,0 +1,89 @@
+/*
+ * FriendlyARM's Exynos4412 based TINY4412 board device tree source
+ *
+ * Copyright (c) 2013 Alex Ling <kasimling@gmail.com>
+ *
+ * Device tree source file for FriendlyARM's TINY4412 board which is based on
+ * Samsung's Exynos4412 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+#include "exynos4412.dtsi"
+
+/ {
+	model = "FriendlyARM TINY4412 board based on Exynos4412";
+	compatible = "friendlyarm,tiny4412", "samsung,exynos4412";
+
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			label = "led1:heart";
+			gpios = <&gpm4 0 1>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+		led2 {
+			label = "led2";
+			gpios = <&gpm4 1 1>;
+			default-state = "off";
+		};
+		led3 {
+			label = "led3";
+			gpios = <&gpm4 2 1>;
+			default-state = "off";
+		};
+		led4 {
+			label = "led4:mmc0";
+			gpios = <&gpm4 3 1>;
+			default-state = "off";
+			linux,default-trigger = "mmc0";
+		};
+	};
+
+	rtc at 10070000 {
+		status = "okay";
+	};
+
+	sdhci at 12530000 {
+		bus-width = <4>;
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	serial at 13800000 {
+		status = "okay";
+	};
+
+	serial at 13810000 {
+		status = "okay";
+	};
+
+	serial at 13820000 {
+		status = "okay";
+	};
+
+	serial at 13830000 {
+		status = "okay";
+	};
+
+	fixed-rate-clocks {
+		xxti {
+			compatible = "samsung,clock-xxti";
+			clock-frequency = <0>;
+		};
+
+		xusbxti {
+			compatible = "samsung,clock-xusbxti";
+			clock-frequency = <24000000>;
+		};
+	};
+};
-- 
1.7.9.5
