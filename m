From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Mar 2011 12:37:15 +0530
Subject: [PATCH v2 3/5] OMAP3: PM: Allow the cache clean when L1 is lost.
In-Reply-To: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
References: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1299740837-27881-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When L1 cache is suppose to be lost, it needs to be cleaned before
entrering to the low power mode.

While at this, also fix few comments and remove un-necessary
clean_l2 lable.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index e58ec7d..7f13336 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -190,12 +190,12 @@ ENTRY(omap34xx_cpu_suspend)
 	stmfd	sp!, {r0-r12, lr}	@ save registers on stack
 
 	/*
-	 * r0 contains restore pointer in sdram
+	 * r0 contains CPU context save/restore pointer in sdram
 	 * r1 contains information about saving context:
 	 *   0 - No context lost
 	 *   1 - Only L1 and logic lost
-	 *   2 - Only L2 lost
-	 *   3 - Both L1 and L2 lost
+	 *   2 - Only L2 lost (Even L1 is retained we clean it along with L2)
+	 *   3 - Both L1 and L2 lost and logic lost
 	 */
 
 	/* Directly jump to WFI is the context save is not required */
@@ -280,15 +280,6 @@ l1_logic_lost:
 
 clean_caches:
 	/*
-	 * Clean Data or unified cache to POU
-	 * How to invalidate only L1 cache???? - #FIX_ME#
-	 * mcr	p15, 0, r11, c7, c11, 1
-	 */
-	cmp	r1, #0x1 		@ Check whether L2 inval is required
-	beq	omap3_do_wfi
-
-clean_l2:
-	/*
 	 * jump out to kernel flush routine
 	 *  - reuse that code is better
 	 *  - it executes in a cached space so is faster than refetch per-block
-- 
1.6.0.4
