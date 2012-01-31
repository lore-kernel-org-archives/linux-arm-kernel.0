From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Jan 2012 12:25:21 +0000
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <20120131095811.GB889@n2100.arm.linux.org.uk>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-3-git-send-email-bill4carson@gmail.com>
 <20120131095811.GB889@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk4MnuHs6MZNds2YmufmY_29dSOoeCxX=ODZ5p23YEcjUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2012 09:58, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 30, 2012 at 03:57:13PM +0800, bill4carson at gmail.com wrote:
>> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
>> index 2317a71..062c93c 100644
>> --- a/arch/arm/include/asm/pgtable-2level.h
>> +++ b/arch/arm/include/asm/pgtable-2level.h
>> @@ -123,6 +123,11 @@
>> ?#define L_PTE_USER ? ? ? ? ? (_AT(pteval_t, 1) << 8)
>> ?#define L_PTE_XN ? ? ? ? ? ? (_AT(pteval_t, 1) << 9)
>> ?#define L_PTE_SHARED ? ? ? ? (_AT(pteval_t, 1) << 10) ? ? ? ?/* shared(v6), coherent(xsc3) */
>> +#ifdef CONFIG_ARM_HUGETLB_SUPPORT
>> +#define L_PTE_HUGEPAGE ? ? ? (_AT(pteval_t, 1) << 11) /* mark hugepage */
>> +#define L_PTE_HPAGE_2M ?(_AT(pteval_t, 1) << 12) /* only when HUGEPAGE set */
>> +#define L_PTE_HPAGE_16M (_AT(pteval_t, 1) << 13) /* only when HUGEPAGE set */
>> +#endif
>
> (1) How does this work when normal pages can have bit 11 set if they're an
> odd PFN?

Isn't that bit 12?

> (2) How do we even get to PTE level when a 2 or 16MB section doesn't have
> a pte table (as the L1 entry is used for the section or supersection
> mapping) ?

We don't, that's why I think we don't even need this bit defined.

-- 
Catalin
