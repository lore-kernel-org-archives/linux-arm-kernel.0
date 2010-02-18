From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 18 Feb 2010 22:58:41 +0530
Subject: [PATCH] Help fix SMP boot issues with L2 cache
In-Reply-To: <20100218171317.GG20243@n2100.arm.linux.org.uk>
References: <20100212182552.GF18595@n2100.arm.linux.org.uk>
	<4B7739F7.7060604@arm.com>
	<20100214001858.GA16553@n2100.arm.linux.org.uk>
	<20100218171317.GG20243@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C417F8FB@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, February 18, 2010 10:43 PM
> To: Catalin Marinas; Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] Help fix SMP boot issues with L2 cache
> 
> Ping.  Acks would be nice.
> 
> On Sun, Feb 14, 2010 at 12:18:58AM +0000, Russell King - ARM Linux wrote:
> > On Sat, Feb 13, 2010 at 11:47:03PM +0000, Catalin Marinas wrote:
> > > Russell King - ARM Linux wrote:
> > >>     ARM: Add L2 cache handling to smp boot support
> > >>         The page table and secondary data which we're asking the
> > >> secondary CPU
> > >>     to make use of has to hit RAM to ensure that the secondary CPU can see
> > >>     it since it may not be taking part in coherency or cache searches at
> > >>     this point.
> > >>         Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > >>
> > >>  arch/arm/kernel/smp.c |    4 +++-
> > >>  1 files changed, 3 insertions(+), 1 deletions(-)
> > >>
> > >> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > >> index 57162af..577543f 100644
> > >> --- a/arch/arm/kernel/smp.c
> > >> +++ b/arch/arm/kernel/smp.c
> > >> @@ -99,6 +99,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
> > >>  	*pmd = __pmd((PHYS_OFFSET & PGDIR_MASK) |
> > >>  		     PMD_TYPE_SECT | PMD_SECT_AP_WRITE);
> > >>  	flush_pmd_entry(pmd);
> > >> +	outer_clean_range(__pa(pmd), __pa(pmd + 1));
> > >>   	/*
> > >>  	 * We need to tell the secondary core where to find
> > >> @@ -106,7 +107,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
> > >>  	 */
> > >>  	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
> > >>  	secondary_data.pgdir = virt_to_phys(pgd);
> > >> -	wmb();
> > >> +	__cpuc_flush_dcache_area(&secondary_data, sizeof(secondary_data));
> > >> +	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
> > >>   	/*
> > >>  	 * Now bring the CPU into our world.
> > >
> > > But is the outer_cache initialised at this point?
Outer cache is initialized by this time, so it's good. Infact this
is the right place to flush the secondary data and page tables instead of 
every arm-smp platform doing that as part of "boot_secondary".

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards,
Santosh
