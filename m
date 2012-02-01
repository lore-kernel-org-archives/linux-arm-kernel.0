From: bill4carson@gmail.com (bill4carson)
Date: Wed, 01 Feb 2012 11:10:21 +0800
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <CAHkRjk4MnuHs6MZNds2YmufmY_29dSOoeCxX=ODZ5p23YEcjUw@mail.gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
 <20120131095811.GB889@n2100.arm.linux.org.uk>
 <CAHkRjk4MnuHs6MZNds2YmufmY_29dSOoeCxX=ODZ5p23YEcjUw@mail.gmail.com>
Message-ID: <4F28AD1D.1000106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?01?31? 20:25, Catalin Marinas wrote:
> On 31 January 2012 09:58, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> On Mon, Jan 30, 2012 at 03:57:13PM +0800, bill4carson at gmail.com wrote:
>>> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
>>> index 2317a71..062c93c 100644
>>> --- a/arch/arm/include/asm/pgtable-2level.h
>>> +++ b/arch/arm/include/asm/pgtable-2level.h
>>> @@ -123,6 +123,11 @@
>>>   #define L_PTE_USER           (_AT(pteval_t, 1)<<  8)
>>>   #define L_PTE_XN             (_AT(pteval_t, 1)<<  9)
>>>   #define L_PTE_SHARED         (_AT(pteval_t, 1)<<  10)        /* shared(v6), coherent(xsc3) */
>>> +#ifdef CONFIG_ARM_HUGETLB_SUPPORT
>>> +#define L_PTE_HUGEPAGE       (_AT(pteval_t, 1)<<  11) /* mark hugepage */
>>> +#define L_PTE_HPAGE_2M  (_AT(pteval_t, 1)<<  12) /* only when HUGEPAGE set */
>>> +#define L_PTE_HPAGE_16M (_AT(pteval_t, 1)<<  13) /* only when HUGEPAGE set */
>>> +#endif
>> (1) How does this work when normal pages can have bit 11 set if they're an
>> odd PFN?
> Isn't that bit 12?
>
>> (2) How do we even get to PTE level when a 2 or 16MB section doesn't have
>> a pte table (as the L1 entry is used for the section or supersection
>> mapping) ?
> We don't, that's why I think we don't even need this bit defined.
>
First, thanks for Russel/Catalin to take time review this patch:)


a:
By pte used in here, I mean linux pte. linux pte is needed by generic mm 
layer
whether this mapping is 4K, 1MB or 16MB.


b:
Why L_PTE_HUGEPAGE is needed?

hugetlb subsystem will call pte_page to derive the corresponding page 
struct from
a given pte, and pte_pfn is used first to convert pte into a page frame 
number.
This is where need to be careful. Normal page based pte upper [31:12] 
bits is pfn,
huge page(1MB) based pte upper[31:20] is pfn, so one bit MUST 
distinguish normal
page based pte with huge page based pte.

This one bit will *only* be BIT11, one last unused PTE flag within 
normal page.
that's why L_PTE_HUGEPAGE is defined.

If L_PTE_HUGEPAGE is set, then BIT19:12 is enough to be used to mark 
this pte is 1MB
or 16MB huge page.



-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
