From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Apr 2017 15:22:25 +0100
Subject: [PATCH v6 4/4] arm64/syscalls: Specific usage of
 verify_pre_usermode_state
In-Reply-To: <20170404174727.35478-4-thgarnie@google.com>
References: <20170404174727.35478-1-thgarnie@google.com>
 <20170404174727.35478-4-thgarnie@google.com>
Message-ID: <20170405142225.GA9072@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 10:47:27AM -0700, Thomas Garnier wrote:
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 43512d4d7df2..6d598e7051c3 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -744,6 +744,10 @@ ENDPROC(cpu_switch_to)
>  ret_fast_syscall:
>  	disable_irq				// disable interrupts
>  	str	x0, [sp, #S_X0]			// returned x0
> +	ldr	x2, [tsk, #TSK_TI_ADDR_LIMIT]	// check addr limit change
> +	mov	x1, #TASK_SIZE_64
> +	cmp	x2, x1
> +	b.ne	addr_limit_fail

KERNEL_DS is set to the maximum address (-1UL), so it would be easier to
check against this here and avoid a "mov". Even simpler if you'd check
against bit 63 of the address for KERNEL_DS:

	ldr	x1, [tsk, TSK_TI_ADDR_LIMIT]	// check addr limit change
	tbnz	x1, #63, addr_limit_fail	// KERNEL_DS is -1UL

>  	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
>  	and	x2, x1, #_TIF_SYSCALL_WORK
>  	cbnz	x2, ret_fast_syscall_trace
> @@ -771,6 +775,11 @@ work_pending:
>   */
>  ret_to_user:
>  	disable_irq				// disable interrupts
> +	ldr	x2, [tsk, #TSK_TI_ADDR_LIMIT]	// check addr limit change
> +	mov	x1, #TASK_SIZE_64
> +	cmp	x2, x1
> +	b.ne	addr_limit_fail

Same here.

> +
>  	ldr	x1, [tsk, #TSK_TI_FLAGS]
>  	and	x2, x1, #_TIF_WORK_MASK
>  	cbnz	x2, work_pending
> @@ -779,6 +788,12 @@ finish_ret_to_user:
>  	kernel_exit 0
>  ENDPROC(ret_to_user)
>  
> +addr_limit_fail:
> +	stp	x0, lr, [sp,#-16]!
> +	bl	asm_verify_pre_usermode_state
> +	ldp	x0, lr, [sp],#16
> +	ret	lr

Where is this supposed to return? What is the value of lr when branching
to addr_limit_fail?

-- 
Catalin
