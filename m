From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  4 Mar 2014 17:37:00 +0100
Subject: [PATCH 2/4] ARM: mvebu: switch the Armada XP DB to use internal
 registers at 0xf1000000
In-Reply-To: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1393951022-18114-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell has now provided bootloaders that are Device Tree capable for
the Armada XP DB board, and that also remap the internal register base
address to 0xf1000000. In addition, the bootloader now sets the MBus
Window base address to 0xf0000000, but on this board, this change
doesn't make much difference since the board is by default equipped
with 2 GB of RAM.

Therefore this commit updates the soc->ranges Device Tree property
with the fact that the internal registers are now mapped at
0xf1000000.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index bcf6d79..448373c 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -2,7 +2,7 @@
  * Device Tree file for Marvell Armada XP evaluation board
  * (DB-78460-BP)
  *
- * Copyright (C) 2012 Marvell
+ * Copyright (C) 2012-2014 Marvell
  *
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
@@ -11,6 +11,15 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
+  *
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
@@ -30,7 +39,7 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
 
-- 
1.8.3.2
