From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:50 +0100
Subject: [PATCH v3 01/19] ARM: dts: armada-xp-matrix: Fix the location of the
 pcie-controller node
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the dts for the Marvell Armada XP Matrix board the pcie-controller was
located under the internal-regs node whereas it belongs to the soc node.

It means that, until this fix, the pcie could not work for this board
because it didn't match the definition of the pcie-controller node in the
dtsi file. If we had a look on the decompiled dtb file we saw two
different instances of the pcie-controller node: one with the all the
resource set but disabled and the other without any resource but enabled.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-matrix.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 6522b04f4a8e..e1509f4c5114 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -71,6 +71,15 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -99,15 +108,6 @@
 				};
 			};
 
-			pcie-controller {
-				status = "okay";
-
-				pcie at 1,0 {
-					/* Port 0, Lane 0 */
-					status = "okay";
-				};
-			};
-
 			usb at 50000 {
 				status = "okay";
 			};
-- 
2.10.2
