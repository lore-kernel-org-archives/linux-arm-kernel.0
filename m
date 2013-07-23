From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 23 Jul 2013 11:43:57 +0100
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <alpine.LFD.2.03.1307221353360.15022@syhkavp.arg>
References: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
 <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
 <20130718150408.GB2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
 <20130718180323.GC2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181452480.14924@syhkavp.arg>
 <20130719102844.GA3746@localhost.localdomain>
 <20130719105907.GB27389@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1307221353360.15022@syhkavp.arg>
Message-ID: <20130723104352.GA3023@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 01:58:12PM -0400, Nicolas Pitre wrote:
> On Fri, 19 Jul 2013, Lorenzo Pieralisi wrote:
> 
> > On Fri, Jul 19, 2013 at 11:28:49AM +0100, Dave Martin wrote:
> > > On Thu, Jul 18, 2013 at 02:59:06PM -0400, Nicolas Pitre wrote:
> > > > On Thu, 18 Jul 2013, Dave Martin wrote:
> > > > 
> > > > > I had other names in mind, like "coherency_exit" or "cache_exit".
> > > > > Those are not very intelligible, but that might at least make people
> > > > > pause and think before blindly using it.
> > > > 
> > > > Good point.  It should still embody the architecture name for which it 
> > > > is valid though.
> > > 
> > > Sure, I was assuming something would be pasted on the start of the name.
> > 
> > v7 :-) with a comment describing the assumptions (in particular related
> > as Dave mentioned to the SMP bit behaviour) ?
> 
> OK... What about this then:
> 
> ----- >8
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date: Thu, 18 Jul 2013 13:12:48 -0400
> Subject: [PATCH] ARM: cacheflush: consolidate single-CPU ARMv7 cache disabling
>  code
> 
> This code is becoming duplicated in many places.  So let's consolidate
> it into a handy macro that is known to be right and available for reuse.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 17d0ae8672..8f4e2297e2 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -436,4 +436,44 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
>  #define sync_cache_w(ptr) __sync_cache_range_w(ptr, sizeof *(ptr))
>  #define sync_cache_r(ptr) __sync_cache_range_r(ptr, sizeof *(ptr))
>  
> +/*
> + * Disabling cache access for one CPU in an ARMv7 SMP system is tricky.
> + * To do so we must:
> + *
> + * - Clear the SCTLR.C bit to prevent further cache allocations
> + * - Flush the desired level of cache
> + * - Clear the ACTLR "SMP" bit to disable local coherency
> + *
> + * ... and so without any intervening memory access in between those steps,
> + * not even to the stack.
> + *
> + * WARNING -- After this has been called:
> + *
> + * - No ldr/str exclusive must be used.

Maybe write ldrex/strex (I misread that the first time around as "no
ldr/str ... must be used", which seemed a bit drastic)

> + * - The CPU is obviously no longer coherent with the other CPUs.
> + *
> + * Further considerations:
> + *
> + * - This relies on the presence and behavior of the AUXCR.SMP bit as
> + *   documented in the ARMv7 TRM.  Vendor implementations that deviate from

Sorry to be pedantic here, but there is no "ARMv7 TRM".  The SMP bit is
not part of ARMv7 at all.  Also, it seems that A9 isn't precisely the
same: two ACTLR bits need to be twiddled.  R-class CPUs are generally
not the same either.

This is why I preferred to treat the whole sequence as specific to a
particular CPU implementation.  The similarity between A7 and A15
might be viewed as a happy coincidence (it also makes life easier in
big.LITTLE land).

(Also, you mix the names "ACTLR" and "AUXCR", but people will generally
be able to guess those are the same thing)

 
> + *   that will need their own procedure.
> + * - This is unlikely to work if Linux is running non-secure.
> + */
> +#define v7_exit_coherency_flush(level) \

... hence:

#define cortex_a15_exit_coherency(level) ...

#define cortex_a7_exit_coherency(level) cortex_a15_exit_coherency(level)


What do you think?

Cheers
---Dave

