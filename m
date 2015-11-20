From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:22 -0800
Subject: [PATCH 15/29] ARM: shmobile: koelsch: Move SPI FLASH partitions to
 subnode
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <27fa0a6c55537f8d8656b9e59ae584b0b427232a.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
partitions in a special 'partitions' subnode"), having partitions as
direct subnodes of an mtd device is discouraged:

    spi0.0: 'partitions' subnode not found on /spi at e6b10000/flash at 0. Trying to parse direct subnodes as partitions.

Hence move the SPI FLASH partitions to a "partitions" subnode.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 98da99d1b7dc..4ec2d1fba7c9 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -479,8 +479,6 @@
 	status = "okay";
 
 	flash: flash at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
@@ -490,19 +488,24 @@
 		spi-cpol;
 		m25p,fast-read;
 
-		partition at 0 {
-			label = "loader";
-			reg = <0x00000000 0x00080000>;
-			read-only;
-		};
-		partition at 80000 {
-			label = "user";
-			reg = <0x00080000 0x00580000>;
-			read-only;
-		};
-		partition at 600000 {
-			label = "flash";
-			reg = <0x00600000 0x03a00000>;
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "loader";
+				reg = <0x00000000 0x00080000>;
+				read-only;
+			};
+			partition at 80000 {
+				label = "user";
+				reg = <0x00080000 0x00580000>;
+				read-only;
+			};
+			partition at 600000 {
+				label = "flash";
+				reg = <0x00600000 0x03a00000>;
+			};
 		};
 	};
 };
-- 
2.1.4
