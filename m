From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:20 +0200
Subject: [PATCH v2 17/17] ARM: dts: mvebu: armada-395-gp: add support for the
 Armada 395 GP Board
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-18-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds description for the following features for this board:

- Serial port
- PCIe interfaces
- USB2.0
- USB3.0
- SDIO
- 1024 MiB NAND-FLASH
- SATA
- I2C buses

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/marvell/armada-39x.txt |   4 +
 arch/arm/boot/dts/armada-395-gp.dts                | 163 +++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-395-gp.dts

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt b/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
index 2d92212..8946866 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
@@ -15,6 +15,10 @@ Required root node property:
 
 compatible: must contain "marvell,armada395"
 
+Example:
+
+compatible = "marvell,a395-gp", "marvell,armada395", "marvell,armada390";
+
 Boards using the Marvell Armada 398 SoC shall have the following
 property before the common "marvell,armada390" one:
 
diff --git a/arch/arm/boot/dts/armada-395-gp.dts b/arch/arm/boot/dts/armada-395-gp.dts
new file mode 100644
index 0000000..2cdbba8
--- /dev/null
+++ b/arch/arm/boot/dts/armada-395-gp.dts
@@ -0,0 +1,163 @@
+/*
+ * Device Tree file for Marvell Armada 395 GP board
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
+#include "armada-395.dtsi"
+
+/ {
+	model = "Marvell Armada 395 GP Board";
+	compatible = "marvell,a395-gp", "marvell,armada395",
+		     "marvell,armada390";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
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
+			i2c at 11000 {
+				status = "okay";
+				clock-frequency = <100000>;
+
+				eeprom at 57 {
+					compatible = "atmel,24c64";
+					reg = <0x57>;
+				};
+			};
+
+			serial at 12000 {
+				/*
+				 * Exported on the micro USB connector CON17
+				 * through an FTDI
+				 */
+				status = "okay";
+			};
+
+			/* CON1 */
+			usb at 58000 {
+				status = "okay";
+			};
+
+			/* CON2 */
+			sata at a8000 {
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
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
+
+				partitions {
+					compatible = "fixed-partitions";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					partition at 0 {
+						label = "U-Boot";
+						reg = <0x00000000 0x00600000>;
+						read-only;
+					};
+
+					partition at 800000 {
+						label = "uImage";
+						reg = <0x00600000 0x00400000>;
+						read-only;
+					};
+
+					partition at 1000000 {
+						label = "Root";
+						reg = <0x00a00000 0x3f600000>;
+					};
+				};
+			};
+
+			/* CON18 */
+			sdhci at d8000 {
+				clock-frequency = <200000000>;
+				broken-cd;
+				wp-inverted;
+				bus-width = <8>;
+				status = "okay";
+				no-1-8-v;
+			};
+
+			/* CON4 */
+			usb3 at f0000 {
+				status = "okay";
+			};
+		};
+
+		pcie-controller {
+			status = "okay";
+
+			/*
+			 * The two PCIe units are accessible through
+			 * mini PCIe slot on the board.
+			 */
+
+			/* CON7 */
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+
+			/* CON8 */
+			pcie at 4,0 {
+				/* Port 3, Lane 0 */
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.8.3.1
