From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Feb 2018 15:48:21 +0000
Subject: [PATCH 9/9] arm64: Use arm64_force_sig_info instead of
 force_sig_info
In-Reply-To: <1519308057-4953-10-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
 <1519308057-4953-10-git-send-email-will.deacon@arm.com>
Message-ID: <20180222154821.rikapebcj3nvp775@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 02:00:57PM +0000, Will Deacon wrote:
> Using arm64_force_sig_info means that printing messages about unhandled
> signals is dealt with for us, so use that in preference to force_sig_info
> and remove any homebrew printing code.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/debug-monitors.c | 3 ++-
>  arch/arm64/kernel/ptrace.c         | 2 +-
>  arch/arm64/kernel/traps.c          | 9 ++-------
>  3 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 53781f5687c5..06ca574495af 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -33,6 +33,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/system_misc.h>
> +#include <asm/traps.h>
>  
>  /* Determine debug architecture. */
>  u8 debug_monitors_arch(void)
> @@ -223,7 +224,7 @@ static void send_user_sigtrap(int si_code)
>  	if (interrupts_enabled(regs))
>  		local_irq_enable();
>  
> -	force_sig_info(SIGTRAP, &info, current);
> +	arm64_force_sig_info(&info, "User debug trap", current);
>  }
>  
>  static int single_step_handler(unsigned long addr, unsigned int esr,
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 6618036ae6d4..dd359ee02e2b 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -209,7 +209,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
>  		force_sig_ptrace_errno_trap(si_errno, (void __user *)bkpt->trigger);
>  	}
>  #endif
> -	force_sig_info(SIGTRAP, &info, current);
> +	arm64_force_sig_info(&info, "Hardware breakpoint trap (ptrace)", current);
>  }
>  
>  /*
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 4231488a5a9f..cb5ad77524f3 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -633,11 +633,6 @@ asmlinkage void bad_el0_sync(struct pt_regs *regs, int reason, unsigned int esr)
>  {
>  	siginfo_t info;
>  	void __user *pc = (void __user *)instruction_pointer(regs);
> -	console_verbose();
> -
> -	pr_crit("Bad EL0 synchronous exception detected on CPU%d, code 0x%08x -- %s\n",
> -		smp_processor_id(), esr, esr_get_class_string(esr));
> -	__show_regs(regs);

Here we dump the CPU so that a developer can figure out which
microarchitecture the exception was taken on (e.g. to allow them to
decode an IMP DEF SError). We added that in commit:

  8051f4d16ef1d037 ("arm64: report CPU number in bad_mode")

However, in arm64_force_sig_info() we don't dump the CPU, and I guess
that may be preemptible in cases other than bad_el0_sync().

Are we happy to lose this?

Thanks,
Mark.
