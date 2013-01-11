From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Jan 2013 17:24:37 +0000
Subject: [PATCH v2 2/2] ARM: KVM: Power State Coordination Interface
 implementation
In-Reply-To: <20130111171232.GH23505@n2100.arm.linux.org.uk>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
 <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
 <20130111171232.GH23505@n2100.arm.linux.org.uk>
Message-ID: <50F04AD5.6020703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/13 17:12, Russell King - ARM Linux wrote:
> On Thu, Jan 10, 2013 at 04:06:45PM +0000, Marc Zyngier wrote:
>> +int kvm_psci_call(struct kvm_vcpu *vcpu)
>> +{
>> +	unsigned long psci_fn = *vcpu_reg(vcpu, 0) & ~((u32) 0);
>> +	unsigned long val;
>> +
>> +	switch (psci_fn) {
>> +	case KVM_PSCI_FN_CPU_OFF:
>> +		kvm_psci_vcpu_off(vcpu);
>> +		val = KVM_PSCI_RET_SUCCESS;
>> +		break;
>> +	case KVM_PSCI_FN_CPU_ON:
>> +		val = kvm_psci_vcpu_on(vcpu);
>> +		break;
>> +	case KVM_PSCI_FN_CPU_SUSPEND:
>> +	case KVM_PSCI_FN_MIGRATE:
>> +		val = KVM_PSCI_RET_NI;
>> +		break;
>> +
>> +	default:
>> +		return -1;
>> +	}
>> +
>> +	*vcpu_reg(vcpu, 0) = val;
>> +	return 0;
>> +}
> 
> We were discussing recently on #kernel about kernel APIs and the way that
> our integer-returning functions pretty much use 0 for success, and -errno
> for failures, whereas our pointer-returning functions are a mess.
> 
> And above we have something returning -1 to some other chunk of code outside
> this compilation unit.  That doesn't sound particularly clever to me.

The original code used to return -EINVAL, see:
https://lists.cs.columbia.edu/pipermail/kvmarm/2013-January/004509.html

Christoffer (Cc-ed) didn't like this, hence the -1. I'm happy to revert
the code to its original state though.

	M.
-- 
Jazz is not dead. It just smells funny...
