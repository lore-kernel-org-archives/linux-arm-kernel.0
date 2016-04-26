From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 26 Apr 2016 03:37:25 +0300
Subject: [PATCH 2/7] ARM: dts: lpc32xx: ea3250: add NAND partitions device node
In-Reply-To: <1461631050-10479-1-git-send-email-vz@mleia.com>
References: <1461631050-10479-1-git-send-email-vz@mleia.com>
Message-ID: <1461631050-10479-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To declare MTD OF partitions NAND controller device node should have
a special 'partitions' subnode, the change removes a debug message
from mtd/ofpart on boot:

  nxp_lpc3220_slc: 'partitions' subnode not found on /ahb/flash at 20020000.
  Trying to parse direct subnodes as partitions.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/ea3250.dts | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/ea3250.dts b/arch/arm/boot/dts/ea3250.dts
index 7cf815a..58bcda9 100644
--- a/arch/arm/boot/dts/ea3250.dts
+++ b/arch/arm/boot/dts/ea3250.dts
@@ -213,8 +213,6 @@
 
 /* 128MB Flash via SLC NAND controller */
 &slc {
-	#address-cells = <1>;
-	#size-cells = <1>;
 	status = "okay";
 
 	nxp,wdr-clks = <14>;
@@ -228,26 +226,31 @@
 	nand-on-flash-bbt;
 	gpios = <&gpio 5 19 1>; /* GPO_P3 19, active low */
 
-	mtd0 at 00000000 {
-		label = "ea3250-boot";
-		reg = <0x00000000 0x00080000>;
-		read-only;
-	};
+	partitions {
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	mtd1 at 00080000 {
-		label = "ea3250-uboot";
-		reg = <0x00080000 0x000c0000>;
-		read-only;
-	};
+		mtd0 at 00000000 {
+			label = "ea3250-boot";
+			reg = <0x00000000 0x00080000>;
+			read-only;
+		};
 
-	mtd2 at 00140000 {
-		label = "ea3250-kernel";
-		reg = <0x00140000 0x00400000>;
-	};
+		mtd1 at 00080000 {
+			label = "ea3250-uboot";
+			reg = <0x00080000 0x000c0000>;
+			read-only;
+		};
 
-	mtd3 at 00540000 {
-		label = "ea3250-rootfs";
-		reg = <0x00540000 0x07ac0000>;
+		mtd2 at 00140000 {
+			label = "ea3250-kernel";
+			reg = <0x00140000 0x00400000>;
+		};
+
+		mtd3 at 00540000 {
+			label = "ea3250-rootfs";
+			reg = <0x00540000 0x07ac0000>;
+		};
 	};
 };
 
-- 
2.1.4
