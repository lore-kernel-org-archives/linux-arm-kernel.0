From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Apr 2012 11:07:46 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
Message-ID: <20120430100746.GA11080@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Sun, Apr 29, 2012 at 07:38:24AM +0100, Jon Masters wrote:
> The audit subsystem builds upon ptrace to record system calls. This is done
> in a couple of places (on return from fork into a new task, on exit from
> the SWI vector), using calls to syscall_trace. The latter function abuses
> the userspace intra-procedure scratch register (regs->ARM_ip, aka r12),
> and intends to restore it prior to return to userspace. Unfortunately,
> there are cases where we will return to userspace without restoring.
> 
> If we are in fact not ptracing but are merely auditing calls, we will
> happily trash the content of ip but will exit to userspace without
> restoring the value. It just so happens that GLIBC uses ip as a
> storage for the TLS thread pointer info, and bad things result.

Ouch, that's pretty horrible. We should have spotted this when we were
fixing the build breakage introduced by the audit stuff. Looking more
closely, does this code work even with your patch? It looks like we use the
saved ip to infer syscall entry, rather than why. On top of that, I think
the polarity is back-to-front.

> The fix is simply to have an additional out when not ptracing.

Actually, I don't understand why we have to update pt_regs so early given
that I don't think the saved ip is used by audit_syscall_{entry,exit} at
all. Perhaps we could just move the ip manipulation until after the thread
flag checks [completely untested patch below]?


diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 80abafb..bfcadc0 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -916,14 +916,7 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 {
        unsigned long ip;
 
-       /*
-        * Save IP.  IP is used to denote syscall entry/exit:
-        *  IP = 0 -> entry, = 1 -> exit
-        */
-       ip = regs->ARM_ip;
-       regs->ARM_ip = why;
-
-       if (!ip)
+       if (why)
                audit_syscall_exit(regs);
        else
                audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
@@ -936,6 +929,13 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 
        current_thread_info()->syscall = scno;
 
+       /*
+        * IP is used to denote syscall entry/exit:
+        * IP = 0 -> entry, = 1 -> exit
+        */
+       ip = regs->ARM_ip;
+       regs->ARM_ip = why;
+
        /* the 0x80 provides a way for the tracing parent to distinguish
           between a syscall stop and SIGTRAP delivery */
        ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)


Also note that this will conflict with 7375/1 in the patch system, but this
should probably take priority and be CC'd for stable once we can convince
ourselves that it's working properly.

Can you take it for a spin please?

Will
