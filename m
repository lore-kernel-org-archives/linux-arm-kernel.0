From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 18:07:59 +0100
Subject: [PATCHv3 03/11] arm64: Introduce helpers for page table levels
In-Reply-To: <1444821634-1689-4-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151014170759.GE5041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 12:20:26PM +0100, Suzuki K. Poulose wrote:
> Introduce helpers for finding the number of page table
> levels required for a given VA width, shift for a particular
> page table level.
> 
> Convert the existing users to the new helpers. More users
> to follow.
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> 
> ---
> Changes since V2:
>   - Add comments around the macros
>   - Change ARM64_HW_PGTABLE_LEVEL_SHIFT to accept pagetable level as
>     described by ARM ARM
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 95c1ec0..c6194ab 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -16,13 +16,31 @@
>  #ifndef __ASM_PGTABLE_HWDEF_H
>  #define __ASM_PGTABLE_HWDEF_H
>  
> +/*
> + * Number of page-table levels required to address 'va_bits' wide
> + * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
> + * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
> + *
> + *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
> + *
> + * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
> + * due to build issues. So we use the following magic formula.
> + */
> +#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))

I think I failed the interview question [1]. :(

I read the comment to mean this was a brand-new piece of magic, as
opposed to a constant-folded copy of DIV_ROUND_UP. So it seems there's
still some scope for confusion, even if that only includes me.

I think we should bite the bullet and have a full copy of DIV_ROUND_UP,
e.g.

/*
 * We cannot include linux/kernel.h for DIV_ROUND_UP due to build
 * issues. Instead, copy & paste its magic formula here for now.
 */
#define __DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))

/*
 * Number of page-table levels required to address 'va_bits' wide
 * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
 * bits with (PAGE_SHIFT - 3) bits at each page table level.
 */
#define ARM64_HW_PGTABLE_LEVELS(va_bits) \
	__DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))


It's a little verbose, but it keeps this legible and ensures I get the
job. We can leave the constant-folding to the compiler.

Other than that, this looks good to me. With the above applied:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/375609.html
