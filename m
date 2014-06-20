From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jun 2014 10:12:26 +0100
Subject: [PATCH V4 1/2] arm: mm: Introduce {pte,pmd}_isset and
 {pte,pmd}_isclear
In-Reply-To: <1402929159-11028-2-git-send-email-steve.capper@linaro.org>
References: <1402929159-11028-1-git-send-email-steve.capper@linaro.org>
 <1402929159-11028-2-git-send-email-steve.capper@linaro.org>
Message-ID: <20140620091226.GJ25104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 03:32:38PM +0100, Steve Capper wrote:
> Long descriptors on ARM are 64 bits, and some pte functions such as
> pte_dirty return a bitwise-and of a flag with the pte value. If the
> flag to be tested resides in the upper 32 bits of the pte, then we run
> into the danger of the result being dropped if downcast.
> 
> For example:
> 	gather_stats(page, md, pte_dirty(*pte), 1);
> where pte_dirty(*pte) is downcast to an int.
> 
> This patch introduces a new macro pte_isset which performs the bitwise
> and, then performs a double logical invert (where needed) to ensure
> predictable downcasting. The logical inverse pte_isclear is also
> introduced.
> 
> Equivalent pmd functions for Transparent HugePages have also been
> added.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
>  arch/arm/include/asm/pgtable-3level.h | 10 +++++++---
>  arch/arm/include/asm/pgtable.h        | 18 +++++++++++-------
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 85c60ad..bde49f9 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -207,16 +207,20 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  #define pte_huge(pte)		(pte_val(pte) && !(pte_val(pte) & PTE_TABLE_BIT))
>  #define pte_mkhuge(pte)		(__pte(pte_val(pte) & ~PTE_TABLE_BIT))
>  
> -#define pmd_young(pmd)		(pmd_val(pmd) & PMD_SECT_AF)
> +#define pmd_isset(pmd, val)	((u32)(val) == (val) ? pmd_val(pmd) & (val) \
> +						: !!(pmd_val(pmd) & (val)))

What does GCC generate for this as opposed to an unconditional !!?

Will
