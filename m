From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Dec 2014 17:15:06 +0000
Subject: [PATCHv6 7/8] arm64: efi: Use ioremap_exec for code sections
In-Reply-To: <1416606645-25633-8-git-send-email-lauraa@codeaurora.org>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
 <1416606645-25633-8-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141202171506.GE29792@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 09:50:44PM +0000, Laura Abbott wrote:
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

What I don't understand is that currently the above remap_region()
function only uses ioremap_cache() and ignores any code attributes. So
we end up with PROT_NORMAL which is non-executable.

Is the current remap_region() function broken or we don't expect it to
be called with any EFI_RUNTIME_SERVICES_CODE region?

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
> +
> +	return __ioremap_caller(phys_addr, size, __pgprot(PROT_NORMAL_EXEC),
> +				__builtin_return_address(0));

In addition to what I said above, do we expect ioremap_exec() to be
called on non-pfn_valid() pages?

-- 
Catalin
