From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:22:54 +0100
Subject: [PATCH 14/22] ARM: dts: add a devicetree for Raidsonic NAS IB-4220-B
Message-ID: <20170122122254.10764-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This devicetree is simply based on the board file in
arch/arm/mach-gemini/board-nas4220b.c and contain the
equivalent platform data, mainly just moving the GPIOs
from the global numberspace to explicitly reference &gpio1.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/gemini-nas4220b.dts | 68 +++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 arch/arm/boot/dts/gemini-nas4220b.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 10edd72a6f3d..fb141e11f8ed 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -169,6 +169,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5440-ssdk5440.dtb \
 	exynos5800-peach-pi.dtb
 dtb-$(CONFIG_ARCH_GEMINI) += \
+	gemini-nas4220b.dtb \
 	gemini-sq201.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += \
 	hi3620-hi4511.dtb
diff --git a/arch/arm/boot/dts/gemini-nas4220b.dts b/arch/arm/boot/dts/gemini-nas4220b.dts
new file mode 100644
index 000000000000..bf12638abb45
--- /dev/null
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -0,0 +1,68 @@
+/*
+ * Device Tree file for the Gemini-based Raidsonic NAS IB-4220-B
+ */
+
+/dts-v1/;
+
+#include "gemini.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Raidsonic NAS IB-4220-B";
+	compatible = "raidsonic,ib-4220-b", "cortina,gemini";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory { /* 128 MB */
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+		stdout-path = &uart0;
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 29 {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <KEY_SETUP>;
+			label = "Backup button";
+			gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+		};
+		button at 31 {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <KEY_RESTART>;
+			label = "Softreset button";
+			gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led at 28 {
+			label = "nas4220b:orange:hdd";
+			gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+		led at 30 {
+			label = "nas4220b:green:os";
+			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	flash at 30000000 {
+		status = "okay";
+		/* 16MB of flash */
+		reg = <0x30000000 0x01000000>;
+		/* TODO: add flash partitions here */
+	};
+};
-- 
2.9.3
