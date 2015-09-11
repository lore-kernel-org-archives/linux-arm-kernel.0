From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 11 Sep 2015 23:52:51 +0200
Subject: [PATCH v2 1/3] ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay
In-Reply-To: <1442008373-19184-1-git-send-email-simon.guinot@sequanux.org>
References: <1442008373-19184-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1442008373-19184-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Donnefort <vdonnefort@gmail.com>

This patch adds DT support for the Seagate NAS 2 and 4-Bay.

Here are some informations allowing to identify these devices:

Product name                 | Seagate NAS 2-Bay | Seagate NAS 4-Bay
Code name (board/PCB)        | Dart 2-Bay        | Dart 4-Bay
Model name (case sticker)    | SRPD20            | SRPD40
Material desc (product spec) | STCTxxxxxxx       | STCUxxxxxxx

Chipset list (common):
- SoC Marvell Armada 370 88F6707, CPU @1.2GHz
- SDRAM memory: 512MB DDR3 600MHz (16-bits bandwidth)
- NAND flash 256MB, 8-bits (Micron MT29F2G08AAB or Hinyx H27U2G8F2CTR-BC)
- 2 SATA II ports (SoC)
- 1 Ethernet Gigabit ports (PHY Marvell 88E1518)
- 2 USB3 host ports (PCIe controller ASM1042)
- GPIO fan (4 speeds)
- External I2C RTC (MCP7940NT)
- 3 push buttons (power, backup and reset)
- 2 SATA LEDs (bi-color, blue and red)
- 1 power LED (bi-color, blue and red)

Only on 4-Bay models:
- 2 extra SATA III ports (PCIe AHCI controller Marvell 88SE9170)
- 1 extra Ethernet Gigabit ports (PHY Marvell 88E1518)
- I2C GPIO expander (PCA9554A)
- 2 extra SATA LEDs (bi-color, blue and red)

Note that support for the white SATA LEDs associated with HDDs 0 and 1
is missing. A dedicated LED driver is needed.

Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
---
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  |  36 ++++
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  | 133 ++++++++++++
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi | 231 +++++++++++++++++++++
 4 files changed, 402 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi

Changes for v2:
- Rename DTS files using the products names.
- Update model and compatible properties as well.
- Add some informations allowing to identify the devices in the commit
  message and in the DTS files headers.
- Remove duplicated rtc alias in armada-370-seagate-nas-xbay.dtsi.

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 233159d2eaab..4f89c35239c0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -702,6 +702,8 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 	armada-370-netgear-rn102.dtb \
 	armada-370-netgear-rn104.dtb \
 	armada-370-rd.dtb \
