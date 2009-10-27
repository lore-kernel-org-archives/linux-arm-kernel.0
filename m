From: jpihet@mvista.com (Jean Pihet)
Date: Tue, 27 Oct 2009 15:14:53 +0100
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <af3ea28a0910251959id60ad5kf95dd1f908fa55c9@mail.gmail.com>
References: <1256123277.3851.36.camel@debian-nb>
	<20091025154416.GB1774@n2100.arm.linux.org.uk>
	<af3ea28a0910251959id60ad5kf95dd1f908fa55c9@mail.gmail.com>
Message-ID: <200910271514.54506.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Janboe,

On Monday 26 October 2009 03:59:23 ye janboe wrote:
> Sure. Russell
>
> After you restart_syscall patch are merged, I will send out another patch.
Here is what I ended up with after merging.
It has been tested on OMAP3 boards although I could not trigger the failing 
put_user test case.

What do you think?

Regards,
Jean


>From dcaf0812f86948fe1c9dbb9fe53e9040f5a6deeb Mon Sep 17 00:00:00 2001
From: Jean Pihet <jpihet@mvista.com>
Date: Tue, 27 Oct 2009 10:09:22 +0100
Subject: ARM: Check put_user fail in do_signal when enable OABI_COMPAT

Using OABI, do_signal need to copy restart_syscall to user stack.
It is possible that put_user fail. This triggers flush_icache page
fault and crash kernel.

Signed-off-by: janboe <janboe.ye@gmail.com>

Merged from
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/002621.html
on top of
http://marc.info/?l=linux-arm-kernel&m=125638133624452&w=2

Tested with multiple sleeping apps/threads (using the nanosleep syscall) and
suspend/resume.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
---
 arch/arm/kernel/signal.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 998fa8d..8ac56fe 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -643,6 +643,7 @@ static int do_signal(sigset_t *oldset, struct pt_regs 
*regs, int syscall)
 	struct k_sigaction ka;
 	siginfo_t info;
 	int signr;
+	int ret = 0;
 
 	/*
 	 * We want the common case to go fast, which
@@ -685,8 +686,15 @@ static int do_signal(sigset_t *oldset, struct pt_regs 
*regs, int syscall)
 				regs->ARM_sp -= 4;
 				usp = (u32 __user *)regs->ARM_sp;
 
-				put_user(regs->ARM_pc, usp);
-				regs->ARM_pc = KERN_RESTART_CODE;
+				ret |= put_user(regs->ARM_pc, usp);
+				if (!ret) {
+					flush_icache_range((unsigned long)usp,
+						(unsigned long)(usp + 1));
+					regs->ARM_pc = KERN_RESTART_CODE;
+				} else {
+					regs->ARM_sp += 4;
+					force_sigsegv(0, current);
+				}
 #endif
 			}
 		}
-- 

>
> Thanks
>
> 2009/10/25 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Sun, Oct 25, 2009 at 02:23:09PM +0800, ye janboe wrote:
> >> hi, Russell
> >>
> >> Your patch looks good for real fixing this issue.
> >
> > My patch doesn't address your issue, it only addresses a previous
> > problem. ?We're still decrementing the stack pointer and writing to
> > a possible new page - which could fault.
> >
> > Therefore, your patch is still required, but it needs to be modified
> > to apply on top of my patch.
> >
> > A replacement patch would be welcome.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
