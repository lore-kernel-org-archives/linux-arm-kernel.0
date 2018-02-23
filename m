From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Feb 2018 18:16:02 +0000
Subject: [PATCH] arm64: mm: fix thinko in non-global page table attribute
 check
In-Reply-To: <20180223180448.6006-1-ard.biesheuvel@linaro.org>
References: <20180223180448.6006-1-ard.biesheuvel@linaro.org>
Message-ID: <20180223181601.5obiyh45kmuxsh4x@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 06:04:48PM +0000, Ard Biesheuvel wrote:
> The routine pgattr_change_is_safe() was extended in commit 4e6020565596
> ("arm64: mm: Permit transitioning from Global to Non-Global without BBM")
> to permit changing the nG attribute from not set to set, but did so in a
> way that inadvertently disallows such changes if other permitted attribute
> changes take place at the same time. So update the code to take this into
> account.
> 
> Fixes: 4e6020565596 ("arm64: mm: Permit transitioning from Global to ...")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/mm/mmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 451f96f3377c..5bdc2c4db9ad 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -107,7 +107,7 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>  	 * The following mapping attributes may be updated in live
>  	 * kernel mappings without the need for break-before-make.
>  	 */
> -	static const pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE;
> +	static const pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
>  
>  	/* creating or taking down mappings is always safe */
>  	if (old == 0 || new == 0)
> @@ -117,9 +117,9 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>  	if ((old | new) & PTE_CONT)
>  		return false;
>  
> -	/* Transitioning from Global to Non-Global is safe */
> -	if (((old ^ new) == PTE_NG) && (new & PTE_NG))
> -		return true;
> +	/* Transitioning from Non-Global to Global is unsafe */
> +	if (old & ~new & PTE_NG)
> +		return false;
>  
>  	return ((old ^ new) & ~mask) == 0;
>  }
> -- 
> 2.11.0
> 
