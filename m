From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 14:31:06 +0000
Subject: [PATCH v8 2/4] arm64: Modify stack trace and dump for use with
 irq_stack
In-Reply-To: <1449226948-14251-3-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-3-git-send-email-james.morse@arm.com>
Message-ID: <20151204143106.GM10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 11:02:26AM +0000, James Morse wrote:
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index 8e8d30684392..e2f3f135a3bc 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
[...]
> +static inline bool on_irq_stack(unsigned long sp, int cpu)
> +{
> +	/* variable names the same as kernel/stacktrace.c */
> +	unsigned long low = (unsigned long)per_cpu(irq_stack, cpu);
> +	unsigned long high = low + IRQ_STACK_START_SP;
> +
> +	return (low <= sp && sp <= high);
> +}
> +
> +#endif /* !__ASSEMBLER__ */
>  #endif
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 9f17ec071ee0..1e3cef578e21 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
[...]
> @@ -39,17 +40,41 @@ int notrace unwind_frame(struct stackframe *frame)
>  {
>  	unsigned long high, low;
>  	unsigned long fp = frame->fp;
> +	unsigned long irq_stack_ptr;
> +
> +	/*
> +	 * Use raw_smp_processor_id() to avoid false-positives from
> +	 * CONFIG_DEBUG_PREEMPT. get_wchan() calls unwind_frame() on sleeping
> +	 * task stacks, we can be pre-empted in this case, so
> +	 * {raw_,}smp_processor_id() may give us the wrong value. Sleeping
> +	 * tasks can't ever be on an interrupt stack, so regardless of cpu,
> +	 * the checks will always fail.
> +	 */
> +	irq_stack_ptr = IRQ_STACK_PTR(raw_smp_processor_id());
>  
>  	low  = frame->sp;
> -	high = ALIGN(low, THREAD_SIZE);
> +	/* irq stacks are not THREAD_SIZE aligned */
> +	if (on_irq_stack(frame->sp, raw_smp_processor_id()))
> +		high = irq_stack_ptr;
> +	else
> +		high = ALIGN(low, THREAD_SIZE) - 0x20;

More of a nitpick: if you rework patch 4, you can remove on_irq_stack()
here, just expand it inline (and avoid IRQ_STACK_PTR twice, though
that's pretty cheap).

Either way:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
