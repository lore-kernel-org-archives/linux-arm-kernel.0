From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 25 Nov 2016 15:26:58 +0100
Subject: [PATCH v5 2/2] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161125142658.21690-1-uwe@kleine-koenig.org>
References: <20161125142658.21690-1-uwe@kleine-koenig.org>
Message-ID: <20161125142658.21690-3-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This machine is an open hardware router by cz.nic driven by a
Marvell Armada 385.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 334 ++++++++++++++++++++++++++
 2 files changed, 335 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-turris-omnia.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd2619902..f1d3b9ff257e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -920,6 +920,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-385-db-ap.dtb \
 	armada-385-linksys-caiman.dtb \
 	armada-385-linksys-cobra.dtb \
+	armada-385-turris-omnia.dtb \
 	armada-388-clearfog.dtb \
 	armada-388-db.dtb \
 	armada-388-gp.dtb \
diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
new file mode 100644
index 000000000000..bcc10c285889
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -0,0 +1,334 @@
+/*
+ * Device Tree file for the Turris Omnia
+ *
+ * Copyright (C) 2016 Uwe Kleine-K?nig <uwe@kleine-koenig.org>
+ * Copyright (C) 2016 Tomas Hlavacek <tmshlvkc@gmail.com>
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
+/*
+ * Schematic available at https://www.turris.cz/doc/_media/rtrom01-schema.pdf
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "armada-385.dtsi"
+
+/ {
+	model = "Turris Omnia";
+	compatible = "cznic,turris-omnia", "marvell,armada385", "marvell,armada380";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>; /* 1024 MB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
+
+		internal-regs {
+
+			/* USB part of the PCIe2/USB 2.0 port */
+			usb at 58000 {
+				status = "okay";
+			};
+
+			sata at a8000 {
+				status = "okay";
+			};
+
+			sdhci at d8000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&sdhci_pins>;
+				status = "okay";
+
+				bus-width = <8>;
+				no-1-8-v;
+				non-removable;
+			};
+
+			usb3 at f0000 {
+				status = "okay";
+			};
+
+			usb3 at f8000 {
+				status = "okay";
+			};
+		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+
+			pcie at 3,0 {
+				/* Port 2, Lane 0 */
+				status = "okay";
+			};
+		};
+	};
+};
+
+/* Connected to 88E6176 switch, port 6 */
+&eth0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ge0_rgmii_pins>;
+	status = "okay";
+	phy-mode = "rgmii-id";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+/* Connected to 88E6176 switch, port 5 */
+&eth1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ge1_rgmii_pins>;
+	status = "okay";
+	phy-mode = "rgmii-id";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+/* WAN port */
+&eth2 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy = <&phy1>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	i2cmux at 70 {
+		compatible = "nxp,pca9547";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		status = "okay";
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			/* STM32F0 command interface at address 0x2a */
+			/* leds device (in STM32F0) at address 0x2b */
+
+			eeprom at 54 {
+				compatible = "at,24c64";
+				reg = <0x54>;
+
+				/* The EEPROM contains data for bootloader.
+				 * Contents:
+				 * 	struct omnia_eeprom {
+				 * 		u32 magic; (=0x0341a034 in LE)
+				 *		u32 ramsize; (in GiB)
+				 * 		char regdomain[4];
+				 * 		u32 crc32;
+				 * 	};
+				 */
+			};
+		};
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			/* routed to PCIe0/mSATA connector (CN7A) */
+		};
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			/* routed to PCIe1/USB2 connector (CN61A) */
+		};
+
+		i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			/* routed to PCIe2 connector (CN62A) */
+		};
+
+		i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			/* routed to SFP+ */
+		};
+
+		i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			/* ATSHA204A at address 0x64 */
+		};
+
+		i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			/* exposed on pin header */
+		};
+
+		i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			pcawan: gpio at 71 {
+				/*
+				 * GPIO expander for SFP+ signals and
+				 * and phy irq
+				 */
+				compatible = "nxp,pca9538";
+				reg = <0x71>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&pcawan_pins>;
+
+				interrupt-parent = <&gpio1>;
+				interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+};
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+	status = "okay";
+
+	phy1: phy at 1 {
+		status = "okay";
+		compatible = "ethernet-phy-id0141.0DD1", "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+
+		/* irq is connected to &pcawan pin 7 */
+	};
+
+	/* Switch MV88E7176 at address 0x10 */
+};
+
+&pinctrl {
+	pcawan_pins: pcawan-pins {
+		marvell,pins = "mpp46";
+		marvell,function = "gpio";
+	};
+
+	spi0cs0_pins: spi0cs0-pins {
+		marvell,pins = "mpp25";
+		marvell,function = "spi0";
+	};
+
+	spi0cs1_pins: spi0cs1-pins {
+		marvell,pins = "mpp26";
+		marvell,function = "spi0";
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins &spi0cs0_pins>;
+	status = "okay";
+
+	spi-nor at 0 {
+		compatible = "spansion,s25fl164k", "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+
+		partition at 0 {
+			reg = <0x0 0x00100000>;
+			label = "U-Boot";
+		};
+
+		partition at 1 {
+			reg = <0x00100000 0x00700000>;
+			label = "Rescue system";
+		};
+	};
+
+	/* MISO, MOSI, SCLK and CS1 are routed to pin header CN11 */
+};
+
+&uart0 {
+	/* Pin header CN10 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	/* Pin header CN11 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
-- 
2.10.2
