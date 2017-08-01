From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Aug 2017 12:49:11 +0100
Subject: [PATCH 2/2] arm64: Abstract syscallno manipulation
In-Reply-To: <1500381724-19003-3-git-send-email-Dave.Martin@arm.com>
References: <1500381724-19003-1-git-send-email-Dave.Martin@arm.com>
 <1500381724-19003-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170801114911.GG8702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 01:41:44PM +0100, Dave Martin wrote:
> The -1 "no syscall" value is written in various ways, shared with
> the user ABI in some places, and generally obscure.
> 
> This patch attempts to make things a little more consistent and
> readable by replacing all these uses with a single #define.  A
> couple of symbolic helpers are provided to clarify the intent
> further.
> 
> Because the in-syscall check in do_signal() is changed from >= 0 to
> != NO_SYSCALL by this patch, different behaviour may be observable
> if syscallno is set to values less than -1 by a tracer.  However,
> this is not different from the behaviour that is already observable
> if a tracer sets syscallno to a value >= __NR_(compat_)syscalls.
> 
> It appears that this can cause spurious syscall restarting, but
> that is not a new behaviour either, and does not appear harmful.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/processor.h |  2 +-
>  arch/arm64/include/asm/ptrace.h    | 21 +++++++++++++++++++++
>  arch/arm64/kernel/entry.S          | 10 ++++------
>  arch/arm64/kernel/ptrace.c         |  2 +-
>  arch/arm64/kernel/signal.c         |  8 ++++----
>  arch/arm64/kernel/signal32.c       |  2 +-
>  6 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 379def1..b7334f1 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -112,7 +112,7 @@ void tls_preserve_current_state(void);
>  static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
>  {
>  	memset(regs, 0, sizeof(*regs));
> -	regs->syscallno = ~0;
> +	forget_syscall(regs);
>  	regs->pc = pc;
>  }
>  
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 21c87dc..3a2d6cc 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -72,8 +72,19 @@
>  #define COMPAT_PT_TEXT_ADDR		0x10000
>  #define COMPAT_PT_DATA_ADDR		0x10004
>  #define COMPAT_PT_TEXT_END_ADDR		0x10008
> +
> +/*
> + * If pt_regs.syscallno == NO_SYSCALL, then the thread is not executing
> + * a syscall -- i.e., its most recent entry into the kernel from
> + * userspace was not via SVC, or otherwise a tracer cancelled the syscall.
> + *
> + * This must have the value -1, for ABI compatibility with ptrace etc.
> + */
> +#define NO_SYSCALL (-1)
> +
>  #ifndef __ASSEMBLY__
>  #include <linux/bug.h>
> +#include <linux/types.h>
>  
>  /* sizeof(struct user) for AArch32 */
>  #define COMPAT_USER_SZ	296
> @@ -128,6 +139,16 @@ struct pt_regs {
>  	u64 unused;	// maintain 16 byte alignment
>  };
>  
> +static inline bool in_syscall(int syscallno)
> +{
> +	return syscallno != NO_SYSCALL;
> +}

I think it would be cleaner for this to take the pt_regs as an argument...

> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 4d04b89..3a59dae 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -387,7 +387,7 @@ static int restore_sigframe(struct pt_regs *regs,
>  	/*
>  	 * Avoid sys_rt_sigreturn() restarting.
>  	 */
> -	regs->syscallno = ~0;
> +	forget_syscall(regs);
>  
>  	err |= !valid_user_regs(&regs->user_regs, current);
>  	if (err == 0)
> @@ -679,7 +679,7 @@ static void do_signal(struct pt_regs *regs)
>  	/*
>  	 * If we were from a system call, check for system call restarting...
>  	 */
> -	if (syscall >= 0) {
> +	if (in_syscall(syscall)) {

.. then update the two callsites in here to pass the regs, and remove the
syscall local variable.

With that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
