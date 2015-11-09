From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 9 Nov 2015 17:59:42 +0100
Subject: [PATCH] ARM/arm64: KVM: test properly for a PTE's uncachedness
In-Reply-To: <20151109163519.GB12968@cbox>
References: <1446810188-13727-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151109162159.GA12968@cbox>
 <CAKv+Gu9RkX1A4rLvTbgkhTQxcVnLjc1tHRaMAOq0cgcpGvkpRg@mail.gmail.com>
 <20151109163519.GB12968@cbox>
Message-ID: <CAKv+Gu_agkv7aDqj7fgdoWU+9k=eJ-0YU7WrDKm1_wtr_xYQ6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 November 2015 at 17:35, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Mon, Nov 09, 2015 at 05:27:40PM +0100, Ard Biesheuvel wrote:
>> On 9 November 2015 at 17:21, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>> > On Fri, Nov 06, 2015 at 12:43:08PM +0100, Ard Biesheuvel wrote:
>> >> The open coded tests for checking whether a PTE maps a page as
>> >> uncached use a flawed 'pte_val(xxx) & CONST != CONST' pattern,
>> >> which is not guaranteed to work since the type of a mapping is an
>> >> index into the MAIR table, not a set of mutually exclusive bits.
>> >>
>> >> Considering that, on arm64, the S2 type definitions use the following
>> >> MAIR indexes
>> >>
>> >>     #define MT_S2_NORMAL            0xf
>> >>     #define MT_S2_DEVICE_nGnRE      0x1
>> >>
>> >> we have been getting lucky merely because the S2 device mappings also
>> >> have the PTE_UXN bit set, which means that a device PTE still does not
>> >> equal a normal PTE after masking with the former type.
>> >>
>> >> Instead, implement proper checking against the MAIR indexes that are
>> >> known to define uncached memory attributes.
>> >>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> ---
>> >>  arch/arm/include/asm/kvm_mmu.h   | 11 +++++++++++
>> >>  arch/arm/kvm/mmu.c               |  5 ++---
>> >>  arch/arm64/include/asm/kvm_mmu.h | 12 ++++++++++++
>> >>  3 files changed, 25 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> >> index 405aa1883307..422973835d41 100644
>> >> --- a/arch/arm/include/asm/kvm_mmu.h
>> >> +++ b/arch/arm/include/asm/kvm_mmu.h
>> >> @@ -279,6 +279,17 @@ static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
>> >>                                      pgd_t *merged_hyp_pgd,
>> >>                                      unsigned long hyp_idmap_start) { }
>> >>
>> >> +static inline bool __kvm_pte_is_uncached(pte_t pte)
>> >> +{
>> >> +     switch (pte_val(pte) & L_PTE_MT_MASK) {
>> >> +     case L_PTE_MT_UNCACHED:
>> >> +     case L_PTE_MT_BUFFERABLE:
>> >> +     case L_PTE_MT_DEV_SHARED:
>> >> +             return true;
>> >> +     }
>> >
>> > so PTEs created by setting PAGE_S2_DEVICE will end up hitting in one of
>> > these because L_PTE_S2_MT_DEV_SHARED is the same as L_PTE_MT_BUFFERABLE
>> > for stage-2 mappings and PAGE_HYP_DEVICE end up using
>> > L_PTE_MT_DEV_SHARED.
>> >
>> > Totally obvious.
>> >
>>
>> Hmm, perhaps not. Would you prefer all aliases of the L_PTE_MT_xx
>> constants that map to device permissions to be listed here?
>>
>
> Meh, there's no great solution and this code is all the kind of code
> that you just need to take the time to understand.  We could add a
> comment I suppose, if I got the above correct, I can throw something in?
>

Actually, I think the patch is wrong, and so is the commit message.

I got confused between HYP mappings and stage 2 mappings. HYP mappings
use an index into the MAIR (which HYP inherits from the kernel) but
the stage 2 mappings have a bit fiield describing the type.

So for one, I think that means that __kvm_pte_is_uncached() cannot be
used for both HYP and stage-2 PTE's, or we'd need to add a parameter
to distinguish between them.

For HYP mappings, we need to compare the MAIR index to values that are
known to refer to device or uncached mappings (as the patch does)
For S2 mappings, we need to mask the MemAttr[5:2] field, and interpret
it according to the description in the ARM ARM, i.e., MemAttr[3:2] ==
0b00 indicates device, MemAttr[3:0] == 0b0101 is uncached memory,
anything else requires cache maintenance.

-- 
Ard.
