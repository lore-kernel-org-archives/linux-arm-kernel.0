From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 4 Mar 2014 08:26:15 +0000
Subject: [PATCH 1/5] mm: hugetlb: Introduce huge_pte_{page,present,young}
In-Reply-To: <5314c4e5.d0128c0a.2ad9.ffffeb8dSMTPIN_ADDED_BROKEN@mx.google.com>
References: <1392737235-27286-1-git-send-email-steve.capper@linaro.org>
 <1392737235-27286-2-git-send-email-steve.capper@linaro.org>
 <5314c4e5.d0128c0a.2ad9.ffffeb8dSMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20140304082615.GA5952@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 01:07:07PM -0500, Naoya Horiguchi wrote:
> Hi Steve,
>

Hi Naoya,

 
> On Tue, Feb 18, 2014 at 03:27:11PM +0000, Steve Capper wrote:
> > Introduce huge pte versions of pte_page, pte_present and pte_young.
> > This allows ARM (without LPAE) to use alternative pte processing logic
> > for huge ptes.
> > 
> > Where these functions are not defined by architectural code they
> > fallback to the standard functions.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > ---
> >  include/linux/hugetlb.h | 12 ++++++++++++
> >  mm/hugetlb.c            | 22 +++++++++++-----------
> >  2 files changed, 23 insertions(+), 11 deletions(-)

Thanks for taking a look at this.

> 
> How about replacing other archs' arch-dependent code with new functions?
> 

In the cases below, the huge_pte_ functions will always resolve to the
standard pte_ functions (unless the arch code changes); so I decided to
only change the core code as that's where the meanings of huge_pte_
can vary.

>   [~/dev]$ find arch/ -name "hugetlbpage.c" | xargs grep pte_page
>   arch/s390/mm/hugetlbpage.c:             pmd_val(pmd) |= pte_page(pte)[1].index;
>   arch/powerpc/mm/hugetlbpage.c:  page = pte_page(*ptep);
>   arch/powerpc/mm/hugetlbpage.c:  head = pte_page(pte);
>   arch/x86/mm/hugetlbpage.c:      page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
>   arch/ia64/mm/hugetlbpage.c:     page = pte_page(*ptep);
>   arch/mips/mm/hugetlbpage.c:     page = pte_page(*(pte_t *)pmd);
>   arch/tile/mm/hugetlbpage.c:     page = pte_page(*(pte_t *)pmd);
>   arch/tile/mm/hugetlbpage.c:     page = pte_page(*(pte_t *)pud);
>   [~/dev]$ find arch/ -name "hugetlbpage.c" | xargs grep pte_present
>   arch/s390/mm/hugetlbpage.c:     if (pte_present(pte)) {
>   arch/sparc/mm/hugetlbpage.c:    if (!pte_present(*ptep) && pte_present(entry))
>   arch/sparc/mm/hugetlbpage.c:    if (pte_present(entry))
>   arch/tile/mm/hugetlbpage.c:     if (!pte_present(*ptep) && huge_shift[level] != 0) {
>   arch/tile/mm/hugetlbpage.c:             if (pte_present(pte) && pte_super(pte))
>   arch/tile/mm/hugetlbpage.c:     if (!pte_present(*pte))
> 

Cheers,
-- 
Steve

> Thanks,
> Naoya Horiguchi
