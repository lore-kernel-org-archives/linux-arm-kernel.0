From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 11:23:34 +0100
Subject: [PATCH v2 05/10] ARM: mvebu: add Device Tree for the Armada 375 DB
 board
In-Reply-To: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392200619-3141-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 375 DB board is the development board from Marvell for the
Armada 375 SoC. This commit adds a Device Tree description for this
board, which enables the following features:

 * I2C buses
 * SDIO
 * Serial port
 * SPI bus, with a SPI flash. Note that the SPI bus is disabled by
   default, because it conflicts with the NAND, and can only work if
   the board boots out of SPI. Since most boards are shipped to boot
   out of NAND, we're default to having the SPI bus disabled.
 * PCIe interfaces

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/armada-375-db.dts | 107 ++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-375-db.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9d6a8b..f1eafbd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -126,6 +126,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-370-netgear-rn102.dtb \
 	armada-370-netgear-rn104.dtb \
 	armada-370-rd.dtb \
+	armada-375-db.dtb \
 	armada-xp-axpwifiap.dtb \
 	armada-xp-db.dtb \
 	armada-xp-gp.dtb \
diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
new file mode 100644
index 0000000..5f317e1
--- /dev/null
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -0,0 +1,107 @@
+/*
+ * Device Tree file for Marvell Armada 375 evaluation board
+ * (DB-88F6720)
+ *
+ *  Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-375.dtsi"
+
+/ {
+	model = "Marvell Armada 375 Development Board";
+	compatible = "marvell,a375-db", "marvell,armada375";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>; /* 1 GB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+
+		internal-regs {
+			spi0: spi at 10600 {
+				pinctrl-0 = <&spi0_pins>;
+				pinctrl-names = "default";
+				/*
+				 * SPI conflicts with NAND, so we disable it
+				 * here, and select NAND as the enabled device
+				 * by default.
+				 */
+				status = "disabled";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "n25q128a13";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <108000000>;
+				};
+			};
+
+			i2c0: i2c at 11000 {
+				status = "okay";
+				clock-frequency = <100000>;
+				pinctrl-0 = <&i2c0_pins>;
+				pinctrl-names = "default";
+			};
+
+			i2c1: i2c at 11100 {
+				status = "okay";
+				clock-frequency = <100000>;
+				pinctrl-0 = <&i2c1_pins>;
+				pinctrl-names = "default";
+			};
+
+			serial at 12000 {
+				clock-frequency = <200000000>;
+				status = "okay";
+			};
+
+			pinctrl {
+				sdio_st_pins: sdio-st-pins {
+					marvell,pins = "mpp44", "mpp45";
+					marvell,function = "gpio";
+				};
+			};
+
+			mvsdio at d4000 {
+				pinctrl-0 = <&sdio_pins &sdio_st_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+				cd-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+				wp-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
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
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.8.3.2
