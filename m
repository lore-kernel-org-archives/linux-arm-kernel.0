From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Nov 2011 17:24:29 +0000
Subject: [PATCH 3/3] ARM: support syscall tracing
In-Reply-To: <1322584095-30439-4-git-send-email-stevenrwalter@gmail.com>
References: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
 <1322584095-30439-4-git-send-email-stevenrwalter@gmail.com>
Message-ID: <20111129172429.GB1104@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 04:28:15PM +0000, Steven Walter wrote:
> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
> index 2c04ed5..1f23923 100644
> --- a/arch/arm/include/asm/unistd.h
> +++ b/arch/arm/include/asm/unistd.h
> @@ -403,6 +403,8 @@
>  #define __NR_sendmmsg			(__NR_SYSCALL_BASE+374)
>  #define __NR_setns			(__NR_SYSCALL_BASE+375)
>  
> +#define NR_syscalls (__NR_setns+1)

[...]

> -	.equ NR_syscalls,0
> -#define CALL(x) .equ NR_syscalls,NR_syscalls+1
> +	.equ NR_syscalls_asm,0
> +#define CALL(x) .equ NR_syscalls_asm,NR_syscalls_asm+1

If we need to have two definitions of NR_syscalls, then it's probably best
to define one in terms of the other to ensure they are consistent.
Unfortunately, it looks like we calculate NR_syscalls recursively from the
syscall table. Perhaps you'd be better off with just the #define and have a
sanity check on the table size using that.

> -	tst	r10, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
> +	tst	r10, #_TIF_SYSCALL_TRACE	@ are we tracing syscalls?
> +	tsteq	r10, #_TIF_SYSCALL_TRACEPOINT
>  	bne	__sys_trace

Maybe you could macroise this pattern.

> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 1411848..0e2699a 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -28,6 +28,9 @@
>  #include <asm/system.h>
>  #include <asm/traps.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/syscalls.h>

[...]

> @@ -939,11 +942,20 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
>  
>  	current_thread_info()->syscall = scno;
>  
> -	if (why == 0) {
> -		if (tracehook_report_syscall_entry(regs))
> -			current_thread_info()->syscall = -1;
> -	} else {
> -		tracehook_report_syscall_exit(regs, 0);

Wait - didn't you just add this code?

Will
