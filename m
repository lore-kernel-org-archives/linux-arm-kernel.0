From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Oct 2014 10:25:04 +0000
Subject: [PATCHv4 1/7] arm64: Treat handle_arch_irq as a function pointer
In-Reply-To: <1414440752-9411-2-git-send-email-lauraa@codeaurora.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141028102503.GA9796@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 08:12:26PM +0000, Laura Abbott wrote:
> handle_arch_irq isn't actually text, it's just a function pointer.
> It doesn't need to be stored in the text section and doing so
> causes problems if we ever want to make the kernel text read only.
> Declare handle_arch_irq as a proper function pointer stored in
> the data section.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

This looks good to me, compiles cleanly on v3.18-rc2, and my Juno
continues to boot, so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> v4: style comments
> ---
>  arch/arm64/include/asm/irq.h | 1 -
>  arch/arm64/kernel/entry.S    | 6 ++----
>  arch/arm64/kernel/irq.c      | 2 ++
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index e1f7ecd..1eebf5b 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -3,7 +3,6 @@
>  
>  #include <asm-generic/irq.h>
>  
> -extern void (*handle_arch_irq)(struct pt_regs *);
>  extern void migrate_irqs(void);
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
>  
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 726b910..ee27f39 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -168,7 +168,8 @@ tsk	.req	x28		// current thread_info
>   * Interrupt handling.
>   */
>  	.macro	irq_handler
> -	ldr	x1, handle_arch_irq
> +	adrp	x1, handle_arch_irq
> +	ldr	x1, [x1, #:lo12:handle_arch_irq]
>  	mov	x0, sp
>  	blr	x1
>  	.endm
> @@ -695,6 +696,3 @@ ENTRY(sys_rt_sigreturn_wrapper)
>  	mov	x0, sp
>  	b	sys_rt_sigreturn
>  ENDPROC(sys_rt_sigreturn_wrapper)
> -
> -ENTRY(handle_arch_irq)
> -	.quad	0
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 071a6ec..240b75c 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -40,6 +40,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>  	return 0;
>  }
>  
> +void (*handle_arch_irq)(struct pt_regs *) = NULL;
> +
>  void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  {
>  	if (handle_arch_irq)
> -- 
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> 
> 
