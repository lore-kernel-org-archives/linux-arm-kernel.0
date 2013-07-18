From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 18 Jul 2013 19:03:23 +0100
Subject: [PATCH 1/4] ARM: vexpress/dcscb: fix cache disabling sequences
In-Reply-To: <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
References: <1374118116-16836-1-git-send-email-nicolas.pitre@linaro.org>
 <1374118116-16836-2-git-send-email-nicolas.pitre@linaro.org>
 <20130718150408.GB2655@localhost.localdomain>
 <alpine.LFD.2.03.1307181231510.14924@syhkavp.arg>
Message-ID: <20130718180323.GC2655@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 01:24:48PM -0400, Nicolas Pitre wrote:
> [ added Russell for his opinion on the patch below ]

[...]

> commit 390cf8b9b83eeeebdfef51912f5003a6a9b84115
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Thu Jul 18 13:12:48 2013 -0400
> 
>     ARM: cacheflush: consolidate single-CPU ARMv7 cache disabling code
>     
>     This code is becoming duplicated in many places.  So let's consolidate
>     it into a handy macro that is known to be right and available for reuse.
>     
>     Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 17d0ae8672..8a76933e80 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -436,4 +436,33 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
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
> + * The clobber list is dictated by the call to v7_flush_dcache_*.
> + */
> +#define v7_disable_flush_cache(level) \
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
> +	: : : "r0","r1","r2","r3","r4","r5","r6","r7", \
> +	      "r9","r10","r11","lr","memory" )
> +
>  #endif

That's roughly what I had in mind, though it might belong somewhere more
obscure than cacheflush.h(?)

"disable_flush_cache" sounds a too general-purpose for my liking.

"v7" isn't really right because we touch the ACTLR.  This only works
on certain CPUs and when Linux is running Secure.  Maybe saying "a15"
instead of "a7" is reasonable, since a7 is supposed to be an a15
workalike in most places.

I had other names in mind, like "coherency_exit" or "cache_exit".
Those are not very intelligible, but that might at least make people
pause and think before blindly using it.

Really, it's for the very specific purpose of doing native low-level
powerdown of an individual CPU in a multiprocessor system, when the
platform as a whole is not being shut down, on A15 or A7 (+ possibly
other future v7 CPUs)... it's not suitable for any other situation.
Even kexec probably shouldn't be disabling the SMP bit.

Cheers
---Dave
