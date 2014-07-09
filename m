From: minchan@kernel.org (Minchan Kim)
Date: Wed, 9 Jul 2014 14:38:37 +0900
Subject: [PATCH v11 6/7] ARM: add pmd_[dirty|mkclean] for THP
In-Reply-To: <20140708113737.GA2958@linaro.org>
References: <1404799424-1120-1-git-send-email-minchan@kernel.org>
 <1404799424-1120-7-git-send-email-minchan@kernel.org>
 <20140708113737.GA2958@linaro.org>
Message-ID: <20140709053837.GC9824@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Steve,

On Tue, Jul 08, 2014 at 12:37:38PM +0100, Steve Capper wrote:
> On Tue, Jul 08, 2014 at 03:03:43PM +0900, Minchan Kim wrote:
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
> >  arch/arm/include/asm/pgtable-3level.h | 3 +++
> >  arch/arm64/include/asm/pgtable.h      | 2 ++
> >  2 files changed, 5 insertions(+)
> 
> Hi Minchan,
> arch/arm and arch/arm64 are handled separately.
> Could you please split this patch into arm and arm64 versions?
> 

Sure.

> 
> > 
> > diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> > index 85c60adc8b60..3a7bb8dc7d05 100644
> > --- a/arch/arm/include/asm/pgtable-3level.h
> > +++ b/arch/arm/include/asm/pgtable-3level.h
> > @@ -220,6 +220,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
> >  #define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
> >  #endif
> >  
> > +#define pmd_dirty	(pmd_val(pmd) & PMD_SECT_DIRTY)
> 
> This macro is missing the parameter definition, and will generate a
> compile errror when CONFIG_ARM_LPAE=y
> 
> For 32-bit ARM with CONFIG_ARM_LPAE=n, we don't have THP support and I noticed
> some compiler errors in mm/madvise.c:
> 
>   CC      mm/madvise.o
> mm/madvise.c: In function ?madvise_free_pte_range?:
> mm/madvise.c:279:3: error: implicit declaration of function ?pmdp_get_and_clear? [-Werror=implicit-function-declaration]
>    orig_pmd = pmdp_get_and_clear(mm, addr, pmd);
>    ^
> mm/madvise.c:285:3: error: implicit declaration of function ?pmd_mkold? [-Werror=implicit-function-declaration]
>    orig_pmd = pmd_mkold(orig_pmd);
>    ^
> mm/madvise.c:286:3: error: implicit declaration of function ?pmd_mkclean? [-Werror=implicit-function-declaration]
>    orig_pmd = pmd_mkclean(orig_pmd);
>    ^
> mm/madvise.c:288:3: error: implicit declaration of function ?set_pmd_at? [-Werror=implicit-function-declaration]
>    set_pmd_at(mm, addr, pmd, orig_pmd);
>    ^
> cc1: some warnings being treated as errors
> make[1]: *** [mm/madvise.o] Error 1
> 

Oops, will fix.

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
