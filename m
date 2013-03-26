From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 26 Mar 2013 11:56:33 +0000
Subject: [PATCH v9 2/3] ARM: ARMv7-M: Add support for exception handling
In-Reply-To: <20130326101508.GG20530@pengutronix.de>
References: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1363901310-9474-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <51509C83.5000907@arm.com> <20130326101508.GG20530@pengutronix.de>
Message-ID: <51518CF1.8090008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 26/03/13 10:15, Uwe Kleine-K?nig wrote:
> Hi Jonny,
>
> On Mon, Mar 25, 2013 at 06:50:43PM +0000, Jonathan Austin wrote:
>> On 21/03/13 21:28, Uwe Kleine-K?nig wrote:
>>> This patch implements the exception handling for the ARMv7-M
>>> architecture (pretty different from the A or R profiles).
>>>
[...]
>>> +	ldmia	r9!, {r8, r10-r12}
>>> +
>>> +	@ calculate the original stack pointer value.
>>> +	@ r9 currently points to the memory location just above the auto saved
>>> +	@ xPSR.
>>> +	@ The cpu might automatically 8-byte align the stack. Bit 9
>>> +	@ of the saved xPSR specifies if stack aligning took place. In this case
>>> +	@ another 32-bit value is included in the stack.
>>> +
>>> +	tst	r12, V7M_xPSR_FPALIGN
>>
>> Minor nit, but we should explain the relationship to FP and bit 9 of
>> the xPSR if we're going to call it this... (see B1.5.7 --Note--)
> This doesn't have anything to do with FP as in floating point. In
> ARMARMv7M I didn't fine a mnemonic for this bit, so I used FPALIGN
> modelled after the variable "frameptralign" in the PushStack()
> pseudocode function. Maybe better use V7M_xPSR_FRAMEPTRALIGN? Or does
> there exist an official name that I just didn't manage to find?

Heh, I read this
"On an implementation that includes the FP extension, if software 
enables automatic FP state preservation on exception entry, that state 
preservation enforces 8-byte stack alignment, ignoring the CCR.STKALIGN
bit value"

and assumed you had said "Floating point stack saving guarantees 8-byte 
alignment so when it is 8-byte aligned it is like the floating-point 
case" :)

So, I'd definitely use FRAMEPTRALIGN!


>
>> Otherwise the casual reader is confused by why FP suddenly ended up
>> in here :)
>>
>>> +	addne	r9, r9, #4
>>> +
>>> +	@ store saved r12 using str to have a register to hold the base for stm
>>> +	str	r8, [sp, #S_IP]
>>> +	add	r8, sp, #S_SP
>>> +	@ store r13-r15, xPSR
>>> +	stmia	r8!, {r9-r12}
>>> +	@ store old_r0
>>> +	str	r0, [r8]
>>> +	.endm
>>> +
>>> +
>>> +/*
>>> + * We won't return to kernel space here because a kernel thread runs in SVCALL
>>> + * context and so cannot be preempted by PENDSV.
>>> + */
>>
>> The reason we can't return to kernel space isn't the context we're
>> in, but rather the priority we set for the exceptions... (both at
>> the same priority => can't preempt each other)
> Well, it's both isn't it? A kernel thread has execution priority of
> SVCALL. As PENDSV and SVCALL are configured to the same priority a
> kernel thread is never preempted. I'll make it:
>
> 	/*
> 	 * PENDSV and SVCALL have the same exception priorities. As a
> 	 * kernel thread runs at SVCALL execution priority it can never
> 	 * be preempted and so we will never have to return to a kernel
> 	 * thread here.
> 	 */
> 	
> Better?

Yea, perhaps just tweak to add that we *control* the priorities - IE it 
is us that have set them to be the same...

>
>>> +	.macro	v7m_exception_slow_exit ret_r0
>>> +	cpsid	i
>>> +	ldr	lr, =EXC_RET_THREADMODE_PROCESSSTACK
>>> +
>>> +	@ read original r12, sp, lr, pc and xPSR
>>> +	add	r12, sp, #S_IP
>>> +	ldmia	r12, {r1-r5}
>>> +
>>> +	@ an exception frame is always 8-byte aligned. To tell the hardware if
>>> +	@ the sp to be restored is aligned or not set bit 9 of the saved xPSR
>>> +	@ accordingly.
>>
>> Does this comment make sense? I can't make much of it, because it
>> says that the exception frame is always 8-byte aligned by then
>> checks to see if it is...
> The exception frame must be aligned, the restored value of sp not
> necessarily. Depending on bit 9 of the xPSR saved in the exception frame
> sp is restored to point to either directly over the exception frame or
> if there is an additional reserved word. See B1.5.7.
>

Yea, that full explanation is better.
The ARM ARM has quite a clear description, actually:

On an exception return when CCR.STKALIGN is set to 1, the processor uses 
the value of bit [9] of the PSR value popped from the stack to determine 
whether it must adjust the stack pointer alignment. This reverses any 
forced stack alignment performed on the exception entry.

Something of that going in to your comment would be good.

>>> +	tst	r2, #4
>>> +	subne	r2, r2, #4
>>> +	orrne	r5, V7M_xPSR_FPALIGN
>>> +	biceq	r5, V7M_xPSR_FPALIGN
>>> +
>>
>> As we've discussed a bit already on IRC, I don't think we need to
>> test the stack pointer here and modify r5, we should be able to use
>> the saved xPSR value. This is a pretty hot path and I think we're
>> better tp have fewer instructions!
>>
>> As far as I can see, if sp's alignment here is different to what it
>> was when we took the exception, we either have a bug (some code
>> hasn't respected the stack), or someone's interfered externally and
>> is about to cause a bug.
>>
>> What use cases do you think we are adding this test for? If it is
>> just people manually modifying sp with debuggers then I'd really
>> rather not have it.
> I don't really have a scenario in mind that makes this fix here
> necessary. It's more that I think the two instructions are cheap enough
> to stick to a defensive coding style.

I've just talked through this with Catalin in detail. If we don't modify 
r5 we can just bic r2 in order to ensure alignment (either it was 
aligned before, the bic does nothing and r5 is already correct, or it 
wasn't aligned before, we make it aligned and r5 is also still correct)

Does that seem right to you? It still gives you the chance to have the 
sp modified by some debug stuff, but assumes that nothing will modify 
the saved version of xPSR on the stack, which I think is a safe assumption.

>
>> ...
>>> +#ifdef CONFIG_CPU_V7M
>>> +	.macro	restore_user_regs, fast = 0, offset = 0
>>> +	@ XXX: clrex?
>>
>> As we've discussed, above, I don't think this is required... It is
>> also fine to have it, but definitely remove the @XXX before putting
>> in next.
>>
>> Also perhaps replace this XXX comment with one explaining that
>> exception return guarantees the monitor is cleared? Otherwise
>> someone reading the code and comparing V7M with V7 might wonder
>> where the clrex went.
> ack
>
>> ...
>>> +	.align	2
>>> +__irq_entry:
>>> +	v7m_exception_entry
>>> +
>>> +	@
>>> +	@ Invoke the IRQ handler
>>> +	@
>>> +	mrs	r0, ipsr
>>> +	ldr	r1, =0x1ff
>>
>> Did this mask not get defined in v7m.h for a reason?
> Yeah, the reason is I missed it :-) Will fix that for the next
> iteration.
>

Cool - looking forward to it...

Thanks,
Jonny
