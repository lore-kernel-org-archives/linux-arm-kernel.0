From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu, 21 Sep 2017 09:36:43 +0200
Subject: [PATCH] arm64: dts: marvell: Enable Armada-8040-DB CPS SPI1
Message-ID: <20170921073643.5677-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christine Gharzuzi <chrisg@marvell.com>

Add the DT node enabling Armada-8040-DB CPS SPI controller driver.

Add the SPI NAND flash device connected on the bus. Fill the MTD
partitions layout.

Signed-off-by: Christine Gharzuzi <chrisg@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 0d7b2ae46610..f5be6ffe0106 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -216,6 +216,37 @@
 	clock-frequency = <100000>;
 };
 
+&cps_spi1 {
+	status = "okay";
+
+	spi-flash at 0 {
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <20000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "Boot";
+				reg = <0x0 0x200000>;
+			};
+			partition at 200000 {
+				label = "Filesystem";
+				reg = <0x200000 0xd00000>;
+			};
+			partition at d00000 {
+				label = "Boot_2nd";
+				reg = <0xf00000 0x100000>;
+			};
+		};
+	};
+};
+
 /* CON4 on CP1 expansion */
 &cps_sata0 {
 	status = "okay";
-- 
2.11.0
