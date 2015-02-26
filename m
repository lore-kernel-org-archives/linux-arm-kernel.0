From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Feb 2015 18:17:45 +0000
Subject: [RFC PATCH 3/3] arm64: KVM: use ID map with increased VA range if
 required
In-Reply-To: <54EF60B2.1050401@arm.com>
References: <1424964547-2118-1-git-send-email-ard.biesheuvel@linaro.org>
 <1424964547-2118-4-git-send-email-ard.biesheuvel@linaro.org>
 <54EF60B2.1050401@arm.com>
Message-ID: <CAKv+Gu8=tAb7+d1qkmY47AvKjs_mjkK=NCMqutPJg9hLV5DY0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2015 at 18:06, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 26/02/15 15:29, Ard Biesheuvel wrote:
>> This patch modifies the HYP init code so it can deal with system
>> RAM residing at an offset which exceeds the reach of VA_BITS.
>>
>> Like for EL1, this involves configuring an additional level of
>> translation for the ID map. However, in case of EL2, this implies
>> that all translations use the extra level, as we cannot seamlessly
>> switch between translation tables with different numbers of
>> translation levels. For this reason, the ID map is merged with
>> the runtime HYP map, since they don't overlap anyway.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kvm/hyp-init.S | 40 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
>> index c3191168a994..0af16bce6316 100644
>> --- a/arch/arm64/kvm/hyp-init.S
>> +++ b/arch/arm64/kvm/hyp-init.S
>> @@ -20,6 +20,7 @@
>>  #include <asm/assembler.h>
>>  #include <asm/kvm_arm.h>
>>  #include <asm/kvm_mmu.h>
>> +#include <asm/pgtable-hwdef.h>
>>
>>       .text
>>       .pushsection    .hyp.idmap.text, "ax"
>> @@ -58,13 +59,44 @@ __invalid:
>>        */
>>  __do_hyp_init:
>>
>> -     msr     ttbr0_el2, x0
>> -
>>       mrs     x4, tcr_el1
>>       ldr     x5, =TCR_EL2_MASK
>>       and     x4, x4, x5
>>       ldr     x5, =TCR_EL2_FLAGS
>>       orr     x4, x4, x5
>> +
>> +#ifndef CONFIG_ARM64_VA_BITS_48
>> +     /*
>> +      * If we are running with VA_BITS < 48, we may be running with an extra
>> +      * level of translation in the ID map. This is only the case if system
>> +      * RAM is out of range for the currently configured page size and number
>> +      * of translation levels, in which case we will also need the extra
>> +      * level for the HYP ID map, or we won't be able to enable the EL2 MMU.
>> +      *
>> +      * However, at EL2, there is only one TTBR register, and we can't switch
>> +      * between translation tables *and* update TCR_EL2.T0SZ at the same
>> +      * time. Bottom line: we need the extra level in *both* our translation
>> +      * tables.
>> +      *
>> +      * Fortunately, there is an easy way out: the existing ID map, with the
>> +      * extra level, can be reused for both. The kernel image is already
>> +      * identity mapped at a high virtual offset, which leaves VA_BITS of
>> +      * address space at the low end to put our runtime HYP mappings.
>> +      */
>> +     adrp    x5, idmap_t0sz                  // get ID map TCR.T0SZ
>> +     ldr     x5, [x5, :lo12:idmap_t0sz]
>> +     cmp     x5, TCR_T0SZ(VA_BITS)           // extra level configured?
>> +     b.ge    1f                              // if not, skip
>> +
>> +     bfi     x4, x5, TCR_T0SZ_OFFSET, TCR_TxSZ_WIDTH
>> +
>> +     adrp    x0, idmap_pg_dir        // get root of ID map
>> +     orr     x5, x1, PMD_TYPE_TABLE  // table entry pointing at HYP pgd
>> +     str     x5, [x0]                // store at offset #0
>> +     mov     x1, #0
>> +1:
>
> Wow. This is making my head spin a bit.
>
> Nitpick: shouldn't you use PUD_TYPE_TABLE instead of PMD_TYPE_TABLE
> (yeah, I know, that's the same thing...)?
>

I think both are equally inappropriate, considering that this is the
level above PGD. But I am happy to switch one for the other ...


>> +#endif
>> +     msr     ttbr0_el2, x0
>>       msr     tcr_el2, x4
>>
>>       ldr     x4, =VTCR_EL2_FLAGS
>> @@ -91,6 +123,9 @@ __do_hyp_init:
>>       msr     sctlr_el2, x4
>>       isb
>>
>> +     /* Skip the trampoline dance if we merged the boot and runtime PGDs */
>> +     cbz     x1, merged
>> +
>>       /* MMU is now enabled. Get ready for the trampoline dance */
>>       ldr     x4, =TRAMPOLINE_VA
>>       adr     x5, target
>> @@ -105,6 +140,7 @@ target: /* We're now in the trampoline code, switch page tables */
>>       tlbi    alle2
>>       dsb     sy
>>
>> +merged:
>>       /* Set the stack and new vectors */
>>       kern_hyp_va     x2
>>       mov     sp, x2
>>
>
> The one thing that worries here is that our EL1 idmap is not a strict
> idmap anymore. I really wonder what we can break with that...
>

Yes, that is the question I had myself. The other issue is that we
never remove the entry we add at the root level in this code, which I
don't think matters that much but it would be good if someone could
confirm.

> But hey, it's so mad I like it! ;-)
>

Thanks!

-- 
Ard.
