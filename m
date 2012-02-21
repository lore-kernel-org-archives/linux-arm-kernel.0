From: eparis@redhat.com (Eric Paris)
Date: Tue, 21 Feb 2012 11:26:55 -0500
Subject: [PATCH -v2] ARM/audit: include audit header and fix audit arch
Message-ID: <1329841615-14132-1-git-send-email-eparis@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both bugs being fixed were introduced in:
29ef73b7a823b77a7cd0bdd7d7cded3fb6c2587b

Include linux/audit.h to fix below build errors:

  CC      arch/arm/kernel/ptrace.o
arch/arm/kernel/ptrace.c: In function 'syscall_trace':
arch/arm/kernel/ptrace.c:919: error: implicit declaration of function 'audit_syscall_exit'
arch/arm/kernel/ptrace.c:921: error: implicit declaration of function 'audit_syscall_entry'
arch/arm/kernel/ptrace.c:921: error: 'AUDIT_ARCH_ARMEB' undeclared (first use in this function)
arch/arm/kernel/ptrace.c:921: error: (Each undeclared identifier is reported only once
arch/arm/kernel/ptrace.c:921: error: for each function it appears in.)
make[1]: *** [arch/arm/kernel/ptrace.o] Error 1
make: *** [arch/arm/kernel] Error 2

This part of the patch is:
Reported-by: Axel Lin <axel.lin@gmail.com>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
(They both provided patches to fix it)

This patch also (at the request of the list) fixes the fact that
ARM has both LE and BE versions however the audit code was called as if
it was always BE.  If audit userspace were to try to interpret the bits
it got from a LE system it would obviously do so incorrectly.  Fix this
by using the right arch flag on the right system.

This part of the patch is:
Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 arch/arm/kernel/ptrace.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index e33870f..ede6443 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -23,6 +23,7 @@
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
+#include <linux/audit.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -904,6 +905,12 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
+#ifdef __ARMEB__
+#define AUDIT_ARCH_NR AUDIT_ARCH_ARMEB
+#else
+#define AUDIT_ARCH_NR AUDIT_ARCH_ARM
+#endif
+
 asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 {
 	unsigned long ip;
@@ -918,7 +925,7 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 	if (!ip)
 		audit_syscall_exit(regs);
 	else
-		audit_syscall_entry(AUDIT_ARCH_ARMEB, scno, regs->ARM_r0,
+		audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
 				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-- 
1.7.1
