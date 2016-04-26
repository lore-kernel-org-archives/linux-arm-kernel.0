From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:34 +0200
Subject: [PATCH v3 06/11] arm64: dts: marvell: improve SPI flash description
 on Armada 7040-DB
In-Reply-To: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1461657519-11939-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit slightly improves the description of the SPI flash
connected to the SPI controller of the Armada 7040, by:

 - Using the more generic "jedec,spi-nor" compatible string, which
   lets the driver auto-detect the exact SPI flash type.

 - Removing the silly comment about the Chip Select, since reg = <0>
   is explicit enough.

 - Switching to the new Device Tree binding to describe flash
   partitions.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 4b01744..95dd7c7 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -72,17 +72,23 @@
 	spi-flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "n25q128a13";
-		reg = <0>; /* Chip select 0 */
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		spi-max-frequency = <10000000>;
 
-		partition at 0 {
-			label = "U-Boot";
-			reg = <0 0x200000>;
-		};
-		partition at 400000 {
-			label = "Filesystem";
-			reg = <0x200000 0xce0000>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0 0x200000>;
+			};
+			partition at 400000 {
+				label = "Filesystem";
+				reg = <0x200000 0xce0000>;
+			};
 		};
 	};
 };
-- 
2.6.4
