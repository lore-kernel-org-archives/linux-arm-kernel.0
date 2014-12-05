From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  5 Dec 2014 15:44:58 +0100
Subject: [PATCH 5/5] ARM: mvebu: Add Armada 385 Access Point Development Board
 support
In-Reply-To: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1417790698-9792-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A385-AP is a board produced by Marvell that holds 3 mPCIe slot, a 16MB
SPI-NOR, 3 Gigabit Ethernet ports, USB3 and NAND flash storage.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/armada-385-ap.dts | 200 ++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-ap.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c89cafa1ab..363fdeaa0368 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -499,6 +499,7 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
 dtb-$(CONFIG_MACH_ARMADA_375) += \
 	armada-375-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_38X) += \
+	armada-385-ap.dtb \
 	armada-385-db.dtb \
 	armada-385-rd.dtb
 dtb-$(CONFIG_MACH_ARMADA_XP) += \
diff --git a/arch/arm/boot/dts/armada-385-ap.dts b/arch/arm/boot/dts/armada-385-ap.dts
new file mode 100644
index 000000000000..915b4438c15d
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-ap.dts
@@ -0,0 +1,200 @@
+/*
+ * Device Tree file for Marvell Armada 385 Access Point Development board
+ * (DB-88F6820-AP)
+ *
+ *  Copyright (C) 2014 Marvell
+ *
+ * Nadav Haklai <nadavh@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "armada-385.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Marvell Armada 385 Access Point Development Board";
+	compatible = "marvell,a385-db-ap", "marvell,armada385", "marvell,armada38x";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>; /* 2GB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000	/* CESA0: PHYS=0xf1100000
+									   size 64K */
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;	/* CESA1: PHYS=0xf1110000
+									   size 64K */
+
+		internal-regs {
+			spi1: spi at 10680 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi1_pins>;
+				status = "okay";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "st,m25p128";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <108000000>;
+				};
+			};
+
+			i2c0: i2c at 11000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins>;
+				status = "okay";
+				clock-frequency = <100000>;
+			};
+
+			i2c1: i2c at 11100 {
+				status = "okay";
+				clock-frequency = <100000>;
+			};
+
+			mdio at 72004 {
+				pinctrl-names = <&phy_pins>;
+
+				phy0: ethernet-phy at 0 {
+					reg = <1>;
+				};
+
+				phy1: ethernet-phy at 1 {
+					reg = <6>;
+				};
+
+				phy2: ethernet-phy at 2 {
+					reg = <4>;
+				};
+			};
+
+			uart0: serial at 12000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart0_pins>;
+				status = "okay";
+			};
+
+			uart1: serial at 12100 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&uart1_pins>;
+				status = "okay";
+			};
+
+			pinctrl at 18000 {
+				ge0_pins: ge-pins-0 {
+					marvell,pins = "mpp6", "mpp7", "mpp8",
+						       "mpp9", "mpp10", "mpp11",
+						       "mpp12", "mpp13", "mpp14",
+						       "mpp15", "mpp16", "mpp17";
+					marvell,function = "ge0";
+				};
+
+				i2c0_pins: i2c-pins-0 {
+					marvell,pins = "mpp2", "mpp3";
+					marvell,function = "i2c0";
+				};
+
+				phy_pins: phy-pins {
+					marvell,pins = "mpp4", "mpp5";
+					marvell,function = "ge";
+				};
+
+				ref_clk0_pins: ref-clk-pins-0 {
+					marvell,pins = "mpp45";
+					marvell,function = "ref";
+				};
+
+				spi1_pins: spi-pins-1 {
+					marvell,pins = "mpp56", "mpp57", "mpp58",
+						       "mpp59";
+					marvell,function = "spi1";
+				};
+
+				uart0_pins: uart-pins-0 {
+					marvell,pins = "mpp0", "mpp1";
+					marvell,function = "ua0";
+				};
+
+				uart1_pins: uart-pins-1 {
+					marvell,pins = "mpp19", "mpp20";
+					marvell,function = "ua1";
+				};
+
+				xhci0_vbus_pins: xhci0-vbus-pins {
+					marvell,pins = "mpp44";
+					marvell,function = "gpio";
+				};
+			};
+
+			ethernet at 30000 {
+				status = "okay";
+				phy = <&phy1>;
+				phy-mode = "sgmii";
+			};
+
+			ethernet at 34000 {
+				status = "okay";
+				phy = <&phy2>;
+				phy-mode = "sgmii";
+			};
+
+			ethernet at 70000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&ge0_pins>, <&ref_clk0_pins>;
+				status = "okay";
+				phy = <&phy0>;
+				phy-mode = "rgmii-id";
+			};
+
+			usb3 at f0000 {
+				status = "okay";
+			};
+		};
+
+		pcie-controller {
+			status = "okay";
+			/*
+			 * The two PCIe units are accessible through
+			 * standard PCIe slots on the board.
+			 */
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
+
+	reg_xhci0_vbus: xhci0-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&xhci0_vbus_pins>;
+		regulator-name = "xhci0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.2.0
