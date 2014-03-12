From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Mar 2014 14:44:52 +0000
Subject: [PATCHv4 2/2] arm: Get rid of meminfo
In-Reply-To: <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
References: <1392761733-32628-1-git-send-email-lauraa@codeaurora.org>
 <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140312144452.GJ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:15:33PM -0800, Laura Abbott wrote:
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index b68c6b2..c3ae96c 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1061,74 +1061,44 @@ phys_addr_t arm_lowmem_limit __initdata = 0;
>  void __init sanity_check_meminfo(void)
>  {
>  	phys_addr_t memblock_limit = 0;
> -	int i, j, highmem = 0;
> +	int highmem = 0;
>  	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
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
>  			highmem = 1;
>  		else
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
> +				pr_notice("Ignoring RAM at %pa-%pa (!CONFIG_HIGHMEM)\n",
> +					&block_start, &block_end);
> +				memblock_remove(reg->base, reg->size);
> +				continue;
>  			}
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
> +				      &block_start, &block_end, &vmalloc_limit);
> +				memblock_remove(vmalloc_limit, overlap_size);
> +				block_end = vmalloc_limit;
> +			}
>  		}
> -#endif
> -		if (!bank->highmem) {
> -			phys_addr_t bank_end = bank->start + bank->size;
>  
> -			if (bank_end > arm_lowmem_limit)
> -				arm_lowmem_limit = bank_end;
> +		if (!highmem) {
> +			if (block_end > arm_lowmem_limit)
> +				arm_lowmem_limit = block_end;
> +
>  
>  			/*
>  			 * Find the first non-section-aligned page, and point
> @@ -1144,35 +1114,16 @@ void __init sanity_check_meminfo(void)
>  			 * occurs before any free memory is mapped.
>  			 */
>  			if (!memblock_limit) {
> -				if (!IS_ALIGNED(bank->start, SECTION_SIZE))
> -					memblock_limit = bank->start;
> -				else if (!IS_ALIGNED(bank_end, SECTION_SIZE))
> -					memblock_limit = bank_end;
> +				if (!IS_ALIGNED(block_start, SECTION_SIZE))
> +					memblock_limit = block_start;
> +				else if (!IS_ALIGNED(block_end, SECTION_SIZE))
> +					memblock_limit = block_end;
>  			}
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
>  		}
> +
>  	}
> -#endif
> -	meminfo.nr_banks = j;
> +

Adding here:
	if (arm_lowmem_limit > vmalloc_limit)
		arm_lowmem_limit = vmalloc_limit;

fixes the booting problems, because we now properly calculate the end of
lowmem rather than letting it overflow - previously, the code would set
the end of lowmem to be the end of the first memblock which is quite
obviously wrong when you could have any size of memory in that block.

BTW, for a v4 patch, please clean up the excess blank lines in this
patch.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
