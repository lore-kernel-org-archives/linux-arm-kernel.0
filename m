From: michael.weiser@gmx.de (Michael Weiser)
Date: Thu,  1 Feb 2018 23:13:37 +0100
Subject: [PATCH v2 2/3] arm64: Mirror arm for unimplemented compat syscalls
In-Reply-To: <20180201221338.9952-1-michael.weiser@gmx.de>
References: <20180201221338.9952-1-michael.weiser@gmx.de>
Message-ID: <20180201221338.9952-3-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mirror arm behaviour for unimplemented syscalls: Below 2048 return
-ENOSYS, above 2048 raise SIGILL.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
---
 arch/arm64/kernel/sys_compat.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 8b8bbd3eaa52..4d5dfbb2c4cb 100644
--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
+#include <asm/system_misc.h>
 #include <asm/unistd.h>
 
 static long
@@ -67,6 +68,7 @@ do_compat_cache_op(unsigned long start, unsigned long end, int flags)
  */
 long compat_arm_syscall(struct pt_regs *regs)
 {
+	siginfo_t info;
 	unsigned int no = regs->regs[7];
 
 	switch (no) {
@@ -99,6 +101,23 @@ long compat_arm_syscall(struct pt_regs *regs)
 		return 0;
 
 	default:
-		return -ENOSYS;
+		/*
+		 * Calls 9f00xx..9f07ff are defined to return -ENOSYS
+		 * if not implemented, rather than raising SIGILL. This
+		 * way the calling program can gracefully determine whether
+		 * a feature is supported.
+		 */
+		if ((no & 0xffff) <= 0x7ff)
+			return -ENOSYS;
+		break;
 	}
+
+	info.si_signo = SIGILL;
+	info.si_errno = 0;
+	info.si_code  = ILL_ILLTRP;
+	info.si_addr  = (void __user *)instruction_pointer(regs) -
+			 (compat_thumb_mode(regs) ? 2 : 4);
+
+	arm64_notify_die("Oops - bad syscall(2)", regs, &info, no);
+	return 0;
 }
-- 
2.16.1
