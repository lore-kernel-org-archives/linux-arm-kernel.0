From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Wed, 16 Mar 2016 14:19:58 -0400
Subject: [PATCH v11 12/13] arm64: factor work_pending state machine to C
In-Reply-To: <1457734223-26209-13-git-send-email-cmetcalf@mellanox.com>
References: <1457734223-26209-1-git-send-email-cmetcalf@mellanox.com>
 <1457734223-26209-13-git-send-email-cmetcalf@mellanox.com>
Message-ID: <56E9A3CE.2040209@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just wanted to ping this one part of the patch series that hopefully
could be picked up in time for the 4.6 rc1 merge window, even if
the rest of the patch series ends up taking longer to get through.
Will, does that seem like something worth trying to do?

I'm hoping that the performance issues you saw with Mark's
original patch are improved with this version, which still tests
the TIF flags prior to calling out to the loop in C code.

Thanks!

On 03/11/2016 05:10 PM, Chris Metcalf wrote:
> Currently ret_fast_syscall, work_pending, and ret_to_user form an ad-hoc
> state machine that can be difficult to reason about due to duplicated
> code and a large number of branch targets.
>
> This patch factors the common logic out into the existing
> do_notify_resume function, converting the code to C in the process,
> making the code more legible.
>
> This patch tries to closely mirror the existing behaviour while using
> the usual C control flow primitives. As local_irq_{disable,enable} may
> be instrumented, we balance exception entry (where we will almost most
> likely enable IRQs) with a call to trace_hardirqs_on just before the
> return to userspace.
>
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> ---
>   arch/arm64/kernel/entry.S  | 12 ++++--------
>   arch/arm64/kernel/signal.c | 36 ++++++++++++++++++++++++++----------
>   2 files changed, 30 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 1f7f5a2b61bf..966d0d4308f2 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -674,18 +674,13 @@ ret_fast_syscall_trace:
>    * Ok, we need to do extra processing, enter the slow path.
>    */
>   work_pending:
> -	tbnz	x1, #TIF_NEED_RESCHED, work_resched
> -	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
>   	mov	x0, sp				// 'regs'
> -	enable_irq				// enable interrupts for do_notify_resume()
>   	bl	do_notify_resume
> -	b	ret_to_user
> -work_resched:
>   #ifdef CONFIG_TRACE_IRQFLAGS
> -	bl	trace_hardirqs_off		// the IRQs are off here, inform the tracing code
> +	bl	trace_hardirqs_on		// enabled while in userspace
>   #endif
> -	bl	schedule
> -
> +	ldr	x1, [tsk, #TI_FLAGS]		// re-check for single-step
> +	b	finish_ret_to_user
>   /*
>    * "slow" syscall return path.
>    */
> @@ -694,6 +689,7 @@ ret_to_user:
>   	ldr	x1, [tsk, #TI_FLAGS]
>   	and	x2, x1, #_TIF_WORK_MASK
>   	cbnz	x2, work_pending
> +finish_ret_to_user:
>   	enable_step_tsk x1, x2
>   	kernel_exit 0
>   ENDPROC(ret_to_user)
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index e18c48cb6db1..1f172f8afe47 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -402,15 +402,31 @@ static void do_signal(struct pt_regs *regs)
>   asmlinkage void do_notify_resume(struct pt_regs *regs,
>   				 unsigned int thread_flags)
>   {
> -	if (thread_flags & _TIF_SIGPENDING)
> -		do_signal(regs);
> -
> -	if (thread_flags & _TIF_NOTIFY_RESUME) {
> -		clear_thread_flag(TIF_NOTIFY_RESUME);
> -		tracehook_notify_resume(regs);
> -	}
> -
> -	if (thread_flags & _TIF_FOREIGN_FPSTATE)
> -		fpsimd_restore_current_state();
> +	/*
> +	 * The assembly code enters us with IRQs off, but it hasn't
> +	 * informed the tracing code of that for efficiency reasons.
> +	 * Update the trace code with the current status.
> +	 */
> +	trace_hardirqs_off();
> +	do {
> +		if (thread_flags & _TIF_NEED_RESCHED) {
> +			schedule();
> +		} else {
> +			local_irq_enable();
> +
> +			if (thread_flags & _TIF_SIGPENDING)
> +				do_signal(regs);
> +
> +			if (thread_flags & _TIF_NOTIFY_RESUME) {
> +				clear_thread_flag(TIF_NOTIFY_RESUME);
> +				tracehook_notify_resume(regs);
> +			}
> +
> +			if (thread_flags & _TIF_FOREIGN_FPSTATE)
> +				fpsimd_restore_current_state();
> +		}
>   
> +		local_irq_disable();
> +		thread_flags = READ_ONCE(current_thread_info()->flags);
> +	} while (thread_flags & _TIF_WORK_MASK);
>   }

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
