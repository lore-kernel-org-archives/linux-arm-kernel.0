From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Jan 2016 17:40:19 +0000
Subject: [PATCH v3 03/21] arm64: pgtable: add dummy pud_index() and
 pmd_index() definitions
In-Reply-To: <1452518355-4606-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1452518355-4606-1-git-send-email-ard.biesheuvel@linaro.org>
 <1452518355-4606-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160111174018.GC6105@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 02:18:56PM +0100, Ard Biesheuvel wrote:
> Add definitions of pud_index() and pmd_index() for configurations with
> fewer than 4 resp. 3 translation levels. This makes it easier to keep
> the users (e.g., the fixmap init code) generic.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index fe9bf47db5d3..6129f6755081 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -495,6 +495,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
>  #else
>  
>  #define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
> +#define pmd_index(addr)		({ BUILD_BUG(); 0; })
>  
>  /* Match pmd_offset folding in <asm/generic/pgtable-nopmd.h> */
>  #define pmd_set_fixmap(addr)		NULL
> @@ -542,6 +543,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>  #else
>  
>  #define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0;})
> +#define pud_index(addr)		({ BUILD_BUG(); 0;})

I think we don't need these if we use p??_ofset_kimg for the fixmap
initialisation.

Regardless, these look good conceptually, so if they're useful
elsewhere:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.
