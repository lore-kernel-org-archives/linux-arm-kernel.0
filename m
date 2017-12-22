From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Dec 2017 15:04:52 +0000
Subject: [PATCH 06/10] arm64: handle 52-bit physical addresses in page
 table entries
In-Reply-To: <a0a81fd9-e11c-bd85-5484-48b2e638c65a@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
 <1513184845-8711-7-git-send-email-kristina.martsenko@arm.com>
 <a0a81fd9-e11c-bd85-5484-48b2e638c65a@arm.com>
Message-ID: <20171222150451.rnkn2avecghhyirb@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 04:36:46PM +0000, Suzuki K. Poulose wrote:
> On 13/12/17 17:07, Kristina Martsenko wrote:
> > @@ -427,7 +451,7 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
> >   #define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
> >   #define pte_clear_fixmap()		clear_fixmap(FIX_PTE)
> > -#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
> > +#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(__pmd_to_phys(pmd)))
> 
> You could simplify the above to :
> 
> #define pmd_page(pmd)			pfn_to_page(pmd_pfn(pmd))
> 
> ? similarly for pud_page.

Just for the record as we already discussed: pmd_pfn(pmd) gives a
different result from __phys_to_pfn(__pmd_to_phys(pmd)). Weird but
pmd_pfn() is used with huge page stuff and it ensures that the pfn
corresponds to a PMD_SIZE-aligned page while pmd_page() is used to
retrieve the page of the pte pointed at by the pmd, so only PAGE_SIZE
aligned.

-- 
Catalin
