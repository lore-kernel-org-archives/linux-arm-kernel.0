From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 14 Mar 2016 12:27:43 +0000
Subject: [PATCH v2 8/8] arm64: kvm: Check support for AArch32 for 32bit
 guests
In-Reply-To: <56D6AD72.8010108@arm.com>
References: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
 <1456393968-17386-9-git-send-email-suzuki.poulose@arm.com>
 <56D6AD72.8010108@arm.com>
Message-ID: <56E6AE3F.2030800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/16 09:08, Marc Zyngier wrote:
> On 25/02/16 09:52, Suzuki K Poulose wrote:
>> Add a check to make sure the system supports AArch32 state
>> before initialising a 32bit guest.
>>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: kvmarm at lists.cs.columbia.edu
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

...

>> @@ -338,6 +340,12 @@ static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>>   static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
>>
>> +static inline bool kvm_arch_vcpu_validate_features(struct kvm_vcpu_arch *arch_vcpu)
>> +{
>> +	return  !test_bit(KVM_ARM_VCPU_EL1_32BIT, arch_vcpu->features) ||
>> +		system_supports_32bit_el0();
>> +}
>> +
>
> This is really convoluted (it took me 5 minutes staring at the
> expression and remembering that AArch32 EL1 implies AArch32 EL0 to get it).
>
> Now, we already have kvm_reset_vcpu() that validates AArch32 support. It
> would probably be better to move things there. Thoughts?

I think we can leave the kvm bits as it is now, discarding this patch, as
we already do the right thing. Also system_supports_32bit_el0() doesn't
guarantee system_supports_32bit_el1(). The negation and converse are
both true though.

i.e,

	!32bit_el0_support => !32bit_el1_support
		  &
	32bit_el1_support => 32bit_el0_support

Thanks
Suzuki
