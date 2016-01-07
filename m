From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 7 Jan 2016 13:55:18 +0000
Subject: [PATCH v2 03/13] arm64: use more granular reservations for
 static page table allocations
In-Reply-To: <1451489172-17420-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1451489172-17420-1-git-send-email-ard.biesheuvel@linaro.org>
 <1451489172-17420-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160107135518.GB15917@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2015 at 04:26:02PM +0100, Ard Biesheuvel wrote:
> Before introducing new statically allocated page tables and increasing
> their alignment in subsequent patches, update the reservation logic
> so that only pages that are in actual use end up as reserved with
> memblock.

Could you add something to the commit message about what this will gain
us (i.e. which pages we don't have to reserve)? It's not immediately
obvious why we'd have page tables we wouldn't want to reserve.

>From the looks of the next patch we won't have redundant levels of
fixmap table for a given configuration, so I guess we're catering for
the case the fixmap shares a pgd/pud/pmd entry with the image mapping?

Does that happen? If so that would invalidate the assumption I make when
copying the fixmap over in [1] (see map_kernel).

To handle that either we need some special logic to copy over the
relevant bits for the fixmap (as with kasan_copy_shadow), or we need to
avoid sharing a pgd entry.

Thoughts?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397114.html

> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/mm/init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 6bacba847923..8e678d05ad84 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -36,6 +36,7 @@
>  #include <linux/swiotlb.h>
>  
>  #include <asm/fixmap.h>
> +#include <asm/kernel-pgtable.h>
>  #include <asm/memory.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
> @@ -165,11 +166,13 @@ void __init arm64_memblock_init(void)
>  	 * Register the kernel text, kernel data, initrd, and initial
>  	 * pagetables with memblock.
>  	 */
> -	memblock_reserve(__pa(_text), _end - _text);
> +	memblock_reserve(__pa(_text), __bss_stop - _text);
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (initrd_start)
>  		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
>  #endif
> +	memblock_reserve(__pa(idmap_pg_dir), IDMAP_DIR_SIZE);
> +	memblock_reserve(__pa(swapper_pg_dir), SWAPPER_DIR_SIZE);
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -- 
> 2.5.0
> 
