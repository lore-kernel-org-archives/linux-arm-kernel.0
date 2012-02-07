From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Feb 2012 11:50:58 +0000
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <4F308169.4010904@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
 <20120131095811.GB889@n2100.arm.linux.org.uk>
 <CAHkRjk4MnuHs6MZNds2YmufmY_29dSOoeCxX=ODZ5p23YEcjUw@mail.gmail.com>
 <4F28AD1D.1000106@gmail.com> <20120206162656.GG26538@arm.com>
 <4F308169.4010904@gmail.com>
Message-ID: <20120207115058.GD3351@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 01:42:01AM +0000, bill4carson wrote:
> On 2012?02?07? 00:26, Catalin Marinas wrote:
> > On Wed, Feb 01, 2012 at 03:10:21AM +0000, bill4carson wrote:
> >> Why L_PTE_HUGEPAGE is needed?
> >>
> >> hugetlb subsystem will call pte_page to derive the corresponding page
> >> struct from a given pte, and pte_pfn is used first to convert pte into
> >> a page frame number.
> >
> > Are you sure the pte_pfn() conversion is right? Does it need to be
> > different from the 4K pfn?
...
> pte_page is defined as following to derive page struct from a given pte.
> This macro is used both in generic mm as well as hugetlb sub-system, so
> we need do the switch in pte_pfn to mark huge page based linux pte out
> of normal page based linux pte, that's what L_PTE_HUGEPAGE for.
> 
> #define pte_page(pte)		pfn_to_page(pte_pfn(pte))
> 
> So L_PTE_HUGEPAGE is *NOT* set in normal page based linux pte,
> linux pte bits[31:12] is the page frame number;

I agree.

> otherwise, we got a huge page based linux pte, and linux pte
> bits[31:20] is page frame number for SECTION mapping, and bits[31:24]
> is page frame number for SUPER-SECTION mapping.

Actually it is still 31:12 but with bits 19:12 or 23:12 masked out. So
you do the correct shift by PAGE_SHIFT with the additional masking for
huge pages (harmless).

But do we actually need this masking? Do the huge_pte_offset() or
huge_pte_alloc() functions return the Linux pte (pmd) for the huge page?
If yes, can we not ensure that bits 19:12 are already zero? This
shouldn't be any different from the 4K Linux pte but with an address
aligned to 1MB.

-- 
Catalin
