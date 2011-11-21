From: rabin@rab.in (Rabin Vincent)
Date: Mon, 21 Nov 2011 20:43:46 +0530
Subject: [PATCH 1/4] ARM: ftrace: use canonical Thumb-2 wide instruction format
Message-ID: <1321888429-3519-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As commit 592201a9f15 (ARM: Thumb-2: Support Thumb-2 in undefined
instruction handler) says:

    32-bit Thumb instructions are specified in the form:
        ((first_half << 16 ) | second_half)
    which matches the layout used by the ARM ARM.

Convert the ftrace code to use the same format to avoid the usage of
different formats in kernel code.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/ftrace.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index c0062ad..cdceb63 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -19,7 +19,7 @@
 #include <asm/ftrace.h>
 
 #ifdef CONFIG_THUMB2_KERNEL
-#define	NOP		0xeb04f85d	/* pop.w {lr} */
+#define	NOP		0xf85deb04	/* pop.w {lr} */
 #else
 #define	NOP		0xe8bd4000	/* pop {lr} */
 #endif
@@ -88,7 +88,7 @@ static unsigned long ftrace_gen_branch(unsigned long pc, unsigned long addr,
 	if (link)
 		second |= 1 << 14;
 
-	return (second << 16) | first;
+	return (first << 16) | second;
 }
 #else
 static unsigned long ftrace_gen_branch(unsigned long pc, unsigned long addr,
@@ -125,11 +125,20 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 {
 	unsigned long replaced;
 
-	if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
-		return -EFAULT;
+#ifndef __ARMEB__
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		old = (old >> 16) | (old << 16);
+		new = (new >> 16) | (new << 16);
+	}
+#endif
 
-	if (replaced != old)
-		return -EINVAL;
+	if (old) {
+		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
+			return -EFAULT;
+
+		if (replaced != old)
+			return -EINVAL;
+	}
 
 	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
 		return -EPERM;
@@ -141,23 +150,21 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
-	unsigned long pc, old;
+	unsigned long pc;
 	unsigned long new;
 	int ret;
 
 	pc = (unsigned long)&ftrace_call;
-	memcpy(&old, &ftrace_call, MCOUNT_INSN_SIZE);
 	new = ftrace_call_replace(pc, (unsigned long)func);
 
-	ret = ftrace_modify_code(pc, old, new);
+	ret = ftrace_modify_code(pc, 0, new);
 
 #ifdef CONFIG_OLD_MCOUNT
 	if (!ret) {
 		pc = (unsigned long)&ftrace_call_old;
-		memcpy(&old, &ftrace_call_old, MCOUNT_INSN_SIZE);
 		new = ftrace_call_replace(pc, (unsigned long)func);
 
-		ret = ftrace_modify_code(pc, old, new);
+		ret = ftrace_modify_code(pc, 0, new);
 	}
 #endif
 
-- 
1.7.7.3
