From: jan.glauber@gmail.com (Jan Glauber)
Date: Mon,  5 May 2014 13:27:39 +0200
Subject: [PATCH] ARM: Use SYSCALL_DEFINEx for sys_sigreturn and
 sys_rt_sigreturn
Message-ID: <1399289259-25020-1-git-send-email-jan.glauber@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the SYSCALL_DEFINEx macros to declare the system calls sigreturn
and rt_sigreturn. This enables system call tracing which is only
available in the SYSCALL_DEFINEx macros.

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 arch/arm/kernel/signal.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index bd19834..7aeda80 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -14,6 +14,7 @@
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/uprobes.h>
+#include <linux/syscalls.h>
 
 #include <asm/elf.h>
 #include <asm/cacheflush.h>
@@ -186,7 +187,7 @@ static int restore_sigframe(struct pt_regs *regs, struct sigframe __user *sf)
 	return err;
 }
 
-asmlinkage int sys_sigreturn(struct pt_regs *regs)
+SYSCALL_DEFINE1(sigreturn, struct pt_regs *, regs)
 {
 	struct sigframe __user *frame;
 
@@ -216,7 +217,7 @@ badframe:
 	return 0;
 }
 
-asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
+SYSCALL_DEFINE1(rt_sigreturn, struct pt_regs *, regs)
 {
 	struct rt_sigframe __user *frame;
 
-- 
1.7.9.5
