From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 24 Apr 2013 09:46:57 -0700
Subject: [PATCH v3 07/32] arm64: KVM: fault injection into a guest
In-Reply-To: <5177AE16.6080509@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-8-git-send-email-marc.zyngier@arm.com>
 <20130423225758.GB20569@gmail.com> <5177AE16.6080509@arm.com>
Message-ID: <CAEDV+gJverKr2wKV__bMTWT2ePrEmZjXzWhOcwu4Hb4HN3wjjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 3:04 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/04/13 23:57, Christoffer Dall wrote:
>> On Mon, Apr 08, 2013 at 05:17:09PM +0100, Marc Zyngier wrote:
>>> Implement the injection of a fault (undefined, data abort or
>>> prefetch abort) into a 64bit guest.
>>>
>>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm64/kvm/inject_fault.c | 118 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 118 insertions(+)
>>>  create mode 100644 arch/arm64/kvm/inject_fault.c
>>>
>>> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
>>> new file mode 100644
>>> index 0000000..2ff3b78
>>> --- /dev/null
>>> +++ b/arch/arm64/kvm/inject_fault.c
>>> @@ -0,0 +1,118 @@
>>> +/*
>>> + * Fault injection for 64bit guests.
>>> + *
>>> + * Copyright (C) 2012,2013 - ARM Ltd
>>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>>> + *
>>> + * Based on arch/arm/kvm/emulate.c
>>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>>> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
>>> + *
>>> + * This program is free software: you can redistribute it and/or modify
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
>>> +#include <linux/kvm_host.h>
>>> +#include <asm/kvm_emulate.h>
>>> +#include <asm/esr.h>
>>> +
>>> +static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
>>> +{
>>> +    unsigned long cpsr = *vcpu_cpsr(vcpu);
>>> +    int is_aarch32;
>>> +    u32 esr = 0;
>>> +
>>> +    is_aarch32 = vcpu_mode_is_32bit(vcpu);
>>> +
>>> +    *vcpu_spsr(vcpu) = cpsr;
>>> +    *vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
>>> +
>>> +    *vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_A_BIT | PSR_F_BIT | PSR_I_BIT;
>>> +    *vcpu_pc(vcpu) = vcpu_sys_reg(vcpu, VBAR_EL1) + 0x200;
>>
>> consider a define for the 0x200?
>
> Yeah, I think Will already mentioned this.
>
>>> +
>>> +    vcpu_sys_reg(vcpu, FAR_EL1) = addr;
>>> +
>>> +    /*
>>> +     * Build an {i,d}abort, depending on the level and the
>>> +     * instruction set. Report an external synchronous abort.
>>> +     */
>>> +    if (kvm_vcpu_trap_il_is32bit(vcpu))
>>> +            esr |= ESR_EL1_IL;
>>> +
>>> +    if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
>>> +            esr |= (ESR_EL1_EC_IABT_EL0 << ESR_EL1_EC_SHIFT);
>>> +    else
>>> +            esr |= (ESR_EL1_EC_IABT_EL1 << ESR_EL1_EC_SHIFT);
>>
>> why is it assumed that the abort must come from EL0 if the vcpu is in
>> aarch32 mode?
>
> We're injecting a fault into a VM that runs with a 64bit EL1. So if we
> end-up faulting in 32bit code, it must come from EL0.
>

ah ok, it could be mentioned in a comment, but meh...

>>> +
>>> +    if (!is_iabt)
>>> +            esr |= ESR_EL1_EC_DABT_EL0;
>>
>> this is slightly confusing unless you actually look at the definitions
>> and realize that or'ing on that extra bit works both in i- and d-abt
>> cases.
>
> Blame Christopher for that, he came up with the idea... ;-)
>

I think this is one of those cases where the compiler should be this
smart, and C should be a little more verbose, but it's not a cardinal
point.

>>> +
>>> +    vcpu_sys_reg(vcpu, ESR_EL1) = esr | 0x10; /* External abort */
>>> +}
>>> +
>>> +static void inject_undef64(struct kvm_vcpu *vcpu)
>>> +{
>>> +    unsigned long cpsr = *vcpu_cpsr(vcpu);
>>> +    u32 esr = (ESR_EL1_EC_UNKNOWN << ESR_EL1_EC_SHIFT);
>>> +
>>> +    *vcpu_spsr(vcpu) = cpsr;
>>> +    *vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
>>> +
>>> +    *vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_F_BIT | PSR_I_BIT;
>>
>> would it make sense to have a define for a common set of these bits or
>> is this explicitly defined per exception type in the specs?
>
> Maybe. Not sure that would be any clearer though...
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
