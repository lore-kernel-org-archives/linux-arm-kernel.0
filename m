From: minchan@kernel.org (Minchan Kim)
Date: Tue, 8 Jul 2014 10:09:36 +0900
Subject: [PATCH v10 6/7] ARM: add pmd_[dirty|mkclean] for THP
In-Reply-To: <20140707092247.GA15168@linaro.org>
References: <1404694438-10272-1-git-send-email-minchan@kernel.org>
 <1404694438-10272-7-git-send-email-minchan@kernel.org>
 <20140707092247.GA15168@linaro.org>
Message-ID: <20140708010936.GC6076@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 10:22:48AM +0100, Steve Capper wrote:
> On Mon, Jul 07, 2014 at 09:53:57AM +0900, Minchan Kim wrote:
> > MADV_FREE needs pmd_dirty and pmd_mkclean for detecting recent
> > overwrite of the contents since MADV_FREE syscall is called for
> > THP page.
> > 
> > This patch adds pmd_dirty and pmd_mkclean for THP page MADV_FREE
> > support.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Steve Capper <steve.capper@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 579702086488..f3ec01cef04f 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -240,10 +240,12 @@ static inline pmd_t pte_pmd(pte_t pte)
> >  #endif
> >  
> >  #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
> > +#define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
> >  #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
> >  #define pmd_mksplitting(pmd)	pte_pmd(pte_mkspecial(pmd_pte(pmd)))
> >  #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
> >  #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
> > +#define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
> >  #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
> >  #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
> >  #define pmd_mknotpresent(pmd)	(__pmd(pmd_val(pmd) & ~PMD_TYPE_MASK))
> > -- 
> > 2.0.0
> >
> 
> Hi Minchan,

Hello Steve and Will,

> 
> This looks good to me too.
> As Will said this applies to arm64, we will also need a version for:
> arch/arm/include/asm/pgtable-3level.h.

Does it work?

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 85c60adc8b60..3a7bb8dc7d05 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -220,6 +220,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
 #endif
 
+#define pmd_dirty	(pmd_val(pmd) & PMD_SECT_DIRTY)
+
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
 
@@ -228,6 +230,7 @@ PMD_BIT_FUNC(mkold,	&= ~PMD_SECT_AF);
 PMD_BIT_FUNC(mksplitting, |= PMD_SECT_SPLITTING);
 PMD_BIT_FUNC(mkwrite,   &= ~PMD_SECT_RDONLY);
 PMD_BIT_FUNC(mkdirty,   |= PMD_SECT_DIRTY);
+PMD_BIT_FUNC(mkclean,   &= ~PMD_SECT_DIRTY);
 PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
-- 
2.0.0

> 
> Is there a testcase we can run to check that this patch set is working
> well for arm/arm64?

I just run several instance of attached simple stress with heavy kernel
build in parallel on 1G RAM machine.

Thanks for the review!

> 
> Cheers,
> -- 
> Steve 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>

-- 
Kind regards,
Minchan Kim
-------------- next part --------------
A non-text attachment was scrubbed...
Name: thp_alloc.c
Type: text/x-csrc
Size: 1328 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/db0fab14/attachment.bin>
