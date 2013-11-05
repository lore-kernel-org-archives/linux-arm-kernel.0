From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 05 Nov 2013 21:45:48 +0100
Subject: [PATCH 1/2] ARM: mvebu: second PCIe unit of Armada XP mv78230 is only
 x1 capable
In-Reply-To: <cover.1383681717.git.arno@natisbad.org>
References: <cover.1383681717.git.arno@natisbad.org>
Message-ID: <b5f36f547bb12ed4e5398401685523625ca50312.1383681717.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various Marvell datasheets advertise second PCIe unit of mv78230
flavour of Armada XP as x4/quad x1 capable. This second unit is in
fact only x1 capable. This patch fixes current mv78230 .dtsi to
reflect that, i.e. makes 1.0 the second interface (instead of 2.0
at the moment). This was successfully tested on a mv78230-based
ReadyNAS 2120 platform with a x1 device (FL1009 XHCI controller)
connected to this second interface.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 0358a33..9dc7381 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -47,7 +47,7 @@
 		/*
 		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
 		 * configured as x4 or quad x1 lanes. One unit is
-		 * x4/x1.
+		 * x1 only.
 		 */
 		pcie-controller {
 			compatible = "marvell,armada-xp-pcie";
@@ -61,10 +61,10 @@
 
 			ranges =
 			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
-				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
 				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
 				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
 				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
+				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
 				0x82000000 0x1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
 				0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
 				0x82000000 0x2 0       MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
@@ -73,8 +73,8 @@
 				0x81000000 0x3 0       MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
 				0x82000000 0x4 0       MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
 				0x81000000 0x4 0       MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
-				0x82000000 0x9 0       MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
-				0x81000000 0x9 0       MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */>;
+				0x82000000 0x5 0       MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
+				0x81000000 0x5 0       MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */>;
 
 			pcie at 1,0 {
 				device_type = "pci";
@@ -144,20 +144,20 @@
 				status = "disabled";
 			};
 
-			pcie at 9,0 {
+			pcie at 5,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
-				reg = <0x4800 0 0 0 0>;
+				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
+				reg = <0x2800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				#interrupt-cells = <1>;
-				ranges = <0x82000000 0 0 0x82000000 0x9 0 1 0
-					  0x81000000 0 0 0x81000000 0x9 0 1 0>;
+				ranges = <0x82000000 0 0 0x82000000 0x5 0 1 0
+					  0x81000000 0 0 0x81000000 0x5 0 1 0>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &mpic 99>;
-				marvell,pcie-port = <2>;
+				interrupt-map = <0 0 0 0 &mpic 62>;
+				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
-				clocks = <&gateclk 26>;
+				clocks = <&gateclk 9>;
 				status = "disabled";
 			};
 		};
-- 
1.8.4.rc3
