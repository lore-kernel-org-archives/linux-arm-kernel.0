From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 17:32:03 +0000
Subject: [PATCH v16 09/13] arch/arm64: enable task isolation functionality
In-Reply-To: <1509728692-10460-10-git-send-email-cmetcalf@mellanox.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
 <1509728692-10460-10-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20171103173203.h7y7c65r4ml6r2jm@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Fri, Nov 03, 2017 at 01:04:48PM -0400, Chris Metcalf wrote:
> In do_notify_resume(), call task_isolation_start() for
> TIF_TASK_ISOLATION tasks.  Add _TIF_TASK_ISOLATION to _TIF_WORK_MASK,
> and define a local NOTIFY_RESUME_LOOP_FLAGS to check in the loop,
> since we don't clear _TIF_TASK_ISOLATION in the loop.
> 
> We tweak syscall_trace_enter() slightly to carry the "flags"
> value from current_thread_info()->flags for each of the tests,
> rather than doing a volatile read from memory for each one.  This
> avoids a small overhead for each test, and in particular avoids
> that overhead for TIF_NOHZ when TASK_ISOLATION is not enabled.
> 
> We instrument the smp_send_reschedule() routine so that it checks for
> isolated tasks and generates a suitable warning if needed.
> 
> Finally, report on page faults in task-isolation processes in
> do_page_faults().

I don't have much context for this (I only received patches 9, 10, and
12), and this commit message doesn't help me to understand why these
changes are necessary.

Some elaboration on what the intended semantics are would be helpful.

[...]

>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>  				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> -				 _TIF_UPROBE | _TIF_FSCHECK)
> +				 _TIF_UPROBE | _TIF_FSCHECK | \
> +				 _TIF_TASK_ISOLATION)

Here we add to _TIF_WORK_MASK...

> @@ -741,6 +742,10 @@ static void do_signal(struct pt_regs *regs)
>  	restore_saved_sigmask();
>  }
>  
> +#define NOTIFY_RESUME_LOOP_FLAGS				     \
> +	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |  _TIF_NOTIFY_RESUME | \
> +	 _TIF_FOREIGN_FPSTATE | _TIF_UPROBE | _TIF_FSCHECK)
> +

... and here we open-code the *old* _TIF_WORK_MASK.

Can we drop both in <asm/thread_info.h>, building one in terms of the
other:

#define _TIF_WORK_NOISOLATION_MASK					\
	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |  _TIF_NOTIFY_RESUME |	\
	 _TIF_FOREIGN_FPSTATE | _TIF_UPROBE | _TIF_FSCHECK)

#define _TIF_WORK_MASK							\
	(_TIF_WORK_NOISOLATION_MASK | _TIF_TASK_ISOLATION)

... that avoids duplication, ensuring the two are kept in sync, and
makes it a little easier to understand.

>  asmlinkage void do_notify_resume(struct pt_regs *regs,
>  				 unsigned int thread_flags)
>  {
> @@ -777,5 +782,8 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>  
>  		local_irq_disable();
>  		thread_flags = READ_ONCE(current_thread_info()->flags);
> -	} while (thread_flags & _TIF_WORK_MASK);
> +	} while (thread_flags & NOTIFY_RESUME_LOOP_FLAGS);
> +
> +	if (thread_flags & _TIF_TASK_ISOLATION)
> +		task_isolation_start();

[...]

> @@ -818,6 +819,7 @@ void arch_send_call_function_single_ipi(int cpu)
>  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
>  void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
>  {
> +	task_isolation_remote_cpumask(mask, "wakeup IPI");

What exactly does this do? Is it some kind of a tracepoint?

As above, I only received patches 9, 10, and 12, so I don't have much
context to go on.

> @@ -879,6 +881,9 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
>  	}
>  
> +	task_isolation_interrupt("IPI type %d (%s)", ipinr,
> +				 ipinr < NR_IPI ? ipi_types[ipinr] : "unknown");
> +
>  	switch (ipinr) {
>  	case IPI_RESCHEDULE:
>  		scheduler_ipi();
> @@ -941,12 +946,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>  
>  void smp_send_reschedule(int cpu)
>  {
> +	task_isolation_remote(cpu, "reschedule IPI");
>  	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>  }
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>  void tick_broadcast(const struct cpumask *mask)
>  {
> +	task_isolation_remote_cpumask(mask, "timer IPI");
>  	smp_cross_call(mask, IPI_TIMER);
>  }
>  #endif

Similarly, I don't know what these are doing.

[...]

> @@ -495,6 +496,10 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	 */
>  	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
>  			      VM_FAULT_BADACCESS)))) {
> +		/* No signal was generated, but notify task-isolation tasks. */
> +		if (user_mode(regs))
> +			task_isolation_interrupt("page fault at %#lx", addr);

What exactly does the task receive here? Are these strings ABI?

Do we need to do this for *every* exception?

Thanks,
Mark.
