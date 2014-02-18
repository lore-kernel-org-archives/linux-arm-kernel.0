From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Feb 2014 15:38:56 +0000
Subject: [PATCH 1/2] arm64: Add seccomp support
In-Reply-To: <1391767892-5395-2-git-send-email-takahiro.akashi@linaro.org>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1391767892-5395-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140218153856.GB904@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:11:31AM +0000, AKASHI Takahiro wrote:
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -26,6 +26,7 @@
>  #include <linux/smp.h>
>  #include <linux/ptrace.h>
>  #include <linux/user.h>
> +#include <linux/seccomp.h>
>  #include <linux/security.h>
>  #include <linux/init.h>
>  #include <linux/signal.h>
> @@ -1064,6 +1065,10 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
>  {
>  	unsigned long saved_reg;
>  
> +	if (!dir && secure_computing((int)regs->syscallno))
> +		/* seccomp failures shouldn't expose any additional code. */
> +		return -1;

That's only restricted to the arm64 code but could we use a more
meaningful error number?

-- 
Catalin
