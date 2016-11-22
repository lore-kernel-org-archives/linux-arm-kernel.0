From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 22 Nov 2016 21:59:08 +0100
Subject: [PATCH v3 2/2] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161122205908.7297-1-uwe@kleine-koenig.org>
References: <20161122205908.7297-1-uwe@kleine-koenig.org>
Message-ID: <20161122205908.7297-2-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This machine is an open hardware router by cz.nic driven by a
Marvell Armada 385.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
Changes since (implicit) v1:

  - disable rtc
  - change compatible to "cznic,turris-omnia"

Changes since v2:

 - fix comment for usb at 58000
 - add gpio-expander that serves SPF and phy irq

I kept all three eth devices to keep the ethernet names when users upgrade.
Tomas said that he had problems with the emmc when operating it in DDR50
mode. I didn't see any I/O errors so far and didn't find a way to
limit the device to SDR50 via dt.

IMHO even with some peripherals still missing (SFP, switch, wlan) it
would be the right thing to take this patch as a base to get the
remaining bits sorted. Is it still possible to get it into 4.10?

Best regards
Uwe

---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 282 ++++++++++++++++++++++++++
 2 files changed, 283 insertions(+)
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
index 000000000000..a750fd8d8225
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -0,0 +1,282 @@
+/*
+ * Device Tree file for the Turris Omnia
+ * Schematic available at https://www.turris.cz/doc/_media/rtrom01-schema.pdf
+ *
+ * Copyright (C) 2016 Uwe Kleine-K?nig <uwe@kleine-koenig.org>
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
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+
+		internal-regs {
+
+			/* part of PCIe */
+			usb at 58000 {
+				status = "okay";
+			};
+
+			rtc at a3800 {
+				/*
+				 * There are several errata for this device
+				 * still unimplemented. Without some love it only reports
+				 * 2016-12-19 22:00:24. So disable for now.
+				 */
+				status = "disabled";
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
+				/* Port 2, Lane 0 */
+				status = "okay";
+			};
+
+			pcie at 3,0 {
+				/* Port 3, Lane 0 */
+				status = "okay";
+			};
+		};
+	};
+};
+
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
+			/* STM32F0 at address 0x2a */
+			/* leds device at address 0x2b */
+
+			eeprom at 54 {
+				/* holds configuration about RAM, evaluated by bootloader */
+				compatible = "at,24c64";
+				reg = <0x54>;
+			};
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
+	};
+
+	/* There is a Switch (MV88E7176) at address 0x10 */
+};
+
+&pinctrl {
+	pcawan_pins: pcawan-pins {
+		marvell,pins = "mpp46";
+		marvell,function = "gpio";
+	};
+
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
+	/* @1 is on pin header */
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
-- 
2.10.2
