From: james.morse@arm.com (James Morse)
Date: Tue, 12 Jun 2018 16:29:33 +0100
Subject: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <f7f59176-16a1-3b24-5acc-87bf1b4c1490@huawei.com>
References: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
 <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
 <45e94aae-ed9f-1fb7-f10e-d95c2f969ddd@arm.com>
 <f7f59176-16a1-3b24-5acc-87bf1b4c1490@huawei.com>
Message-ID: <6887237f-d252-5b9e-02cb-5a44fef27080@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 12/06/18 15:50, gengdongjiu wrote:
> On 2018/6/11 21:36, James Morse wrote:
>> On 08/06/18 20:48, Dongjiu Geng wrote:
>>> For the migrating VMs, user space may need to know the exception
>>> state. For example, in the machine A, KVM make an SError pending,
>>> when migrate to B, KVM also needs to pend an SError.
>>>
>>> This new IOCTL exports user-invisible states related to SError.
>>> Together with appropriate user space changes, user space can get/set
>>> the SError exception state to do migrate/snapshot/suspend.


>>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>>> index caae484..c3e6975 100644
>>> --- a/arch/arm/include/uapi/asm/kvm.h
>>> +++ b/arch/arm/include/uapi/asm/kvm.h
>>> @@ -124,6 +124,18 @@ struct kvm_sync_regs {
>>>  struct kvm_arch_memory_slot {
>>>  };
>>>  
>>> +/* for KVM_GET/SET_VCPU_EVENTS */
>>> +struct kvm_vcpu_events {
>>> +	struct {
>>> +		__u8 serror_pending;
>>> +		__u8 serror_has_esr;
>>> +		/* Align it to 8 bytes */
>>> +		__u8 pad[6];
>>> +		__u64 serror_esr;
>>> +	} exception;
>>> +	__u32 reserved[12];
>>> +};
>>> +
>>
>> You haven't defined __KVM_HAVE_VCPU_EVENTS for 32bit, so presumably this struct
>> will never be used. Why is it here?

>   if not add it for 32 bits. the 32 arm platform will build Fail, whether you have good
>    idea to avoid this Failure if not add this struct for the 32 bit?

How does this 32bit code build without this patch?
If do you provide the struct, how will that code build with older headers?

As far as I can see, this is what the __KVM_HAVE_VCPU_EVENTS define is for.

This should be both, or neither. Having just the struct is useless.


>>> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>>> +			struct kvm_vcpu_events *events)
>>> +{
>>> +	bool serror_pending = events->exception.serror_pending;
>>> +	bool has_esr = events->exception.serror_has_esr;
>>> +
>>> +	if (serror_pending && has_esr) {
>>> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
>>> +			return -EINVAL;
>>> +
>>> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);
>>
>> kvm_set_sei_esr() will silently discard the top 40 bits of serror_esr, (which is
>> correct, we shouldn't copy them into hardware without know what they do).
>>
>> Could we please force user-space to zero these bits, we can advertise extra CAPs
>> if new features turn up in that space, instead of user-space passing <something>
>> and relying on the kernel to remove it.
> 
>   yes, I can zero these bits in the  user-space and not depend on kernel to remove it.

But the kernel must check that user-space did zero those bits. Otherwise
user-space may start using them when a future version of the architecture gives
them a meaning, but an older kernel version doesn't know it has to do extra
work, but still lets the bits from user-space through into the hardware.

If new bits do turn up, we can advertise a CAP that says that KVM supports
whatever that feature is.


>> (Background: VSESR is a 64bit register that holds the value to go in a 32bit
>> register. I suspect the top-half could get re-used for control values or
>> something we don't want to give user-space)

>   do you mean when user-space get the VSESR value through KVM_GET_VCPU_EVENTS
> it only return the low-half 32 bits?

No, the kernel will only ever set a 24bit value here. If we force user-space to
only provide a 24bit value then we don't need to check it on read. We never read
the value back from hardware.

These high bits are RES0 at the moment, they may get used for something in the
future. As we are exposing this via a user-space ABI we need to make sure we
only expose the bits we understand today.


Thanks,

James
