From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 27 Apr 2016 00:10:33 +0300
Subject: [PATCH v2 6/7] ARM: dts: lpc32xx: phy3250: add NAND partitions device
 node
In-Reply-To: <1461705034-355-1-git-send-email-vz@mleia.com>
References: <1461705034-355-1-git-send-email-vz@mleia.com>
Message-ID: <1461705034-355-7-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To declare MTD OF partitions NAND controller device node should have
a special 'partitions' subnode, the change removes a debug message
from mtd/ofpart on boot:

  nxp_lpc3220_slc: 'partitions' subnode not found on /ahb/flash at 20020000.
  Trying to parse direct subnodes as partitions.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
* on conversion added missing 'compatible = "fixed-partitions";',
  thanks to Sylvain for finding

 arch/arm/boot/dts/phy3250.dts | 50 +++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
index c1a6e62..fd95e2b 100644
--- a/arch/arm/boot/dts/phy3250.dts
+++ b/arch/arm/boot/dts/phy3250.dts
@@ -136,8 +136,6 @@
 
 /* 64MB Flash via SLC NAND controller */
 &slc {
-	#address-cells = <1>;
-	#size-cells = <1>;
 	status = "okay";
 
 	nxp,wdr-clks = <14>;
@@ -151,31 +149,37 @@
 	nand-on-flash-bbt;
 	gpios = <&gpio 5 19 1>; /* GPO_P3 19, active low */
 
-	mtd0 at 00000000 {
-		label = "phy3250-boot";
-		reg = <0x00000000 0x00064000>;
-		read-only;
-	};
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	mtd1 at 00064000 {
-		label = "phy3250-uboot";
-		reg = <0x00064000 0x00190000>;
-		read-only;
-	};
+		mtd0 at 00000000 {
+			label = "phy3250-boot";
+			reg = <0x00000000 0x00064000>;
+			read-only;
+		};
 
-	mtd2 at 001f4000 {
-		label = "phy3250-ubt-prms";
-		reg = <0x001f4000 0x00010000>;
-	};
+		mtd1 at 00064000 {
+			label = "phy3250-uboot";
+			reg = <0x00064000 0x00190000>;
+			read-only;
+		};
 
-	mtd3 at 00204000 {
-		label = "phy3250-kernel";
-		reg = <0x00204000 0x00400000>;
-	};
+		mtd2 at 001f4000 {
+			label = "phy3250-ubt-prms";
+			reg = <0x001f4000 0x00010000>;
+		};
 
-	mtd4 at 00604000 {
-		label = "phy3250-rootfs";
-		reg = <0x00604000 0x039fc000>;
+		mtd3 at 00204000 {
+			label = "phy3250-kernel";
+			reg = <0x00204000 0x00400000>;
+		};
+
+		mtd4 at 00604000 {
+			label = "phy3250-rootfs";
+			reg = <0x00604000 0x039fc000>;
+		};
 	};
 };
 
-- 
2.1.4
