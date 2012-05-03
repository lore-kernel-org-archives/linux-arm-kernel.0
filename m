From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 May 2012 18:42:55 +0100
Subject: [PATCH 1/6] ARM: audit: fix treatment of saved ip register during
 syscall tracing
In-Reply-To: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
References: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
Message-ID: <1336066980-24000-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM audit code incorrectly uses the saved application ip register
value to infer syscall entry or exit. Additionally, the saved value will
be clobbered if the current task is not being traced, which can lead to
libc corruption if ip is live (apparently glibc uses it for the TLS
pointer).

This patch fixes the syscall tracing code so that the why parameter is
used to infer the syscall direction and the saved ip is only updated if
we know that we will be signalling a ptrace trap.

Cc: Eric Paris <eparis@redhat.com>
Reported-and-tested-by: Jon Masters <jcm@jonmasters.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/ptrace.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 80abafb..d8dbe9c 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -916,14 +916,7 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 {
 	unsigned long ip;
 
-	/*
-	 * Save IP.  IP is used to denote syscall entry/exit:
-	 *  IP = 0 -> entry, = 1 -> exit
-	 */
-	ip = regs->ARM_ip;
-	regs->ARM_ip = why;
-
-	if (!ip)
+	if (why)
 		audit_syscall_exit(regs);
 	else
 		audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
@@ -936,6 +929,13 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 
 	current_thread_info()->syscall = scno;
 
+	/*
+	 * IP is used to denote syscall entry/exit:
+	 * IP = 0 -> entry, =1 -> exit
+	 */
+	ip = regs->ARM_ip;
+	regs->ARM_ip = why;
+
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-- 
1.7.4.1
