From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 24 Apr 2013 10:08:05 -0700
Subject: [PATCH v3 17/32] arm64: KVM: HYP mode world switch implementation
In-Reply-To: <5177C47B.6090502@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-18-git-send-email-marc.zyngier@arm.com>
 <20130423225958.GF20569@gmail.com> <5177C47B.6090502@arm.com>
Message-ID: <CAEDV+gJt7D5NgJJQsFe8YrG+5ErrnAYGDRAdBQBFOx+b=HKapA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 4:39 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/04/13 23:59, Christoffer Dall wrote:
>> On Mon, Apr 08, 2013 at 05:17:19PM +0100, Marc Zyngier wrote:
>>> The HYP mode world switch in all its glory.
>>>
>>> Implements save/restore of host/guest registers, EL2 trapping,
>>> IPA resolution, and additional services (tlb invalidation).
>>>
>>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm64/kernel/asm-offsets.c |  34 +++
>>>  arch/arm64/kvm/hyp.S            | 602 ++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 636 insertions(+)
>>>  create mode 100644 arch/arm64/kvm/hyp.S
>>>
>
> [...]
>
>>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>>> new file mode 100644
>>> index 0000000..c745d20
>>> --- /dev/null
>>> +++ b/arch/arm64/kvm/hyp.S
>>> @@ -0,0 +1,602 @@
>>> +/*
>>> + * Copyright (C) 2012,2013 - ARM Ltd
>>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/linkage.h>
>>> +#include <linux/irqchip/arm-gic.h>
>>> +
>>> +#include <asm/assembler.h>
>>> +#include <asm/memory.h>
>>> +#include <asm/asm-offsets.h>
>>> +#include <asm/fpsimdmacros.h>
>>> +#include <asm/kvm.h>
>>> +#include <asm/kvm_asm.h>
>>> +#include <asm/kvm_arm.h>
>>> +#include <asm/kvm_mmu.h>
>>> +
>>> +#define CPU_GP_REG_OFFSET(x) (CPU_GP_REGS + x)
>>> +#define CPU_XREG_OFFSET(x)   CPU_GP_REG_OFFSET(CPU_USER_PT_REGS + 8*x)
>>> +#define CPU_SPSR_OFFSET(x)   CPU_GP_REG_OFFSET(CPU_SPSR + 8*x)
>>> +#define CPU_SYSREG_OFFSET(x) (CPU_SYSREGS + 8*x)
>>> +
>>> +     .text
>>> +     .pushsection    .hyp.text, "ax"
>>> +     .align  PAGE_SHIFT
>>> +
>>> +__kvm_hyp_code_start:
>>> +     .globl __kvm_hyp_code_start
>>> +
>>> +.macro save_common_regs
>>> +     // x2: base address for cpu context
>>> +     // x3: tmp register
>>
>> what's with the C99 style comments? Standard for arm64 assembly?
>
> Yes. The toolchain guys got rid of '@' as a single line comment delimiter.
>
> [...]
>
>>> +el1_sync:                                    // Guest trapped into EL2
>>> +     push    x0, x1
>>> +     push    x2, x3
>>> +
>>> +     mrs     x1, esr_el2
>>> +     lsr     x2, x1, #ESR_EL2_EC_SHIFT
>>> +
>>> +     cmp     x2, #ESR_EL2_EC_HVC64
>>> +     b.ne    el1_trap
>>> +
>>> +     mrs     x3, vttbr_el2                   // If vttbr is valid, the 64bit guest
>>> +     cbnz    x3, el1_trap                    // called HVC
>>> +
>>> +     /* Here, we're pretty sure the host called HVC. */
>>> +     pop     x2, x3
>>> +     pop     x0, x1
>>> +
>>> +     push    lr, xzr
>>> +
>>> +     /*
>>> +      * Compute the function address in EL2, and shuffle the parameters.
>>> +      */
>>> +     kern_hyp_va     x0
>>> +     mov     lr, x0
>>> +     mov     x0, x1
>>> +     mov     x1, x2
>>> +     mov     x2, x3
>>> +     blr     lr
>>> +
>>> +     pop     lr, xzr
>>> +     eret
>>> +
>>> +el1_trap:
>>> +     /*
>>> +      * x1: ESR
>>> +      * x2: ESR_EC
>>> +      */
>>> +     cmp     x2, #ESR_EL2_EC_DABT
>>> +     mov     x0, #ESR_EL2_EC_IABT
>>> +     ccmp    x2, x0, #4, ne
>>> +     b.ne    1f              // Not an abort we care about
>>
>> why do we get the hpfar_el2 if it's not an abort (or is this for a
>> special type of abort) ?
>
> No, we could actually avoid saving HPFAR_EL2 altogether in this case.
>
>>> +
>>> +     /* This is an abort. Check for permission fault */
>>> +     and     x2, x1, #ESR_EL2_FSC_TYPE
>>> +     cmp     x2, #FSC_PERM
>>> +     b.ne    1f              // Not a permission fault
>>> +
>>> +     /*
>>> +      * Check for Stage-1 page table walk, which is guaranteed
>>> +      * to give a valid HPFAR_EL2.
>>> +      */
>>> +     tbnz    x1, #7, 1f      // S1PTW is set
>>> +
>>> +     /*
>>> +      * Permission fault, HPFAR_EL2 is invalid.
>>> +      * Resolve the IPA the hard way using the guest VA.
>>> +      * We always perform an EL1 lookup, as we already
>>> +      * went through Stage-1.
>>> +      */
>>
>> What does the last sentence mean exactly?
>
> It means that the Stage-1 translation already validated the memory
> access rights. As such, we can use the EL1 translation regime, and don't
> have to distinguish between EL0 and EL1 access.
>

ah, right, now I remember this one, I think the comment could say that
more clearly:)

>>> +     mrs     x3, far_el2
>>> +     at      s1e1r, x3
>>> +     isb
>>> +
>>> +     /* Read result */
>>> +     mrs     x3, par_el1
>>> +     tbnz    x3, #1, 3f              // Bail out if we failed the translation
>>> +     ubfx    x3, x3, #12, #36        // Extract IPA
>>> +     lsl     x3, x3, #4              // and present it like HPFAR
>>> +     b       2f
>>> +
>>> +1:   mrs     x3, hpfar_el2
>>> +
>>> +2:   mrs     x0, tpidr_el2
>>> +     mrs     x2, far_el2
>>> +     str     x1, [x0, #VCPU_ESR_EL2]
>>> +     str     x2, [x0, #VCPU_FAR_EL2]
>>> +     str     x3, [x0, #VCPU_HPFAR_EL2]
>>> +
>>> +     mov     x1, #ARM_EXCEPTION_TRAP
>>> +     b       __kvm_vcpu_return
>>> +
>>> +     /*
>>> +      * Translation failed. Just return to the guest and
>>> +      * let it fault again. Another CPU is probably playing
>>> +      * behind our back.
>>> +      */
>>
>> This actually makes me wonder if this is a potential DOS attack from
>> guests (on the 32-bit code as well), or are we sure that an asynchronous
>> timer interrupt to the host will always creep in between e.g. a tight
>> loop playing this trick on us?
>
> Host interrupts will fire as soon as you eret into the guest. At that
> point, the (malicious) guest will be scheduled out, just like a normal
> process.
>
good, thanks.
