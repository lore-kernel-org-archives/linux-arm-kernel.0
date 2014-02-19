From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Feb 2014 16:41:25 +0000
Subject: [PATCH 1/2] arm64: Add seccomp support
In-Reply-To: <530497DD.2020806@linaro.org>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <1391767892-5395-2-git-send-email-takahiro.akashi@linaro.org>
 <20140218153856.GB904@localhost> <530497DD.2020806@linaro.org>
Message-ID: <20140219164125.GD22252@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 11:39:09AM +0000, AKASHI Takahiro wrote:
> On 02/19/2014 12:38 AM, Catalin Marinas wrote:
> > On Fri, Feb 07, 2014 at 10:11:31AM +0000, AKASHI Takahiro wrote:
> >> --- a/arch/arm64/kernel/ptrace.c
> >> +++ b/arch/arm64/kernel/ptrace.c
> >> @@ -26,6 +26,7 @@
> >>   #include <linux/smp.h>
> >>   #include <linux/ptrace.h>
> >>   #include <linux/user.h>
> >> +#include <linux/seccomp.h>
> >>   #include <linux/security.h>
> >>   #include <linux/init.h>
> >>   #include <linux/signal.h>
> >> @@ -1064,6 +1065,10 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
> >>   {
> >>   	unsigned long saved_reg;
> >>
> >> +	if (!dir && secure_computing((int)regs->syscallno))
> >> +		/* seccomp failures shouldn't expose any additional code. */
> >> +		return -1;
> >
> > That's only restricted to the arm64 code but could we use a more
> > meaningful error number?
> 
> Other architectures, including arm, also return just -1 in syscall_trace_enter(),
> but of course, we can use another value, say, -EPERM or -ENOSYS?

Actually we have another case of setting regs->syscallno = ~0UL in the
same function, so we could do the same (also in line with entry.S).

-- 
Catalin
