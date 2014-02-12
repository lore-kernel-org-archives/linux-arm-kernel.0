From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 11:23:37 +0100
Subject: [PATCH v2 08/10] ARM: mvebu: add Device Tree for the Armada 385 DB
 board
In-Reply-To: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392200619-3141-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 385 DB board is the development board from Marvell for the
Armada 385 SoC. This commit adds a Device Tree description for this
board, which enables the following features:

 * Network interfaces
 * I2C buses
 * SDIO
 * Serial port
 * SPI bus, with a SPI flash
 * PCIe interfaces

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile          |   1 +
 arch/arm/boot/dts/armada-385-db.dts | 101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-385-db.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f1eafbd..bd789fc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -127,6 +127,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-370-netgear-rn104.dtb \
 	armada-370-rd.dtb \
 	armada-375-db.dtb \
+	armada-385-db.dtb \
 	armada-xp-axpwifiap.dtb \
 	armada-xp-db.dtb \
 	armada-xp-gp.dtb \
diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
new file mode 100644
index 0000000..566601c
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -0,0 +1,101 @@
+/*
+ * Device Tree file for Marvell Armada 385 evaluation board
+ * (DB-88F6820)
+ *
+ *  Copyright (C) 2014 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "armada-385.dtsi"
+
+/ {
+	model = "Marvell Armada 385 Development Board";
+	compatible = "marvell,a385-db", "marvell,armada385", "marvell,armada38x";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>; /* 256 MB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+
+		internal-regs {
+			spi0: spi at 10600 {
+				status = "okay";
+
+				spi-flash at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "w25q32";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <108000000>;
+				};
+			};
+
+			i2c0: i2c at 11000 {
+				status = "okay";
+				clock-frequency = <100000>;
+			};
+
+			i2c1: i2c at 11100 {
+				status = "okay";
+				clock-frequency = <100000>;
+			};
+
+			serial at 12000 {
+				clock-frequency = <200000000>;
+				status = "okay";
+			};
+
+			ethernet at 30000 {
+				status = "okay";
+				phy = <&phy1>;
+				phy-mode = "rgmii";
+			};
+
+			ethernet at 70000 {
+				status = "okay";
+				phy = <&phy0>;
+				phy-mode = "rgmii";
+			};
+
+			mdio {
+				phy0: ethernet-phy at 0 {
+					reg = <0>;
+				};
+
+				phy1: ethernet-phy at 1 {
+					reg = <1>;
+				};
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
