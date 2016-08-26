From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2016 17:38:54 +0200
Subject: [PATCH] ARM: dts: mvebu: fix reference to a390 spi controller
Message-ID: <20160826153925.863488-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI controller in the arch/arm/boot/dts/armada-39x.dtsi file has moved
to a different location in the hierarchy, which breaks the overrides
in the board specific file:

Warning (reg_format): "reg" property in /soc/internal-regs/spi at 10680/spi-flash at 1 has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/internal-regs/spi at 10680/spi-flash at 1

This changes the board to reference the spi controller by its label
(which has not changed) rather than the full path.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0160a4b68987 ("ARM: dts: mvebu: A37x/XP/38x/39x: Move SPI controller nodes into 'soc' node")
---
 arch/arm/boot/dts/armada-390-db.dts | 60 ++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/armada-390-db.dts b/arch/arm/boot/dts/armada-390-db.dts
index 9d0d9b2e9bfc..34e279d973c8 100644
--- a/arch/arm/boot/dts/armada-390-db.dts
+++ b/arch/arm/boot/dts/armada-390-db.dts
@@ -66,36 +66,6 @@
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
 
 		internal-regs {
-			spi at 10680 {
-				status = "okay";
-				pinctrl-0 = <&spi1_pins>;
-				pinctrl-names = "default";
-
-				spi-flash at 1 {
-					#address-cells = <1>;
-					#size-cells = <1>;
-					compatible = "n25q128a13",
-						     "jedec,spi-nor";
-					reg = <0>; /* Chip select 0 */
-					spi-max-frequency = <108000000>;
-
-					partitions {
-						compatible = "fixed-partitions";
-						#address-cells = <1>;
-						#size-cells = <1>;
-
-						partition at 0 {
-							label = "U-Boot";
-							reg = <0 0x400000>;
-						};
-						partition at 400000 {
-							label = "Filesystem";
-							reg = <0x400000 0xc00000>;
-						};
-					};
-				};
-			};
-
 			i2c at 11000 {
 				status = "okay";
 				clock-frequency = <100000>;
@@ -173,3 +143,33 @@
 		};
 	};
 };
+
+&spi1 {
+	status = "okay";
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+
+	spi-flash at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a13",
+			     "jedec,spi-nor";
+		reg = <0>; /* Chip select 0 */
+		spi-max-frequency = <108000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0 0x400000>;
+			};
+			partition at 400000 {
+				label = "Filesystem";
+				reg = <0x400000 0xc00000>;
+			};
+		};
+	};
+};
-- 
2.9.0
