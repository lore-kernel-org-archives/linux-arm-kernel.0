From: bill4carson@gmail.com (carson bill)
Date: Tue, 7 Feb 2012 22:46:50 +0800
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <20120207141100.GI3351@arm.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
 <20120131095811.GB889@n2100.arm.linux.org.uk>
 <CAHkRjk4MnuHs6MZNds2YmufmY_29dSOoeCxX=ODZ5p23YEcjUw@mail.gmail.com>
 <4F28AD1D.1000106@gmail.com> <20120206162656.GG26538@arm.com>
 <4F308169.4010904@gmail.com> <20120207115058.GD3351@arm.com>
 <CAOMgcGLhGyz5xU1P2C=Av9LWazJF3X=U14riNi=xESZX68mdwQ@mail.gmail.com>
 <20120207141100.GI3351@arm.com>
Message-ID: <CAOMgcG+rtHynsSe71onpL-Mp2dLq6Rv-7hLmj2noy7zx-QtTuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/7, Catalin Marinas <catalin.marinas@arm.com>:
> On Tue, Feb 07, 2012 at 01:24:09PM +0000, carson bill wrote:
>> 2012/2/7, Catalin Marinas <catalin.marinas@arm.com>:
>> > On Tue, Feb 07, 2012 at 01:42:01AM +0000, bill4carson wrote:
>> >> On 2012?02?07? 00:26, Catalin Marinas wrote:
>> >> > On Wed, Feb 01, 2012 at 03:10:21AM +0000, bill4carson wrote:
>> >> >> Why L_PTE_HUGEPAGE is needed?
>> >> >>
>> >> >> hugetlb subsystem will call pte_page to derive the corresponding
>> >> >> page
>> >> >> struct from a given pte, and pte_pfn is used first to convert pte
>> >> >> into
>> >> >> a page frame number.
>> >> >
>> >> > Are you sure the pte_pfn() conversion is right? Does it need to be
>> >> > different from the 4K pfn?
>> > ...
>> >> pte_page is defined as following to derive page struct from a given
>> >> pte.
>> >> This macro is used both in generic mm as well as hugetlb sub-system, so
>> >> we need do the switch in pte_pfn to mark huge page based linux pte out
>> >> of normal page based linux pte, that's what L_PTE_HUGEPAGE for.
>> >>
>> >> #define pte_page(pte)		pfn_to_page(pte_pfn(pte))
>> >>
>> >> So L_PTE_HUGEPAGE is *NOT* set in normal page based linux pte,
>> >> linux pte bits[31:12] is the page frame number;
>> >
>> > I agree.
>> >
>> >> otherwise, we got a huge page based linux pte, and linux pte
>> >> bits[31:20] is page frame number for SECTION mapping, and bits[31:24]
>> >> is page frame number for SUPER-SECTION mapping.
>> >
>> > Actually it is still 31:12 but with bits 19:12 or 23:12 masked out. So
>> > you do the correct shift by PAGE_SHIFT with the additional masking for
>> > huge pages (harmless).
>> >
>> > But do we actually need this masking? Do the huge_pte_offset() or
>> > huge_pte_alloc() functions return the Linux pte (pmd) for the huge page?
>> > If yes, can we not ensure that bits 19:12 are already zero? This
>> > shouldn't be any different from the 4K Linux pte but with an address
>> > aligned to 1MB.
>>
>> I'm afraid there is some misunderstanding.
>> huge_pte_offset() returns the huge linux pte address if they exist;
>> huge_pte_alloc()  allocates a location to store huge linux pte, and
>> return this address;
>> non of above functions return huge linux pte *value*.
>
> I agree, huge_pte_offset() returns a pointer to the Linux pte/pmd if it
> exists. My point is that the values stored in Linux pte/pmd have bits
> 20:12 cleared already as the address is at least 2MB aligned (well,
> apart from the additional L_PTE_HPAGE_* bits that you declared). Is this
> correct? If yes, then you don't need any additional masking for
> pte_pfn() even if it is passed a Linux pmd.

Yes, pte_pfn doesn't need any modification if we don't need any L_PTE_HPAGE_*).


>
>> make_huge_pte() will return huge linux pte for a given page and vma
>> protection bits,
>> please notice pte_mkhuge is used to mark this pte as huge linux pte by
>> setting
>> L_PTE_HUGEPAGE, then set_huge_pte_at() is used to set huge linux pte as
>> well
>> huge hardware pte.
>>
>>
>> 2113static pte_t make_huge_pte(struct vm_area_struct *vma, struct page
>> *page,
>> 2114                                int writable)
>> 2115{
>> 2116        pte_t entry;
>> 2117
>> 2118        if (writable) {
>> 2119                entry =
>> 2120                    pte_mkwrite(pte_mkdirty(mk_pte(page,
>> vma->vm_page_prot)));
>> 2121        } else {
>> 2122                entry = huge_pte_wrprotect(mk_pte(page,
>> vma->vm_page_prot));
>> 2123        }
>> 2124        entry = pte_mkyoung(entry);
>> 2125        entry = pte_mkhuge(entry);
>> 2126
>> 2127        return entry;
>> 2128}
>>
>> Hence, normal linux pte must has L_PTE_HUGEPAE cleared;
>> A huge linux pte must has L_PTE_HUGEPAGE(BIT11) set
>> This could lead to L_PTE_HPAGE_2M(BIT12) or L_PTE_HPAGE_16M(BIT13) set
>> respectively, that's why the masking is needed for pte_pfn.
>
> But if you avoid setting L_PTE_HPAGE_*, than we don't need the masking
> for pte_pfn. In which case, we don't need to differentiate between a
> normal and a huge pte in pte_pfn(), so no need for L_PTE_HUGEPAGE. The
> set_huge_pte_at() function is only called with a huge pte, so it doesn't
> need to check the L_PTE_HUGEPAGE bit either.
>

I understood what you mean now, and the original design is almost like you said.
But the consequences of eliminating L_PTE_HUGEPAGE as well as L_PTE_HPAGE_*
only leave us with huge page size fixed at build time, I mean boot
time huge page
size configuration feature like X86 will NOT be feasible anymore!

looks like we have to made a choice now, what do you think? Catalin

> --
> Catalin
>
