From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri, 8 Jul 2016 11:43:50 -0400
Subject: [PATCH]: arm64: factor work_pending state machine to C
In-Reply-To: <1459877922-15512-13-git-send-email-cmetcalf@mellanox.com>
References: <1459877922-15512-1-git-send-email-cmetcalf@mellanox.com>
 <1459877922-15512-13-git-send-email-cmetcalf@mellanox.com>
Message-ID: <e19d6de0-c754-d53b-3420-16d460a4cb33@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!

I am hopeful that this patch [1] can be picked up for the 4.8 merge window
in the arm64 tree.  As I mentioned in my last patch series that included
this patch [2], I'm hopeful that this version addresses the performance
issues that were seen with Mark's original patch.  This version tests the
TIF flags prior to calling out to the loop in C code.

It makes more sense for it go via the arm64 tree than to wait and go
through the nohz_full tree, I suspect.

Thanks!

[1] https://lkml.kernel.org/g/1459877922-15512-13-git-send-email-cmetcalf at mellanox.com
[2] https://lkml.kernel.org/g/56E9A3CE.2040209 at mellanox.com

On 4/5/2016 1:38 PM, Chris Metcalf wrote:
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
> index 12e8d2bcb3f9..d70a9e44b7d6 100644
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
> index a8eafdbc7cb8..404dd67080b9 100644
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
