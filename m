From: keescook@chromium.org (Kees Cook)
Date: Thu, 4 Sep 2014 10:23:42 -0700
Subject: [PATCH v5 3/8] arm: fixmap: implement __set_fixmap()
In-Reply-To: <20140904170349.GL7156@arm.com>
References: <1409781429-27593-1-git-send-email-keescook@chromium.org>
 <1409781429-27593-4-git-send-email-keescook@chromium.org>
 <20140904170349.GL7156@arm.com>
Message-ID: <CAGXu5jKimGaupwyUwt0Zwa3OtjeoED8-uBeMX0MwXjBYP6ssAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 4, 2014 at 10:03 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Kees,
>
> On Wed, Sep 03, 2014 at 10:57:04PM +0100, Kees Cook wrote:
>> This is used from set_fixmap() and clear_fixmap() via asm-generic/fixmap.h.
>> Also makes sure that the fixmap allocation fits into the expected range.
>>
>> Based on patch by Rabin Vincent.
>
> [...]
>
>> +void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>> +{
>> +     unsigned long vaddr = __fix_to_virt(idx);
>> +     pte_t *pte = pte_offset_kernel(pmd_off_k(vaddr), vaddr);
>> +
>> +     /* Make sure fixmap region does not exceed available allocation. */
>> +     BUILD_BUG_ON(FIXADDR_START + (__end_of_fixed_addresses * PAGE_SIZE) >
>> +                  FIXADDR_END);
>> +     BUG_ON(idx >= __end_of_fixed_addresses);
>> +
>> +     if (pgprot_val(prot))
>> +             set_pte_at(NULL, vaddr, pte,
>> +                     pfn_pte(phys >> PAGE_SHIFT, prot));
>> +     else
>> +             pte_clear(NULL, vaddr, pte);
>> +
>> +     /*
>> +      * Given the potential a15 tlbi errata, we can only do tlb flushes
>> +      * with interrupts disabled. Callers must have taken care of this.
>> +      */
>> +     WARN_ON_ONCE(!irqs_disabled());
>> +     flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
>
> Aha, this explains why we were confusing each other! The issue is that
> interrupts must be *enabled*, so this code does the exact opposite of
> what we need.
>
> I think this got lost in a sea of double negatives during the last round
> of review.

Ah! If this is the case, perhaps we can get away with
local_flush_tlb_kernel_range() then?

-Kees

-- 
Kees Cook
Chrome OS Security
