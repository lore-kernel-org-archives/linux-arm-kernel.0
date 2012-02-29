From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Feb 2012 09:39:05 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <4F4D8EBA.90406@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
 <20120228173027.GB22082@arm.com> <4F4D8EBA.90406@gmail.com>
Message-ID: <20120229093905.GA17745@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 02:34:34AM +0000, bill4carson wrote:
> On 2012?02?29? 01:30, Catalin Marinas wrote:
> > On Mon, Feb 13, 2012 at 09:44:22AM +0000, Bill Carson wrote:
> >> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
> >> index 97b440c..3e6769a 100644
> >> --- a/arch/arm/include/asm/page.h
> >> +++ b/arch/arm/include/asm/page.h
> >> @@ -15,6 +15,21 @@
> >>   #define PAGE_SIZE		(_AC(1,UL)<<  PAGE_SHIFT)
> >>   #define PAGE_MASK		(~(PAGE_SIZE-1))
> >>
> >> +#ifdef CONFIG_HUGEPAGE_SIZE_2MB
> >> +/* we have 2MB hugepage for two 1MB section mapping */
> >> +#define HPAGE_SHIFT		(SECTION_SHIFT + 1)
> >> +#define HPAGE_SIZE		(_AC(1, UL)<<  HPAGE_SHIFT)
> >> +#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
> >> +#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> >> +#endif
> >> +
> >> +#ifdef CONFIG_HUGEPAGE_SIZE_16MB
> >> +#define HPAGE_SHIFT		SUPERSECTION_SHIFT
> >> +#define HPAGE_SIZE		(_AC(1, UL)<<  HPAGE_SHIFT)
> >> +#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
> >> +#define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> >> +#endif
> >
> > Ah, you still have these just config time options. Can you not make an
> > hpage_shift variable like PowerPC or IA-64?
> 
> Thank you for reviewing this patch.

I haven't finished yet (another email to come :)).

> unsigned int hpage_shift = SECTION_SHIFT + 1; /* default to 2MB page */
> #define HPAGE_SHIFT hpage_shift

Something like that. You could even use PMD_SHIFT which is 21 already
and it makes it clearer that we use huge pages at the pmd level.

> So, should I send another version now, or wait until you walk through
> the reset of patch set?

Just wait, I'll have a look through all the patches.

BTW, there are several coding style issues, I won't go through them but
it would help if you have a look at Documentation/CodingStyle
(especially comment style, if/else brackets).

Thanks.

-- 
Catalin
