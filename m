From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2010 17:13:17 +0000
Subject: [PATCH] Help fix SMP boot issues with L2 cache
In-Reply-To: <20100214001858.GA16553@n2100.arm.linux.org.uk>
References: <20100212182552.GF18595@n2100.arm.linux.org.uk>
	<4B7739F7.7060604@arm.com>
	<20100214001858.GA16553@n2100.arm.linux.org.uk>
Message-ID: <20100218171317.GG20243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.  Acks would be nice.

On Sun, Feb 14, 2010 at 12:18:58AM +0000, Russell King - ARM Linux wrote:
> On Sat, Feb 13, 2010 at 11:47:03PM +0000, Catalin Marinas wrote:
> > Russell King - ARM Linux wrote:
> >>     ARM: Add L2 cache handling to smp boot support
> >>         The page table and secondary data which we're asking the 
> >> secondary CPU
> >>     to make use of has to hit RAM to ensure that the secondary CPU can see
> >>     it since it may not be taking part in coherency or cache searches at
> >>     this point.
> >>         Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >>
> >>  arch/arm/kernel/smp.c |    4 +++-
> >>  1 files changed, 3 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> >> index 57162af..577543f 100644
> >> --- a/arch/arm/kernel/smp.c
> >> +++ b/arch/arm/kernel/smp.c
> >> @@ -99,6 +99,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
> >>  	*pmd = __pmd((PHYS_OFFSET & PGDIR_MASK) |
> >>  		     PMD_TYPE_SECT | PMD_SECT_AP_WRITE);
> >>  	flush_pmd_entry(pmd);
> >> +	outer_clean_range(__pa(pmd), __pa(pmd + 1));
> >>   	/*
> >>  	 * We need to tell the secondary core where to find
> >> @@ -106,7 +107,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
> >>  	 */
> >>  	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
> >>  	secondary_data.pgdir = virt_to_phys(pgd);
> >> -	wmb();
> >> +	__cpuc_flush_dcache_area(&secondary_data, sizeof(secondary_data));
> >> +	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
> >>   	/*
> >>  	 * Now bring the CPU into our world.
> >
> > But is the outer_cache initialised at this point?
> 
> If it isn't, the calls are no-ops, so are harmless.  However, there are
> platforms where the L2 is already initialized at this point, and therefore
> this needs to be handled.
> 
> Whether platforms have initialized their L2 cache support while the
> hardware is enabled is their own lookout at this point - that's outside
> of the scope of this patch.
> 
> > I recall for RealView  
> > I had to change the l2x0_init to an early_initcall:
> >
> > http://linux-arm.org/git?p=linux-2.6-stable.git;a=commitdiff;h=70e1b8d308f635eaeb7dad14fc5c79f082a147ef;hp=f034a4ab31b0663a5b68c65503122bed1eaca349
> 
> And that's what I'm addressing with this patch - the need to patch
> every platsmp.c file with that kind of dirty hack.  With my patch,
> the SMP generic data structures will be covered by the appropriate
> code, rather than having every SMP platform having to do that itself.
> 
> Please update your patch for mine - the only thing you need to look
> after is 'pen_release'.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
