From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Jun 2013 16:51:06 +0100
Subject: dummy_flush_tlb_a15_erratum in check_and_switch_context
In-Reply-To: <20130628085719.GA29002@mudshark.cambridge.arm.com>
References: <51CD077E.7040207@jonmasters.org>
 <20130628085719.GA29002@mudshark.cambridge.arm.com>
Message-ID: <20130628155106.GG1643@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 09:57:19AM +0100, Will Deacon wrote:
> On Fri, Jun 28, 2013 at 04:48:14AM +0100, Jon Masters wrote:
> > #ifdef CONFIG_ARM_ERRATA_798181
> > static inline void dummy_flush_tlb_a15_erratum(void)
> > {
> >         /*
> >          * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
> >          */
> >         asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
> >         dsb();
> > }
> > #else
> > static inline void dummy_flush_tlb_a15_erratum(void)
> > {
> > }
> > #endif
> 
> Yep, the -IS variants are only available on SMP cores.
> 
> > Now I think it's personally just easier to only turn on that errata on
> > LPAE/A15 kernels and just leave it at that (I've requested this get
> > moved to the lpae config and out of the base config so this is what
> > should happen shortly - clearly the intention), but some folks out there
> > want to do exciting things...I got asked if this could be runtime
> > patched (which I guess in theory is possible), but I'm not going there.
> > 
> > Anyway, in addition, does this kind of thing need fixing with a more
> > specific Kconfig so that there's an explicit A15 dependency in there?
> > Rather just "depends on CPU_V7 && SMP"?
> 
> Even better: my TLB optimisation series removes this line of code
> altogether:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/178592.html
> 
> If we need a quick fix for stable, we should just check the CPUID on
> the context-switch slow(er) path.

I've been waiting for the arch/arm/mm/context.c change in the above
patch to reach mainline for a long time ;). Basically with
cpumask_setall(&tlb_flush_pending) we no longer need the dummy flush for
this erratum since the flush will happen on all CPUs anyway.

-- 
Catalin
