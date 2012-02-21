From: eparis@redhat.com (Eric Paris)
Date: Tue, 21 Feb 2012 08:47:39 -0500
Subject: [PATCH] ARM/audit: use correct arch on audit_syscall_enter
Message-ID: <1329832059-11000-1-git-send-email-eparis@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM has both LE and BE versions however the audit code was called as if
it was always BE.  If audit userspace were to try to interpret the bits
it got from a LE system it would obviously do so incorrectly.  Fix this
by using the right arch flag on the right system.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 arch/arm/kernel/ptrace.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index e33870f..8009e84 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -915,10 +915,15 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 	ip = regs->ARM_ip;
 	regs->ARM_ip = why;
 
+#ifdef __ARMEB__
+#define AUDIT_ARCH_NR AUDIT_ARCH_ARMEB
+#else
+#define AUDIT_ARCH_NR AUDIT_ARCH_ARM
+#endif
 	if (!ip)
 		audit_syscall_exit(regs);
 	else
-		audit_syscall_entry(AUDIT_ARCH_ARMEB, scno, regs->ARM_r0,
+		audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
 				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-- 
1.7.1
