From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Nov 2014 17:26:44 +0000
Subject: [PATCHv6 7/8] arm64: efi: Use ioremap_exec for code sections
In-Reply-To: <1416606645-25633-8-git-send-email-lauraa@codeaurora.org>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
 <1416606645-25633-8-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141125172644.GC21525@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Fri, Nov 21, 2014 at 09:50:44PM +0000, Laura Abbott wrote:
> ioremap is not guaranteed to return memory with proper
> execution permissions. Introduce ioremap_exec which will
> ensure that permission bits are set as expected for EFI
> code sections.
> 
> Tested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/include/asm/io.h      |  1 +
>  arch/arm64/include/asm/pgtable.h |  1 +
>  arch/arm64/kernel/efi.c          | 12 +++++++++++-
>  arch/arm64/mm/ioremap.c          | 11 +++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 79f1d519..7dd8465 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -230,6 +230,7 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
>  extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot);
>  extern void __iounmap(volatile void __iomem *addr);
>  extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
> +extern void __iomem *ioremap_exec(phys_addr_t phys_addr, size_t size);
>  
>  #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
>  #define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 41a43bf..9b1d9d0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -65,6 +65,7 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>  #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_DEVICE_nGnRE))
>  #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_NORMAL_NC))
>  #define PROT_NORMAL		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_ATTRINDX(MT_NORMAL))
> +#define PROT_NORMAL_EXEC	(PROT_DEFAULT | PTE_UXN | PTE_ATTRINDX(MT_NORMAL))
>  
>  #define PROT_SECT_DEVICE_nGnRE	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_DEVICE_nGnRE))
>  #define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index 95c49eb..9e41f95 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -47,6 +47,14 @@ static int __init is_normal_ram(efi_memory_desc_t *md)
>  	return 0;
>  }
>  
> +static int __init is_code(efi_memory_desc_t *md)
> +{
> +	if (md->attribute & EFI_RUNTIME_SERVICES_CODE)
> +		return 1;
> +	return 0;
> +}
> +
> +
>  static void __init efi_setup_idmap(void)
>  {
>  	struct memblock_region *r;
> @@ -338,7 +346,9 @@ static int __init remap_region(efi_memory_desc_t *md, void **new)
>  	memrange_efi_to_native(&paddr, &npages);
>  	size = npages << PAGE_SHIFT;
>  
> -	if (is_normal_ram(md))
> +	if (is_code(md))
> +		vaddr = (__force u64)ioremap_exec(paddr, size);
> +	else if (is_normal_ram(md))
>  		vaddr = (__force u64)ioremap_cache(paddr, size);
>  	else
>  		vaddr = (__force u64)ioremap(paddr, size);

All of the above looks fine to me.

> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index cbb99c8..b998441 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -103,6 +103,17 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
>  }
>  EXPORT_SYMBOL(ioremap_cache);
>  
> +void __iomem *ioremap_exec(phys_addr_t phys_addr, size_t size)
> +{
> +	/* For normal memory we already have a cacheable mapping. */
> +	if (pfn_valid(__phys_to_pfn(phys_addr)))
> +		return (void __iomem *)__phys_to_virt(phys_addr);

Is this guaranteed to be executable in all cases once the stricter page
permissions are in force?

Thanks,
Mark.

> +
> +	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL_EXEC),
> +				__builtin_return_address(0));
> +}
> +EXPORT_SYMBOL(ioremap_exec);
> +
>  /*
>   * Must be called after early_fixmap_init
>   */
> -- 
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> 
> 
