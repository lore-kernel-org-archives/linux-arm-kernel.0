From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Nov 2015 11:38:53 -0800
Subject: [PATCH 2/4] ARM: shmobile: lager: Move SPI FLASH partitions to subnode
In-Reply-To: <1448048335-23927-1-git-send-email-horms+renesas@verge.net.au>
References: <1448048335-23927-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1448048335-23927-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support partitions
in a special 'partitions' subnode"), having partitions as direct subnodes
of an mtd device is discouraged. Hence move the SPI FLASH partitions to a
"partitions" subnode.

Based on similar work for the koelsch board by Geert Uytterhoeven.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e2174d816e78..f98f5c782589 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -439,8 +439,6 @@
 	status = "okay";
 
 	flash: flash at 0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
@@ -450,19 +448,24 @@
 		spi-cpol;
 		m25p,fast-read;
 
-		partition at 0 {
-			label = "loader";
-			reg = <0x00000000 0x00040000>;
-			read-only;
-		};
-		partition at 40000 {
-			label = "user";
-			reg = <0x00040000 0x00400000>;
-			read-only;
-		};
-		partition at 440000 {
-			label = "flash";
-			reg = <0x00440000 0x03bc0000>;
+		partitions {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "loader";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+			partition at 40000 {
+				label = "user";
+				reg = <0x00040000 0x00400000>;
+				read-only;
+			};
+			partition at 440000 {
+				label = "flash";
+				reg = <0x00440000 0x03bc0000>;
+			};
 		};
 	};
 };
-- 
2.1.4
