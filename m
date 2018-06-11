From: james.morse@arm.com (James Morse)
Date: Mon, 11 Jun 2018 14:36:42 +0100
Subject: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <86zi04875t.wl-marc.zyngier@arm.com>
References: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
 <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
 <86zi04875t.wl-marc.zyngier@arm.com>
Message-ID: <af93e4b1-80d5-33be-d5ed-312c3ea1d715@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 09/06/18 13:40, Marc Zyngier wrote:
> On Fri, 08 Jun 2018 20:48:40 +0100, Dongjiu Geng wrote:
>> For the migrating VMs, user space may need to know the exception
>> state. For example, in the machine A, KVM make an SError pending,
>> when migrate to B, KVM also needs to pend an SError.
>>
>> This new IOCTL exports user-invisible states related to SError.
>> Together with appropriate user space changes, user space can get/set
>> the SError exception state to do migrate/snapshot/suspend.

>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 04b3256..df4faee 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -153,6 +154,18 @@ struct kvm_sync_regs {
>>  struct kvm_arch_memory_slot {
>>  };
>>  
>> +/* for KVM_GET/SET_VCPU_EVENTS */
>> +struct kvm_vcpu_events {
>> +	struct {
>> +		__u8 serror_pending;
>> +		__u8 serror_has_esr;
>> +		/* Align it to 8 bytes */
>> +		__u8 pad[6];
>> +		__u64 serror_esr;
>> +	} exception;
>> +	__u32 reserved[12];
>> +};

>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 56a0260..4426915 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c

>> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>> +			struct kvm_vcpu_events *events)
>> +{
>> +	bool serror_pending = events->exception.serror_pending;
>> +	bool has_esr = events->exception.serror_has_esr;
>> +
>> +	if (serror_pending && has_esr) {
>> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
>> +			return -EINVAL;
>> +
>> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);
>> +	} else if (serror_pending) {
>> +		kvm_inject_vabt(vcpu);
>> +	}
>> +
>> +	return 0;
> 
> There was an earlier request to check that all the padding is set to
> zero. I still think this makes sense.

I agree, not just the exception.padding[], but reserved[] too.


Thanks,

James
