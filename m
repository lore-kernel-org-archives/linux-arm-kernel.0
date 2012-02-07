From: bill4carson@gmail.com (bill4carson)
Date: Tue, 07 Feb 2012 09:42:01 +0800
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <20120206162656.GG26538@arm.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
 <20120131095811.GB889@n2100.arm.linux.org.uk>
 <CAHkRjk4MnuHs6MZNds2YmufmY_29dSOoeCxX=ODZ5p23YEcjUw@mail.gmail.com>
 <4F28AD1D.1000106@gmail.com> <20120206162656.GG26538@arm.com>
Message-ID: <4F308169.4010904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?02?07? 00:26, Catalin Marinas wrote:
> On Wed, Feb 01, 2012 at 03:10:21AM +0000, bill4carson wrote:
>> Why L_PTE_HUGEPAGE is needed?
>>
>> hugetlb subsystem will call pte_page to derive the corresponding page
>> struct from a given pte, and pte_pfn is used first to convert pte into
>> a page frame number.
>
> Are you sure the pte_pfn() conversion is right? Does it need to be
> different from the 4K pfn?

Hello, Catalin

Let me take a few words to make this clear for us.

pte_page is defined as following to derive page struct from a given pte.
This macro is used both in generic mm as well as hugetlb sub-system, so
we need do the switch in pte_pfn to mark huge page based linux pte out
of normal page based linux pte, that's what L_PTE_HUGEPAGE for.

#define pte_page(pte)		pfn_to_page(pte_pfn(pte))


So L_PTE_HUGEPAGE is *NOT* set in normal page based linux pte,
linux pte bits[31:12] is the page frame number;
otherwise, we got a huge page based linux pte, and linux pte
bits[31:20] is page frame number for SECTION mapping, and bits[31:24]
is page frame number for SUPER-SECTION mapping.

I think this the full story of following code:

#ifdef CONFIG_ARM_HUGETLB_SUPPORT

#ifdef CONFIG_HUGEPAGE_SIZE_2MB
#define hugepte_pfn(pte)    ((pte_val(pte) & SECTION_MASK) >> PAGE_SHIFT)
#endif
#ifdef CONFIG_HUGEPAGE_SIZE_16MB
#define hugepte_pfn(pte)    ((pte_val(pte) & SUPERSECTION_MASK) >> 
PAGE_SHIFT)
#endif
#define pte_is_huge(pte)	(pte_val(pte) & L_PTE_HUGEPAGE)
#define pte_pfn(pte)	    (pte_is_huge(pte) ? \
				hugepte_pfn(pte) : ((pte_val(pte) & PHYS_MASK) >> PAGE_SHIFT))
#else
#define pte_pfn(pte)		((pte_val(pte) & PHYS_MASK) >> PAGE_SHIFT)
#endif /*!CONFIG_ARM_HUGETLB_SUPPORT*/


#define pte_page(pte)		pfn_to_page(pte_pfn(pte))




> I haven't seen any other architecture doing
> shifts other than PAGE_SHIFT even for huge pages.
>

#define L_PTE_HUGEPAGE	(_AT(pteval_t, 1) << 11) /* mark hugepage */
#define L_PTE_HPAGE_2M  (_AT(pteval_t, 1) << 12) /* only when HUGEPAGE 
set */
#define L_PTE_HPAGE_16M (_AT(pteval_t, 1) << 13) /* only when HUGEPAGE 
set */

See linux pte BIT12 is used to denote 2MB huge page, BIT13 is used for
16MB page, that's why PAGE_SHIFT is not enough for do the shifting.

I hope I understand your question and give the right answer :)



-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
