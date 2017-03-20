From: james.morse@arm.com (James Morse)
Date: Mon, 20 Mar 2017 15:08:08 +0000
Subject: [PATCH] kvm: pass the virtual SEI syndrome to guest OS
In-Reply-To: <22fb583f-a33e-15f8-a059-fb112b27dd4f@arm.com>
References: <1489996534-8270-1-git-send-email-gengdongjiu@huawei.com>
 <7055772d-2a20-6e0c-2bf8-204bc9ef52a5@arm.com>
 <b912c293-4314-7c90-30a4-2f986feb1670@huawei.com>
 <22fb583f-a33e-15f8-a059-fb112b27dd4f@arm.com>
Message-ID: <58CFF058.8020205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 20/03/17 13:58, Marc Zyngier wrote:
> On 20/03/17 12:28, gengdongjiu wrote:
>> On 2017/3/20 19:24, Marc Zyngier wrote:
>>> Please include James Morse on anything RAS related, as he's already
>>> looking at related patches.

(Thanks Marc,)

>>> On 20/03/17 07:55, Dongjiu Geng wrote:
>>>> In the RAS implementation, hardware pass the virtual SEI
>>>> syndrome information through the VSESR_EL2, so set the virtual
>>>> SEI syndrome using physical SEI syndrome el2_elr to pass to
>>>> the guest OS

How does this work with firmware first?
If we took a Physical SError Interrupt the CPER records are in the hosts memory.
To deliver a RAS event to the guest something needs to generate CPER records and
put them in the guest memory. Only Qemu knows where these memory regions are.

Put another way, what is the guest expected to do with this SError interrupt?
The only choice is panic(). We should send this via Qemu so that we can add
proper guest RAS support later. Once Qemu has written the CPER records into
guest memory, it can notify the guest.

Is anyone from Huawei looking at adding RAS support for Qemu?


It looks like we should save/restore VSESR_EL2 as part of the guest CPU state,
but this needs doing with the cpufeature framework so that the single-image
kernel works on platforms with and without these features.

Xie XiuQi's series for SEI also touches the cpufeature framework.


>>>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>>>> index aede1658aeda..770a153fb6ba 100644
>>>> --- a/arch/arm64/kvm/hyp/switch.c
>>>> +++ b/arch/arm64/kvm/hyp/switch.c
>>>> @@ -86,6 +86,13 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>>>>  		isb();
>>>>  	}
>>>>  	write_sysreg(val, hcr_el2);
>>>> +#ifdef CONFIG_HAS_RAS_EXTENSION
>>>> +	/* If virtual System Error or Asynchronous Abort is pending. set
>>>> +	 * the virtual exception syndrome information
>>>> +	 */
>>>> +	if (vcpu->arch.hcr_el2 & HCR_VSE)

>>>> +		write_sysreg(vcpu->arch.fault.vsesr_el2, vsesr_el2);

This won't build with versions of binutils that don't recognise vsesr_el2.
Is there another patch out there that adds a sysreg definition for vsesr_el2?


>>>> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
>>>> index da6a8cfa54a0..08a13dfe28a8 100644
>>>> --- a/arch/arm64/kvm/inject_fault.c
>>>> +++ b/arch/arm64/kvm/inject_fault.c
>>>> @@ -242,4 +242,14 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
>>>>  void kvm_inject_vabt(struct kvm_vcpu *vcpu)
>>>>  {
>>>>  	vcpu_set_hcr(vcpu, vcpu_get_hcr(vcpu) | HCR_VSE);
>>>> +#ifdef CONFIG_HAS_RAS_EXTENSION
>>>> +	/* If virtual System Error or Asynchronous Abort is set. set
>>>> +	 * the virtual exception syndrome information
>>>> +	 */
>>>> +	kvm_vcpu_set_vsesr(vcpu, ((kvm_vcpu_get_vsesr(vcpu)
>>>> +				& (~VSESR_ELx_IDS_ISS_MASK))
>>>> +				| (kvm_vcpu_get_hsr(vcpu)
>>>> +				& VSESR_ELx_IDS_ISS_MASK)));
>>>
>>> What is the rational for setting VSESR_EL2 with the EL1 syndrome
>>> information? That doesn't make any sense to me.
>> thanks, I set the VSESR_EL2 using the  EL2 syndrome information, "kvm_vcpu_get_hsr"
>> return the value of esr_el2, not EL1 syndrome information
> 
> Ah, good point. But that doesn't make it more valid. I still don't see
> anything in the spec that supports this behaviour, and I still propose
> that when RAS is enabled, the VSError injection is mediated by userspace.

I agree, we should be handling RAS errors as firmware-first, and Qemu plays the
part of firmware for a guest. We will probably need to have a KVM API for Qemu
to pend an SError with a specific ESR value.

If this isn't a firmware-first RAS error the existing code will pend an SError
for the guest.


Thanks,

James
