From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 9 Jan 2017 13:14:31 +0000
Subject: [PATCH 1/2] ARM: hyp-stub: improve ABI
In-Reply-To: <20170109125431.GY14217@n2100.armlinux.org.uk>
References: <20161213113044.GC19985@leverpostej>
 <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
 <72f93940-cf87-fd91-90f2-760b7ff050fb@arm.com>
 <20170109125431.GY14217@n2100.armlinux.org.uk>
Message-ID: <e16d9b76-49ce-ae22-60f9-f2000d1862af@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/17 12:54, Russell King - ARM Linux wrote:
> On Thu, Dec 15, 2016 at 11:18:48AM +0000, Marc Zyngier wrote:
>> On 14/12/16 10:46, Russell King wrote:
>>> Improve the hyp-stub ABI to allow it to do more than just get/set the
>>> vectors.  We follow the example in ARM64, where r0 is used as an opcode
>>> with the other registers as an argument.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>>> ---
>>>  arch/arm/kernel/hyp-stub.S | 27 ++++++++++++++++++++++-----
>>>  1 file changed, 22 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
>>> index 15d073ae5da2..f3e9ba5fb642 100644
>>> --- a/arch/arm/kernel/hyp-stub.S
>>> +++ b/arch/arm/kernel/hyp-stub.S
>>> @@ -22,6 +22,9 @@
>>>  #include <asm/assembler.h>
>>>  #include <asm/virt.h>
>>>  
>>> +#define HVC_GET_VECTORS 0
>>> +#define HVC_SET_VECTORS 1
>>> +
>>>  #ifndef ZIMAGE
>>>  /*
>>>   * For the kernel proper, we need to find out the CPU boot mode long after
>>> @@ -202,9 +205,19 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
>>>  ENDPROC(__hyp_stub_install_secondary)
>>>  
>>>  __hyp_stub_do_trap:
>>> -	cmp	r0, #-1
>>> -	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
>>> -	mcrne	p15, 4, r0, c12, c0, 0	@ set HVBAR
>>> +	teq	r0, #HVC_GET_VECTORS
>>> +	bne	1f
>>> +	mrc	p15, 4, r0, c12, c0, 0	@ get HVBAR
>>> +	b	__hyp_stub_exit
>>> +
>>> +1:	teq	r0, #HVC_SET_VECTORS
>>> +	bne	1f
>>> +	mcr	p15, 4, r1, c12, c0, 0	@ set HVBAR
>>> +	b	__hyp_stub_exit
>>> +
>>> +1:	mov	r0, #-1
>>> +
>>> +__hyp_stub_exit:
>>>  	__ERET
>>>  ENDPROC(__hyp_stub_do_trap)
>>>  
>>> @@ -231,10 +244,14 @@ ENDPROC(__hyp_stub_do_trap)
>>>   * initialisation entry point.
>>>   */
>>>  ENTRY(__hyp_get_vectors)
>>> -	mov	r0, #-1
>>> +	mov	r0, #HVC_GET_VECTORS
>>
>> This breaks the KVM implementation of __hyp_get_vectors, easily fixed
>> with the following patchlet:
>>
>> diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
>> index a2e75b8..0fe637e 100644
>> --- a/arch/arm/include/asm/virt.h
>> +++ b/arch/arm/include/asm/virt.h
>> @@ -89,6 +89,14 @@ extern char __hyp_text_start[];
>>  extern char __hyp_text_end[];
>>  #endif
>>  
>> +#else
>> +
>> +/* Only assembly code should need those */
>> +
>> +#define HVC_GET_VECTORS 0
>> +#define HVC_SET_VECTORS 1
>> +#define HVC_SOFT_RESTART 2
>> +
>>  #endif /* __ASSEMBLY__ */
>>  
>>  #endif /* ! VIRT_H */
>> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
>> index ebc26f8..1c6888f 100644
>> --- a/arch/arm/kernel/hyp-stub.S
>> +++ b/arch/arm/kernel/hyp-stub.S
>> @@ -22,10 +22,6 @@
>>  #include <asm/assembler.h>
>>  #include <asm/virt.h>
>>  
>> -#define HVC_GET_VECTORS 0
>> -#define HVC_SET_VECTORS 1
>> -#define HVC_SOFT_RESTART 2
>> -
>>  #ifndef ZIMAGE
>>  /*
>>   * For the kernel proper, we need to find out the CPU boot mode long after
>> diff --git a/arch/arm/kvm/hyp/hyp-entry.S b/arch/arm/kvm/hyp/hyp-entry.S
>> index 96beb53..1f8db7d 100644
>> --- a/arch/arm/kvm/hyp/hyp-entry.S
>> +++ b/arch/arm/kvm/hyp/hyp-entry.S
>> @@ -127,7 +127,7 @@ hyp_hvc:
>>  	pop	{r0, r1, r2}
>>  
>>  	/* Check for __hyp_get_vectors */
>> -	cmp	r0, #-1
>> +	cmp	r0, #HVC_GET_VECTORS
>>  	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
>>  	beq	1f
> 
> I don't think this is sufficient - the kdump case for ARM will still be
> broken after these patches.
> 
> The new soft-restart ABI introduced by my patch 2 passes in:
> 
> r0 = HVC_SOFT_RESTART
> r1 = non-zero
> r2 = undefined
> r3 = function pointer
> 
> and the assumption is that r3 will be preserved if the HVC call does
> nothing - which probably isn't a safe assumption.
> 
> With these arguments passed to the KVM stub (which may be in place at
> the point of a kdump), we end up executing this code:
> 
>         push    {lr}
> 
>         mov     lr, r0
>         mov     r0, r1
>         mov     r1, r2
>         mov     r2, r3
> 
> THUMB(  orr     lr, #1)
>         blx     lr                      @ Call the HYP function
> 
> This will result in an attempt to branch to address 2 or 3, which isn't
> sane - a panic in the host kernel (eg due to a NULL pointer deref with
> panic_on_oops enabled) will then cause kdump to try to execute code from
> a stupid address.
> 
> So, we need KVM's stub to be (a) better documented so this stuff is
> obvious, and (b) updated so that kdump stands a chance of working even
> if the KVM stub is still in place at the point the host kernel panics.
> 
> Another reason why documentation is important here is that we need to
> make it clear to alternative hypervisors that the host kernel may issue
> a HVC call at any moment due to a crash with particular arguments, and
> that the host kernel expects a certain behaviour in that case, and that
> the hypervisor does not crash.
> 
> For example, how will Xen behave - is introducing these changes going
> to cause a regression with Xen?  Does anyone even know the answer to
> that?  From what I can see, it seems we'll end up calling Xen's
> hypervisor with a random r12 value (which it uses as a reason code)
> but without the 0xea1 immediate constant in the HVC instruction.
> Beyond that, I've no idea.

I fail to see why you would issue a hyp stub hypercall if you're booted
under *any* hypervisor. The only way you can have a valid hyp stub is
because the kernel was booted at EL2/HYP. If you're running under Xen,
KVM or whatever other hypervisor, you're booted at EL1/SVC, you only
have the hypercall API exposed by that hypervisor, and nothing else. You
can't even install the stub the first place.

So any code path that tries to tear down KVM would better check that the
kernel was entered at HYP. If it doesn't, it is broken.

	M.
-- 
Jazz is not dead. It just smells funny...
