From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 16:29:18 +0100
Subject: [PATCH v3 07/32] arm64: KVM: fault injection into a guest
In-Reply-To: <20130410164038.GI26992@mudshark.cambridge.arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-8-git-send-email-marc.zyngier@arm.com>
 <20130410164038.GI26992@mudshark.cambridge.arm.com>
Message-ID: <5168284E.6030407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/13 17:40, Will Deacon wrote:
> On Mon, Apr 08, 2013 at 05:17:09PM +0100, Marc Zyngier wrote:
>> Implement the injection of a fault (undefined, data abort or
>> prefetch abort) into a 64bit guest.
>>
>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/inject_fault.c | 118 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 118 insertions(+)
>>  create mode 100644 arch/arm64/kvm/inject_fault.c
>>
>> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
>> new file mode 100644
>> index 0000000..2ff3b78
>> --- /dev/null
>> +++ b/arch/arm64/kvm/inject_fault.c
>> @@ -0,0 +1,118 @@
>> +/*
>> + * Fault injection for 64bit guests.
>> + *
>> + * Copyright (C) 2012,2013 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * Based on arch/arm/kvm/emulate.c
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/kvm_host.h>
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/esr.h>
>> +
>> +static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr)
>> +{
>> +	unsigned long cpsr = *vcpu_cpsr(vcpu);
>> +	int is_aarch32;
>> +	u32 esr = 0;
>> +
>> +	is_aarch32 = vcpu_mode_is_32bit(vcpu);
>> +
>> +	*vcpu_spsr(vcpu) = cpsr;
>> +	*vcpu_elr_el1(vcpu) = *vcpu_pc(vcpu);
>> +
>> +	*vcpu_cpsr(vcpu) = PSR_MODE_EL1h | PSR_A_BIT | PSR_F_BIT | PSR_I_BIT;
> 
> You probably want to set PSR_D_BIT too.

Ah! I didn't realize Debug was disabled on exception entry. I'll fix that.

>> +	*vcpu_pc(vcpu) = vcpu_sys_reg(vcpu, VBAR_EL1) + 0x200;
>> +
>> +	vcpu_sys_reg(vcpu, FAR_EL1) = addr;
>> +
>> +	/*
>> +	 * Build an {i,d}abort, depending on the level and the
>> +	 * instruction set. Report an external synchronous abort.
>> +	 */
>> +	if (kvm_vcpu_trap_il_is32bit(vcpu))
>> +		esr |= ESR_EL1_IL;
>> +
>> +	if (is_aarch32 || (cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
>> +		esr |= (ESR_EL1_EC_IABT_EL0 << ESR_EL1_EC_SHIFT);
>> +	else
>> +		esr |= (ESR_EL1_EC_IABT_EL1 << ESR_EL1_EC_SHIFT);
>> +
>> +	if (!is_iabt)
>> +		esr |= ESR_EL1_EC_DABT_EL0;
>> +
>> +	vcpu_sys_reg(vcpu, ESR_EL1) = esr | 0x10; /* External abort */
>> +}
> 
> Probably worth #defining the el1_sync offset and also the esr external abort
> class.

Sure.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
