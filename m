From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 16:16:18 +0100
Subject: [PATCH 23/25] ARM: pm: omap34xx: remove misleading comment and use
	of r9
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Message-ID: <E1QZPAA-0002XG-1C@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code alludes to r9 being used to indicate what was lost over the
suspend/resume transition.  However, although r9 is set, it is never
actually used.

Also, the comments before the code (which refer to the value of r9)
and the comments against the assignment of r9 contradict each other,
so just remove them to avoid confusion.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/sleep34xx.S |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 9551c7d..12e9da2 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -381,18 +381,13 @@ restore_3630:
 
 restore:
 	/*
-	 * Check what was the reason for mpu reset and store the reason in r9:
-	 *  0 - No context lost
-	 *  1 - Only L1 and logic lost
-	 *  2 - Only L2 lost - In this case, we wont be here
-	 *  3 - Both L1 and L2 lost
+	 * Read the pwstctrl register to check the reason for mpu reset.
+	 * This tells us what was lost.
 	 */
 	ldr	r1, pm_pwstctrl_mpu
 	ldr	r2, [r1]
 	and	r2, r2, #0x3
 	cmp	r2, #0x0	@ Check if target power state was OFF or RET
-	moveq	r9, #0x3	@ MPU OFF => L1 and L2 lost
-	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
 	bne	logic_l1_restore
 
 	ldr	r0, l2dis_3630
-- 
1.7.4.4
