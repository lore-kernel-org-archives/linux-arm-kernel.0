From: gerg@snapgear.com (Greg Ungerer)
Date: Sun, 22 Nov 2009 10:05:40 +1000
Subject: [PATCH 06/10] ARM: dma-mapping: move consistent_init into
	CONFIG_MMU section
In-Reply-To: <E1NBvmz-0007qr-7X@rmk-PC.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
	<E1NBvmz-0007qr-7X@rmk-PC.arm.linux.org.uk>
Message-ID: <4B088054.30606@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Russell King - ARM Linux wrote:
> No point wrapping the contents of this function with #ifdef CONFIG_MMU
> when we can place it and the core_initcall() entirely within the

Lost the end of the comments here?

Regards
Greg



> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mm/dma-mapping.c |   78 ++++++++++++++++++++++-----------------------
>  1 files changed, 38 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 2e025f6..7e8f150 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -144,6 +144,44 @@ static struct arm_vmregion_head consistent_head = {
>  #error ARM Coherent DMA allocator does not (yet) support huge TLB
>  #endif
>  
> +/*
> + * Initialise the consistent memory allocation.
> + */
> +static int __init consistent_init(void)
> +{
> +	int ret = 0;
> +	pgd_t *pgd;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	int i = 0;
> +	u32 base = CONSISTENT_BASE;
> +
> +	do {
> +		pgd = pgd_offset(&init_mm, base);
> +		pmd = pmd_alloc(&init_mm, pgd, base);
> +		if (!pmd) {
> +			printk(KERN_ERR "%s: no pmd tables\n", __func__);
> +			ret = -ENOMEM;
> +			break;
> +		}
> +		WARN_ON(!pmd_none(*pmd));
> +
> +		pte = pte_alloc_kernel(pmd, base);
> +		if (!pte) {
> +			printk(KERN_ERR "%s: no pte tables\n", __func__);
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		consistent_pte[i++] = pte;
> +		base += (1 << PGDIR_SHIFT);
> +	} while (base < CONSISTENT_END);
> +
> +	return ret;
> +}
> +
> +core_initcall(consistent_init);
> +
>  static void *
>  __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
>  	    pgprot_t prot)
> @@ -400,46 +438,6 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
>  EXPORT_SYMBOL(dma_free_coherent);
>  
>  /*
> - * Initialise the consistent memory allocation.
> - */
> -static int __init consistent_init(void)
> -{
> -	int ret = 0;
> -#ifdef CONFIG_MMU
> -	pgd_t *pgd;
> -	pmd_t *pmd;
> -	pte_t *pte;
> -	int i = 0;
> -	u32 base = CONSISTENT_BASE;
> -
> -	do {
> -		pgd = pgd_offset(&init_mm, base);
> -		pmd = pmd_alloc(&init_mm, pgd, base);
> -		if (!pmd) {
> -			printk(KERN_ERR "%s: no pmd tables\n", __func__);
> -			ret = -ENOMEM;
> -			break;
> -		}
> -		WARN_ON(!pmd_none(*pmd));
> -
> -		pte = pte_alloc_kernel(pmd, base);
> -		if (!pte) {
> -			printk(KERN_ERR "%s: no pte tables\n", __func__);
> -			ret = -ENOMEM;
> -			break;
> -		}
> -
> -		consistent_pte[i++] = pte;
> -		base += (1 << PGDIR_SHIFT);
> -	} while (base < CONSISTENT_END);
> -#endif	/* !CONFIG_MMU */
> -
> -	return ret;
> -}
> -
> -core_initcall(consistent_init);
> -
> -/*
>   * Make an area consistent for devices.
>   * Note: Drivers should NOT use this function directly, as it will break
>   * platforms with CONFIG_DMABOUNCE.


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
