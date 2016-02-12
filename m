From: james.morse@arm.com (James Morse)
Date: Fri, 12 Feb 2016 13:47:12 +0000
Subject: [PATCH] arm64: make irq_stack_ptr more robust
In-Reply-To: <1455227590-9837-1-git-send-email-yang.shi@linaro.org>
References: <1455227590-9837-1-git-send-email-yang.shi@linaro.org>
Message-ID: <56BDE260.20504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 11/02/16 21:53, Yang Shi wrote:
> Switching between stacks is only valid if we are tracing ourselves while on the
> irq_stack, so it is only valid when in current and non-preemptible context,
> otherwise is is just zeroed off.

Given it was picked up with CONFIG_DEBUG_PREEMPT:

Fixes: 132cd887b5c5 ("arm64: Modify stack trace and dump for use with irq_stack")


> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
>  arch/arm64/kernel/stacktrace.c | 13 ++++++-------
>  arch/arm64/kernel/traps.c      | 11 ++++++++++-
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 12a18cb..d9751a4 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -44,14 +44,13 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  	unsigned long irq_stack_ptr;
>  
>  	/*
> -	 * Use raw_smp_processor_id() to avoid false-positives from
> -	 * CONFIG_DEBUG_PREEMPT. get_wchan() calls unwind_frame() on sleeping
> -	 * task stacks, we can be pre-empted in this case, so
> -	 * {raw_,}smp_processor_id() may give us the wrong value. Sleeping
> -	 * tasks can't ever be on an interrupt stack, so regardless of cpu,
> -	 * the checks will always fail.
> +	 * Switching between stacks is valid when tracing current and in
> +	 * non-preemptible context.
>  	 */
> -	irq_stack_ptr = IRQ_STACK_PTR(raw_smp_processor_id());
> +	if (tsk == current && !preemptible())
> +		irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
> +	else
> +		irq_stack_ptr = 0;
>  
>  	low  = frame->sp;
>  	/* irq stacks are not THREAD_SIZE aligned */
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index cbedd72..7d8db3a 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -146,9 +146,18 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>  static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  {
>  	struct stackframe frame;
> -	unsigned long irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
> +	unsigned long irq_stack_ptr;
>  	int skip;
>  
> +	/*
> +	 * Switching between  stacks is valid when tracing current and in

Nit: Two spaces: "between[ ][ ]stacks"


> +	 * non-preemptible context.
> +	 */
> +	if (tsk == current && !preemptible())
> +		irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
> +	else
> +		irq_stack_ptr = 0;
> +
>  	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
>  
>  	if (!tsk)
> 

Neither file includes 'linux/preempt.h' for the definition of preemptible().
(I can't talk: I should have included smp.h for smp_processor_id())


Acked-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>


Thanks!

James
