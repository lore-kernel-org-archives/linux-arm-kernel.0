From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Feb 2014 17:20:06 +0000
Subject: [PATCH v2 2/3] arm64: Add seccomp support
In-Reply-To: <1393320025-2855-3-git-send-email-takahiro.akashi@linaro.org>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320025-2855-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320025-2855-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140228172006.GF30996@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 09:20:24AM +0000, AKASHI Takahiro wrote:
> secure_computing() should always be called first in syscall_trace(), and
> if it returns non-zero, we should stop further handling. Then that system
> call may eventually fail, be trapped or the process itself be killed
> depending on loaded rules.

[...]

> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index d4ce70e..f2a74bc 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -20,12 +20,14 @@
>   */
>  
>  #include <linux/audit.h>
> +#include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/ptrace.h>
>  #include <linux/user.h>
> +#include <linux/seccomp.h>
>  #include <linux/security.h>
>  #include <linux/init.h>
>  #include <linux/signal.h>
> @@ -1064,6 +1066,10 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
>  {
>  	unsigned long saved_reg;
>  
> +	if (!dir && secure_computing((int)regs->syscallno))

Why do you need this cast to (int)? Also, it's probably better to check for
-1 explicitly here.

I'm slightly surprised that we do the secure computing check first. Doesn't
this allow a debugger to change the syscall to something else after we've
decided that it's ok?

Will
