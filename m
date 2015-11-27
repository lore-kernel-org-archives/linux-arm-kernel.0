From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:55:52 +0900
Subject: [PATCH 09/15] ARM: shmobile: porter: Move SPI FLASH partitions to
 subnode
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
Message-ID: <26fac0eebccec898a7a7670856cbde5583a5ec2e.1448586938.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support partitions
in a special 'partitions' subnode"), having partitions as direct subnodes
of an mtd device is discouraged. Hence move the SPI FLASH partitions to a
"partitions" subnode.

Based on similar work for the koelsch board by Geert Uytterhoeven.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 3e198e7b3ee4..f2dd5356eac8 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -192,8 +192,6 @@
 	status = "okay";
 
 	flash at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
@@ -201,19 +199,24 @@
 		spi-rx-bus-width = <4>;
 		m25p,fast-read;
 
-		partition at 0 {
-			label = "loader_prg";
-			reg = <0x00000000 0x00040000>;
-			read-only;
-		};
-		partition at 40000 {
-			label = "user_prg";
-			reg = <0x00040000 0x00400000>;
-			read-only;
-		};
-		partition at 440000 {
-			label = "flash_fs";
-			reg = <0x00440000 0x03bc0000>;
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "loader_prg";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			partition at 40000 {
+				label = "user_prg";
+				reg = <0x00040000 0x00400000>;
+				read-only;
+			};
+			partition at 440000 {
+				label = "flash_fs";
+				reg = <0x00440000 0x03bc0000>;
+			};
 		};
 	};
 };
-- 
2.1.4
