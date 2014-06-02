From: rric@kernel.org (Robert Richter)
Date: Mon, 2 Jun 2014 10:05:34 +0200
Subject: [PATCH v2 2/7] ARM: Introduce arm_get_current_stack_frame()
In-Reply-To: <1401469191-29232-3-git-send-email-nikolay.borisov@arm.com>
References: <1401469191-29232-1-git-send-email-nikolay.borisov@arm.com>
 <1401469191-29232-3-git-send-email-nikolay.borisov@arm.com>
Message-ID: <20140602080534.GY27560@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.05.14 17:59:46, Nikolay Borisov wrote:
> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index c877654..601264d 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -84,6 +84,12 @@ static inline long regs_return_value(struct pt_regs *regs)
>  
>  #define instruction_pointer(regs)	(regs)->ARM_pc
>  
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define frame_pointer(regs) (regs)->ARM_r7
> +#else
> +#define frame_pointer(regs) (regs)->ARM_fp
> +#endif
> +
>  static inline void instruction_pointer_set(struct pt_regs *regs,
>  					   unsigned long val)
>  {
> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
> index 4d0a164..6a5b13e 100644
> --- a/arch/arm/include/asm/stacktrace.h
> +++ b/arch/arm/include/asm/stacktrace.h
> @@ -2,12 +2,24 @@
>  #define __ASM_STACKTRACE_H
>  
>  struct stackframe {
> +	/* FP member should hold R7 when CONFIG_THUMB2_KERNEL is enabled.
> +	 * and R11 otherwise
> +	 */
>  	unsigned long fp;
>  	unsigned long sp;
>  	unsigned long lr;
>  	unsigned long pc;
>  };
>  
> +static __always_inline
> +void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
> +{
> +		frame->fp = frame_pointer(regs);

stacktrace.h should now include asm/ptrace.h.

Otherwise

Acked-by: Robert Richter <rric@kernel.org>

for patch 2 and 7 of this series.

-Robert

> +		frame->sp = regs->ARM_sp;
> +		frame->lr = regs->ARM_lr;
> +		frame->pc = regs->ARM_pc;
> +}
