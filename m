From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Aug 2012 17:21:57 +0100
Subject: [PATCH v2] ARM: support syscall tracing
In-Reply-To: <502BBCCC.1020006@mentor.com>
References: <502BBCCC.1020006@mentor.com>
Message-ID: <20120815162157.GJ29448@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wade,

On Wed, Aug 15, 2012 at 04:14:20PM +0100, Wade Farnsworth wrote:
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 3e0fc5f..4e82fc1 100644
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

Can we now remove this hunk?

>  	current_thread_info()->syscall = scno;
> @@ -930,10 +934,12 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
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

and also this one?

Will
