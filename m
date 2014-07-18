From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Jul 2014 09:48:47 +0100
Subject: [PATCH v13 6/8] arm: add pmd_[dirty|mkclean] for THP
In-Reply-To: <1405666386-15095-7-git-send-email-minchan@kernel.org>
References: <1405666386-15095-1-git-send-email-minchan@kernel.org>
 <1405666386-15095-7-git-send-email-minchan@kernel.org>
Message-ID: <20140718084847.GC9548@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 07:53:04AM +0100, Minchan Kim wrote:
> MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
> overwrite of the contents since MADV_FREE syscall is called for
> THP page.
> 
> This patch adds pmd_dirty and pmd_mkclean for THP page MADV_FREE
> support.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  arch/arm/include/asm/pgtable-3level.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index 85c60adc8b60..830f84f2d277 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -220,6 +220,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
>  #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
>  #endif
>  
> +#define pmd_dirty(pmd)		(pmd_val(pmd) & PMD_SECT_DIRTY)
> +
>  #define PMD_BIT_FUNC(fn,op) \
>  static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
>  
> @@ -228,6 +230,7 @@ PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
>  PMD_BIT_FUNC(mksplitting, |= PMD_SECT_SPLITTING);
>  PMD_BIT_FUNC(mkwrite,   &= ~PMD_SECT_RDONLY);
>  PMD_BIT_FUNC(mkdirty,   |= PMD_SECT_DIRTY);
> +PMD_BIT_FUNC(mkclean,   &= ~PMD_SECT_DIRTY);
>  PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
>  
>  #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))

Looks fine to me, but again, it would be great if Steve can take a look too.

Will
