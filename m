From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Feb 2010 15:42:01 +0000
Subject: [PATCH] Help fix SMP boot issues with L2 cache
In-Reply-To: <20100214001858.GA16553@n2100.arm.linux.org.uk>
References: <20100214001858.GA16553@n2100.arm.linux.org.uk>
Message-ID: <1266594121.32546.24.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-02-14 at 00:18 +0000, Russell King - ARM Linux wrote:
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
> >>      *pmd = __pmd((PHYS_OFFSET & PGDIR_MASK) |
> >>                   PMD_TYPE_SECT | PMD_SECT_AP_WRITE);
> >>      flush_pmd_entry(pmd);
> >> +    outer_clean_range(__pa(pmd), __pa(pmd + 1));
> >>      /*
> >>       * We need to tell the secondary core where to find
> >> @@ -106,7 +107,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
> >>       */
> >>      secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
> >>      secondary_data.pgdir = virt_to_phys(pgd);
> >> -    wmb();
> >> +    __cpuc_flush_dcache_area(&secondary_data, sizeof(secondary_data));
> >> +    outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
> >>      /*
> >>       * Now bring the CPU into our world.
> >
> > But is the outer_cache initialised at this point?
> 
> If it isn't, the calls are no-ops, so are harmless.  However, there are
> platforms where the L2 is already initialized at this point, and therefore
> this needs to be handled.

Yes, for what it is intended the patch is fine:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
