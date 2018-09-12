From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 12 Sep 2018 14:07:16 +0100
Subject: [PATCH v5 06/27] arm64: Delay daif masking for user return
In-Reply-To: <59fa96d5-6bfa-c3aa-94d6-5941a7576bfa@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-7-git-send-email-julien.thierry@arm.com>
 <59fa96d5-6bfa-c3aa-94d6-5941a7576bfa@arm.com>
Message-ID: <a206ae6a-e615-96bd-7f9b-90691cd7af8f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 12/09/18 11:31, James Morse wrote:
> Hi Julien,
> 
> On 28/08/18 16:51, Julien Thierry wrote:
>> Masking daif flags is done very early before returning to EL0.
>>
>> Only toggle the interrupt masking while in the vector entry and mask daif
>> once in kernel_exit.
> 
> I had an earlier version that did this, but it showed up as a performance
> problem. commit 8d66772e869e ("arm64: Mask all exceptions during kernel_exit")
> described it as:
> |    Adding a naked 'disable_daif' to kernel_exit causes a performance problem
> |    for micro-benchmarks that do no real work, (e.g. calling getpid() in a
> |    loop). This is because the ret_to_user loop has already masked IRQs so
> |    that the TIF_WORK_MASK thread flags can't change underneath it, adding
> |    disable_daif is an additional self-synchronising operation.
> |
> |    In the future, the RAS APEI code may need to modify the TIF_WORK_MASK
> |    flags from an SError, in which case the ret_to_user loop must mask SError
> |    while it examines the flags.
> 
> 
> We may decide that the benchmark is silly, and we don't care about this. (At the
> time it was easy enough to work around).
> 
> We need regular-IRQs masked when we read the TIF flags, and to stay masked until
> we return to user-space.
> I assume you're changing this so that psuedo-NMI are unmasked for EL0 until
> kernel_exit.
> 

Yes.

> I'd like to be able to change the TIF flags from the SError handlers for RAS,
> which means masking SError for do_notify_resume too. (The RAS code that does
> this doesn't exist today, so you can make this my problem to work out later!)
> I think we should have psuedo_NMI masked if SError is masked too.
> 

Yes, my intention in the few daif changes was that PseudoNMI would have 
just a little bit more priority than interrupt:

Debug > Abort > FIQ (not used) > NMI (PMR masked, PSR.I == 0) > IRQ 
(daif + PMR cleared)

So if at any point I break this just shout. (I did that change because 
currently el0_error has everything enabled before returning).

> 
> Is there a strong reason for having psuedo-NMI unmasked during
> do_notify_resume(), or is it just for having the maximum amount of code exposed?
> 

As you suspected, this is to have the maximum amount of code exposed to 
Pseudo-NMIs.

Since it is not a strong requirement for Pseudo-NMI, if the perf issue 
is more important I can drop the patch for now. Although it would be 
useful to have other opinions to see what makes the most sense.

Thanks,

> 
> Thanks,
> 
> James
> 
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 09dbea22..85ce06ac 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -259,9 +259,9 @@ alternative_else_nop_endif
>>   	.endm
>>   
>>   	.macro	kernel_exit, el
>> -	.if	\el != 0
>>   	disable_daif
>>   
>> +	.if	\el != 0
>>   	/* Restore the task's original addr_limit. */
>>   	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
>>   	str	x20, [tsk, #TSK_TI_ADDR_LIMIT]
>> @@ -896,7 +896,7 @@ work_pending:
>>    * "slow" syscall return path.
>>    */
>>   ret_to_user:
>> -	disable_daif
>> +	disable_irq				// disable interrupts
>>   	ldr	x1, [tsk, #TSK_TI_FLAGS]
>>   	and	x2, x1, #_TIF_WORK_MASK
>>   	cbnz	x2, work_pending
>>
> 

-- 
Julien Thierry
