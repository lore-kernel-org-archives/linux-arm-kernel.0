From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 19 Sep 2014 10:02:08 -0400
Subject: [RFC] arm: Handle starting up in secure mode
In-Reply-To: <20140918172318.GF25330@e104818-lin.cambridge.arm.com>
References: <1410901756-20694-1-git-send-email-cov@codeaurora.org>
 <20140918172318.GF25330@e104818-lin.cambridge.arm.com>
Message-ID: <541C3760.5040300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 09/18/2014 01:23 PM, Catalin Marinas wrote:
> On Tue, Sep 16, 2014 at 10:09:16PM +0100, Christopher Covington wrote:
>> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
>> index 2a55373..36d1a9c 100644
>> --- a/arch/arm/kernel/hyp-stub.S
>> +++ b/arch/arm/kernel/hyp-stub.S
>> @@ -20,6 +20,7 @@
>>  #include <linux/linkage.h>
>>  #include <asm/assembler.h>
>>  #include <asm/virt.h>
>> +#include <asm/opcodes-sec.h>
>>  
>>  #ifndef ZIMAGE
>>  /*
>> @@ -76,6 +77,64 @@ ENTRY(__boot_cpu_mode)
>>  #endif /* ZIMAGE */
>>  
>>  /*
>> + * Detect whether the system is in secure supervisor mode, and if it is,
>> + * switch to hypervisor mode by way of secure monitor mode.
>> + */
>> +ENTRY(__mon_stub_install)
>> +	mrs	r4, cpsr
>> +	and	r4, r4, #MODE_MASK
>> +	cmp	r4, #SVC_MODE
>> +	movne	pc, lr
>> +
>> +	/*
>> +	 * Set things up so that if an NSACR access causes an undefined
>> +	 * instruction exception, we return. safe_svcmode_maskall called
>> +	 * just after this will get us back into supervisor mode.
>> +	 */
>> +	adr	r4, __mon_stub_vectors
>> +	mcr	p15, 0, r4, c12, c0, 0	@ set vector base address (VBAR)
>> +	mov	r4, lr
>> +
>> +	/*
>> +	 * Writing the NSACR will only succeed if we're in a secure mode.
>> +	 */
>> +	mrc	p15, 0, r5, c1, c1, 2	@ get non-secure access control (NSACR)
>> +	mcr	p15, 0, r5, c1, c1, 2	@ set non-secure access control (NSACR)
> 
> Since you talk about ARMv8 further down, if you run in AArch32 mode in
> secure EL1 it will trap to EL3.

If EL3/MON is A64, yes. If EL3/MON is A32 (the case I care most about for A32
kernels), my simulator experiments and reading of the documentation suggest
the write succeeds. I'll have to make an A64 EL3 test case and see what I can
do about that.

>> +	/*
>> +	 * If we get here, we know we're in secure supervisor mode, so make the
>> +	 * switch to secure monitor mode.
>> +	 *
>> +	 * TODO: make sure this doesn't trap to A64 EL3.
>> +	 */
>> +	adr	r4, __mon_stub_vectors
>> +	mcr	p15, 0, r4, c12, c0, 1	@ set monitor vector base (MVBAR)
>> +	adr	r4, mon_settings
>> +	__SMC(0)
> 
> I think from secure EL1 you can switch to monitor simply by setting the
> CPSR mode bits (though IIRC on ARMv8 would also trap to EL3).
> 
>> +
>> +	/*
>> +	 * Now, from non-secure supervisor mode, transition to hypervisor mode
>> +	 * and return via the exception vector.
>> +	 */
>> +	mov	r4, lr
>> +	__HVC(0)
> 
> From monitor mode can you return directly to HVC mode via ERET and avoid
> another HVC?

I'll experiment with switching modes through [CS]PSR writes.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
