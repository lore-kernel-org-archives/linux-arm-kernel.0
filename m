From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 23 Jan 2014 18:09:48 +0200
Subject: [RESEND][RFC PATCH 2/2] arm: Get rid of meminfo
In-Reply-To: <1389813057-26572-3-git-send-email-lauraa@codeaurora.org>
References: <1389813057-26572-1-git-send-email-lauraa@codeaurora.org>
 <1389813057-26572-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <52E13ECC.3070203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On 01/15/2014 09:10 PM, Laura Abbott wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.
>
> TODO: fix early_mem, get rid of NR_BANKS?

There are few comments below.

>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>   arch/arm/include/asm/mach/arch.h         |    4 +-
>   arch/arm/include/asm/memblock.h          |    3 +-
>   arch/arm/include/asm/setup.h             |   23 ------
>   arch/arm/kernel/atags_parse.c            |    5 +-
>   arch/arm/kernel/setup.c                  |   33 +++------
>   arch/arm/mach-clps711x/board-clep7312.c  |    7 +-
>   arch/arm/mach-clps711x/board-edb7211.c   |   10 +--
>   arch/arm/mach-clps711x/board-p720t.c     |    2 +-
>   arch/arm/mach-footbridge/cats-hw.c       |    2 +-
>   arch/arm/mach-footbridge/netwinder-hw.c  |    2 +-
>   arch/arm/mach-msm/board-halibut.c        |    6 --
>   arch/arm/mach-msm/board-mahimahi.c       |   13 +--
>   arch/arm/mach-msm/board-msm7x30.c        |    3 +-
>   arch/arm/mach-msm/board-sapphire.c       |   13 +--
>   arch/arm/mach-msm/board-trout.c          |    8 +-
>   arch/arm/mach-orion5x/common.c           |    3 +-
>   arch/arm/mach-orion5x/common.h           |    3 +-
>   arch/arm/mach-pxa/cm-x300.c              |    3 +-
>   arch/arm/mach-pxa/corgi.c                |   10 +--
>   arch/arm/mach-pxa/eseries.c              |    9 +-
>   arch/arm/mach-pxa/poodle.c               |    8 +-
>   arch/arm/mach-pxa/spitz.c                |    9 +--
>   arch/arm/mach-pxa/tosa.c                 |    8 +-
>   arch/arm/mach-realview/core.c            |   11 +--
>   arch/arm/mach-realview/core.h            |    3 +-
>   arch/arm/mach-realview/realview_pb1176.c |    8 +-
>   arch/arm/mach-realview/realview_pbx.c    |   17 ++---
>   arch/arm/mach-s3c24xx/mach-smdk2413.c    |    8 +-
>   arch/arm/mach-s3c24xx/mach-vstms.c       |    8 +-
>   arch/arm/mach-sa1100/assabet.c           |    2 +-
>   arch/arm/mm/init.c                       |   61 ++++++----------
>   arch/arm/mm/mmu.c                        |  122 ++++++++++--------------------
>   32 files changed, 143 insertions(+), 284 deletions(-)
>
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index 17a3fa2..c43473a 100644
[...]

