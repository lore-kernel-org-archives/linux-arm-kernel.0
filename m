From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 15 Oct 2013 23:34:46 -0400 (EDT)
Subject: [PATCH] ARM: cacheflush: consolidate single-CPU ARMv7 cache disabling
 code
Message-ID: <alpine.LFD.2.03.1310152327290.1873@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This code is becoming duplicated in many places.  So let's consolidate
it into a handy macro that is known to be right and available for reuse.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---

I forgot which version this one is.  As far as I know, I've incorporated 
most review comments, and ignored conflicting ones which tended to look 
like bikeshedding and attempted to compensate for them with additional 
code comments.

ACK?

 arch/arm/include/asm/cacheflush.h | 45 +++++++++++++++++++++++++++++++
 arch/arm/mach-vexpress/dcscb.c    | 56 +++------------------------------------
 arch/arm/mach-vexpress/tc2_pm.c   | 48 ++-------------------------------
 3 files changed, 51 insertions(+), 98 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 15f2d5bf88..60a0a79b1a 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -435,4 +435,49 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
 #define sync_cache_w(ptr) __sync_cache_range_w(ptr, sizeof *(ptr))
 #define sync_cache_r(ptr) __sync_cache_range_r(ptr, sizeof *(ptr))
 
+/*
+ * Disabling cache access for one CPU in an ARMv7 SMP system is tricky.
+ * To do so we must:
+ *
+ * - Clear the SCTLR.C bit to prevent further cache allocations
+ * - Flush the desired level of cache
+ * - Clear the ACTLR "SMP" bit to disable local coherency
+ *
+ * ... and so without any intervening memory access in between those steps,
+ * not even to the stack.
+ *
+ * WARNING -- After this has been called:
+ *
+ * - No ldrex/strex (and similar) instructions must be used.
+ * - The CPU is obviously no longer coherent with the other CPUs.
+ * - This is unlikely to work as expected if Linux is running non-secure.
+ *
+ * Note:
+ *
+ * - This is known to apply to several ARMv7 processor implementations,
+ *   however some exceptions may exist.  Caveat emptor.
+ *
+ * - The clobber list is dictated by the call to v7_flush_dcache_*.
+ *   fp is preserved to the stack explicitly prior disabling the cache
+ *   since adding it to the clobber list is incompatible with having
+ *   CONFIG_FRAME_POINTER=y.
+ */
+#define v7_exit_coherency_flush(level) \
+	asm volatile( \
+	"str	fp, [sp, #-4]! \n\t" \
+	"mrc	p15, 0, r0, c1, c0, 0	@ get SCTLR \n\t" \
+	"bic	r0, r0, #"__stringify(CR_C)" \n\t" \
+	"mcr	p15, 0, r0, c1, c0, 0	@ set SCTLR \n\t" \
+	"isb	\n\t" \
+	"bl	v7_flush_dcache_"__stringify(level)" \n\t" \
+	"clrex	\n\t" \
+	"mrc	p15, 0, r0, c1, c0, 1	@ get ACTLR \n\t" \
+	"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t" \
+	"mcr	p15, 0, r0, c1, c0, 1	@ set ACTLR \n\t" \
+	"isb	\n\t" \
+	"dsb	\n\t" \
+	"ldr	fp, [sp], #4" \
+	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
+	      "r9","r10","lr","memory" )
+
 #endif
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 3a6384c6c4..14d4996887 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -133,38 +133,8 @@ static void dcscb_power_down(void)
 	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
 		arch_spin_unlock(&dcscb_lock);
 
-		/*
-		 * Flush all cache levels for this cluster.
-		 *
-		 * To do so we do:
-		 * - Clear the SCTLR.C bit to prevent further cache allocations
-		 * - Flush the whole cache
-		 * - Clear the ACTLR "SMP" bit to disable local coherency
-		 *
-		 * Let's do it in the safest possible way i.e. with
-		 * no memory access within the following sequence
-		 * including to the stack.
-		 *
-		 * Note: fp is preserved to the stack explicitly prior doing
-		 * this since adding it to the clobber list is incompatible
-		 * with having CONFIG_FRAME_POINTER=y.
-		 */
-		asm volatile(
-		"str	fp, [sp, #-4]! \n\t"
-		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
-		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
-		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
-		"isb	\n\t"
-		"bl	v7_flush_dcache_all \n\t"
-		"clrex	\n\t"
-		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
-		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
-		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
-		"isb	\n\t"
-		"dsb	\n\t"
-		"ldr	fp, [sp], #4"
-		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","lr","memory");
+		/* Flush all cache levels for this cluster. */
+		v7_exit_coherency_flush(all);
 
 		/*
 		 * This is a harmless no-op.  On platforms with a real
@@ -183,26 +153,8 @@ static void dcscb_power_down(void)
 	} else {
 		arch_spin_unlock(&dcscb_lock);
 
-		/*
-		 * Flush the local CPU cache.
-		 * Let's do it in the safest possible way as above.
-		 */
-		asm volatile(
-		"str	fp, [sp, #-4]! \n\t"
-		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
-		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
-		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
-		"isb	\n\t"
-		"bl	v7_flush_dcache_louis \n\t"
-		"clrex	\n\t"
-		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
-		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
-		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
-		"isb	\n\t"
-		"dsb	\n\t"
-		"ldr	fp, [sp], #4"
-		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","lr","memory");
+		/* Disable and flush the local CPU cache. */
+		v7_exit_coherency_flush(louis);
 	}
 
 	__mcpm_cpu_down(cpu, cluster);
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index e6eb481929..4eb92ebfd9 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -156,32 +156,7 @@ static void tc2_pm_down(u64 residency)
 			: : "r" (0x400) );
 		}
 
-		/*
-		 * We need to disable and flush the whole (L1 and L2) cache.
-		 * Let's do it in the safest possible way i.e. with
-		 * no memory access within the following sequence
-		 * including the stack.
-		 *
-		 * Note: fp is preserved to the stack explicitly prior doing
-		 * this since adding it to the clobber list is incompatible
-		 * with having CONFIG_FRAME_POINTER=y.
-		 */
-		asm volatile(
-		"str	fp, [sp, #-4]! \n\t"
-		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
-		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
-		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
-		"isb	\n\t"
-		"bl	v7_flush_dcache_all \n\t"
-		"clrex	\n\t"
-		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
-		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
-		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
-		"isb	\n\t"
-		"dsb	\n\t"
-		"ldr	fp, [sp], #4"
-		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","lr","memory");
+		v7_exit_coherency_flush(all);
 
 		cci_disable_port_by_cpu(mpidr);
 
@@ -197,26 +172,7 @@ static void tc2_pm_down(u64 residency)
 
 		arch_spin_unlock(&tc2_pm_lock);
 
-		/*
-		 * We need to disable and flush only the L1 cache.
-		 * Let's do it in the safest possible way as above.
-		 */
-		asm volatile(
-		"str	fp, [sp, #-4]! \n\t"
-		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
-		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
-		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
-		"isb	\n\t"
-		"bl	v7_flush_dcache_louis \n\t"
-		"clrex	\n\t"
-		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
-		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
-		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
-		"isb	\n\t"
-		"dsb	\n\t"
-		"ldr	fp, [sp], #4"
-		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","lr","memory");
+		v7_exit_coherency_flush(louis);
 	}
 
 	__mcpm_cpu_down(cpu, cluster);
