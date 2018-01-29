From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jan 2018 15:37:30 +0000
Subject: [PATCH 2/2] arm64: Mirror arm for unimplemented compat syscalls
In-Reply-To: <20180122212026.26262-3-michael.weiser@gmx.de>
References: <20180122131851.GA28638@arm.com>
 <20180122212026.26262-3-michael.weiser@gmx.de>
Message-ID: <20180129153730.GA24444@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Mon, Jan 22, 2018 at 10:20:26PM +0100, Michael Weiser wrote:
> Mirror arm behaviour for unimplemented syscalls: Below 2048 return
> -ENOSYS. Above 2048 raise SIGILL and print a ratelimited message with
> details. dump_instr() is made non-static and added to system_misc.h so
> it can be used in compat_arm_syscall(). Also it is synced with the arm
> implementation to support thumb instructions.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> ---
>  arch/arm64/include/asm/system_misc.h |  1 +
>  arch/arm64/kernel/sys_compat.c       | 27 ++++++++++++++++++++++++++-
>  arch/arm64/kernel/traps.c            | 14 ++++++++++----
>  3 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
> index 07aa8e3c5630..0f73b6c1ca63 100644
> --- a/arch/arm64/include/asm/system_misc.h
> +++ b/arch/arm64/include/asm/system_misc.h
> @@ -42,6 +42,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
>  struct mm_struct;
>  extern void show_pte(unsigned long addr);
>  extern void __show_regs(struct pt_regs *);
> +extern void dump_instr(const char *lvl, struct pt_regs *regs);
>  
>  extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>  
> diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
> index 8b8bbd3eaa52..3a5b3809b671 100644
> --- a/arch/arm64/kernel/sys_compat.c
> +++ b/arch/arm64/kernel/sys_compat.c
> @@ -27,6 +27,7 @@
>  #include <linux/uaccess.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/system_misc.h>
>  #include <asm/unistd.h>
>  
>  static long
> @@ -67,6 +68,7 @@ do_compat_cache_op(unsigned long start, unsigned long end, int flags)
>   */
>  long compat_arm_syscall(struct pt_regs *regs)
>  {
> +	siginfo_t info;
>  	unsigned int no = regs->regs[7];
>  
>  	switch (no) {
> @@ -99,6 +101,31 @@ long compat_arm_syscall(struct pt_regs *regs)
>  		return 0;
>  
>  	default:
> -		return -ENOSYS;
> +		/*
> +		 * Calls 9f00xx..9f07ff are defined to return -ENOSYS
> +		 * if not implemented, rather than raising SIGILL. This
> +		 * way the calling program can gracefully determine whether
> +		 * a feature is supported.
> +		 */
> +		if ((no & 0xffff) <= 0x7ff)
> +			return -ENOSYS;
> +		break;
>  	}
> +
> +	if (show_unhandled_signals_ratelimited()) {
> +		pr_err("[%d] %s: arm syscall %d\n",
> +		       task_pid_nr(current), current->comm, no);
> +		dump_instr("", regs);
> +		if (user_mode(regs))
> +			__show_regs(regs);
> +	}
> +
> +	info.si_signo = SIGILL;
> +	info.si_errno = 0;
> +	info.si_code  = ILL_ILLTRP;
> +	info.si_addr  = (void __user *)instruction_pointer(regs) -
> +			 (compat_thumb_mode(regs) ? 2 : 4);
> +
> +	arm64_notify_die("Oops - bad syscall(2)", regs, &info, no);
> +	return 0;

Whilst I think it's worth mirroring the SIGILL behaviour here, I don't think
we need to both with the show_unhandled_signals_ratelimited() hunk. It's
predicated on CONFI_DEBUG_USER for arch/arm/ anyway, so it's something that
can be relied upon but really more of a debug aid that we can live without
for now.

So I'd suggest simply dropping that hunk and the changes to __dump_instr.

Cheers,

Will