>
> @@ -692,6 +685,12 @@ int __init arm_add_memory(u64 start, u64 size)
>    * Pick out the memory size.  We look for mem=size at start,
>    * where start and size are "size[KkMm]"
>    */
> +
> +/*
> + * XXX this is busted when just using memblock. Need to add memblock
> + * hook to reset.
> + */
> +
>   static int __init early_mem(char *p)
>   {
>   	static int usermem __initdata = 0;
> @@ -706,7 +705,6 @@ static int __init early_mem(char *p)
>   	 */
>   	if (usermem == 0) {
>   		usermem = 1;
> -		meminfo.nr_banks = 0;
>   	}

The below code might work here:
memblock_remove(memblock_start_of_DRAM(),
		memblock_end_of_DRAM() - memblock_start_of_DRAM());

>
>   	start = PHYS_OFFSET;
> @@ -851,13 +849,6 @@ static void __init reserve_crashkernel(void)
>   static inline void reserve_crashkernel(void) {}
>   #endif /* CONFIG_KEXEC */
>

[...]

> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index e0e3968..c6ea491 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -81,24 +81,21 @@ __tagtable(ATAG_INITRD2, parse_tag_initrd2);
>    * initialization functions, as well as show_mem() for the skipping
>    * of holes in the memory map.  It is populated by arm_add_memory().
>    */
> -struct meminfo meminfo;
> -
>   void show_mem(unsigned int filter)
>   {
>   	int free = 0, total = 0, reserved = 0;
> -	int shared = 0, cached = 0, slab = 0, i;
> -	struct meminfo * mi = &meminfo;
> +	int shared = 0, cached = 0, slab = 0;
> +	struct memblock_region *reg;
>
>   	printk("Mem-info:\n");
>   	show_free_areas(filter);
>
> -	for_each_bank (i, mi) {
> -		struct membank *bank = &mi->bank[i];
> +	for_each_memblock (memory, reg) {
>   		unsigned int pfn1, pfn2;
>   		struct page *page, *end;
>
> -		pfn1 = bank_pfn_start(bank);
> -		pfn2 = bank_pfn_end(bank);
> +		pfn1 = memblock_region_memory_base_pfn(reg);
> +		pfn2 = memblock_region_memory_end_pfn(reg);
>
>   		page = pfn_to_page(pfn1);
>   		end  = pfn_to_page(pfn2 - 1) + 1;
> @@ -130,16 +127,9 @@ void show_mem(unsigned int filter)
>   static void __init find_limits(unsigned long *min, unsigned long *max_low,
>   			       unsigned long *max_high)
>   {
> -	struct meminfo *mi = &meminfo;
> -	int i;
> -
> -	/* This assumes the meminfo array is properly sorted */
> -	*min = bank_pfn_start(&mi->bank[0]);
> -	for_each_bank (i, mi)
> -		if (mi->bank[i].highmem)
> -				break;
> -	*max_low = bank_pfn_end(&mi->bank[i - 1]);
> -	*max_high = bank_pfn_end(&mi->bank[mi->nr_banks - 1]);
> +	*max_low = PFN_DOWN(memblock_get_current_limit());
> +	*min = PFN_UP(memblock_start_of_DRAM());
> +	*max_high = PFN_DOWN(memblock_end_of_DRAM());

Just to notify. Above values may have different values after your 
change, because of usage arm_memblock_steal(). Is it ok?

>   }
>
>   static void __init arm_bootmem_init(unsigned long start_pfn,
> @@ -327,14 +317,8 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
>   	return phys;
>   }
>
> -void __init arm_memblock_init(struct meminfo *mi,
> -	const struct machine_desc *mdesc)
> +void __init arm_memblock_init(const struct machine_desc *mdesc)
>   {
> -	int i;
> -
> -	for (i = 0; i < mi->nr_banks; i++)
> -		memblock_add(mi->bank[i].start, mi->bank[i].size);
> -
>   	/* Register the kernel text, kernel data and initrd with memblock. */
>   #ifdef CONFIG_XIP_KERNEL
>   	memblock_reserve(__pa(_sdata), _end - _sdata);
> @@ -466,48 +450,47 @@ free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>   /*
>    * The mem_map array can get very big.  Free the unused area of the memory map.
>    */
> -static void __init free_unused_memmap(struct meminfo *mi)
> +static void __init free_unused_memmap(void)
>   {
> -	unsigned long bank_start, prev_bank_end = 0;
> -	unsigned int i;
> +	unsigned long start, prev_end = 0;
> +	struct memblock_region *reg;
>
>   	/*
>   	 * This relies on each bank being in address order.
>   	 * The banks are sorted previously in bootmem_init().
>   	 */
> -	for_each_bank(i, mi) {
> -		struct membank *bank = &mi->bank[i];
> -
> -		bank_start = bank_pfn_start(bank);
> +	for_each_memblock(memory, reg) {
> +		start = __phys_to_pfn(reg->base);
>
>   #ifdef CONFIG_SPARSEMEM
>   		/*
>   		 * Take care not to free memmap entries that don't exist
>   		 * due to SPARSEMEM sections which aren't present.
>   		 */
> -		bank_start = min(bank_start,
> -				 ALIGN(prev_bank_end, PAGES_PER_SECTION));
> +		start = min(start,
> +				 ALIGN(prev_end, PAGES_PER_SECTION));
>   #else
>   		/*
>   		 * Align down here since the VM subsystem insists that the
>   		 * memmap entries are valid from the bank start aligned to
>   		 * MAX_ORDER_NR_PAGES.
>   		 */
> -		bank_start = round_down(bank_start, MAX_ORDER_NR_PAGES);
> +		start = round_down(start, MAX_ORDER_NR_PAGES);
>   #endif
>   		/*
>   		 * If we had a previous bank, and there is a space
>   		 * between the current bank and the previous, free it.
>   		 */
> -		if (prev_bank_end && prev_bank_end < bank_start)
> -			free_memmap(prev_bank_end, bank_start);
> +		if (prev_end && prev_end < start)
> +			free_memmap(prev_end, start);
>
>   		/*
>   		 * Align up here since the VM subsystem insists that the
>   		 * memmap entries are valid from the bank end aligned to
>   		 * MAX_ORDER_NR_PAGES.
>   		 */
> -		prev_bank_end = ALIGN(bank_pfn_end(bank), MAX_ORDER_NR_PAGES);
> +		prev_end = ALIGN(start + __phys_to_pfn(reg->size),
> +				 MAX_ORDER_NR_PAGES);
>   	}
>
>   #ifdef CONFIG_SPARSEMEM
> @@ -589,7 +572,7 @@ void __init mem_init(void)
>   	max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
>
>   	/* this will put all unused low memory onto the freelists */
> -	free_unused_memmap(&meminfo);
> +	free_unused_memmap();
>   	free_all_bootmem();
>
>   #ifdef CONFIG_SA1111
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 4f08c13..394701c 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1043,77 +1043,54 @@ early_param("vmalloc", early_vmalloc);
>
>   phys_addr_t arm_lowmem_limit __initdata = 0;
>
> +static void remove_memblock(phys_addr_t base, phys_addr_t size)
> +{
> +        memblock_reserve(base, size);
> +        memblock_free(base, size);
> +        memblock_remove(base, size);
> +}

I think it'll be ok to use just memblock_remove(base, size); below.

> +
>   void __init sanity_check_meminfo(void)
>   {
>   	phys_addr_t memblock_limit = 0;
> -	int i, j, highmem = 0;
> +	int highmem = 0;
>   	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
> +	struct memblock_region *reg;
>
> -	for (i = 0, j = 0; i < meminfo.nr_banks; i++) {
> -		struct membank *bank = &meminfo.bank[j];
> -		phys_addr_t size_limit;
> -
> -		*bank = meminfo.bank[i];
> -		size_limit = bank->size;
> +	for_each_memblock(memory, reg) {
> +		phys_addr_t block_start = reg->base;
> +		phys_addr_t block_end = reg->base + reg->size;
> +		phys_addr_t size_limit = reg->size;
>
> -		if (bank->start >= vmalloc_limit)
> +		if (reg->base >= vmalloc_limit)
>   			highmem = 1;
>   		else
> -			size_limit = vmalloc_limit - bank->start;
> +			size_limit = vmalloc_limit - reg->base;
>
> -		bank->highmem = highmem;
>
> -#ifdef CONFIG_HIGHMEM
> -		/*
> -		 * Split those memory banks which are partially overlapping
> -		 * the vmalloc area greatly simplifying things later.
> -		 */
> -		if (!highmem && bank->size > size_limit) {
> -			if (meminfo.nr_banks >= NR_BANKS) {
> -				printk(KERN_CRIT "NR_BANKS too low, "
> -						 "ignoring high memory\n");
> -			} else {
> -				memmove(bank + 1, bank,
> -					(meminfo.nr_banks - i) * sizeof(*bank));
> -				meminfo.nr_banks++;
> -				i++;
> -				bank[1].size -= size_limit;
> -				bank[1].start = vmalloc_limit;
> -				bank[1].highmem = highmem = 1;
> -				j++;
> +		if (!IS_ENABLED(CONFIG_HIGHMEM) || cache_is_vipt_aliasing()) {
> +
> +			if (highmem) {
> +				pr_notice("Ignoring ram at %pa-%pa (!CONFIG_HIGHMEM)\n",
> +					&block_start, &block_end);
> +				remove_memblock(block_start, block_end);
> +				continue;
>   			}
> -			bank->size = size_limit;
> -		}
> -#else
> -		/*
> -		 * Highmem banks not allowed with !CONFIG_HIGHMEM.
> -		 */
> -		if (highmem) {
> -			printk(KERN_NOTICE "Ignoring RAM at %.8llx-%.8llx "
> -			       "(!CONFIG_HIGHMEM).\n",
> -			       (unsigned long long)bank->start,
> -			       (unsigned long long)bank->start + bank->size - 1);
> -			continue;
> -		}
>
> -		/*
> -		 * Check whether this memory bank would partially overlap
> -		 * the vmalloc area.
> -		 */
> -		if (bank->size > size_limit) {
> -			printk(KERN_NOTICE "Truncating RAM at %.8llx-%.8llx "
> -			       "to -%.8llx (vmalloc region overlap).\n",
> -			       (unsigned long long)bank->start,
> -			       (unsigned long long)bank->start + bank->size - 1,
> -			       (unsigned long long)bank->start + size_limit - 1);
> -			bank->size = size_limit;
> +			if (reg->size > size_limit) {
> +				phys_addr_t overlap_size = reg->size - size_limit;
> +
> +				pr_notice("Truncating RAM at %pa-%pa to -%pa",
> +					&block_start, &block_end, &overlap_size);
> +				remove_memblock(vmalloc_limit, overlap_size);
> +				block_end = vmalloc_limit;
> +			}
>   		}
> -#endif
> -		if (!bank->highmem) {
> -			phys_addr_t bank_end = bank->start + bank->size;
>
> -			if (bank_end > arm_lowmem_limit)
> -				arm_lowmem_limit = bank_end;
> +		if (!highmem) {
> +			if (block_end > arm_lowmem_limit)
> +				arm_lowmem_limit = reg->base + size_limit;
> +
>
>   			/*
>   			 * Find the first non-section-aligned page, and point
> @@ -1129,35 +1106,16 @@ void __init sanity_check_meminfo(void)
>   			 * occurs before any free memory is mapped.
>   			 */
>   			if (!memblock_limit) {
> -				if (!IS_ALIGNED(bank->start, SECTION_SIZE))
> -					memblock_limit = bank->start;
> -				else if (!IS_ALIGNED(bank_end, SECTION_SIZE))
> -					memblock_limit = bank_end;
> +				if (!IS_ALIGNED(block_start, SECTION_SIZE))
> +					memblock_limit = block_start;
> +				else if (!IS_ALIGNED(block_end, SECTION_SIZE))
> +					memblock_limit = block_end;
>   			}
> -		}
> -		j++;
> -	}
> -#ifdef CONFIG_HIGHMEM
> -	if (highmem) {
> -		const char *reason = NULL;
>
> -		if (cache_is_vipt_aliasing()) {
> -			/*
> -			 * Interactions between kmap and other mappings
> -			 * make highmem support with aliasing VIPT caches
> -			 * rather difficult.
> -			 */
> -			reason = "with VIPT aliasing cache";
> -		}
> -		if (reason) {
> -			printk(KERN_CRIT "HIGHMEM is not supported %s, ignoring high memory\n",
> -				reason);
> -			while (j > 0 && meminfo.bank[j - 1].highmem)
> -				j--;
>   		}
> +
>   	}
> -#endif
> -	meminfo.nr_banks = j;
> +
>   	high_memory = __va(arm_lowmem_limit - 1) + 1;
>
>   	/*
>

Regards,
- grygorii
