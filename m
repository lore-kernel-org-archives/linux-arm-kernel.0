From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 May 2013 15:36:27 +0100
Subject: [PATCH v4 14/32] arm64: KVM: guest one-reg interface
In-Reply-To: <20130521143015.GF27002@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-15-git-send-email-marc.zyngier@arm.com>
 <20130521143015.GF27002@arm.com>
Message-ID: <519B866B.5080101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/13 15:30, Catalin Marinas wrote:
> On Tue, May 14, 2013 at 03:13:42PM +0100, Marc Zyngier wrote:
>> Let userspace play with the guest registers.
>>
>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> --- /dev/null
>> +++ b/arch/arm64/kvm/guest.c
> ...
>> +static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> +{
>> +	__u32 __user *uaddr = (__u32 __user *)(unsigned long)reg->addr;
>> +	struct kvm_regs *regs = vcpu_gp_regs(vcpu);
>> +	int nr_regs = sizeof(*regs) / sizeof(__u32);
> 
> Was there any conclusion on using __u32 rather than __u64 here? At least
> you should add a comment since it's slightly confusing.

To use __u64, we'd have to move the FP/SIMD stuff out of struct kvm_regs
and use a separate one_reg bank. Actually, probably two, as the FP stuff
is already a mix of 32b and 128b registers.

I'll add a comment about the __u32 addressing of the structure.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
