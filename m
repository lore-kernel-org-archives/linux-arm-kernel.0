From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Aug 2012 17:11:57 +0100
Subject: [PATCH] ARM: support syscall tracing
In-Reply-To: <5029336B.2050305@mentor.com>
References: <5029336B.2050305@mentor.com>
Message-ID: <20120814161157.GJ26070@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wade,

Thanks for the new patch. A few comments inline.

On Mon, Aug 13, 2012 at 06:03:39PM +0100, Wade Farnsworth wrote:
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index af7b0bd..d3e4410 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -154,6 +154,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
>  #define TIF_RESTORE_SIGMASK	20
>  #define TIF_SECCOMP		21
>  #define TIF_SWITCH_MM		22	/* deferred switch_mm */
> +#define TIF_SYSCALL_TRACEPOINT	23
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> @@ -163,6 +164,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>  #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> +#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)

Can you add this to the definition of _TIF_SYSCALL_WORK as well please?

> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 978eac5..51b64c1 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -94,6 +94,15 @@ ENDPROC(ret_from_fork)
>  	.equ NR_syscalls,0
>  #define CALL(x) .equ NR_syscalls,NR_syscalls+1
>  #include "calls.S"
> +
> +/*
> + * Ensure that the system call table is equal to __NR_syscalls,
> + * which is the value the rest of the system sees
> + */
> +.ifne NR_syscalls - __NR_syscalls
> +.error "__NR_syscalls is not equal to the size of the syscall table"
> +.endif
> +
>  #undef CALL
>  #define CALL(x) .long x
>  
> @@ -415,7 +424,8 @@ local_restart:
>  1:
>  #endif
>  
> -	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
> +	tst     r10, #_TIF_SYSCALL_WORK
> +	tsteq   r10, #_TIF_SYSCALL_TRACEPOINT
>  	bne	__sys_trace

Then we don't need this hunk.

> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 3e0fc5f..a2d46ed 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -30,6 +30,9 @@
>  #include <asm/pgtable.h>
>  #include <asm/traps.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/syscalls.h>
> +
>  #define REG_PC	15
>  #define REG_PSR	16
>  /*
> @@ -918,7 +921,8 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
>  {
>  	unsigned long ip;
>  
> -	if (!test_thread_flag(TIF_SYSCALL_TRACE))
> +	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
> +	    !test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		return scno;
>  
>  	current_thread_info()->syscall = scno;
> @@ -930,10 +934,19 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
>  	ip = regs->ARM_ip;
>  	regs->ARM_ip = dir;
>  
> -	if (dir == PTRACE_SYSCALL_EXIT)
> -		tracehook_report_syscall_exit(regs, 0);
> -	else if (tracehook_report_syscall_entry(regs))
> -		current_thread_info()->syscall = -1;
> +	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
> +		if (dir == PTRACE_SYSCALL_EXIT)
> +			tracehook_report_syscall_exit(regs, 0);
> +		else if (tracehook_report_syscall_entry(regs))
> +			current_thread_info()->syscall = -1;
> +	}
> +
> +	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
> +		if (dir == PTRACE_SYSCALL_EXIT)
> +			trace_sys_exit(regs, scno);
> +		else
> +			trace_sys_enter(regs, scno);
> +	}

I reckon the TRACEPOINT stuff would be better off inside the
syscall_trace_{enter,exit} functions. They don't modify the syscall number,
so they can just use the return value from ptrace_syscall_trace before the
audit hook invoked.

Will
