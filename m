From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Sep 2012 17:55:55 +0100
Subject: [PATCH v3 RESEND 08/17] ARM: LPAE: use phys_addr_t in
 free_memmap()
In-Reply-To: <50608D3D.2010106@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-9-git-send-email-cyril@ti.com>
 <20120924132942.GD23298@arm.com>
 <20120924134145.GB26454@n2100.arm.linux.org.uk> <506077BE.6000600@ti.com>
 <20120924152220.GE26454@n2100.arm.linux.org.uk> <50608D3D.2010106@ti.com>
Message-ID: <20120924165555.GF26454@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 12:41:33PM -0400, Cyril Chemparathy wrote:
> It appears to be not that hard actually... Or maybe I'm totally missing  
> your point.  Could it be that you last looked at this prior to the  
> nobootmem compatibility stuff being added in?

Quite possible - we converted over to memblock here:

commit 2778f62056ada442414392d7ccd41188bb631619
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Jul 9 16:27:52 2010 +0100

It looks like nobootmem.c was created here:

commit 0932587328d9bd5b500a640fbaff3290c8d4cabf
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Thu Feb 24 14:43:05 2011 +0100

So, when I was porting ARM to memblock, we had:

commit 08677214e318297f228237be0042aac754f48f1d
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Wed Feb 10 01:20:20 2010 -0800

which causes a load of bootmem functions to panic() when bootmem is
disabled.

> The following patch appears to work just fine on a faked sparsemem system:

Great.  Don't forget to also check flatmem too, just to be sure.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 92f598a..e94fa4c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -49,6 +49,7 @@ config ARM
>  	select GENERIC_STRNCPY_FROM_USER
>  	select GENERIC_STRNLEN_USER
>  	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) &&  
> !CPU_BIG_ENDIAN
> +	select NO_BOOTMEM
>  	help
>  	  The ARM series is a line of low-power-consumption RISC chip designs
>  	  licensed by ARM Ltd and targeted at embedded applications and
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 29560d8..0ca6c00 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -150,58 +150,6 @@ static void __init find_limits(unsigned long *min,  
> unsigned long *max_low,
>  	*max_high = bank_pfn_end(&mi->bank[mi->nr_banks - 1]);
>  }
>
> -static void __init arm_bootmem_init(unsigned long start_pfn,
> -	unsigned long end_pfn)
> -{
> -	struct memblock_region *reg;
> -	unsigned int boot_pages;
> -	phys_addr_t bitmap;
> -	pg_data_t *pgdat;
> -
> -	/*
> -	 * Allocate the bootmem bitmap page.  This must be in a region
> -	 * of memory which has already been mapped.
> -	 */
> -	boot_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
> -	bitmap = memblock_alloc_base(boot_pages << PAGE_SHIFT, L1_CACHE_BYTES,
> -				__pfn_to_phys(end_pfn));
> -
> -	/*
> -	 * Initialise the bootmem allocator, handing the
> -	 * memory banks over to bootmem.
> -	 */
> -	node_set_online(0);
> -	pgdat = NODE_DATA(0);
> -	init_bootmem_node(pgdat, __phys_to_pfn(bitmap), start_pfn, end_pfn);
> -
> -	/* Free the lowmem regions from memblock into bootmem. */
> -	for_each_memblock(memory, reg) {
> -		unsigned long start = memblock_region_memory_base_pfn(reg);
> -		unsigned long end = memblock_region_memory_end_pfn(reg);
> -
> -		if (end >= end_pfn)
> -			end = end_pfn;
> -		if (start >= end)
> -			break;
> -
> -		free_bootmem(__pfn_to_phys(start), (end - start) << PAGE_SHIFT);
> -	}
> -
> -	/* Reserve the lowmem memblock reserved regions in bootmem. */
> -	for_each_memblock(reserved, reg) {
> -		unsigned long start = memblock_region_reserved_base_pfn(reg);
> -		unsigned long end = memblock_region_reserved_end_pfn(reg);
> -
> -		if (end >= end_pfn)
> -			end = end_pfn;
> -		if (start >= end)
> -			break;
> -
> -		reserve_bootmem(__pfn_to_phys(start),
> -			        (end - start) << PAGE_SHIFT, BOOTMEM_DEFAULT);
> -	}
> -}
> -
>  #ifdef CONFIG_ZONE_DMA
>
>  unsigned long arm_dma_zone_size __read_mostly;
> @@ -393,8 +341,6 @@ void __init bootmem_init(void)
>
>  	find_limits(&min, &max_low, &max_high);
>
> -	arm_bootmem_init(min, max_low);
> -
>  	/*
>  	 * Sparsemem tries to allocate bootmem in memory_present(),
>  	 * so must be done after the fixed reservations
> @@ -443,6 +389,54 @@ static inline int free_area(unsigned long pfn,  
> unsigned long end, char *s)
>  	return pages;
>  }
>
> +static unsigned long free_all_lowmem(void)
> +{
> +	unsigned long max_low = max_low_pfn + PHYS_PFN_OFFSET;
> +	struct memblock_region *mem, *res;
> +	unsigned long total_pages = 0;
> +
> +	/* set highmem page free */
> +	for_each_memblock(memory, mem) {
> +		unsigned long start = memblock_region_memory_base_pfn(mem);
> +		unsigned long end = memblock_region_memory_end_pfn(mem);
> +
> +		/* Ignore complete lowmem entries */
> +		if (start > max_low)
> +			continue;
> +
> +		/* Truncate partial highmem entries */
> +		if (end > max_low)
> +			end = max_low;
> +
> +		/* Find and exclude any reserved regions */
> +		for_each_memblock(reserved, res) {
> +			unsigned long res_start, res_end;
> +
> +			res_start = memblock_region_reserved_base_pfn(res);
> +			res_end = memblock_region_reserved_end_pfn(res);
> +
> +			if (res_end < start)
> +				continue;
> +			if (res_start < start)
> +				res_start = start;
> +			if (res_start > end)
> +				res_start = end;
> +			if (res_end > end)
> +				res_end = end;
> +			if (res_start != start)
> +				total_pages += free_area(start, res_start, NULL);
> +			start = res_end;
> +			if (start == end)
> +				break;
> +		}
> +
> +		/* And now free anything which remains */
> +		if (start < end)
> +			total_pages += free_area(start, end, NULL);
> +	}
> +	return total_pages;
> +}
> +
>  /*
>   * Poison init memory with an undefined instruction (ARM) or a branch  
> to an
>   * undefined instruction (Thumb).
> @@ -606,7 +600,7 @@ void __init mem_init(void)
>  	/* this will put all unused low memory onto the freelists */
>  	free_unused_memmap(&meminfo);
>
> -	totalram_pages += free_all_bootmem();
> +	totalram_pages += free_all_lowmem();
>
>  #ifdef CONFIG_SA1111
>  	/* now that our DMA memory is actually so designated, we can free it */
>
> -- 
> Thanks
> - Cyril
