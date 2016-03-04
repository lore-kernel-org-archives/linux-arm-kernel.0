From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri, 4 Mar 2016 15:02:47 -0500
Subject: [PATCH v10 11/12] arm64: factor work_pending state machine to C
In-Reply-To: <20160304163814.GD7886@arm.com>
References: <1456949376-4910-1-git-send-email-cmetcalf@ezchip.com>
 <1456949376-4910-12-git-send-email-cmetcalf@ezchip.com>
 <20160304163814.GD7886@arm.com>
Message-ID: <56D9E9E7.9000503@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2016 11:38 AM, Will Deacon wrote:
> Hi Chris,
>
> On Wed, Mar 02, 2016 at 03:09:35PM -0500, Chris Metcalf wrote:
>> Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
>> state machine that can be difficult to reason about due to duplicated
>> code and a large number of branch targets.
>>
>> This patch factors the common logic out into the existing
>> do_notify_resume function, converting the code to C in the process,
>> making the code more legible.
>>
>> This patch tries to closely mirror the existing behaviour while using
>> the usual C control flow primitives. As local_irq_{disable,enable} may
>> be instrumented, we balance exception entry (where we will almost most
>> likely enable IRQs) with a call to trace_hardirqs_on just before the
>> return to userspace.
> [...]
>
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 1f7f5a2b61bf..966d0d4308f2 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -674,18 +674,13 @@ ret_fast_syscall_trace:
>>    * Ok, we need to do extra processing, enter the slow path.
>>    */
>>   work_pending:
>> -	tbnz	x1, #TIF_NEED_RESCHED, work_resched
>> -	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
>>   	mov	x0, sp				// 'regs'
>> -	enable_irq				// enable interrupts for do_notify_resume()
>>   	bl	do_notify_resume
>> -	b	ret_to_user
>> -work_resched:
>>   #ifdef CONFIG_TRACE_IRQFLAGS
>> -	bl	trace_hardirqs_off		// the IRQs are off here, inform the tracing code
>> +	bl	trace_hardirqs_on		// enabled while in userspace
> This doesn't look right to me. We only get here after running
> do_notify_resume, which returns with interrupts disabled.
>
> Do we not instead need to inform the tracing code that interrupts are
> disabled prior to calling do_notify_resume?

I think you are right about the trace_hardirqs_off prior to
calling into do_notify_resume, given Catalin's recent commit to
add it.  I dropped it since I was moving schedule() into C code,
but I suspect we'll see the same problem that Catalin saw with
CONFIG_TRACE_IRQFLAGS without it.  I'll copy the arch/arm approach
and add a trace_hardirqs_off() at the top of do_notify_resume().

The trace_hardirqs_on I was copying from Mark Rutland's earlier patch:

http://permalink.gmane.org/gmane.linux.ports.arm.kernel/467781

I don't know if it's necessary to flag that interrupts are enabled
prior to returning to userspace; it may well not be.  Mark, can you
comment on what led you to add that trace_hardirqs_on?

For now I've left both of them in there.

>> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
>> index e18c48cb6db1..3432e14b7d6e 100644
>> --- a/arch/arm64/kernel/signal.c
>> +++ b/arch/arm64/kernel/signal.c
>> @@ -402,15 +402,29 @@ static void do_signal(struct pt_regs *regs)
>>   asmlinkage void do_notify_resume(struct pt_regs *regs,
>>   				 unsigned int thread_flags)
>>   {
>> -	if (thread_flags & _TIF_SIGPENDING)
>> -		do_signal(regs);
>> +	while (true) {
>> [...]
>> +	}
> This might be easier to read as a do { ... } while.

Yes, and in fact that's how I did it for arch/tile, as the maintainer.
I picked up the arch/x86 version as more canonical to copy.  But I'm
more than happy to do it the other way :-).  Fixed.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
