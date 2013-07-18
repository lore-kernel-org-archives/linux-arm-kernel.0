From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Jul 2013 13:24:48 -0400 (EDT)
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <20130718150408.GB2655@localhost.localdomain>
References: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
 <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
 <20130718150408.GB2655@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ added Russell for his opinion on the patch below ]

On Thu, 18 Jul 2013, Dave Martin wrote:

> On Wed, Jul 17, 2013 at 11:28:33PM -0400, Nicolas Pitre wrote:
> > Unlike real A15/A7's, the RTSM simulation doesn't appear to hit the
> > cache when the CTRL.C bit is cleared.  Let's ensure there is no memory
> > access within the disable and flush cache sequence, including to the
> > stack.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >  arch/arm/mach-vexpress/dcscb.c | 58 +++++++++++++++++++++++++++---------------
> >  1 file changed, 37 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> > index 16d57a8a9d..9f01c04d58 100644
> > --- a/arch/arm/mach-vexpress/dcscb.c
> > +++ b/arch/arm/mach-vexpress/dcscb.c
> > @@ -136,14 +136,29 @@ static void dcscb_power_down(void)
> >  		/*
> >  		 * Flush all cache levels for this cluster.
> >  		 *
> > -		 * A15/A7 can hit in the cache with SCTLR.C=0, so we don't need
> > -		 * a preliminary flush here for those CPUs.  At least, that's
> > -		 * the theory -- without the extra flush, Linux explodes on
> > -		 * RTSM (to be investigated).
> > +		 * To do so we do:
> > +		 * - Clear the CTLR.C bit to prevent further cache allocations
> 
> SCTLR

Fixed.

> > +		 * - Flush the whole cache
> > +		 * - Disable local coherency by clearing the ACTLR "SMP" bit
> > +		 *
> > +		 * Let's do it in the safest possible way i.e. with
> > +		 * no memory access within the following sequence
> > +		 * including the stack.
> >  		 */
> > -		flush_cache_all();
> > -		set_cr(get_cr() & ~CR_C);
> > -		flush_cache_all();
> > +		asm volatile(
> > +		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
> > +		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
> > +		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
> > +		"isb	\n\t"
> > +		"bl	v7_flush_dcache_all \n\t"
> > +		"clrex	\n\t"
> > +		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
> > +		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
> > +		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
> > +		"isb	\n\t"
> > +		"dsb	"
> > +		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
> > +		      "r9","r10","r11","lr","memory");
> 
> Along with the TC2 support, we now have 4 copies of this code sequence.
> 
> This is basically the A15/A7 native "exit coherency and flash and
> disable some levels of dcache" operation, whose only parameter is which
> cache levels to flush.
> 
> That's a big mouthful -- we can probably come up with a better name --
> but we've pretty much concluded that there is no way to break this
> operation apart into bitesize pieces.  Nonetheless, any native
> powerdown sequence for these processors will need to do this, or
> something closely related.
> 
> Is it worth consolidating, or is that premature?

It is probably worth consolidating.

What about this:

commit 390cf8b9b83eeeebdfef51912f5003a6a9b84115
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Thu Jul 18 13:12:48 2013 -0400

    ARM: cacheflush: consolidate single-CPU ARMv7 cache disabling code
    
    This code is becoming duplicated in many places.  So let's consolidate
    it into a handy macro that is known to be right and available for reuse.
    
    Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 17d0ae8672..8a76933e80 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -436,4 +436,33 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
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
+ * The clobber list is dictated by the call to v7_flush_dcache_*.
+ */
+#define v7_disable_flush_cache(level) \
+	asm volatile( \
+	"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t" \
+	"bic	r0, r0, #"__stringify(CR_C)" \n\t" \
+	"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t" \
+	"isb	\n\t" \
+	"bl	v7_flush_dcache_"__stringify(level)" \n\t" \
+	"clrex	\n\t" \
+	"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t" \
+	"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t" \
+	"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t" \
+	"isb	\n\t" \
+	"dsb	" \
+	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
+	      "r9","r10","r11","lr","memory" )
+
 #endif
diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 85fffa702f..145d8237d5 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -133,32 +133,8 @@ static void dcscb_power_down(void)
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
-		 */
-		asm volatile(
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
-		"dsb	"
-		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","r11","lr","memory");
+		/* Flush all cache levels for this cluster. */
+		v7_disable_flush_cache(all);
 
 		/*
 		 * This is a harmless no-op.  On platforms with a real
@@ -177,24 +153,8 @@ static void dcscb_power_down(void)
 	} else {
 		arch_spin_unlock(&dcscb_lock);
 
-		/*
-		 * Flush the local CPU cache.
-		 * Let's do it in the safest possible way as above.
-		 */
-		asm volatile(
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
-		"dsb	"
-		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","r11","lr","memory");
+		/* Flush the local CPU cache. */
+		v7_disable_flush_cache(louis);
 	}
 
 	__mcpm_cpu_down(cpu, cluster);
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index dfb55d45b6..fd8bc2d931 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -134,26 +134,7 @@ static void tc2_pm_down(u64 residency)
 			: : "r" (0x400) );
 		}
 
-		/*
-		 * We need to disable and flush the whole (L1 and L2) cache.
-		 * Let's do it in the safest possible way i.e. with
-		 * no memory access within the following sequence
-		 * including the stack.
-		 */
-		asm volatile(
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
-		"dsb	"
-		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","r11","lr","memory");
+		v7_disable_flush_cache(all);
 
 		cci_disable_port_by_cpu(mpidr);
 
@@ -169,24 +150,7 @@ static void tc2_pm_down(u64 residency)
 
 		arch_spin_unlock(&tc2_pm_lock);
 
-		/*
-		 * We need to disable and flush only the L1 cache.
-		 * Let's do it in the safest possible way as above.
-		 */
-		asm volatile(
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
-		"dsb	"
-		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
-		      "r9","r10","r11","lr","memory");
+		v7_disable_flush_cache(louis);
 	}
 
 	__mcpm_cpu_down(cpu, cluster);
