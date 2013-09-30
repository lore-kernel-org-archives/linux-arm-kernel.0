From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 01 Oct 2013 00:19:16 +0200
Subject: [PATCH,
 FIX] ARM: mvebu: add missing DT Mbus ranges and relocate PCIe DT
 nodes for RN102
Message-ID: <87a9iuq7ff.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


When 5e12a613 and 0cd3754a were introduced, Netgear ReadyNAS 102 .dts
file was queued for inclusion and missed the update to have Mbus (and
then BootROM) ranges properties declared. It also missed the relocation
of Armada 370/XP PCIe DT nodes introduced by 14fd8ed0 after de1af8d4.
This patch fixes that which makes 3.12-rc3 bootable on the NAS.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 35 ++++++++++++++------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 05e4485..aef5ac5 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -27,6 +27,25 @@
 	};
 
 	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
+
+		pcie-controller {
+			status = "okay";
+
+			/* Connected to Marvell SATA controller */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+
+			/* Connected to FL1009 USB 3.0 controller */
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
@@ -89,22 +108,6 @@
 					pwm_polarity = <0>;
 				};
 			};
-
-			pcie-controller {
-				status = "okay";
-
-				/* Connected to Marvell SATA controller */
-				pcie at 1,0 {
-					/* Port 0, Lane 0 */
-					status = "okay";
-				};
-
-				/* Connected to FL1009 USB 3.0 controller */
-				pcie at 2,0 {
-					/* Port 1, Lane 0 */
-					status = "okay";
-				};
-			};
 		};
 	};
 
-- 
1.8.4.rc3
