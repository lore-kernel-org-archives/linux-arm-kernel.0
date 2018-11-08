From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 8 Nov 2018 12:20:33 +0000
Subject: [PATCH 3/7] arm64: Align stack when taking exception from EL1
In-Reply-To: <20181107215901.GE12248@brain-police>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <1537970184-44348-4-git-send-email-julien.thierry@arm.com>
 <20181107215901.GE12248@brain-police>
Message-ID: <90c99ffd-d744-47d4-2a49-e0e6471572d6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/11/18 21:59, Will Deacon wrote:
> On Wed, Sep 26, 2018 at 02:56:20PM +0100, Julien Thierry wrote:
>> Arm64 SP needs to be aligned to 16 bytes before being used as base address
>> for loads and stores. When taking some valid exceptions from EL1 (e.g. irq,
>> dbg, data abort), there is no guarantee that SP_EL1 was aligned when
>> taking the exception.
>>
>> Pad the stack on EL1 entries when misaligned.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> ---
>>   arch/arm64/include/asm/assembler.h |  9 +++++++++
>>   arch/arm64/kernel/entry.S          | 32 ++++++++++++++++++++++++++++++--
>>   2 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index 0bcc98d..a0a5415 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -701,4 +701,13 @@
>>   .Lyield_out_\@ :
>>   	.endm
>>   
>> +/*
>> + * Echange content of register xt with sp.
> 
> Exchange contents of register Xt with SP
> 
>> + */
>> +	.macro xchg_sp	xt
>> +	add	sp, sp, \xt	// sp' = sp + xt
>> +	sub	\xt, sp, \xt	// xt' = sp' - xt = sp + xt - xt = sp
>> +	sub	sp, sp, \xt	// sp'' = sp' - xt' = sp + xt - sp = xt
>> +	.endm
> 
> Having said that, this is clearly inspired by the code in kernel_ventry for
> dealing with stack overflow, yet the macro you've got here cannot be reused
> there.
> 
> Maybe we're better off only macro-ising:
> 
> 	.macro sp_fetch_add xt
> 	add	sp, sp, \xt
> 	sub	\xt, sp, \xt
> 	.endm
> 
> and then letting the callers handle the rest, or build an swizzle_sp macro
> on top of it?
> 

Hmm, I'll try to do that and see how it looks.

>> +
>>   #endif	/* __ASM_ASSEMBLER_H */
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index fc5842b..8fb66e4 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -59,6 +59,19 @@
>>   	.endr
>>   	.endm
>>   
>> +	.macro force_stack_align
>> +	xchg_sp	x0
>> +	str	x1, [x0] // store x1 far away from S_SP
> 
> So this temporarily trashes pt_regs.regs[0] if the stack is already aligned,
> right? I think that's fine, but we should comment /that/ rather than vaguely
> saying it's far away from S_SP. In fact, having a block comment above this
> macro saying exactly what is clobbered would generally be a good idea (esp
> as you nobble the flags in your next patch).
> 

Is it a big deal to trash pt_regs.regs[0] if the stack is already 
aligned? This is a freshly allocated stack frame, and we expect 
pt_regs.regs[0] to be overwritten afterwards.

I don't mind adding a comment about that, I'm just wondering about the 
relevance of it.

However, I do agree that I should add a comment about what this does 
with pt_regs.sp since the code using that macro needs to be aware of it.

>> +
>> +	// aligned_sp[S_SP] = old_sp
>> +	bic	x1, x0, #0xf	// align down to 16-byte
>> +	str	x0, [x1, #S_SP]
>> +
>> +	ldr	x1, [x0]
>> +	bic	x0, x0, #0xf	// x0 = aligned_sp
>> +	xchg_sp	x0
>> +	.endm
>> +
>>   /*
>>    * Bad Abort numbers
>>    *-----------------
>> @@ -158,6 +171,10 @@ alternative_cb_end
>>   	.if	\regsize == 32
>>   	mov	w0, w0				// zero upper 32 bits of x0
>>   	.endif
>> +	.if	\el != 0
>> +	force_stack_align
>> +	.endif
>> +
>>   	stp	x0, x1, [sp, #16 * 0]
>>   	stp	x2, x3, [sp, #16 * 1]
>>   	stp	x4, x5, [sp, #16 * 2]
>> @@ -184,7 +201,8 @@ alternative_cb_end
>>   	apply_ssbd 1, x22, x23
>>   
>>   	.else
>> -	add	x21, sp, #S_FRAME_SIZE
>> +	ldr	x21, [sp, #S_SP]
>> +	add	x21, x21, #S_FRAME_SIZE		// adjust stored sp
> 
> Can we not just store the corrected SP in force_stack_align, rather than
> store something bogus and then have to add the frame size back here?

We can, it would add 2 instructions to the alignment macro. I think I 
mainly tried to keep the alignment stuff short in case we want to add 
the fast path from the next patch, but if we're keeping it anyway we 
might as well add the code to save the correct SP.

Thanks,

-- 
Julien Thierry
