From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 29 Aug 2015 18:46:43 +0200
Subject: [PATCH 1/3] ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay
In-Reply-To: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
References: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1440866805-31731-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Donnefort <vdonnefort@gmail.com>

This patch adds DT support for the Seagate NAS 2 and 4-Bay (n090201 and
n090401).

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
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/armada-370-n090201.dts  |  28 ++++
 arch/arm/boot/dts/armada-370-n090401.dts  | 124 ++++++++++++++++
 arch/arm/boot/dts/armada-370-n090x01.dtsi | 232 ++++++++++++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-n090201.dts
 create mode 100644 arch/arm/boot/dts/armada-370-n090401.dts
 create mode 100644 arch/arm/boot/dts/armada-370-n090x01.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 233159d2eaab..0a46613e90d2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -699,6 +699,8 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 	armada-370-db.dtb \
 	armada-370-dlink-dns327l.dtb \
 	armada-370-mirabox.dtb \
+	armada-370-n090201.dtb \
+	armada-370-n090401.dtb \
 	armada-370-netgear-rn102.dtb \
 	armada-370-netgear-rn104.dtb \
 	armada-370-rd.dtb \
diff --git a/arch/arm/boot/dts/armada-370-n090201.dts b/arch/arm/boot/dts/armada-370-n090201.dts
new file mode 100644
index 000000000000..b92b1ee067d6
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-n090201.dts
@@ -0,0 +1,28 @@
+/*
+ * Device Tree file for Seagate NAS 2-Bay (n090201)
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
+/dts-v1/;
+
+#include "armada-370-n090x01.dtsi"
+
+/ {
+	model = "Seagate NAS 2-Bay";
+	compatible = "seagate,n090201", "marvell,armada370", "marvell,armada-370-xp";
+
+	gpio-fan {
+		gpio-fan,speed-map =
+			<   0 3
+			  950 2
+			 1400 1
+			 1800 0>;
+	};
+};
diff --git a/arch/arm/boot/dts/armada-370-n090401.dts b/arch/arm/boot/dts/armada-370-n090401.dts
new file mode 100644
index 000000000000..c36f10f0eb04
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-n090401.dts
@@ -0,0 +1,124 @@
+/*
+ * Device Tree file for Seagate NAS 4-Bay
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
+/dts-v1/;
+#include "armada-370-n090x01.dtsi"
+#include <dt-bindings/leds/leds-ns2.h>
+
+/ {
+	model = "Seagate NAS 4-Bay";
+	compatible = "seagate,n090401", "marvell,armada370", "marvell,armada-370-xp";
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
+			label = "n090x01:red:sata2";
+			gpios = <&pca9554 0 GPIO_ACTIVE_LOW>;
+		};
+		red-sata3 {
+			label = "n090x01:red:sata3";
+			gpios = <&pca9554 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds-ns2 {
+		compatible = "lacie,ns2-leds";
+
+		white-sata2 {
+			label = "n090x01:white:sata2";
+			cmd-gpio = <&pca9554 1 GPIO_ACTIVE_HIGH>;
+			slow-gpio = <&pca9554 2 GPIO_ACTIVE_HIGH>;
+			num-modes = <4>;
+			modes-map = <NS_V2_LED_SATA 0 0
+				     NS_V2_LED_OFF  0 1
+				     NS_V2_LED_ON   1 0
+				     NS_V2_LED_ON   1 1>;
+		};
+		white-sata3 {
+			label = "n090x01:white:sata3";
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
diff --git a/arch/arm/boot/dts/armada-370-n090x01.dtsi b/arch/arm/boot/dts/armada-370-n090x01.dtsi
new file mode 100644
index 000000000000..6142136f2db5
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-n090x01.dtsi
@@ -0,0 +1,232 @@
+/*
+ * Device Tree common file for the Seagate NAS 2 and 4-bay
+ * (n090201 and n090401).
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
+				rtc: rtc at 51 {
+					compatible = "nxp,pcf8563";
+					reg = <0x51>;
+					interrupts = <110>;
+				};
+				/* RTC - MCP7940NT */
+				rtc: rtc at 6f {
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
+			label = "n090x01:white:power";
+			gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "timer";
+
+		};
+		red-power {
+			label = "n090x01:red:power";
+			gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
+		};
+		red-sata0 {
+			label = "n090x01:red:sata0";
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+		};
+		red-sata1 {
+			label = "n090x01:red:sata1";
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
