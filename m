From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:13:24 +0900
Subject: [PATCH 06/15] ARM: sh7372: fix cache clean / invalidate order
In-Reply-To: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080013-29189-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

According to the Cortex A8 TRM the L2 cache should be first cleaned and
then disabled. Fix the swapped order on sh7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/sleep-sh7372.S |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/sleep-sh7372.S b/arch/arm/mach-shmobile/sleep-sh7372.S
index 1d56467..a9df53b 100644
--- a/arch/arm/mach-shmobile/sleep-sh7372.S
+++ b/arch/arm/mach-shmobile/sleep-sh7372.S
@@ -59,17 +59,19 @@ sh7372_do_idle_sysc:
 	mcr	p15, 0, r0, c1, c0, 0
 	isb
 
+	/*
+	 * Clean and invalidate data cache again.
+	 */
+	ldr	r1, kernel_flush
+	blx	r1
+
 	/* disable L2 cache in the aux control register */
 	mrc     p15, 0, r10, c1, c0, 1
 	bic     r10, r10, #2
 	mcr     p15, 0, r10, c1, c0, 1
+	isb
 
 	/*
-	 * Invalidate data cache again.
-	 */
-	ldr	r1, kernel_flush
-	blx	r1
-	/*
 	 * The kernel doesn't interwork: v7_flush_dcache_all in particluar will
 	 * always return in Thumb state when CONFIG_THUMB2_KERNEL is enabled.
 	 * This sequence switches back to ARM.  Note that .align may insert a
-- 
1.7.10.4
