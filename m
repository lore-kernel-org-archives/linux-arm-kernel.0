From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:22:46 +0100
Subject: [PATCH 13/22] ARM: dts: add device tree for Gemini SoC and SQ201
Message-ID: <20170122122246.10714-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a device tree for the Gemini SoC and the ITian
Square One SQ201 board that has been my testing target
for Gemini device tree support.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile         |  2 +
 arch/arm/boot/dts/gemini-sq201.dts | 94 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/gemini.dtsi      | 96 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 arch/arm/boot/dts/gemini-sq201.dts
 create mode 100644 arch/arm/boot/dts/gemini.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cccdbcb557b6..10edd72a6f3d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -168,6 +168,8 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb \
 	exynos5800-peach-pi.dtb
+dtb-$(CONFIG_ARCH_GEMINI) += \
+	gemini-sq201.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += \
 	hi3620-hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += \
diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
new file mode 100644
index 000000000000..1fd87d6a880f
--- /dev/null
+++ b/arch/arm/boot/dts/gemini-sq201.dts
@@ -0,0 +1,94 @@
+/*
+ * Device Tree file for ITian Square One SQ201 NAS
+ */
+
+/dts-v1/;
+
+#include "gemini.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "ITian Square One SQ201";
+	compatible = "itian,sq201", "cortina,gemini";
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
+		button at 18 {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <KEY_SETUP>;
+			label = "factory reset";
+			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led at 20 {
+			label = "sq201:green:info";
+			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+		led at 31 {
+			label = "sq201:green:usb";
+			gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "usb-host";
+		};
+	};
+
+	flash at 30000000 {
+		status = "okay";
+		/* 16MB of flash */
+		reg = <0x30000000 0x01000000>;
+
+		partition at 0 {
+			label = "RedBoot";
+			reg = <0x00000000 0x00120000>;
+			read-only;
+		};
+		partition at 120000 {
+			label = "Kernel";
+			reg = <0x00120000 0x00200000>;
+		};
+		partition at 320000 {
+			label = "Ramdisk";
+			reg = <0x00320000 0x00600000>;
+		};
+		partition at 920000 {
+			label = "Application";
+			reg = <0x00920000 0x00600000>;
+		};
+		partition at f20000 {
+			label = "VCTL";
+			reg = <0x00f20000 0x00020000>;
+			read-only;
+		};
+		partition at f40000 {
+			label = "CurConf";
+			reg = <0x00f40000 0x000a0000>;
+			read-only;
+		};
+		partition at fe0000 {
+			label = "FIS directory";
+			reg = <0x00fe0000 0x00020000>;
+			read-only;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
new file mode 100644
index 000000000000..19c93cfbeae3
--- /dev/null
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -0,0 +1,96 @@
+/*
+ * Device Tree file for Cortina systems Gemini SoC
+ */
+
+/include/ "skeleton.dtsi"
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	interrupt-parent = <&intcon>;
+
+	flash at 30000000 {
+		compatible = "cortina,gemini-flash", "cfi-flash";
+		syscon = <&syscon>;
+		bank-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		status = "disabled";
+	};
+
+	syscon: syscon at 40000000 {
+		compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
+		reg = <0x40000000 0x1000>;
+
+		syscon-reboot {
+			compatible = "syscon-reboot";
+			regmap = <&syscon>;
+			/* GLOBAL_RESET register */
+			offset = <0x0c>;
+			/* RESET_GLOBAL | RESET_CPU1 */
+			mask = <0xC0000000>;
+		};
+	};
+
+	timer at 43000000 {
+		compatible = "cortina,gemini-timer";
+		reg = <0x43000000 0x1000>;
+		interrupt-parent = <&intcon>;
+		interrupts = <14 IRQ_TYPE_EDGE_RISING>, /* Timer 1 */
+			   <15 IRQ_TYPE_EDGE_RISING>, /* Timer 2 */
+			   <16 IRQ_TYPE_EDGE_RISING>; /* Timer 3 */
+		syscon = <&syscon>;
+	};
+
+	uart0: serial at 42000000 {
+		compatible = "ns16550a";
+		reg = <0x42000000 0x100>;
+		clock-frequency = <48000000>;
+		interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+	};
+
+	rtc at 45000000 {
+		compatible = "cortina,gemini-rtc";
+		reg = <0x45000000 0x100>;
+		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	intcon: interrupt-controller at 48000000 {
+		compatible = "cortina,gemini-interrupt-controller";
+		reg = <0x48000000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio0: gpio at 4d000000 {
+		compatible = "cortina,gemini-gpio";
+		reg = <0x4d000000 0x100>;
+		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio1: gpio at 4e000000 {
+		compatible = "cortina,gemini-gpio";
+		reg = <0x4e000000 0x100>;
+		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio2: gpio at 4f000000 {
+		compatible = "cortina,gemini-gpio";
+		reg = <0x4f000000 0x100>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
-- 
2.9.3
