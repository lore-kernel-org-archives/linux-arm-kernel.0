From: stefan@agner.ch (Stefan Agner)
Date: Wed, 07 Sep 2016 13:52:30 -0700
Subject: [PATCH v2] ARM: LPAE: initialize cache policy correctly
In-Reply-To: <20160905180003.30638-1-stefan@agner.ch>
References: <20160905180003.30638-1-stefan@agner.ch>
Message-ID: <4ee97b594d1d3bc8fa9a3df915d96b2c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-05 11:00, Stefan Agner wrote:
> The cachepolicy variable gets initialized using a masked pmd
> value. So far, the pmd has been masked with flags valid for the
> 2-page table format, but the 3-page table format requires a
> different mask. On LPAE, this lead to a wrong assumption of what
> initial cache policy has been used. Later a check forces the
> cache policy to writealloc and prints the following warning:
> Forcing write-allocate cache policy for SMP
> 
> This patch introduces a new definition PMD_SECT_CACHE_MASK for
> both page table formats which masks in all cache flags in both
> cases.

Submitted the patch to your tracking system (Patch #8612/1).

--
Stefan

> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v1:
> - Introduce new definition PMD_SECT_CACHE_MASK
> 
>  arch/arm/include/asm/pgtable-2level-hwdef.h | 1 +
>  arch/arm/include/asm/pgtable-3level-hwdef.h | 1 +
>  arch/arm/mm/mmu.c                           | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level-hwdef.h
> b/arch/arm/include/asm/pgtable-2level-hwdef.h
> index d0131ee..3f82e9d 100644
> --- a/arch/arm/include/asm/pgtable-2level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-2level-hwdef.h
> @@ -47,6 +47,7 @@
>  #define PMD_SECT_WB		(PMD_SECT_CACHEABLE | PMD_SECT_BUFFERABLE)
>  #define PMD_SECT_MINICACHE	(PMD_SECT_TEX(1) | PMD_SECT_CACHEABLE)
>  #define PMD_SECT_WBWA		(PMD_SECT_TEX(1) | PMD_SECT_CACHEABLE |
> PMD_SECT_BUFFERABLE)
> +#define PMD_SECT_CACHE_MASK	(PMD_SECT_TEX(1) | PMD_SECT_CACHEABLE |
> PMD_SECT_BUFFERABLE)
>  #define PMD_SECT_NONSHARED_DEV	(PMD_SECT_TEX(2))
>  
>  /*
> diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h
> b/arch/arm/include/asm/pgtable-3level-hwdef.h
> index f8f1cff..4cd664a 100644
> --- a/arch/arm/include/asm/pgtable-3level-hwdef.h
> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> @@ -62,6 +62,7 @@
>  #define PMD_SECT_WT		(_AT(pmdval_t, 2) << 2)	/* normal inner write-through */
>  #define PMD_SECT_WB		(_AT(pmdval_t, 3) << 2)	/* normal inner write-back */
>  #define PMD_SECT_WBWA		(_AT(pmdval_t, 7) << 2)	/* normal inner write-alloc */
> +#define PMD_SECT_CACHE_MASK	(_AT(pmdval_t, 7) << 2)
>  
>  /*
>   * + Level 3 descriptor (PTE)
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 724d6be..4001dd1 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -137,7 +137,7 @@ void __init init_default_cache_policy(unsigned long pmd)
>  
>  	initial_pmd_value = pmd;
>  
> -	pmd &= PMD_SECT_TEX(1) | PMD_SECT_BUFFERABLE | PMD_SECT_CACHEABLE;
> +	pmd &= PMD_SECT_CACHE_MASK;
>  
>  	for (i = 0; i < ARRAY_SIZE(cache_policies); i++)
>  		if (cache_policies[i].pmd == pmd) {
