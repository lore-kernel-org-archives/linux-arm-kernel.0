From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 18:15:04 +0100
Subject: [PATCHv3 05/11] arm64: Handle 4 level page table for swapper
In-Reply-To: <1444821634-1689-6-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151014171504.GG5041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 12:20:28PM +0100, Suzuki K. Poulose wrote:
> At the moment, we only support maximum of 3-level page table for
> swapper. With 48bit VA, 64K has only 3 levels and 4K uses section
> mapping. Add support for 4-level page table for swapper, needed
> by 16K pages.
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/head.S |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 149fce3..7ace955 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -271,7 +271,10 @@ ENDPROC(preserve_boot_args)
>   */
>  	.macro	create_pgd_entry, tbl, virt, tmp1, tmp2
>  	create_table_entry \tbl, \virt, PGDIR_SHIFT, PTRS_PER_PGD, \tmp1, \tmp2
> -#if SWAPPER_PGTABLE_LEVELS == 3
> +#if SWAPPER_PGTABLE_LEVELS > 3
> +	create_table_entry \tbl, \virt, PUD_SHIFT, PTRS_PER_PUD, \tmp1, \tmp2
> +#endif
> +#if SWAPPER_PGTABLE_LEVELS > 2
>  	create_table_entry \tbl, \virt, SWAPPER_TABLE_SHIFT, PTRS_PER_PTE, \tmp1, \tmp2
>  #endif
>  	.endm

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
