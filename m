From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Apr 2015 16:16:58 +0100
Subject: [RFC] mixture of cleanups to cache-v7.S
In-Reply-To: <20150410142655.GF12732@n2100.arm.linux.org.uk>
References: <20150402224947.GX24899@n2100.arm.linux.org.uk>
 <20150410132723.GD6854@e104818-lin.cambridge.arm.com>
 <20150410141105.GA16979@red-moon>
 <20150410142655.GF12732@n2100.arm.linux.org.uk>
Message-ID: <20150410151657.GE6854@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 03:26:55PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 10, 2015 at 03:11:05PM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Apr 10, 2015 at 02:27:42PM +0100, Catalin Marinas wrote:
> > > As for the v7_flush_dcache_all always having the barriers, I guess
> > > no-one is expecting a v7 CPU without caches.
> > 
> > Well, yes, actually I'd rather remove the barriers if LoC is 0 instead
> > of adding them to LoUIS API in case there is nothing to flush, I do not
> > think that's a problem in the first place.
> 
> Maybe you should read through the patch set before declaring there to
> be no problem.

I don't think anyone was disputing the code clean-up but whether the
cache flushing functions need to have barrier semantics even when there
isn't any level to flush. Looking through the code, flush_cache_louis()
is used in cpu_die() where in some circumstances a DSB would be needed
(like the CPU being killed from another CPU rather than by a WFI
execution). To avoid duplicating barriers in cpu_die() since in practice
LoUIS is at least 1 (unless you have unified caches at level 1), we
could always require them in v7_flush_dcache_louis.

> ENTRY(v7_flush_dcache_louis)
>         mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
> ALT_SMP(mov     r3, r0, lsr #20)                @ move LoUIS into position
> ALT_UP( mov     r3, r0, lsr #26)                @ move LoUU into position
> #ifdef CONFIG_ARM_ERRATA_643719
> ALT_SMP(ands    r3, r3, #7 << 1)                @ extract LoU*2 field from clidrALT_UP( b       start_flush_levels)
>         bne     start_flush_levels              @ LoU != 0, start flushing
>         mrc     p15, 0, r2, c0, c0, 0           @ read main ID register
>         movw    r1, #:lower16:(0x410fc090 >> 4) @ ID of ARM Cortex A9 r0p?
>         movt    r1, #:upper16:(0x410fc090 >> 4)
>         teq     r1, r2, lsr #4                  @ test for errata affected core
> and if so...
>         moveq   r3, #1 << 1                     @ fix LoUIS value (and set flags state to 'ne')
> #endif
>         b       start_flush_levels              @ start flushing cache levels
> 
> ENTRY(v7_flush_dcache_all)
>         mrc     p15, 1, r0, c0, c0, 1           @ read clidr
>         mov     r3, r0, lsr #23                 @ move LoC into position
> start_flush_levels:
>         dmb                                     @ ensure ordering with previous memory accesses
>         ands    r3, r3, #7 << 1                 @ extract field from clidr
>         beq     finished                        @ if loc is 0, then no need to clean
>         mov     r10, #0                         @ start clean at cache level 0
> flush_levels:
>         add     r2, r10, r10, lsr #1            @ work out 3x current cache level
>         mov     r1, r0, lsr r2                  @ extract cache type bits from clidr

Since the DMB is only needed for ordering prior memory accesses with the
cache maintenance itself, you could move it just before 'flush_levels'
(rather theoretical as I'm not aware of any ARMv7 CPUs with a unified
level 1 cache).

With that said, you can add my reviewed-by on all patches:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
