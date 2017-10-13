From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Oct 2017 12:31:31 +0100
Subject: [PATCH 01/37] KVM: arm64: Avoid storing the vcpu pointer on the
 stack
In-Reply-To: <20171012170216.GA26425@cbox>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
 <20171012104141.26902-2-christoffer.dall@linaro.org>
 <ef4bffe5-b3c5-5fdd-cb8b-1840d2243ae1@arm.com> <20171012170216.GA26425@cbox>
Message-ID: <20a58b6b-7476-fed9-6b48-b9710b437750@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/17 18:02, Christoffer Dall wrote:
> On Thu, Oct 12, 2017 at 04:49:44PM +0100, Marc Zyngier wrote:
>> On 12/10/17 11:41, Christoffer Dall wrote:
>>> We already have the percpu area for the host cpu state, which points to
>>> the VCPU, so there's no need to store the VCPU pointer on the stack on
>>> every context switch.  We can be a little more clever and just use
>>> tpidr_el2 for the percpu offset and load the VCPU pointer from the host
>>> context.
>>>
>>> This requires us to have a scratch register though, so we take the
>>> chance to rearrange some of the el1_sync code to only look at the
>>> vttbr_el2 to determine if this is a trap from the guest or an HVC from
>>> the host.  We do add an extra check to call the panic code if the kernel
>>> is configured with debugging enabled and we saw a trap from the host
>>> which wasn't an HVC, indicating that we left some EL2 trap configured by
>>> mistake.
>>>
>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> ---
>>>  arch/arm64/include/asm/kvm_asm.h | 20 ++++++++++++++++++++
>>>  arch/arm64/kernel/asm-offsets.c  |  1 +
>>>  arch/arm64/kvm/hyp/entry.S       |  5 +----
>>>  arch/arm64/kvm/hyp/hyp-entry.S   | 39 ++++++++++++++++++---------------------
>>>  arch/arm64/kvm/hyp/switch.c      |  2 +-
>>>  5 files changed, 41 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
>>> index ab4d0a9..7e48a39 100644
>>> --- a/arch/arm64/include/asm/kvm_asm.h
>>> +++ b/arch/arm64/include/asm/kvm_asm.h
>>> @@ -70,4 +70,24 @@ extern u32 __init_stage2_translation(void);
>>>  
>>>  #endif
>>>  
>>> +#ifdef __ASSEMBLY__
>>> +.macro get_host_ctxt reg, tmp
>>> +	/*
>>> +	 * '=kvm_host_cpu_state' is a host VA from the constant pool, it may
>>> +	 * not be accessible by this address from EL2, hyp_panic() converts
>>> +	 * it with kern_hyp_va() before use.
>>> +	 */
>>
>> This really looks like a stale comment, as there is no hyp_panic
>> involved here anymore (thankfully!).
>>
> 
> yeah, I suppose.
> 
>>> +	ldr	\reg, =kvm_host_cpu_state
>>> +	mrs	\tmp, tpidr_el2
>>> +	add	\reg, \reg, \tmp
>>> +	kern_hyp_va \reg
>>
>> Here, we're trading a load from the stack for a load from the constant
>> pool. Can't we do something like:
>>
>> 	adr_l	\reg, kvm_host_cpu_state
>> 	msr	\tmp, tpidr_el2
>> 	add	\reg, \reg, \tmp
>>
>> and that's it? 
> 
> That's definitely what the compiler generates from C code...
> 
>> This relies on the property that the kernel/hyp offset is
>> constant, and that it doesn't matter if we add the offset to a kernel VA
>> or a HYP VA... Completely untested of course!
>>
> 
> You're the hyp VA expert.  Is it valid to rely on that assumption?

Absolutely. Otherwise, we've messed up something really badly.

[...]

>>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>>> index 69ef24a..a0123ad 100644
>>> --- a/arch/arm64/kvm/hyp/switch.c
>>> +++ b/arch/arm64/kvm/hyp/switch.c
>>> @@ -435,7 +435,7 @@ void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context *__host_ctxt)
>>>  	if (read_sysreg(vttbr_el2)) {
>>>  		struct kvm_cpu_context *host_ctxt;
>>>  
>>> -		host_ctxt = kern_hyp_va(__host_ctxt);
>>> +		host_ctxt = __host_ctxt;
>>
>> Can't we just rename __host_ctxt to host_ctxt and drop the local definition?
>>
> 
> yes, patch splitting snafu.  Will fix.
> 
> By the way, what I'm going for is anything in the hyp address space has
> leading __, and otherwise ot.

OK, that's a useful convention, actually.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
