From: qiuxishi@huawei.com (Xishi Qiu)
Date: Thu, 15 Dec 2016 14:18:00 +0800
Subject: [RFC PATCH] Memory hotplug support for arm64 platform
In-Reply-To: <1481717765-31186-1-git-send-email-m.bielski@virtualopensystems.com>
References: <1481717765-31186-1-git-send-email-m.bielski@virtualopensystems.com>
Message-ID: <58523598.3080902@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/14 20:16, Maciej Bielski wrote:

> 
>  
> -#ifdef CONFIG_MEMORY_HOTREMOVE
> -int arch_remove_memory(u64 start, u64 size)
> -{
> -	unsigned long start_pfn = start >> PAGE_SHIFT;
> -	unsigned long nr_pages = size >> PAGE_SHIFT;
> -	struct zone *zone;
> -	int ret;
> +		SetPageReserved(pfn_to_page(pfn));
> +	}

Hi Maciej,

Why we need to set reserved here?
I think the new pages are already reserved in __add_zone() -> memmap_init_zone(), right?

Thanks,
Xishi Qiu

>  
> -	zone = page_zone(pfn_to_page(start_pfn));
> -	ret = __remove_pages(zone, start_pfn, nr_pages);
>  	if (ret)
> -		pr_warn("%s: Problem encountered in __remove_pages() ret=%d\n",
> +		pr_warn("%s: Problem encountered in __add_pages() ret=%d\n",
>  			__func__, ret);
>  
>  	return ret;
>  }
>  #endif
> -#endif
>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 05615a3..9efa7d1 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -493,6 +493,30 @@ void __init paging_init(void)
>  		      SWAPPER_DIR_SIZE - PAGE_SIZE);
>  }
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +/*
> + * hotplug_paging() is used by memory hotplug to build new page tables
> + * for hot added memory.
> + */
> +void hotplug_paging(phys_addr_t start, phys_addr_t size)
> +{
> +	phys_addr_t pgd_phys = pgd_pgtable_alloc();
> +	pgd_t *pgd = pgd_set_fixmap(pgd_phys);
> +
> +	memcpy(pgd, swapper_pg_dir, PAGE_SIZE);
> +
> +	__create_pgd_mapping(pgd, start, __phys_to_virt(start), size,
> +			PAGE_KERNEL, pgd_pgtable_alloc, false);
> +
> +	cpu_replace_ttbr1(__va(pgd_phys));
> +	memcpy(swapper_pg_dir, pgd, PAGE_SIZE);
> +	cpu_replace_ttbr1(swapper_pg_dir);
> +
> +	pgd_clear_fixmap();
> +	memblock_free(pgd_phys, PAGE_SIZE);
> +}
> +#endif
> +
>  /*
>   * Check whether a kernel address is valid (derived from arch/x86/).
>   */
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 5b759c9..5f78257 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -92,6 +92,7 @@ int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
> +int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>  ulong choose_memblock_flags(void);
>  
>  /* Low level functions */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 7608bc3..05e7676 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -814,6 +814,16 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>  }
>  
>  /**
> + * memblock_clear_nomap - Clear a flag of MEMBLOCK_NOMAP memory region
> + * @base: the base phys addr of the region
> + * @size: the size of the region
> + */
> +int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
> +{
> +	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
> +}
> +
> +/**
>   * __next_reserved_mem_region - next function for for_each_reserved_region()
>   * @idx: pointer to u64 loop variable
>   * @out_start: ptr to phys_addr_t for start address of the region, can be %NULL
