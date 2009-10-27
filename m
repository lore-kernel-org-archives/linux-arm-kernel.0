From: jpihet@mvista.com (Jean Pihet)
Date: Tue, 27 Oct 2009 18:57:34 +0100
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <19175.5363.259051.477820@pilspetsen.it.uu.se>
References: <1256123277.3851.36.camel@debian-nb>
	<200910271514.54506.jpihet@mvista.com>
	<19175.5363.259051.477820@pilspetsen.it.uu.se>
Message-ID: <200910271857.35371.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 27 October 2009 16:42:43 Mikael Pettersson wrote:
...
>
> I don't like this 'ret' variable:
> - it's only for OABI, but declared at the top and initialised also for EABI
> - you update it with |=, but clearly there's no useful previous value
>
> I'd drop 'ret' and just do:
>
> 				if (put_user(regs->ARM_pc, usp) == 0) {
> 					flush...
> 				} else {
> 					... force_sigsegv
> 				}
>
> (Note: == 0 not !, since ! is often read as "failed" whereas for
> put_user() 0 means Ok and non-zero means -errno.)
Yes that improves the code readability. Thanks for the suggestion.

Here is an updated patch.

Regards,
Jean


>From 885a5952dd38bc0c023e52f731ea2681d43132ba Mon Sep 17 00:00:00 2001
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
 arch/arm/kernel/signal.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index f330974..4366cc0 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -676,8 +676,14 @@ static int do_signal(sigset_t *oldset, struct pt_regs 
*regs, int syscall)
 				regs->ARM_sp -= 4;
 				usp = (u32 __user *)regs->ARM_sp;
 
-				put_user(regs->ARM_pc, usp);
-				regs->ARM_pc = KERN_RESTART_CODE;
+				if (put_user(regs->ARM_pc, usp) == 0) {
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
1.6.2.5.168.g3823
