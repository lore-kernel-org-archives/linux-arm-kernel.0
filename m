From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 29 Aug 2015 18:46:44 +0200
Subject: [PATCH 2/3] ARM: mvebu: add DT support for Seagate Personal Cloud
In-Reply-To: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
References: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1440866805-31731-3-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT support for the Seagate Personal Cloud 1 and 2-Bay
(n090103 and n090203).

Chipset list:
- SoC Marvell Armada 370 88F6707, CPU @1GHz
- SDRAM memory: 512MB DDR3 667MHz (16-bits bandwidth)
- SPI flash 1MB (Macronix MX25L8006E)
- 1 or 2 SATA internal ports
- 1 Ethernet Gigabit port (PHY Marvell 88E1518)
- 1 USB3 host port (PCIe controller ASM1042)
- 1 USB2 host port (SoC)
- 2 push buttons (power and reset)
- 1 SATA LED (bi-color, white and red)

Note that support for the white SATA LED is missing. A dedicated LED
driver is needed.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/armada-370-n090103.dts  |  28 +++++
 arch/arm/boot/dts/armada-370-n090203.dts  |  42 ++++++++
 arch/arm/boot/dts/armada-370-n090x03.dtsi | 174 ++++++++++++++++++++++++++++++
 4 files changed, 246 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-n090103.dts
 create mode 100644 arch/arm/boot/dts/armada-370-n090203.dts
 create mode 100644 arch/arm/boot/dts/armada-370-n090x03.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0a46613e90d2..2b30300db972 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -699,7 +699,9 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 	armada-370-db.dtb \
 	armada-370-dlink-dns327l.dtb \
 	armada-370-mirabox.dtb \
+	armada-370-n090103.dtb \
 	armada-370-n090201.dtb \
+	armada-370-n090203.dtb \
 	armada-370-n090401.dtb \
 	armada-370-netgear-rn102.dtb \
 	armada-370-netgear-rn104.dtb \
diff --git a/arch/arm/boot/dts/armada-370-n090103.dts b/arch/arm/boot/dts/armada-370-n090103.dts
new file mode 100644
index 000000000000..c94bed449050
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-n090103.dts
@@ -0,0 +1,28 @@
+/*
+ * Device Tree file for Seagate Personal Cloud NAS (n090103).
+ *
+ * Copyright (C) 2015 Seagate
+ *
+ * Author: Simon Guinot <simon.guinot@sequanux.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "armada-370-n090x03.dtsi"
+
+/ {
+	model = "Seagate Personal Cloud";
+	compatible = "seagate,n090103", "marvell,armada370", "marvell,armada-370-xp";
+
+	soc {
+		internal-regs {
+			sata at a0000 {
+				status = "okay";
+				nr-ports = <1>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-n090203.dts b/arch/arm/boot/dts/armada-370-n090203.dts
new file mode 100644
index 000000000000..3bc62b9f0b0c
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-n090203.dts
@@ -0,0 +1,42 @@
+/*
+ * Device Tree file for Seagate Personnal Cloud 2-Bay NAS (n090203).
+ *
+ * Copyright (C) 2015 Seagate
+ *
+ * Author: Simon Guinot <simon.guinot@sequanux.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "armada-370-n090x03.dtsi"
+
+/ {
+	model = "Seagate Personnal Cloud 2-Bay";
+	compatible = "seagate,n090203", "marvell,armada370", "marvell,armada-370-xp";
+
+	soc {
+		internal-regs {
+			sata at a0000 {
+				status = "okay";
+				nr-ports = <2>;
+			};
+		};
+	};
+
+	regulators {
+		regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "SATA1 power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-n090x03.dtsi b/arch/arm/boot/dts/armada-370-n090x03.dtsi
new file mode 100644
index 000000000000..1bd67869ba78
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-n090x03.dtsi
@@ -0,0 +1,174 @@
+/*
+ * Device Tree common file for the Seagate Personal Cloud 1 and 2-Bay
+ * (n090103 and n090203).
+ *
+ * Copyright (C) 2015 Seagate
+ *
+ * Author: Simon Guinot <simon.guinot@sequanux.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/*
+ * TODO: add support for the white SATA LED.
+ */
+
+#include "armada-370.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>; /* 512 MB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+
+		pcie-controller {
+			status = "okay";
+
+			/* USB 3.0 Bridge ASM1042A */
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+
+		internal-regs {
+			serial at 12000 {
+				status = "okay";
+			};
+
+			mdio {
+				pinctrl-0 = <&mdio_pins>;
+				pinctrl-names = "default";
+
+				phy0: ethernet-phy at 0 {
+					reg = <0>;
+				};
+			};
+
+			ethernet at 74000 {
+				status = "okay";
+				pinctrl-0 = <&ge1_rgmii_pins>;
+				pinctrl-names = "default";
+				phy = <&phy0>;
+				phy-mode = "rgmii-id";
+			};
+
+			spi at 10600 {
+				status = "okay";
+				pinctrl-0 = <&spi0_pins2>;
+				pinctrl-names = "default";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					/* MX25L8006E */
+					compatible = "mxicy,mx25l8005", "jedec,spi-nor";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <50000000>;
+
+					partition at 0 {
+						label = "u-boot";
+						reg = <0x0 0x100000>;
+					};
+				};
+			};
+
+			usb at 50000 {
+				status = "okay";
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "USB Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
+		};
+		regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "SATA0 power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			label = "Power button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+			debounce-interval = <100>;
+		};
+		button at 2 {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
+			debounce-interval = <100>;
+		};
+		button at 3 {
+			label = "USB VBUS error";
+			linux,code = <KEY_UNKNOWN>;
+			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
+			debounce-interval = <100>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		red-sata0 {
+			label = "n090x03:red:sata0";
+			gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&pinctrl {
+	pinctrl-0 = <&sata_led_pin>;
+	pinctrl-names = "default";
+
+	sata_led_pin: sata-led-pin {
+		marvell,pins = "mpp60";
+		marvell,function = "sata0";
+	};
+	gpio_led_pin: gpio-led-pin {
+		marvell,pins = "mpp60";
+		marvell,function = "gpio";
+	};
+};
-- 
2.1.4
