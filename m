From: tmshlvck@gmail.com (Tomas Hlavacek)
Date: Wed, 23 Nov 2016 01:09:20 +0100
Subject: [RFC PATCH] ARM: dts: Add support for Turris Omnia
In-Reply-To: <1479851991.26813.2@smtp.gmail.com>
References: <1479851991.26813.2@smtp.gmail.com>
Message-ID: <1479859770-9375-1-git-send-email-tmshlvck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turris Omnia board by CZ.NIC:

  * Marvell Armada 385 SoC
  * 1 or 2 GB DDR3
  * eMMC
  * 8 MB SPI flash (U-Boot and rescue Linux image)
  * 88E1514 PHY
  * 88E6176 Ethernet switch (not supported)

Supported board revision: CZ11NIC13 (production board).

Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
---
Changes since Uwe's version:

- add MBUS regions (needed for Marvell CESA)
- remove rtc disable (WFM with CZ11NIC13 = production board)
- cleanup comments

Unsupported peripherals:
- MV88E7176 switch
- SFP
- LEDs

---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 279 ++++++++++++++++++++++++++
 2 files changed, 280 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-turris-omnia.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..f1d3b9ff 100644
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
index 0000000..5ef3d62
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -0,0 +1,279 @@
+/*
+ * Device Tree file for the Turris Omnia
+ * Schematic available at https://www.turris.cz/doc/_media/rtrom01-schema.pdf
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
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "armada-385.dtsi"
+
+/ {
+	model = "Turris Omnia";
+	compatible = "cznic,turris-omnia", "marvell,armada385", \
+			"marvell,armada380";
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
+			status = "okay";
+
+			/* STM32F0 command interface at address 0x2a.
+			 * STM32F0 LED interface at address 0x2b.
+			 */
+
+			eeprom at 54 {
+				compatible = "at,24c64";
+				reg = <0x54>;
+
+				/* The EEPROM contains data for bootloader.
+				 * Contents:
+				 *	struct omnia_eeprom {
+				 *		u32 magic; (=0x0341a034)
+				 *		u32 ramsize;
+				 *		char region[4] (=0x0);
+				 *		u32 crc32;
+				 *	};
+				 */
+			};
+		};
+
+		/* Channel 1: Routed to PCIe0/mSATA connector (CN7A).
+		 * Channel 2: Routed to PCIe1/USB2 connector (CN61A).
+		 * Channel 3: Routed to PCIe2 connector (CN62A).
+		 * Channel 4: Routed to SFP+.
+		 * Channel 5: ATSHA204A at address 0x64.
+		 * Channel 6: Routed to user pin header CN11.
+		 */
+
+		i2c at 7 {
+			/* GPIO expander for SFP+ signals */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			wangpio: gpio at 71 {
+				compatible = "nxp,pca9538";
+				reg = <0x71>;
+				interrupt-parent = <&gpio1>;
+				interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
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
+		compatible = "ethernet-phy-id0141.0DD1", \
+				"ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		/* IRQ is connected to PCA9538 pin 7. Currently it
+		 * can not be utilized.
+		 */
+	};
+
+	/* Switch MV88E7176 at address 0x10. */
+};
+
+&pinctrl {
+	spi0cs1_pins: spi0-pins-0cs1 {
+		marvell,pins = "mpp26";
+		marvell,function = "spi0";
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins &spi0cs1_pins>;
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
+	/* SPI0 + CS1 (MPP26) is routed to a pin header CN11. */
+};
+
+&uart0 {
+	/* Pin header CN10. */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	/* Pin header CN11. */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
-- 
2.7.4
