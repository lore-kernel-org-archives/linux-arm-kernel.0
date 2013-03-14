From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 14 Mar 2013 17:46:02 +0000
Subject: [PATCH V3] ARM: mvebu: fix RAM size for Armada XP board DB-MV784MP-GP
In-Reply-To: <20130216164457.GA23237@titan.lakedaemon.net>
References: <20130216164457.GA23237@titan.lakedaemon.net>
Message-ID: <1363283162-26041-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board is supplied with a 4GB RAM module.  This value can be
overridden by the bootloader based on probed memory size.  We set it to
a reasonable value here.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Changes from v2:
 - trimmed size to not conflict with internal register addresses, added comment.
   Thanks to Jason Gunthorpe for raising this and Gregory Clement for confirming.

Changes from v1:
 - grammatical fix suggested by Sergei Shtylyov
 - correct size suggested by several folks (within 32bit, 1 dword)

As promised, catching this fix in the -rc cycle.

For those not familiar, earlier versions of the patch adding this board listed
3GB because that is all that was visible.  I mistaken applied v3 of the patch
instead of v4 which properly listed 4GB.  This patch cleans up my error.


 arch/arm/boot/dts/armada-xp-gp.dts | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 1c8afe2..b2d7804 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -28,12 +28,14 @@
 		device_type = "memory";
 
 		/*
-		 * 4 GB of plug-in RAM modules by default but only 3GB
-		 * are visible, the amount of memory available can be
-		 * changed by the bootloader according the size of the
-		 * module actually plugged
+		 * 4 GB of plug-in RAM modules by default. The amount of memory
+		 * available can be changed by the bootloader according to the
+		 * size of the module actually plugged
+		 *
+		 * Clipped at 0xD0000000 since this is the start of the internal
+		 * registers.
 		 */
-		reg = <0x00000000 0xC0000000>;
+		reg = <0x00000000 0xD0000000>;
 	};
 
 	soc {
-- 
1.8.1.5
