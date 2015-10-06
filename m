From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue,  6 Oct 2015 16:13:43 +0200
Subject: [PATCH v5 3/4] ARM: mvebu: add DT support for Seagate Personal Cloud
In-Reply-To: <1444140824-24132-1-git-send-email-simon.guinot@sequanux.org>
References: <1444140824-24132-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1444140824-24132-4-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT support for the Seagate Personal Cloud 1 and 2-Bay.

Here are some information allowing to identify these devices:

Product name                 | Personal Cloud | Personal Cloud 2-Bay
Code name (board/PCB)        | Cumulus        | Cumulus Max
Model name (case sticker)    | SRN21C         | SRN22C
Material desc (product spec) | STCRxxxxxxx    | STCSxxxxxxx

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
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/Makefile                         |   2 +
 .../dts/armada-370-seagate-personal-cloud-2bay.dts |  51 ++++++
 .../boot/dts/armada-370-seagate-personal-cloud.dts |  37 +++++
 .../dts/armada-370-seagate-personal-cloud.dtsi     | 178 +++++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi

Changes for v2:
- Rename DTS files using the products names.
- Update model and compatible properties as well.
- Add some information allowing to identify the devices in the commit
  message and in the DTS files headers.

Changes for v3:
- Fix spelling for Personal Cloud DTS files: 'personal' instead of
  'personnal'.
- Add Andrew's Acked-by.

Changes for v4:
- Add "broken-idle" property in the coherency-fabric DT node.

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a0cc0b63db41..8e83da127a9c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -712,6 +712,8 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 	armada-370-rd.dtb \
 	armada-370-seagate-nas-2bay.dtb \
 	armada-370-seagate-nas-4bay.dtb \
+	armada-370-seagate-personal-cloud.dtb \
+	armada-370-seagate-personal-cloud-2bay.dtb \
 	armada-370-synology-ds213j.dtb
 dtb-$(CONFIG_MACH_ARMADA_375) += \
 	armada-375-db.dtb
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
new file mode 100644
index 000000000000..3c91f9821c89
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
@@ -0,0 +1,51 @@
+/*
+ * Device Tree file for Seagate Personal Cloud NAS 2-Bay (Armada 370 SoC).
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
+ * Here are some information allowing to identify the device:
+ *
+ * Product name                 : Seagate Personal Cloud 2-Bay
+ * Code name (board/PCB)        : Cumulus Max
+ * Model name (case sticker)    : SRN22C
+ * Material desc (product spec) : STCSxxxxxxx
+ */
+
+/dts-v1/;
+#include "armada-370-seagate-personal-cloud.dtsi"
+
+/ {
+	model = "Seagate Personal Cloud 2-Bay (Cumulus, SRN22C)";
+	compatible = "seagate,cumulus-max", "marvell,armada370", "marvell,armada-370-xp";
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
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
new file mode 100644
index 000000000000..aad39e97af43
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
@@ -0,0 +1,37 @@
+/*
+ * Device Tree file for Seagate Personal Cloud NAS (Armada 370 SoC).
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
+ * Here are some information allowing to identify the device:
+ *
+ * Product name                 : Seagate Personal Cloud
+ * Code name (board/PCB)        : Cumulus
+ * Model name (case sticker)    : SRN21C
+ * Material desc (product spec) : STCRxxxxxxx
+ */
+
+/dts-v1/;
+#include "armada-370-seagate-personal-cloud.dtsi"
+
+/ {
+	model = "Seagate Personal Cloud (Cumulus, SRN21C)";
+	compatible = "seagate,cumulus", "marvell,armada370", "marvell,armada-370-xp";
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
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
new file mode 100644
index 000000000000..1aba08e4377c
--- /dev/null
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -0,0 +1,178 @@
+/*
+ * Device Tree common file for the Seagate Personal Cloud NAS 1 and 2-Bay
+ * (Armada 370 SoC).
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
+			coherency-fabric at 20200 {
+				broken-idle;
+			};
+
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
+			label = "cumulus:red:sata0";
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
