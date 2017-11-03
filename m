From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri, 3 Nov 2017 13:53:51 -0400
Subject: [PATCH v16 09/13] arch/arm64: enable task isolation functionality
In-Reply-To: <20171103173203.h7y7c65r4ml6r2jm@lakrids.cambridge.arm.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
 <1509728692-10460-10-git-send-email-cmetcalf@mellanox.com>
 <20171103173203.h7y7c65r4ml6r2jm@lakrids.cambridge.arm.com>
Message-ID: <a71932dc-c232-a1ca-3fbc-09af1f8f77b0@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/3/2017 1:32 PM, Mark Rutland wrote:
> Hi Chris,
>
> On Fri, Nov 03, 2017 at 01:04:48PM -0400, Chris Metcalf wrote:
>> In do_notify_resume(), call task_isolation_start() for
>> TIF_TASK_ISOLATION tasks.  Add _TIF_TASK_ISOLATION to _TIF_WORK_MASK,
>> and define a local NOTIFY_RESUME_LOOP_FLAGS to check in the loop,
>> since we don't clear _TIF_TASK_ISOLATION in the loop.
>>
>> We tweak syscall_trace_enter() slightly to carry the "flags"
>> value from current_thread_info()->flags for each of the tests,
>> rather than doing a volatile read from memory for each one.  This
>> avoids a small overhead for each test, and in particular avoids
>> that overhead for TIF_NOHZ when TASK_ISOLATION is not enabled.
>>
>> We instrument the smp_send_reschedule() routine so that it checks for
>> isolated tasks and generates a suitable warning if needed.
>>
>> Finally, report on page faults in task-isolation processes in
>> do_page_faults().
> I don't have much context for this (I only received patches 9, 10, and
> 12), and this commit message doesn't help me to understand why these
> changes are necessary.

Sorry, I missed having you on the cover letter.? I'll fix that for the 
next spin.
The cover letter (and rest of the series) is here:

https://lkml.org/lkml/2017/11/3/589

The core piece of the patch is here:

https://lkml.org/lkml/2017/11/3/598

> Here we add to _TIF_WORK_MASK...
> [...]
> ... and here we open-code the *old* _TIF_WORK_MASK.
>
> Can we drop both in <asm/thread_info.h>, building one in terms of the
> other:
>
> #define _TIF_WORK_NOISOLATION_MASK					\
> 	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |  _TIF_NOTIFY_RESUME |	\
> 	 _TIF_FOREIGN_FPSTATE | _TIF_UPROBE | _TIF_FSCHECK)
>
> #define _TIF_WORK_MASK							\
> 	(_TIF_WORK_NOISOLATION_MASK | _TIF_TASK_ISOLATION)
>
> ... that avoids duplication, ensuring the two are kept in sync, and
> makes it a little easier to understand.

We certainly could do that.? I based my approach on the x86 model,
which defines _TIF_ALLWORK_MASK in thread_info.h, and then a local
EXIT_TO_USERMODE_WORK_FLAGS above exit_to_usermode_loop().

If you'd prefer to avoid the duplication, perhaps names more like this?

_TIF_WORK_LOOP_MASK (without TIF_TASK_ISOLATION)
_TIF_WORK_MASK as _TIF_WORK_LOOP_MASK | _TIF_TASK_ISOLATION

That keeps the names reflective of the function (entry only vs loop).

>> @@ -818,6 +819,7 @@ void arch_send_call_function_single_ipi(int cpu)
>>   #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
>>   void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
>>   {
>> +	task_isolation_remote_cpumask(mask, "wakeup IPI");
> What exactly does this do? Is it some kind of a tracepoint?

It is intended to generate a diagnostic for a remote task that is
trying to run isolated from the kernel (NOHZ_FULL on steroids, more
or less), if the kernel is about to interrupt it.

Similarly, the task_isolation_interrupt() hooks are diagnostics for
the current task.? The intent is that by hooking a little deeper in
the call path, you get actionable diagnostics for processes that are
about to be signalled because they have lost task isolation for some
reason.

>> @@ -495,6 +496,10 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>>   	 */
>>   	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
>>   			      VM_FAULT_BADACCESS)))) {
>> +		/* No signal was generated, but notify task-isolation tasks. */
>> +		if (user_mode(regs))
>> +			task_isolation_interrupt("page fault at %#lx", addr);
> What exactly does the task receive here? Are these strings ABI?
>
> Do we need to do this for *every* exception?

The strings are diagnostic messages; the process itself just gets
a SIGKILL (or user-defined signal if requested).? To provide better
diagnosis we emit a log message that can be examined to see
what exactly caused the signal to be generated.

Thanks!

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
