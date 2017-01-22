From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:23:03 +0100
Subject: [PATCH 15/22] ARM: dts: add a devicetree for Teltonika RUT1xx
Message-ID: <20170122122303.10813-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This devicetree is simply based on the board file in
arch/arm/mach-gemini/board-rut1xx.c and contain the
equivalent platform data, mainly just moving the GPIOs
from the global numberspace to explicitly reference their
parent GPIO.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile          |  1 +
 arch/arm/boot/dts/gemini-rut1xx.dts | 63 +++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 arch/arm/boot/dts/gemini-rut1xx.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fb141e11f8ed..517306f28427 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -170,6 +170,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5800-peach-pi.dtb
 dtb-$(CONFIG_ARCH_GEMINI) += \
 	gemini-nas4220b.dtb \
+	gemini-rut1xx.dtb \
 	gemini-sq201.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += \
 	hi3620-hi4511.dtb
diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
new file mode 100644
index 000000000000..4807974bbf22
--- /dev/null
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -0,0 +1,63 @@
+/*
+ * Device Tree file for Teltonika RUT1xx
+ */
+
+/dts-v1/;
+
+#include "gemini.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Teltonika RUT1xx";
+	compatible = "teltonika,rut1xx", "cortina,gemini";
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
+		button at 28 {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <KEY_SETUP>;
+			label = "Reset to defaults";
+			gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led at 7 {
+			/* FIXME: add the LED color */
+			label = "rut1xx::gsm";
+			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+		led at 31 {
+			/* FIXME: add the LED color */
+			label = "rut1xx::power";
+			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	flash at 30000000 {
+		status = "okay";
+		/* 8MB of flash */
+		reg = <0x30000000 0x00800000>;
+		/* TODO: add flash partitions here */
+	};
+};
-- 
2.9.3
