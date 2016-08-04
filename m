From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:19 +0200
Subject: [PATCH v2 16/17] ARM: dts: mvebu: armada-390-db: add support for the
 Armada 390 DB board
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-17-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds description for following features for this board:

- Serial port
- I2C buses
- 16MB SPI-NOR
- USB2.0
- USB3.0
- PCIe interfaces

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-390-db.dts | 175 ++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-390-db.dts

diff --git a/arch/arm/boot/dts/armada-390-db.dts b/arch/arm/boot/dts/armada-390-db.dts
new file mode 100644
index 0000000..9d0d9b2
--- /dev/null
+++ b/arch/arm/boot/dts/armada-390-db.dts
@@ -0,0 +1,175 @@
+/*
+ * Device Tree file for Marvell Armada 390 Development Board
+ * (DB-88F6920)
+ *
+ * Copyright (C) 2016 Marvell
+ *
+ * Grzegorz Jaszczyk <jaz@semihalf.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "armada-390.dtsi"
+
+/ {
+	model = "Marvell Armada 390 Development Board";
+	compatible = "marvell,a390-db", "marvell,armada390";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
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
+			spi at 10680 {
+				status = "okay";
+				pinctrl-0 = <&spi1_pins>;
+				pinctrl-names = "default";
+
+				spi-flash at 1 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "n25q128a13",
+						     "jedec,spi-nor";
+					reg = <0>; /* Chip select 0 */
+					spi-max-frequency = <108000000>;
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition at 0 {
+							label = "U-Boot";
+							reg = <0 0x400000>;
+						};
+						partition at 400000 {
+							label = "Filesystem";
+							reg = <0x400000 0xc00000>;
+						};
+					};
+				};
+			};
+
+			i2c at 11000 {
+				status = "okay";
+				clock-frequency = <100000>;
+
+				eeprom at 50 {
+					compatible = "atmel,24c64";
+					reg = <0x50>;
+				};
+			};
+
+			/* CON104 */
+			serial at 12000 {
+				status = "okay";
+			};
+
+			/* CON97 */
+			usb at 58000 {
+				status = "okay";
+			};
+
+			flash at d0000 {
+				status = "okay";
+				pinctrl-0 = <&nand_pins>;
+				pinctrl-names = "default";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+				nand-ecc-strength = <8>;
+				nand-ecc-step-size = <512>;
+
+				partitions {
+					compatible = "fixed-partitions";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					partition at 0 {
+						label = "U-Boot";
+						reg = <0 0x800000>;
+					};
+					partition at 800000 {
+						label = "Linux";
+						reg = <0x800000 0x800000>;
+					};
+					partition at 1000000 {
+						label = "Filesystem";
+						reg = <0x1000000 0x3f000000>;
+					};
+				};
+			};
+
+			/* CON98 */
+			usb3 at f8000 {
+				status = "okay";
+			};
+		};
+
+		pcie-controller {
+			status = "okay";
+
+			/* CON30 */
+			pcie at 1,0 {
+				status = "okay";
+			};
+
+			/* CON44 */
+			pcie at 2,0 {
+				status = "okay";
+			};
+
+			/* CON61 */
+			pcie at 3,0 {
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.8.3.1
