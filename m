From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  4 Mar 2014 17:37:01 +0100
Subject: [PATCH 3/4] ARM: mvebu: switch the Armada XP GP to use internal
 registers at 0xf1000000
In-Reply-To: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1393951022-18114-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell has now provided bootloaders that are Device Tree capable for
the Armada XP GP board, and that also remap the internal register base
address to 0xf1000000. In addition, the bootloader now sets the MBus
Window base address to 0xf0000000, which allows to use much more RAM
in the last GB of RAM before the 4 GB limit (the entire space from
0xC0000000 to 0xFFFFFFFF was not usable due to being used for I/O, not
only the space from 0xF0000000 to 0xFFFFFFFF is used for I/O).

Therefore this commit:

 * Updates the memory->reg Device Tree property with the fact that in
   the first bank of RAM, memory up to 0xf0000000 can be used.

 * Updates the soc->ranges Device Tree property with the fact that the
   internal registers are now mapped at 0xf1000000.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-gp.dts | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 274e2ad..61bda68 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -2,7 +2,7 @@
  * Device Tree file for Marvell Armada XP development board
  * (DB-MV784MP-GP)
  *
- * Copyright (C) 2013 Marvell
+ * Copyright (C) 2013-2014 Marvell
  *
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
@@ -11,6 +11,15 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
+ *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
  */
 
 /dts-v1/;
@@ -30,16 +39,17 @@
                  * 8 GB of plug-in RAM modules by default.The amount
                  * of memory available can be changed by the
                  * bootloader according the size of the module
-                 * actually plugged. Only 7GB are usable because
-                 * addresses from 0xC0000000 to 0xffffffff are used by
-                 * the internal registers of the SoC.
+                 * actually plugged. However, memory between
+                 * 0xF0000000 to 0xFFFFFFFF cannot be used, as it is
+                 * the address range used for I/O (internal registers,
+                 * MBus windows).
 		 */
-		reg = <0x00000000 0x00000000 0x00000000 0xC0000000>,
+		reg = <0x00000000 0x00000000 0x00000000 0xf0000000>,
 		      <0x00000001 0x00000000 0x00000001 0x00000000>;
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
 
-- 
1.8.3.2
