From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 18 May 2011 13:42:05 -0400 (EDT)
Subject: [PATCH] ARM: sparsemem: fix highmem detection when using SPARSEMEM
In-Reply-To: <1305734711-6710-1-git-send-email-will.deacon@arm.com>
References: <1305734711-6710-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.00.1105181341320.14430@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 May 2011, Will Deacon wrote:

> sanity_check_meminfo walks over the registered memory banks and attempts
> to split banks across lowmem and highmem when they would otherwise
> overlap with the vmalloc space.
> 
> When SPARSEMEM is used, there are two potential problems that occur
> when the virtual address of the start of a bank is equal to vmalloc_min.
> 
>  1.) The end of lowmem is calculated as __pa(vmalloc_min - 1) + 1.
>      In the above scenario, this will give the end address of the
>      previous bank, rather than the actual bank we are interested in.
>      This value is later used as the memblock limit and artificially
>      restricts the total amount of available memory.
> 
>  2.) The checks to determine whether or not a bank belongs to highmem
>      or not only check if __va(bank->start) is greater or less than
>      vmalloc_min. In the case that it is equal, the bank is incorrectly
>      treated as lowmem, which hoses the vmalloc area.
> 
> This patch fixes these two problems by checking whether the virtual
> start address of a bank is >= vmalloc_min and then calculating
> lowmem_end by finding the virtual end address of the highest lowmem
> bank.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
> 
> Russell - I hit this problem on a RealView-PBX board when trying to use
> the full 1GB of memory with a 3:1 split configuration.
> 
>  arch/arm/mm/mmu.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 6cf76b3..9d8f0c8 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -765,15 +765,12 @@ static void __init sanity_check_meminfo(void)
>  {
>  	int i, j, highmem = 0;
>  
> -	lowmem_limit = __pa(vmalloc_min - 1) + 1;
> -	memblock_set_current_limit(lowmem_limit);
> -
>  	for (i = 0, j = 0; i < meminfo.nr_banks; i++) {
>  		struct membank *bank = &meminfo.bank[j];
>  		*bank = meminfo.bank[i];
>  
>  #ifdef CONFIG_HIGHMEM
> -		if (__va(bank->start) > vmalloc_min ||
> +		if (__va(bank->start) >= vmalloc_min ||
>  		    __va(bank->start) < (void *)PAGE_OFFSET)
>  			highmem = 1;
>  
> @@ -831,6 +828,9 @@ static void __init sanity_check_meminfo(void)
>  			bank->size = newsize;
>  		}
>  #endif
> +		if (!bank->highmem && bank->start + bank->size > lowmem_limit)
> +			lowmem_limit = bank->start + bank->size;
> +
>  		j++;
>  	}
>  #ifdef CONFIG_HIGHMEM
> @@ -854,6 +854,7 @@ static void __init sanity_check_meminfo(void)
>  	}
>  #endif
>  	meminfo.nr_banks = j;
> +	memblock_set_current_limit(lowmem_limit);
>  }
>  
>  static inline void prepare_page_table(void)
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