+	armada-370-seagate-nas-2bay.dtb \
+	armada-370-seagate-nas-4bay.dtb \
 	armada-370-synology-ds213j.dtb
 dtb-$(CONFIG_MACH_ARMADA_375) += \
 	armada-375-db.dtb
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
new file mode 100644
index 000000000000..43dd69a54ff1
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
@@ -0,0 +1,36 @@
+/*
+ * Device Tree file for Seagate NAS 2-Bay (Armada 370 SoC).
+ *
+ * Copyright (C) 2015 Seagate
+ *
+ * Author: Vincent Donnefort <vdonnefort@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/*
+ * Here are some informations allowing to identify the device:
+ *
+ * Product name                 : Seagate NAS 2-Bay
+ * Code name (board/PCB)        : Dart 2-Bay
+ * Model name (case sticker)    : SRPD20
+ * Material desc (product spec) : STCTxxxxxxx
+ */
+
+/dts-v1/;
+#include "armada-370-seagate-nas-xbay.dtsi"
+
+/ {
+	model = "Seagate NAS 2-Bay (Dart, SRPD20)";
+	compatible = "seagate,dart-2", "marvell,armada370", "marvell,armada-370-xp";
+
+	gpio-fan {
+		gpio-fan,speed-map =
+			<   0 3
+			  950 2
+			 1400 1
+			 1800 0>;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
new file mode 100644
index 000000000000..bc3e6a3a233b
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -0,0 +1,133 @@
+/*
+ * Device Tree file for Seagate NAS 4-Bay (Armada 370 SoC).
+ *
+ * Copyright (C) 2015 Seagate
+ *
+ * Author: Vincent Donnefort <vdonnefort@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/*
+ * Here are some informations allowing to identify the device:
+ *
+ * Product name                 : Seagate NAS 4-Bay
+ * Code name (board/PCB)        : Dart 4-Bay
+ * Model name (case sticker)    : SRPD40
+ * Material desc (product spec) : STCUxxxxxxx
+ */
+
+/dts-v1/;
+#include "armada-370-seagate-nas-xbay.dtsi"
+#include <dt-bindings/leds/leds-ns2.h>
+
+/ {
+	model = "Seagate NAS 4-Bay (Dart, SRPD40)";
+	compatible = "seagate,dart-4", "marvell,armada370", "marvell,armada-370-xp";
+
+	soc {
+		pcie-controller {
+			/* SATA AHCI controller 88SE9170 */
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+
+		internal-regs {
+			mdio {
+				phy1: ethernet-phy at 1 {
+					reg = <1>;
+				};
+			};
+
+			ethernet at 74000 {
+				status = "okay";
+				pinctrl-0 = <&ge1_rgmii_pins>;
+				pinctrl-names = "default";
+				phy = <&phy1>;
+				phy-mode = "rgmii-id";
+			};
+
+			i2c at 11000 {
+				/* I2C GPIO expander (PCA9554A) */
+				pca9554: pca9554 at 21 {
+					compatible = "nxp,pca9554";
+					reg = <0x21>;
+					#gpio-cells = <2>;
+					gpio-controller;
+				};
+			};
+		};
+	};
+
+	regulators {
+		regulator at 3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "SATA2 power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&pca9554 6 GPIO_ACTIVE_HIGH>;
+		};
+		regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "SATA3 power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&pca9554 7 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-leds {
+		red-sata2 {
+			label = "dart:red:sata2";
+			gpios = <&pca9554 0 GPIO_ACTIVE_LOW>;
+		};
+		red-sata3 {
+			label = "dart:red:sata3";
+			gpios = <&pca9554 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds-ns2 {
+		compatible = "lacie,ns2-leds";
+
+		white-sata2 {
+			label = "dart:white:sata2";
+			cmd-gpio = <&pca9554 1 GPIO_ACTIVE_HIGH>;
+			slow-gpio = <&pca9554 2 GPIO_ACTIVE_HIGH>;
+			num-modes = <4>;
+			modes-map = <NS_V2_LED_SATA 0 0
+				     NS_V2_LED_OFF  0 1
+				     NS_V2_LED_ON   1 0
+				     NS_V2_LED_ON   1 1>;
+		};
+		white-sata3 {
+			label = "dart:white:sata3";
+			cmd-gpio = <&pca9554 4 GPIO_ACTIVE_HIGH>;
+			slow-gpio = <&pca9554 5 GPIO_ACTIVE_HIGH>;
+			num-modes = <4>;
+			modes-map = <NS_V2_LED_SATA 0 0
+				     NS_V2_LED_OFF  0 1
+				     NS_V2_LED_ON   1 0
+				     NS_V2_LED_ON   1 1>;
+		};
+	};
+
+	gpio-fan {
+		gpio-fan,speed-map =
+			<   0 3
+			  800 2
+			  1050 1
+			  1300 0>;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
new file mode 100644
index 000000000000..a04e7105edd4
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -0,0 +1,231 @@
+/*
+ * Device Tree common file for the Seagate NAS 2 and 4-bay (Armada 370 SoC).
+ *
+ * Copyright (C) 2015 Seagate
+ *
+ * Author: Vincent Donnefort <vdonnefort@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/*
+ * TODO: add support for the white SATA LEDs associated with HDD 0 and 1.
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
+			/* USB 3.0 bridge ASM1042A */
+			pcie at 2,0 {
+				status = "okay";
+			};
+		};
+
+		internal-regs {
+			serial at 12000 {
+				status = "okay";
+			};
+
+			sata at a0000 {
+				nr-ports = <2>;
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
+			ethernet at 70000 {
+				status = "okay";
+				pinctrl-0 = <&ge0_rgmii_pins>;
+				pinctrl-names = "default";
+				phy = <&phy0>;
+				phy-mode = "rgmii-id";
+			};
+
+			i2c at 11000 {
+				status = "okay";
+				pinctrl-0 = <&i2c0_pins>;
+				pinctrl-names = "default";
+				clock-frequency = <100000>;
+
+				/* RTC - NXP 8563T (second source) */
+				rtc at 51 {
+					compatible = "nxp,pcf8563";
+					reg = <0x51>;
+					interrupts = <110>;
+				};
+				/* RTC - MCP7940NT */
+				rtc at 6f {
+					compatible = "microchip,mcp7941x";
+					reg = <0x6f>;
+					interrupts = <110>;
+				};
+			};
+
+			nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
+
+				partition at 0 {
+					label = "u-boot";
+					reg = <0x0 0x300000>;
+				};
+				partition at 300000 {
+					label = "device-tree";
+					reg = <0x300000 0x20000>;
+				};
+				partition at 320000 {
+					label = "linux";
+					reg = <0x320000 0x2000000>;
+				};
+				partition at 2320000 {
+					label = "rootfs";
+					reg = <0x2320000 0xdce0000>;
+				};
+			};
+		};
+
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+
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
+
+	gpio-fan {
+		compatible = "gpio-fan";
+		gpios = <&gpio2 0 0
+			 &gpio2 1 0>;
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
+			gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+			debounce-interval = <100>;
+		};
+		button at 2 {
+			label = "Backup button";
+			linux,code = <KEY_OPTION>;
+			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
+			debounce-interval = <100>;
+		};
+		button at 3 {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
+			debounce-interval = <100>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		white-power {
+			label = "dart:white:power";
+			gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "timer";
+
+		};
+		red-power {
+			label = "dart:red:power";
+			gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
+		};
+		red-sata0 {
+			label = "dart:red:sata0";
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+		};
+		red-sata1 {
+			label = "dart:red:sata1";
+			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio_poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	pinctrl-0 = <&hdd0_led_sata_pin>, <&hdd1_led_sata_pin>;
+	pinctrl-names = "default";
+
+	hdd0_led_sata_pin: hdd0-led-sata-pin {
+		marvell,pins = "mpp48";
+		marvell,function = "sata1";
+	};
+	hdd0_led_gpio_pin: hdd0-led-gpio-pin {
+		marvell,pins = "mpp48";
+		marvell,function = "gpio";
+	};
+	hdd1_led_sata_pin: hdd1-led-sata-pin {
+		marvell,pins = "mpp57";
+		marvell,function = "sata0";
+	};
+	hdd1_led_gpio_pin: hdd1-led-gpio-pin {
+		marvell,pins = "mpp57";
+		marvell,function = "gpio";
+	};
+};
-- 
2.1.4
