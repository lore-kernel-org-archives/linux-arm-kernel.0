From: pawel.moll@arm.com (Pawel Moll)
Date: Wed,  7 Aug 2013 16:09:44 +0100
Subject: [PATCH v2 1/5] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
References: <1375888188-30213-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1375888188-30213-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Unlike real A15/A7's, the RTSM simulation doesn't appear to hit the
cache when the CTRL.C bit is cleared.  Let's ensure there is no memory
access within the disable and flush cache sequence, including to the
stack.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/dcscb.c | 58 +++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 16d57a8..85fffa7 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -136,14 +136,29 @@ static void dcscb_power_down(void)
 		/*
 		 * Flush all cache levels for this cluster.
 		 *
-		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
-		 * a preliminary flush here for those CPUs.  At least, that's
-		 * the theory -- without the extra flush, Linux explodes on
-		 * RTSM (to be investigated).
+		 * To do so we do:
+		 * - Clear the SCTLR.C bit to prevent further cache allocations
+		 * - Flush the whole cache
+		 * - Clear the ACTLR "SMP" bit to disable local coherency
+		 *
+		 * Let's do it in the safest possible way i.e. with
+		 * no memory access within the following sequence
+		 * including to the stack.
 		 */
-		flush_cache_all();
-		set_cr(get_cr() & ~CR_C);
-		flush_cache_all();
+		asm volatile(
+		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
+		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
+		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
+		"isb	\n\t"
+		"bl	v7_flush_dcache_all \n\t"
+		"clrex	\n\t"
+		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
+		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
+		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
+		"isb	\n\t"
+		"dsb	"
+		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
+		      "r9","r10","r11","lr","memory");
 
 		/*
 		 * This is a harmless no-op.  On platforms with a real
@@ -152,9 +167,6 @@ static void dcscb_power_down(void)
 		 */
 		outer_flush_all();
 
-		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
-		set_auxcr(get_auxcr() & ~(1 << 6));
-
 		/*
 		 * Disable cluster-level coherency by masking
 		 * incoming snoops and DVM messages:
@@ -167,18 +179,22 @@ static void dcscb_power_down(void)
 
 		/*
 		 * Flush the local CPU cache.
-		 *
-		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
-		 * a preliminary flush here for those CPUs.  At least, that's
-		 * the theory -- without the extra flush, Linux explodes on
-		 * RTSM (to be investigated).
+		 * Let's do it in the safest possible way as above.
 		 */
-		flush_cache_louis();
-		set_cr(get_cr() & ~CR_C);
-		flush_cache_louis();
-
-		/* Disable local coherency by clearing the ACTLR "SMP" bit: */
-		set_auxcr(get_auxcr() & ~(1 << 6));
+		asm volatile(
+		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
+		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
+		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
+		"isb	\n\t"
+		"bl	v7_flush_dcache_louis \n\t"
+		"clrex	\n\t"
+		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
+		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
+		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
+		"isb	\n\t"
+		"dsb	"
+		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
+		      "r9","r10","r11","lr","memory");
 	}
 
 	__mcpm_cpu_down(cpu, cluster);
-- 
1.8.1.2
