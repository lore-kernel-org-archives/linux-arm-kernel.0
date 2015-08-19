From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Aug 2015 17:03:20 +0100
Subject: [PATCH] arm64: entry: always restore x0 from the stack on
 syscall return
In-Reply-To: <1439996989-5772-1-git-send-email-will.deacon@arm.com>
References: <1439996989-5772-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150819160320.GI24062@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 04:09:49PM +0100, Will Deacon wrote:
> @@ -613,13 +609,14 @@ ENDPROC(cpu_switch_to)
>   */
>  ret_fast_syscall:
>  	disable_irq				// disable interrupts
> +	str	x0, [sp, #S_X0]			// returned x0
>  	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
>  	and	x2, x1, #_TIF_SYSCALL_WORK
>  	cbnz	x2, ret_fast_syscall_trace
>  	and	x2, x1, #_TIF_WORK_MASK
> -	cbnz	x2, fast_work_pending
> +	cbnz	x2, work_pending
>  	enable_step_tsk x1, x2
> -	kernel_exit 0, ret = 1
> +	kernel_exit 0
>  ret_fast_syscall_trace:
>  	enable_irq				// enable interrupts
>  	b	__sys_trace_return

There is another str x0 in __sys_trace_return which I think we could
remove.

-- 
Catalin
