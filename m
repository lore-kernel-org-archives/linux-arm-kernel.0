From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jan 2017 16:15:46 +0000
Subject: [PATCH] arm64: mm: fix __page_to_voff definition
In-Reply-To: <1484666633-1753-1-git-send-email-andr2000@gmail.com>
References: <1484666633-1753-1-git-send-email-andr2000@gmail.com>
Message-ID: <20170117161546.GF11939@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 05:23:53PM +0200, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
> 
> Fix parameter name for __page_to_voff, to match its definition.
> There are other callers of page_to_virt which do not
> declare 'page'.
> 
> Fixes: 3fa72fe9c614 ("arm64: mm: fix __page_to_voff definition")
> Signed-off-by: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>

I take it this is because it messes up the 'struct page' at the end of
the macro expansion?

It would be good to explicitly state that, since that's not immediately
obvious.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/memory.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index bfe632808d77..90c39a662379 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -222,7 +222,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define _virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
>  #else
>  #define __virt_to_pgoff(kaddr)	(((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
> -#define __page_to_voff(page)	(((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
> +#define __page_to_voff(kaddr)	(((u64)(kaddr) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
>  
>  #define page_to_virt(page)	((void *)((__page_to_voff(page)) | PAGE_OFFSET))
>  #define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
