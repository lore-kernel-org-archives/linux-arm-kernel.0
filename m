From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 17:35:23 +0100
Subject: [PATCH v3 15/32] arm64: KVM: guest one-reg interface
In-Reply-To: <20130410171339.GN26992@mudshark.cambridge.arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-16-git-send-email-marc.zyngier@arm.com>
 <20130410171339.GN26992@mudshark.cambridge.arm.com>
Message-ID: <516837CB.2030700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/13 18:13, Will Deacon wrote:
> On Mon, Apr 08, 2013 at 05:17:17PM +0100, Marc Zyngier wrote:
>> Let userspace play with the guest registers.
>>
>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/guest.c | 254 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 254 insertions(+)
>>  create mode 100644 arch/arm64/kvm/guest.c
>>
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> new file mode 100644
>> index 0000000..47d3729
>> --- /dev/null
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -0,0 +1,254 @@
>> +/*
>> + * Copyright (C) 2012,2013 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * Derived from arch/arm/kvm/guest.c:
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
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
>> +#include <linux/errno.h>
>> +#include <linux/err.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/module.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/fs.h>
>> +#include <asm/cputype.h>
>> +#include <asm/uaccess.h>
>> +#include <asm/kvm.h>
>> +#include <asm/kvm_asm.h>
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/kvm_coproc.h>
>> +
>> +struct kvm_stats_debugfs_item debugfs_entries[] = {
>> +	{ NULL }
>> +};
>> +
>> +int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>> +{
>> +	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
>> +	return 0;
>> +}
>> +
>> +static u64 core_reg_offset_from_id(u64 id)
>> +{
>> +	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
>> +}
>> +
>> +static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> +{
>> +	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
>> +	struct kvm_regs *regs = vcpu_gp_regs(vcpu);
>> +	int nr_regs = sizeof(*regs) / sizeof(__u32);
> 
> Why are you treating the registers as u32?

Not the registers themselves, but the index into the kvm_regs structure.
The reason is that this structure is a mix of 32, 64 and 128bit fields.
So we index it on the smallest quantity.

	M.
-- 
Jazz is not dead. It just smells funny...
