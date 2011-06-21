From: vapier@gentoo.org (Mike Frysinger)
Date: Tue, 21 Jun 2011 15:31:20 -0400
Subject: [PATCH] ARM: quiet sparse noise due to
	__ARCH_WANT_SYS_RT_SIG(ACTION|SUSPEND)
In-Reply-To: <201106211209.46462.hartleys@visionengravers.com>
References: <201106211209.46462.hartleys@visionengravers.com>
Message-ID: <BANLkTi=8mstQAWKxBBBFH_+byGoXr8ieRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 15:09, H Hartley Sweeten wrote:
> --- a/arch/arm/include/asm/unistd.h
> +++ b/arch/arm/include/asm/unistd.h
> @@ -467,6 +467,20 @@
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +#include <linux/linkage.h>
> +#include <linux/compiler.h>
> +#include <linux/signal.h>
> +
> +asmlinkage long sys_rt_sigaction(int sig, const struct sigaction __user *act,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct sigaction __user *oact,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?size_t sigsetsize);
> +asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize);
> +
> +#endif /* !__ASSEMBLY__ */

yikes ... this really the only way to fix the sparse warning ?
-mike
