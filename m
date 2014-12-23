From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Dec 2014 15:25:56 +0000
Subject: [PATCH] arm64: mm: Add pgd_page to support RCU fast_gup
In-Reply-To: <20141221105633.GJ23242@arm.com>
References: <11B98DF8-2B98-414B-88E5-14C97ADAA60E@gmail.com>
 <20141221105633.GJ23242@arm.com>
Message-ID: <20141223152555.GB21816@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 21, 2014 at 10:56:33AM +0000, Will Deacon wrote:
> On Sat, Dec 20, 2014 at 12:49:40AM +0000, Jungseok Lee wrote:
> > This patch adds pgd_page definition in order to keep supporting
> > HAVE_GENERIC_RCU_GUP configuration. In addition, it changes pud_page
> > expression to align with pmd_page for readability.
> > 
> > An introduction of pgd_page resolves the following build breakage
> > under 4KB + 4Level memory management combo.
> > 
> > mm/gup.c: In function 'gup_huge_pgd':
> > mm/gup.c:889:2: error: implicit declaration of function 'pgd_page' [-Werror=implicit-function-declaration]
> >   head = pgd_page(orig);
> >   ^
> > mm/gup.c:889:7: warning: assignment makes pointer from integer without a cast
> >   head = pgd_page(orig);
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Steve Capper <steve.capper@linaro.org>
> > Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index df22314..a1fe927 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -401,7 +401,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
> >  	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(addr);
> >  }
> >  
> > -#define pud_page(pud)           pmd_page(pud_pmd(pud))
> > +#define pud_page(pud)		pfn_to_page(__phys_to_pfn(pud_val(pud) & PHYS_MASK))
> 
> It would be cleaner to use pud_pfn here, otherwise we end up passing a
> physical address with the lower attributes present to __phys_to_pfn, which
> "knows" to shift them away.

OK, I tried this, together with aligning pmd_page to use pmd_pfn, and
after debugging I realised why it is a bad idea. I had a feeling that I
tried this before but didn't remember the details.

I'll take the pmd_page() example, it is used in two scenarios:

a) getting the first page structure of a huge page
b) getting the page structure of the pte page pointed at by the pmd

In the first case, we know that the pmd value is aligned to PMD_SIZE as
it points to the physical address of a huge page, so pmd_pfn() masking
is fine. In the second case, such masking is not, a pte page can be just
PAGE_SIZE aligned. So using pmd_pfn to mask out the bits above 12 in the
pmd val breaks case (b) above.

While we don't have such use-case (b) for pud_page(), I would rather
keep them consistent with pmd_page.

A better fix would be to change such pmd_page() usage to pmd_pgtable()
in the core mm code and have a different implementation for the latter.
I guess we can leave this exercise to Steve ;).

In the meantime, I'll merge Jungseok's original patch.

-- 
Catalin
