From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 18 Mar 2018 17:48:44 +0300
Subject: [PATCH v16 10/13] arch/arm: enable task isolation functionality
In-Reply-To: <1509728692-10460-11-git-send-email-cmetcalf@mellanox.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
 <1509728692-10460-11-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20180318144844.ehkbx7npszfreyeh@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Francis, Chris,

On Fri, Nov 03, 2017 at 01:04:49PM -0400, Chris Metcalf wrote:
> From: Francis Giraldeau <francis.giraldeau@gmail.com>
> 
> This patch is a port of the task isolation functionality to the arm 32-bit
> architecture. The task isolation needs an additional thread flag that
> requires to change the entry assembly code to accept a bitfield larger than
> one byte.  The constants _TIF_SYSCALL_WORK and _TIF_WORK_MASK are now
> defined in the literal pool. The rest of the patch is straightforward and
> reflects what is done on other architectures.
> 
> To avoid problems with the tst instruction in the v7m build, we renumber
> TIF_SECCOMP to bit 8 and let TIF_TASK_ISOLATION use bit 7.
> 
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com> [with modifications]

[...]

> ---
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index 58e3771e4c5b..0cfcba5a93df 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -27,6 +27,7 @@
>  #include <linux/audit.h>
>  #include <linux/tracehook.h>
>  #include <linux/unistd.h>
> +#include <linux/isolation.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/traps.h>
> @@ -936,6 +937,15 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
>  	if (test_thread_flag(TIF_SYSCALL_TRACE))
>  		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
>  
> +	/*
> +	 * In task isolation mode, we may prevent the syscall from
> +	 * running, and if so we also deliver a signal to the process.
> +	 */
> +	if (test_thread_flag(TIF_TASK_ISOLATION)) {
> +		if (task_isolation_syscall(scno) == -1)
> +			return -1;
> +	}

I think it would make sense to load thread flags to local variable
because later in the code test_thread_flag() is called again to check
TIF_SYSCALL_TRACEPOINT flag, and we can avoid it, like this:

unsigned long work = READ_ONCE(current_thread_info()->flags);

Also, all other architectures cache thread flags to local
variable before use; so doing this would make sense for the sake
of unification.

Yury
