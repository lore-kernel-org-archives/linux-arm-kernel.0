From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Jul 2016 14:46:26 +0100
Subject: [PATCH 1/2] arm64: mm: make create_mapping_late() non-allocating
In-Reply-To: <1469208745-6693-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
 <1469208745-6693-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160725134550.GA14465@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Fri, Jul 22, 2016 at 07:32:24PM +0200, Ard Biesheuvel wrote:
> The only purpose served by create_mapping_late() is to remap the already
> mapped .text and .rodata kernel segments with read-only permissions. Since
> we no longer allow block mappings to be split or merged,
> create_mapping_late() should not pass an allocation function pointer into
> __create_pgd_mapping(). So pass NULL instead.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a96a2413fa18..33f36cede02d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -312,7 +312,7 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
>  	}
>  
>  	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot,
> -			     late_pgtable_alloc, !debug_pagealloc_enabled());
> +			     NULL, !debug_pagealloc_enabled());
>  }

How about we drop the __init marker from create_mapping_noalloc(), and
update the callers in mark_rodata_ro() to use that, so that we can drop
create_mapping_late() entirely.

Other than the __init marker and name, create_mapping_late() and
create_mapping_noalloc() would be identical after this change, and the
naming of create_mapping_noalloc() does better describe what we're
trying to achieve in mark_rodata_ro().

Thanks,
Mark.
