From: michael.weiser@gmx.de (Michael Weiser)
Date: Mon, 22 Jan 2018 22:20:26 +0100
Subject: [PATCH 2/2] arm64: Mirror arm for unimplemented compat syscalls
In-Reply-To: <20180122212026.26262-1-michael.weiser@gmx.de>
References: <20180122212026.26262-1-michael.weiser@gmx.de>
Message-ID: <20180122212026.26262-3-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mirror arm behaviour for unimplemented syscalls: Below 2048 return
-ENOSYS. Above 2048 raise SIGILL and print a ratelimited message with
details. dump_instr() is made non-static and added to system_misc.h so
it can be used in compat_arm_syscall(). Also it is synced with the arm
implementation to support thumb instructions.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
---
 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/sys_compat.c       | 27 ++++++++++++++++++++++++++-
 arch/arm64/kernel/traps.c            | 14 ++++++++++----
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 07aa8e3c5630..0f73b6c1ca63 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -42,6 +42,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 struct mm_struct;
 extern void show_pte(unsigned long addr);
 extern void __show_regs(struct pt_regs *);
+extern void dump_instr(const char *lvl, struct pt_regs *regs);
 
 extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
diff --git a/arch/arm64/kernel/sys_compat.c b/arch/arm64/kernel/sys_compat.c
index 8b8bbd3eaa52..3a5b3809b671 100644
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
@@ -99,6 +101,31 @@ long compat_arm_syscall(struct pt_regs *regs)
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
+	if (show_unhandled_signals_ratelimited()) {
+		pr_err("[%d] %s: arm syscall %d\n",
+		       task_pid_nr(current), current->comm, no);
+		dump_instr("", regs);
+		if (user_mode(regs))
+			__show_regs(regs);
+	}
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
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0ef28b7f6aa7..2ee511243140 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -67,16 +67,22 @@ static void dump_backtrace_entry(unsigned long where)
 static void __dump_instr(const char *lvl, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
+	const int thumb = compat_thumb_mode(regs);
+	const int width = thumb ? 4 : 8;
 	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
 	int i;
 
-	for (i = -4; i < 1; i++) {
+	for (i = -4; i < 1 + !!thumb; i++) {
 		unsigned int val, bad;
 
-		bad = get_user(val, &((u32 *)addr)[i]);
+		if (thumb)
+			bad = get_user(val, &((u16 *)addr)[i]);
+		else
+			bad = get_user(val, &((u32 *)addr)[i]);
 
 		if (!bad)
-			p += sprintf(p, i == 0 ? "(%08x) " : "%08x ", val);
+			p += sprintf(p, i == 0 ? "(%0*x) " : "%0*x ",
+					width, val);
 		else {
 			p += sprintf(p, "bad PC value");
 			break;
@@ -85,7 +91,7 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
 
-static void dump_instr(const char *lvl, struct pt_regs *regs)
+void dump_instr(const char *lvl, struct pt_regs *regs)
 {
 	if (!user_mode(regs)) {
 		mm_segment_t fs = get_fs();
-- 
2.16.0
