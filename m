From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 11 Nov 2016 11:50:50 +0900
Subject: [PATCH v27 1/9] memblock: add memblock_cap_memory_range()
In-Reply-To: <20161110172720.GB17134@arm.com>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
 <20161102045153.12008-1-takahiro.akashi@linaro.org>
 <20161110172720.GB17134@arm.com>
Message-ID: <20161111025049.GG381@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,
(+ Cc: Dennis)

On Thu, Nov 10, 2016 at 05:27:20PM +0000, Will Deacon wrote:
> On Wed, Nov 02, 2016 at 01:51:53PM +0900, AKASHI Takahiro wrote:
> > Add memblock_cap_memory_range() which will remove all the memblock regions
> > except the range specified in the arguments.
> > 
> > This function, like memblock_mem_limit_remove_map(), will not remove
> > memblocks with MEMMAP_NOMAP attribute as they may be mapped and accessed
> > later as "device memory."
> > See the commit a571d4eb55d8 ("mm/memblock.c: add new infrastructure to
> > address the mem limit issue").
> > 
> > This function is used, in a succeeding patch in the series of arm64 kdump
> > suuport, to limit the range of usable memory, System RAM, on crash dump
> > kernel.
> > (Please note that "mem=" parameter is of little use for this purpose.)
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: linux-mm at kvack.org
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  include/linux/memblock.h |  1 +
> >  mm/memblock.c            | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 5b759c9..0e770af 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -334,6 +334,7 @@ phys_addr_t memblock_start_of_DRAM(void);
> >  phys_addr_t memblock_end_of_DRAM(void);
> >  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> >  void memblock_mem_limit_remove_map(phys_addr_t limit);
> > +void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
> >  bool memblock_is_memory(phys_addr_t addr);
> >  int memblock_is_map_memory(phys_addr_t addr);
> >  int memblock_is_region_memory(phys_addr_t base, phys_addr_t size);
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 7608bc3..eb53876 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1544,6 +1544,34 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
> >  			      (phys_addr_t)ULLONG_MAX);
> >  }
> >  
> > +void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
> > +{
> > +	int start_rgn, end_rgn;
> > +	int i, ret;
> > +
> > +	if (!size)
> > +		return;
> > +
> > +	ret = memblock_isolate_range(&memblock.memory, base, size,
> > +						&start_rgn, &end_rgn);
> > +	if (ret)
> > +		return;
> > +
> > +	/* remove all the MAP regions */
> > +	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
> > +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> > +			memblock_remove_region(&memblock.memory, i);
> > +
> > +	for (i = start_rgn - 1; i >= 0; i--)
> > +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> > +			memblock_remove_region(&memblock.memory, i);
> > +
> > +	/* truncate the reserved regions */
> > +	memblock_remove_range(&memblock.reserved, 0, base);
> > +	memblock_remove_range(&memblock.reserved,
> > +			base + size, (phys_addr_t)ULLONG_MAX);
> > +}
> 
> This duplicates a bunch of the logic in memblock_mem_limit_remove_map. Can
> you not implement that in terms of your new, more general, function? e.g.
> by passing base == 0, and size == limit?

Obviously it's possible.
I actually talked to Dennis before about merging them,
but he was against my idea.

Thanks,
-Takahiro AKASHI

> Will
