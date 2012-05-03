From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 May 2012 18:42:56 +0100
Subject: [PATCH 2/6] ARM: audit: use only AUDIT_ARCH_ARM regardless of
 endianness
In-Reply-To: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
References: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
Message-ID: <1336066980-24000-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The machine endianness has no direct correspondence to the syscall ABI,
so use only AUDIT_ARCH_ARM when identifying the ABI to the audit tools
in userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/ptrace.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index d8dbe9c..9650c14 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -906,12 +906,6 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-#ifdef __ARMEB__
-#define AUDIT_ARCH_NR AUDIT_ARCH_ARMEB
-#else
-#define AUDIT_ARCH_NR AUDIT_ARCH_ARM
-#endif
-
 asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 {
 	unsigned long ip;
@@ -919,7 +913,7 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 	if (why)
 		audit_syscall_exit(regs);
 	else
-		audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
+		audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0,
 				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-- 
1.7.4.1
