From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Feb 2012 11:05:23 +0000
Subject: [PATCH 3/3] ARM: support syscall tracing
In-Reply-To: <4F44FFE4.5070708@mentor.com>
References: <4F44FF58.3060907@mentor.com>
 <4F44FFE4.5070708@mentor.com>
Message-ID: <20120224110522.GF13504@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 02:47:00PM +0000, Wade Farnsworth wrote:
> As specified by ftrace-design.txt, TIF_SYSCALL_TRACEPOINT was
> added, as well as NR_syscalls in asm/unistd.h.  Additionally,
> __sys_trace was modified to call trace_sys_enter and
> trace_sys_exit when appropriate.
> 
> Tests #2 - #4 of "perf test" now complete successfully.
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
> ---

[...]

> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
> index 512cd14..e4a2e78 100644
> --- a/arch/arm/include/asm/unistd.h
> +++ b/arch/arm/include/asm/unistd.h
> @@ -405,6 +405,18 @@
>  #define __NR_process_vm_readv		(__NR_SYSCALL_BASE+376)
>  #define __NR_process_vm_writev		(__NR_SYSCALL_BASE+377)
>  
> +#ifdef __KERNEL__
> +
> +/* This may need to be greater than __NR_last_syscall+1 in order to
> + * account for the padding in the syscall table */
> +#define __NR_syscalls  (380)

Do we actually have padding in the syscall table? It looks like a list of
.long to me. I'd rather put the correct number in if possible.

> +#ifndef __ASSEMBLY__
> +#define NR_syscalls (__NR_syscalls)
> +#endif /* __ASSEMBLY__ */

Hmm, these guards feel like a hack. Would moving the define into syscall.h
help?

> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 9fd0ba9..9bed212 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -79,6 +79,11 @@ no_work_pending:
>  ENDPROC(ret_to_user_from_irq)
>  ENDPROC(ret_to_user)
>  
> +.macro test_syscall_tracing reg
> +       tst     \reg, #_TIF_SYSCALL_WORK
> +       tsteq   \reg, #_TIF_SYSCALL_TRACEPOINT
> +.endm
> +
>  /*
>   * This is how we return from a fork.
>   */
> @@ -87,7 +92,7 @@ ENTRY(ret_from_fork)
>  	get_thread_info tsk
>  	ldr	r1, [tsk, #TI_FLAGS]		@ check for syscall tracing
>  	mov	why, #1
> -	tst	r1, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
> +	test_syscall_tracing r1
>  	beq	ret_slow_syscall
>  	mov	r1, sp
>  	mov	r0, #1				@ trace exit [IP = 1]
> @@ -98,6 +103,13 @@ ENDPROC(ret_from_fork)
>  	.equ NR_syscalls,0
>  #define CALL(x) .equ NR_syscalls,NR_syscalls+1
>  #include "calls.S"
> +
> +/* Ensure that the system call table is not larger than __NR_syscalls,
> + * which is the value the rest of the system sees */
> +.ifgt NR_syscalls - __NR_syscalls
> +.error "__NR_syscalls is less than the size of the syscall table"
> +.endif

I think it would also be nice to check for equality here if we can.

Rest of the code looks alright, but it should be tested with OABI if it
hasn't been already.

Will