> +	asm volatile( \
> +	"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t" \
> +	"bic	r0, r0, #"__stringify(CR_C)" \n\t" \
> +	"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t" \
> +	"isb	\n\t" \
> +	"bl	v7_flush_dcache_"__stringify(level)" \n\t" \
> +	"clrex	\n\t" \
> +	"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t" \
> +	"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t" \
> +	"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t" \
> +	"isb	\n\t" \
> +	"dsb	" \
> +	/* The clobber list is dictated by the call to v7_flush_dcache_* */ \
> +	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
> +	      "r9","r10","r11","lr","memory" )
> +
>  #endif
> diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> index 85fffa702f..14d4996887 100644
> --- a/arch/arm/mach-vexpress/dcscb.c
> +++ b/arch/arm/mach-vexpress/dcscb.c
> @@ -133,32 +133,8 @@ static void dcscb_power_down(void)
>  	if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
>  		arch_spin_unlock(&dcscb_lock);
>  
> -		/*
> -		 * Flush all cache levels for this cluster.
> -		 *
> -		 * To do so we do:
> -		 * - Clear the SCTLR.C bit to prevent further cache allocations
> -		 * - Flush the whole cache
> -		 * - Clear the ACTLR "SMP" bit to disable local coherency
> -		 *
> -		 * Let's do it in the safest possible way i.e. with
> -		 * no memory access within the following sequence
> -		 * including to the stack.
> -		 */
> -		asm volatile(
> -		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
> -		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
> -		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
> -		"isb	\n\t"
> -		"bl	v7_flush_dcache_all \n\t"
> -		"clrex	\n\t"
> -		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
> -		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
> -		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
> -		"isb	\n\t"
> -		"dsb	"
> -		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
> -		      "r9","r10","r11","lr","memory");
> +		/* Flush all cache levels for this cluster. */
> +		v7_exit_coherency_flush(all);
>  
>  		/*
>  		 * This is a harmless no-op.  On platforms with a real
> @@ -177,24 +153,8 @@ static void dcscb_power_down(void)
>  	} else {
>  		arch_spin_unlock(&dcscb_lock);
>  
> -		/*
> -		 * Flush the local CPU cache.
> -		 * Let's do it in the safest possible way as above.
> -		 */
> -		asm volatile(
> -		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
> -		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
> -		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
> -		"isb	\n\t"
> -		"bl	v7_flush_dcache_louis \n\t"
> -		"clrex	\n\t"
> -		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
> -		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
> -		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
> -		"isb	\n\t"
> -		"dsb	"
> -		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
> -		      "r9","r10","r11","lr","memory");
> +		/* Disable and flush the local CPU cache. */
> +		v7_exit_coherency_flush(louis);
>  	}
>  
>  	__mcpm_cpu_down(cpu, cluster);
> diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> index dfb55d45b6..5940f1e317 100644
> --- a/arch/arm/mach-vexpress/tc2_pm.c
> +++ b/arch/arm/mach-vexpress/tc2_pm.c
> @@ -134,26 +134,7 @@ static void tc2_pm_down(u64 residency)
>  			: : "r" (0x400) );
>  		}
>  
> -		/*
> -		 * We need to disable and flush the whole (L1 and L2) cache.
> -		 * Let's do it in the safest possible way i.e. with
> -		 * no memory access within the following sequence
> -		 * including the stack.
> -		 */
> -		asm volatile(
> -		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
> -		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
> -		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
> -		"isb	\n\t"
> -		"bl	v7_flush_dcache_all \n\t"
> -		"clrex	\n\t"
> -		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
> -		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
> -		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
> -		"isb	\n\t"
> -		"dsb	"
> -		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
> -		      "r9","r10","r11","lr","memory");
> +		v7_exit_coherency_flush(all);
>  
>  		cci_disable_port_by_cpu(mpidr);
>  
> @@ -169,24 +150,7 @@ static void tc2_pm_down(u64 residency)
>  
>  		arch_spin_unlock(&tc2_pm_lock);
>  
> -		/*
> -		 * We need to disable and flush only the L1 cache.
> -		 * Let's do it in the safest possible way as above.
> -		 */
> -		asm volatile(
> -		"mrc	p15, 0, r0, c1, c0, 0	@ get CR \n\t"
> -		"bic	r0, r0, #"__stringify(CR_C)" \n\t"
> -		"mcr	p15, 0, r0, c1, c0, 0	@ set CR \n\t"
> -		"isb	\n\t"
> -		"bl	v7_flush_dcache_louis \n\t"
> -		"clrex	\n\t"
> -		"mrc	p15, 0, r0, c1, c0, 1	@ get AUXCR \n\t"
> -		"bic	r0, r0, #(1 << 6)	@ disable local coherency \n\t"
> -		"mcr	p15, 0, r0, c1, c0, 1	@ set AUXCR \n\t"
> -		"isb	\n\t"
> -		"dsb	"
> -		: : : "r0","r1","r2","r3","r4","r5","r6","r7",
> -		      "r9","r10","r11","lr","memory");
> +		v7_exit_coherency_flush(louis);
>  	}
>  
>  	__mcpm_cpu_down(cpu, cluster);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
