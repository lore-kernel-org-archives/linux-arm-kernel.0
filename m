From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 18 Jun 2015 16:49:36 -0700
Subject: [PATCH v2 2/2] arm: KVM: keep arm vfp/simd exit handling
 consistent with arm64
In-Reply-To: <5582FF76.6060100@arm.com>
References: <1434491452-19177-1-git-send-email-m.smarduch@samsung.com>
 <1434491452-19177-3-git-send-email-m.smarduch@samsung.com>
 <5582FF76.6060100@arm.com>
Message-ID: <55835910.3060601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2015 10:27 AM, Marc Zyngier wrote:
> On 16/06/15 22:50, Mario Smarduch wrote:
>> After enhancing arm64 FP/SIMD exit handling, FP/SIMD exit branch is moved
>> to guest trap handling. This keeps exiting handling flow between both
>> architectures consistent.
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/kvm/interrupts.S |   12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index 79caf79..fca2c56 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -363,10 +363,6 @@ hyp_hvc:
>>  	@ Check syndrome register
>>  	mrc	p15, 4, r1, c5, c2, 0	@ HSR
>>  	lsr	r0, r1, #HSR_EC_SHIFT
>> -#ifdef CONFIG_VFPv3
>> -	cmp	r0, #HSR_EC_CP_0_13
>> -	beq	switch_to_guest_vfp
>> -#endif
>>  	cmp	r0, #HSR_EC_HVC
>>  	bne	guest_trap		@ Not HVC instr.
>>  
>> @@ -406,6 +402,12 @@ THUMB(	orr	lr, #1)
>>  1:	eret
>>  
>>  guest_trap:
>> +#ifdef CONFIG_VFPv3
>> +	/* Guest accessed VFP/SIMD registers, save host, restore Guest */
>> +	cmp	r0, #HSR_EC_CP_0_13
>> +	beq	switch_to_guest_fpsimd
>> +#endif
>> +
>>  	load_vcpu			@ Load VCPU pointer to r0
>>  	str	r1, [vcpu, #VCPU_HSR]
>>  
>> @@ -478,7 +480,7 @@ guest_trap:
>>   * inject an undefined exception to the guest.
>>   */
>>  #ifdef CONFIG_VFPv3
>> -switch_to_guest_vfp:
>> +switch_to_guest_fpsimd:
> 
> Ah, I think I managed to confuse you in my previous comment.
> On ARMv7, we call the floating point stuff VFP.
> On ARMv8, we call it FP/SIMD.

Ah I see, I'll update.
> 
> Not very consistent, I know...
> 
>>  	load_vcpu			@ Load VCPU pointer to r0

How about move it here - then it does not stick out like
before.

guest_trap:
        load_vcpu                       @ Load VCPU pointer to r0
        str     r1, [vcpu, #VCPU_HSR]

        @ Check if we need the fault information
        lsr     r1, r1, #HSR_EC_SHIFT
#ifdef CONFIG_VFPv3
        /* Guest accessed VFP/SIMD registers, save host, restore Guest */
        cmp     r1, #HSR_EC_CP_0_13
        beq     switch_to_guest_vfp
#endif


Regarding "host_switch_to_hyp:" it has no reference but appears
like a clean separator, that's on purpose?

Thanks

> 
> It would be interesting to find out if we can make this load_vcpu part
> of the common sequence (without spilling another register, of course).
> Probably involves moving the exception class to r2.
> 
> Thanks,
> 
> 	M.
> 
