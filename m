From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Nov 2017 16:47:20 +0100
Subject: [PATCH] ARM: dts: Add basic devicetree for D-Link DNS-313
Message-ID: <20171129154720.16662-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a basic device tree for the D-Link DNS-313
NAS enclosure.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 179 +++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100644 arch/arm/boot/dts/gemini-dlink-dns-313.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..4388905a4326 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -192,6 +192,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5800-peach-pi.dtb
 dtb-$(CONFIG_ARCH_GEMINI) += \
 	gemini-dlink-dir-685.dtb \
+	gemini-dlink-dns-313.dtb \
 	gemini-nas4220b.dtb \
 	gemini-rut1xx.dtb \
 	gemini-sq201.dtb \
diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
new file mode 100644
index 000000000000..aec9343e7e84
--- /dev/null
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for D-Link DNS-313 1-Bay Network Storage Enclosure
+ */
+
+/dts-v1/;
+
+#include "gemini.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "D-Link DNS-313 1-Bay Network Storage Enclosure";
+	compatible = "dlink,dir-313", "cortina,gemini";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		/* 64 MB SDRAM in a Nanya NT5DS32M16BS-6K package */
+		device_type = "memory";
+		reg = <0x00000000 0x4000000>;
+	};
+
+	aliases {
+		mdio-gpio0 = &mdio0;
+	};
+
+	chosen {
+		stdout-path = "uart0:19200n8";
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button-esc {
+			debounce_interval = <50>;
+			wakeup-source;
+			linux,code = <KEY_ESC>;
+			label = "reset";
+			gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-power {
+			label = "dns313:blue:power";
+			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+		led-disk-blue {
+			label = "dns313:blue:disk";
+			gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+		led-disk-green {
+			label = "dns313:green:disk";
+			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "ide-disk";
+			/* Ideally should activate while reading */
+		};
+		led-disk-red {
+			label = "dns313:red:disk";
+			gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			/* Ideally should activate while writing */
+		};
+	};
+
+	/*
+	 * This is a ADDA AD0405GB-G73 fan @3000 and 6000 RPM.
+	 */
+	gpio-fan {
+		compatible = "gpio-fan";
+		gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>,
+			<&gpio0 12 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <0 0>, <3000 1>, <6000 2>;
+		/* If this falls, something is wrong */
+		// alarm-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+		#cooling-cells = <2>;
+	};
+
+
+	mdio0: ethernet-phy {
+		compatible = "virtual,mdio-gpio";
+		/* Uses MDC and MDIO */
+		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
+			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* This is a Realtek RTL8211B Gigabit ethernet transceiver */
+		phy0: ethernet-phy at 0 {
+			reg = <1>;
+			device_type = "ethernet-phy";
+		};
+	};
+
+	soc {
+		flash at 30000000 {
+			status = "okay";
+			/* 512KB of flash */
+			reg = <0x30000000 0x00080000>;
+
+			/*
+			 * This "RedBoot" is the Storlink derivative.
+			 */
+			partition at 0 {
+				label = "RedBoot";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			partition at 40000 {
+				label = "MTD1";
+				reg = <0x00040000 0x00020000>;
+				read-only;
+			};
+			partition at 60000 {
+				label = "MTD2";
+				reg = <0x00060000 0x00020000>;
+				read-only;
+			};
+		};
+
+		syscon: syscon at 40000000 {
+			pinctrl {
+				/*
+				 */
+				gpio0_default_pins: pinctrl-gpio0 {
+					mux {
+						function = "gpio0";
+						groups =
+						/* Used by LEDs conflicts ICE */
+						"gpio0bgrp",
+						/* Used by ? conflicts ICE */
+						"gpio0cgrp",
+						/*
+						 * Used by fan, conflicts LPC,
+						 * UART modem lines, SSP
+						 */
+						"gpio0egrp",
+						/* Used by MDIO */
+						"gpio0igrp";
+					};
+				};
+				gpio1_default_pins: pinctrl-gpio1 {
+					mux {
+						function = "gpio1";
+						/* Used by "reset" button */
+						groups = "gpio1dgrp";
+					};
+				};
+			};
+		};
+
+		sata: sata at 46000000 {
+			/* The ROM uses this muxmode */
+			cortina,gemini-ata-muxmode = <3>;
+			cortina,gemini-enable-sata-bridge;
+			status = "okay";
+		};
+
+		gpio0: gpio at 4d000000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio0_default_pins>;
+		};
+
+		gpio1: gpio at 4e000000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&gpio1_default_pins>;
+		};
+
+		ata at 63000000 {
+			status = "okay";
+		};
+	};
+};
-- 
2.14.3
