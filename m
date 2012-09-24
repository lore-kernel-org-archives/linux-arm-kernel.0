From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 14:29:42 +0100
Subject: [PATCH v3 RESEND 08/17] ARM: LPAE: use phys_addr_t in
 free_memmap()
In-Reply-To: <1348242975-19184-9-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-9-git-send-email-cyril@ti.com>
Message-ID: <20120924132942.GD23298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:06PM +0100, Cyril Chemparathy wrote:
> From: Vitaly Andrianov <vitalya@ti.com>
> 
> The free_memmap() was mistakenly using unsigned long type to represent
> physical addresses.  This breaks on PAE systems where memory could be placed
> above the 32-bit addressible limit.
> 
> This patch fixes this function to properly use phys_addr_t instead.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/mm/init.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 9aec41f..19ba70b 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -457,7 +457,7 @@ static inline void
>  free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	struct page *start_pg, *end_pg;
> -	unsigned long pg, pgend;
> +	phys_addr_t pg, pgend;
>  
>  	/*
>  	 * Convert start_pfn/end_pfn to a struct page pointer.
> @@ -469,8 +469,8 @@ free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  	 * Convert to physical addresses, and
>  	 * round start upwards and end downwards.
>  	 */
> -	pg = (unsigned long)PAGE_ALIGN(__pa(start_pg));
> -	pgend = (unsigned long)__pa(end_pg) & PAGE_MASK;
> +	pg = PAGE_ALIGN(__pa(start_pg));
> +	pgend = __pa(end_pg) & PAGE_MASK;
>  
>  	/*
>  	 * If there are free pages between these,

This function also calls free_bootmem() which takes unsigned long. Are
patches sent separately for this or we just ignore holes in memmap?
There are other calls to free_bootmem() or reserve_bootmem(), do they
just work with the high phys addresses?

-- 
Catalin
