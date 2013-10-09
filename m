From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Oct 2013 11:06:03 +0100
Subject: [PATCH v3 5/6] ARM: mm: Recreate kernel mappings in
 early_paging_init()
In-Reply-To: <525444BD.80304@ti.com>
References: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
 <1380835081-12129-6-git-send-email-santosh.shilimkar@ti.com>
 <20131004155958.GU24303@mudshark.cambridge.arm.com>
 <524EE8F4.4060407@ti.com> <52530CD1.5010309@ti.com>
 <20131008102642.GC17148@mudshark.cambridge.arm.com>
 <525444BD.80304@ti.com>
Message-ID: <20131009100603.GA5985@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 06:45:33PM +0100, Santosh Shilimkar wrote:
> On Tuesday 08 October 2013 06:26 AM, Will Deacon wrote:
> > On Mon, Oct 07, 2013 at 08:34:41PM +0100, Santosh Shilimkar wrote:
> >> +		/*
> >> +		 * Cache cleaning operations for self-modifying code
> >> +		 * We should clean the entries by MVA but running a
> >> +		 * for loop over every pv_table entry pointer would
> >> +		 * just complicate the code. isb() is added to commit
> >> +		 * all the prior cp15 operations.
> >> +		 */
> >> +		flush_cache_louis();
> >> +		isb();
> > 
> > I see, you need the new __pv_tables to be visible for your page table
> > population below, right? In which case, I'm afraid I have to go back on my
> > original statement; you *do* need that dsb() prior to the isb() if you want
> > to ensure that the icache maintenance is complete and synchronised.
> > 
> Need of dsb and isb is what ARM ARM says but then I got bit biased after
> your reply. 

Yeah, sorry about that. I didn't originally notice that you needed the I-cache
flushing before the __pa stuff below.

> >> +	}
> >> +
> >> +	/* remap level 1 table */
> >> +	for (i = 0; i < PTRS_PER_PGD; i++) {
> >> +		*pud0++ = __pud(__pa(pmd0) | PMD_TYPE_TABLE | L_PGD_SWAPPER);
> >> +		pmd0 += PTRS_PER_PMD;
> >> +	}
> >> +
> >> +	__cpuc_flush_dcache_area(pud_start, sizeof(pud_start) * PTRS_PER_PGD);
> >> +	outer_clean_range(virt_to_phys(pud_start), sizeof(pud_start) * PTRS_PER_PGD);
> > 
> > You don't need to flush these page tables if you're SMP. If you use
> > clean_dcache_area instead, it will do the right thing. The again, why can't
> > you use pud_populate and pmd_populate for these two loops? Is there an
> > interaction with coherency here? (if so, why don't you need to flush the
> > entire cache hierarchy anyway?)
> > 
> You mean AMRMv7 SMP PT walkers can read from L1 cache and hence doesn't need 
> flushing L1. While this could be true, for some reason we don't the same
> behavior and seeing that without flush we are seeing the issue.

I would really like to know why this isn't working for you. I have a feeling
that it's related to your interesting coherency issues on keystone. For
example, if the physical address put in the ttbr doesn't match the physical
address which is mapped to the kernel page tables, then we could get
physical aliasing in the caches.

> Initially we were doing entire cache flush but moved to the mva based
> routines on your suggestion.

If the issue is related to coherency and physical aliasing, I really think
you should just flush the entire cache hierarchy. It's difficult to identify
exactly what state needs to be carried over between the old and new
mappings, but I bet it's more than just page tables.

> Regarding the pud_populate(), since we needed L_PGD_SWAPPER, we couldn't
> use that version but updated patch uses the set_pud() which takes the flag.
> And pmd_populate() can't be used either because it creates pte based
> tables which is not what we want.

Ok. It certainly looks better than it did.

Will
