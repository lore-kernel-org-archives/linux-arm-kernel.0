From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:23:23 +0100
Subject: [PATCH 17/22] ARM: dts: add a devicetree for Wiliboard WBD-222
Message-ID: <20170122122323.10912-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This devicetree is simply based on the board file in
arch/arm/mach-gemini/board-wbd222.c and contain the
equivalent platform data, mainly just moving the GPIOs
from the global numberspace to explicitly reference their
parent GPIO.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile          |   3 +-
 arch/arm/boot/dts/gemini-wbd222.dts | 101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/gemini-wbd222.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 144584a83582..52d1cfbaa1da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -172,7 +172,8 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
 	gemini-nas4220b.dtb \
 	gemini-rut1xx.dtb \
 	gemini-sq201.dtb \
-	gemini-wbd111.dtb
+	gemini-wbd111.dtb \
+	gemini-wbd222.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += \
 	hi3620-hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += \
diff --git a/arch/arm/boot/dts/gemini-wbd222.dts b/arch/arm/boot/dts/gemini-wbd222.dts
new file mode 100644
index 000000000000..47ac6c6762c5
--- /dev/null
+++ b/arch/arm/boot/dts/gemini-wbd222.dts
@@ -0,0 +1,101 @@
+/*
+ * Device Tree file for Wiliboard WBD-222
+ */
+
+/dts-v1/;
+
+#include "gemini.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Wiliboard WBD-222";
+	compatible = "wiliboard,wbd222", "cortina,gemini";
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
+		button at 5 {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <KEY_SETUP>;
+			label = "reset";
+			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led at 1 {
+			label = "wbd111:red:L3";
+			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led at 2 {
+			label = "wbd111:green:L4";
+			gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led at 3 {
+			label = "wbd111:red:L4";
+			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led at 5 {
+			label = "wbd111:green:L3";
+			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	flash at 30000000 {
+		status = "okay";
+		/* 8MB of flash */
+		reg = <0x30000000 0x00800000>;
+
+		/* FIXME */
+		partition at 0 {
+			label = "RedBoot";
+			reg = <0x00000000 0x00020000>;
+			read-only;
+		};
+		partition at 20000 {
+			label = "kernel";
+			reg = <0x00020000 0x00100000>;
+		};
+		partition at 120000 {
+			label = "rootfs";
+			reg = <0x00120000 0x006a0000>;
+		};
+		partition at 7c0000 {
+			label = "VCTL";
+			reg = <0x007c0000 0x00010000>;
+			read-only;
+		};
+		partition at 7d0000 {
+			label = "cfg";
+			reg = <0x007d0000 0x00010000>;
+			read-only;
+		};
+		partition at 7e0000 {
+			label = "FIS";
+			reg = <0x007e0000 0x00010000>;
+			read-only;
+		};
+	};
+};
-- 
2.9.3
