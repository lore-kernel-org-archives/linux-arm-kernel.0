From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Apr 2013 12:27:39 +0100
Subject: [PATCH v3 15/32] arm64: KVM: guest one-reg interface
In-Reply-To: <20130423225937.GE20569@gmail.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-16-git-send-email-marc.zyngier@arm.com>
 <20130423225937.GE20569@gmail.com>
Message-ID: <5177C1AB.3090301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/13 23:59, Christoffer Dall wrote:
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
> eh, arent' your regs 64 bit?  Or are you 32-bit indexing into a 64-bit
> structure?  If so, this needs to be described in a big fat comment
> somewhere, which I couldn't even see looking forward in the patch series
> for the documentation part.

As you noticed below, we have a mix of 32/64/128bit fields there. The
index is indeed on 32bit boundary.

> Seems to me you'd want to remove the fp_regs from the core regs and just
> use a 64-bit indexing and have a separate category for the fp stuff...

Hell no! ;-)

FP is mandatory on arm64, and I'm not going down the road of having
separate structures for that. 32bit has historical baggage to deal with,
but not arm64.

This is the register set, and if the ONE_REG API is too cumbersome to
deal with it, then lets change ONE_REG instead (yes, I can run faster
than you think... ;-).

>> +	u32 off;
>> +
>> +	/* Our ID is an index into the kvm_regs struct. */
>> +	off = core_reg_offset_from_id(reg->id);
>> +	if (off >= nr_regs ||
>> +	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
> 
> According to your documentation you will always save/restore 32-bit
> registers here, so the desijunction shouldn't be necessary, nor will it
> be if you just base everything on 64-bit here.

No. Your *offset* is a 32bit index. The size can be anything, and you
want to make sure you don't read/write past the kvm_regs structure.

>> +		return -ENOENT;
>> +
>> +	if (copy_to_user(uaddr, ((u32 *)regs) + off, KVM_REG_SIZE(reg->id)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> +{
>> +	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
>> +	struct kvm_regs *regs = vcpu_gp_regs(vcpu);
>> +	int nr_regs = sizeof(*regs) / sizeof(__u32);
> 
> same concern here

Same answer.

> 
>> +	void *valp;
>> +	u64 off;
>> +	int err = 0;
>> +
>> +	/* Our ID is an index into the kvm_regs struct. */
>> +	off = core_reg_offset_from_id(reg->id);
>> +	if (off >= nr_regs ||
>> +	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
>> +		return -ENOENT;
>> +
>> +	valp = kmalloc(KVM_REG_SIZE(reg->id), GFP_KERNEL);
>> +	if (!valp)
>> +		return -ENOMEM;
> 
> Why are you dynamically allocating this?  Do you ever have anything
> larger than a 64 bit core register? Just put that on the stack.

Look at what a ONE_REG access can be: up to 1kB. I'm not allocating that
on the stack.

>> +
>> +	if (copy_from_user(valp, uaddr, KVM_REG_SIZE(reg->id))) {
>> +		err = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
>> +		unsigned long mode = (*(unsigned long *)valp) & COMPAT_PSR_MODE_MASK;
>> +		switch (mode) {
>> +		case PSR_MODE_EL0t:
>> +		case PSR_MODE_EL1t:
>> +		case PSR_MODE_EL1h:
>> +			break;
>> +		default:
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	memcpy((u32 *)regs + off, valp, KVM_REG_SIZE(reg->id));
>> +out:
>> +	kfree(valp);
>> +	return err;
>> +}
>> +
>> +int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +static unsigned long num_core_regs(void)
>> +{
>> +	return sizeof(struct kvm_regs) / sizeof(unsigned long);
>> +}
>> +
>> +/**
>> + * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
>> + *
>> + * This is for all registers.
>> + */
>> +unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>> +{
>> +	return num_core_regs() + kvm_arm_num_sys_reg_descs(vcpu);
>> +}
>> +
>> +/**
>> + * kvm_arm_copy_reg_indices - get indices of all registers.
>> + *
>> + * We do core registers right here, then we apppend system regs.
>> + */
>> +int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>> +{
>> +	unsigned int i;
>> +	const u64 core_reg = KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE;
>> +
>> +	for (i = 0; i < sizeof(struct kvm_regs)/sizeof(unsigned long); i++) {
> 
> nit: spaces around the division
> nit: the kvm_regs struct uses __u64, so would be slightly more coherent
>      to use that for the sizeof(...) as well

Actually, it should be __u32, as that is an index into the kvm_regs
structure.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
