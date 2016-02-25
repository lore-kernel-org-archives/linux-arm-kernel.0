From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Feb 2016 08:02:00 +0100
Subject: [RFC PATCH 1/6] arm64: vmemmap: use virtual projection of linear
 region
In-Reply-To: <1456330893-19228-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1456330893-19228-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456330893-19228-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9M6QukGqLWYgDqAp6xaa7RPVW36E591LOPf6xP_TH48w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 February 2016 at 17:21, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Commit dd006da21646 ("arm64: mm: increase VA range of identity map") made
> some changes to the memory mapping code to allow physical memory to reside
> at an offset that exceeds the size of the virtual address space.
>
> However, since the size of the vmemmap area is proportional to the size of
> the VA area, but it is populated relative to the physical space, we may
> end up with the struct page array being mapped outside of the vmemmap
> region. For instance, on my Seattle A0 box, I can see the following output
> in the dmesg log.
>
>    vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
>              0xffffffbfc0000000 - 0xffffffbfd0000000   (   256 MB actual)
>
> We can fix this by deciding that the vmemmap region is not a projection of
> the physical space, but of the virtual space above PAGE_OFFSET, i.e., the
> linear region. This way, we are guaranteed that the vmemmap region is of
> sufficient size, and we can also reduce its size by half.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 7 ++++---
>  arch/arm64/mm/init.c             | 4 ++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index a440f5a85d08..8e6baea0ff61 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -34,18 +34,19 @@
>  /*
>   * VMALLOC and SPARSEMEM_VMEMMAP ranges.
>   *
> - * VMEMAP_SIZE: allows the whole VA space to be covered by a struct page array
> + * VMEMAP_SIZE: allows the whole linear region to be covered by a struct page array
>   *     (rounded up to PUD_SIZE).
>   * VMALLOC_START: beginning of the kernel vmalloc space
>   * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
>   *     fixed mappings and modules
>   */
> -#define VMEMMAP_SIZE           ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
> +#define VMEMMAP_SIZE           ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1)) * sizeof(struct page), PUD_SIZE)
>
>  #define VMALLOC_START          (MODULES_END)
>  #define VMALLOC_END            (PAGE_OFFSET - PUD_SIZE - VMEMMAP_SIZE - SZ_64K)
>
> -#define vmemmap                        ((struct page *)(VMALLOC_END + SZ_64K))
> +#define VMEMMAP_START          (VMALLOC_END + SZ_64K)
> +#define vmemmap                        ((struct page *)(VMEMMAP_START - memstart_addr / sizeof(struct page)))
>

Note that with the linear region randomization which is now in -next,
this division needs to be signed (since memstart_addr can wrap).

So I should either update the definition of memstart_addr to s64 in
this patch, or cast to (s64) in the expression above


>  #define FIRST_USER_ADDRESS     0UL
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index c0ea54bd9995..88046b94fa87 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -363,8 +363,8 @@ void __init mem_init(void)
>                   MLK_ROUNDUP(_text, _etext),
>                   MLK_ROUNDUP(_sdata, _edata),
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -                 MLG((unsigned long)vmemmap,
> -                     (unsigned long)vmemmap + VMEMMAP_SIZE),
> +                 MLG(VMEMMAP_START,
> +                     VMEMMAP_START + VMEMMAP_SIZE),
>                   MLM((unsigned long)virt_to_page(PAGE_OFFSET),
>                       (unsigned long)virt_to_page(high_memory)),
>  #endif
> --
> 2.5.0
>
