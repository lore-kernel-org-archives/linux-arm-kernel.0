From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Jan 2015 11:51:45 +0100
Subject: [PATCH v2 8/8] ARM: mvebu: Add Armada 385 General Purpose Development
 Board support
In-Reply-To: <1420714305-7496-1-git-send-email-gregory.clement@free-electrons.com>
References: <1420714305-7496-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1420714305-7496-9-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A385-GP is a board produced by Marvell that holds

- 1 PCIe slot
- 2 mini PCIe slot (one of them is multiplexed with the PCIe slot,
  muxing is selected through the GPIO expander)
- 1 16MB SPI-NOR
- 2 Gigabit Ethernet ports
- 4 SATA ports (2 of them are multiplexed with the mini PCIe slots,
  muxing is selected through the GPIO expander)
- 1 SDIO slot
- 1 USB3 port
- 2 USB2 port
- 2 GPIO/interrupts expander on I2C

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/armada-385-gp.dts | 288 ++++++++++++++++++++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-gp.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd62857..d6d7bafac127 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -535,6 +535,7 @@ dtb-$(CONFIG_MACH_ARMADA_375) += \
 	armada-375-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-385-db.dtb \
+	armada-385-gp.dtb \
 	armada-385-rd.dtb
 dtb-$(CONFIG_MACH_ARMADA_XP) += \
 	armada-xp-axpwifiap.dtb \
diff --git a/arch/arm/boot/dts/armada-385-gp.dts b/arch/arm/boot/dts/armada-385-gp.dts
new file mode 100644
index 000000000000..66cd006e8478
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-gp.dts
@@ -0,0 +1,288 @@
+/*
+ * Device Tree file for Marvell Armada 385 development board
+ * (RD-88F6820-GP)
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is licensed under the terms of the GNU General Public
+ *     License version 2.  This program is licensed "as is" without
+ *     any warranty of any kind, whether express or implied.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "armada-388.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Marvell Armada 385 GP";
+	compatible = "marvell,a385-gp", "marvell,armada388", "marvell,armada380";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>; /* 2 GB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+
+		internal-regs {
+			spi at 10600 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi0_pins>;
+				status = "okay";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "st,m25p128";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <50000000>;
+					m25p,fast-read;
+				};
+			};
+
+			i2c at 11000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins>;
+				status = "okay";
+				clock-frequency = <100000>;
+				/*
+				 * The EEPROM located at adresse 54 is needed
+				 * for the boot - DO NOT ERASE IT -
+				 */
+
+				expander0: pca9555 at 20 {
+					compatible = "nxp,pca9555";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pca0_pins>;
+					interrupt-parent = <&gpio0>;
+					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					reg = <0x20>;
+				};
+
+				expander1: pca9555 at 21 {
+					compatible = "nxp,pca9555";
+					pinctrl-names = "default";
+					interrupt-parent = <&gpio0>;
+					interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					reg = <0x21>;
+				};
+
+			};
+
+			serial at 12000 {
+				/*
+				 * Exported on the micro USB connector CON16
+				 * through an FTDI
+				 */
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart0_pins>;
+				status = "okay";
+			};
+
+			/* GE1 CON15 */
+			ethernet at 30000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&ge1_rgmii_pins>;
+				status = "okay";
+				phy = <&phy1>;
+				phy-mode = "rgmii-id";
+			};
+
+			/* CON4 */
+			usb at 50000 {
+				vcc-supply = <&reg_usb2_0_vbus>;
+				status = "okay";
+			};
+
+			/* GE0 CON1 */
+			ethernet at 70000 {
+				pinctrl-names = "default";
+				/*
+				 * The Reference Clock 0 is used to provide a
+				 * clock to the PHY
+				 */
+				pinctrl-0 = <&ge0_rgmii_pins>, <&ref_clk0_pins>;
+				status = "okay";
+				phy = <&phy0>;
+				phy-mode = "rgmii-id";
+			};
+
+
+			mdio at 72004 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&mdio_pins>;
+
+				phy0: ethernet-phy at 1 {
+					reg = <1>;
+				};
+
+				phy1: ethernet-phy at 0 {
+					reg = <0>;
+				};
+			};
+
+			sata at a8000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&sata0_pins>, <&sata1_pins>;
+				status = "okay";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			sata at e0000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&sata2_pins>, <&sata3_pins>;
+				status = "okay";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			sdhci at d8000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&sdhci_pins>;
+				cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;
+				no-1-8-v;
+				wp-inverted;
+				bus-width = <8>;
+				status = "okay";
+			};
+
+			/* CON5 */
+			usb3 at f0000 {
+				vcc-supply = <&reg_usb2_1_vbus>;
+				status = "okay";
+			};
+
+			/* CON7 */
+			usb3 at f8000 {
+				vcc-supply = <&reg_usb3_vbus>;
+				status = "okay";
+			};
+		};
+
+		pcie-controller {
+			status = "okay";
+			/*
+			 * One PCIe units is accessible through
+			 * standard PCIe slot on the board.
+			 */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+
+			/*
+			 * The two other PCIe units are accessible
+			 * through mini PCIe slot on the board.
+			 */
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+			pcie at 3,0 {
+				/* Port 2, Lane 0 */
+				status = "okay";
+			};
+		};
+
+		gpio-fan {
+			compatible = "gpio-fan";
+			gpios = <&expander1 3 GPIO_ACTIVE_HIGH>;
+			gpio-fan,speed-map = <	 0 0
+								  3000 1>;
+		};
+	};
+
+	reg_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander1 15 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_usb2_0_vbus: v5-vbus0 {
+		compatible = "regulator-fixed";
+		regulator-name = "v5.0-vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander1 14 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_usb2_1_vbus: v5-vbus1 {
+		compatible = "regulator-fixed";
+		regulator-name = "v5.0-vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_usb2_1_vbus: v5-vbus1 {
+		compatible = "regulator-fixed";
+		regulator-name = "v5.0-vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&expander0 4 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&pinctrl {
+	pca0_pins: pca0_pins {
+		marvell,pins = "mpp18";
+		marvell,function = "gpio";
+	};
+};
-- 
1.9.1
