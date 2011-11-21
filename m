From: rabin@rab.in (Rabin Vincent)
Date: Mon, 21 Nov 2011 20:43:47 +0530
Subject: [PATCH 2/4] ARM: extract out insn generation code from ftrace
In-Reply-To: <1321888429-3519-1-git-send-email-rabin@rab.in>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
Message-ID: <1321888429-3519-2-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extract out the instruction generation code so that it can be used
for jump labels too.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/Makefile |    5 ++-
 arch/arm/kernel/ftrace.c |   61 +++-------------------------------------------
 arch/arm/kernel/insn.c   |   60 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/insn.h   |   19 ++++++++++++++
 4 files changed, 86 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/kernel/insn.c
 create mode 100644 arch/arm/kernel/insn.h

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 16eed6a..a2f34a3 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -7,6 +7,7 @@ AFLAGS_head.o        := -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = -pg
+CFLAGS_REMOVE_insn.o = -pg
 endif
 
 CFLAGS_REMOVE_return_address.o = -pg
@@ -34,8 +35,8 @@ obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
-obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
-obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
+obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-common.o
 ifdef CONFIG_THUMB2_KERNEL
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index cdceb63..c46d18b 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -18,6 +18,8 @@
 #include <asm/cacheflush.h>
 #include <asm/ftrace.h>
 
+#include "insn.h"
+
 #ifdef CONFIG_THUMB2_KERNEL
 #define	NOP		0xf85deb04	/* pop.w {lr} */
 #else
@@ -60,64 +62,9 @@ static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
 }
 #endif
 
-#ifdef CONFIG_THUMB2_KERNEL
-static unsigned long ftrace_gen_branch(unsigned long pc, unsigned long addr,
-				       bool link)
-{
-	unsigned long s, j1, j2, i1, i2, imm10, imm11;
-	unsigned long first, second;
-	long offset;
-
-	offset = (long)addr - (long)(pc + 4);
-	if (offset < -16777216 || offset > 16777214) {
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	s	= (offset >> 24) & 0x1;
-	i1	= (offset >> 23) & 0x1;
-	i2	= (offset >> 22) & 0x1;
-	imm10	= (offset >> 12) & 0x3ff;
-	imm11	= (offset >>  1) & 0x7ff;
-
-	j1 = (!i1) ^ s;
-	j2 = (!i2) ^ s;
-
-	first = 0xf000 | (s << 10) | imm10;
-	second = 0x9000 | (j1 << 13) | (j2 << 11) | imm11;
-	if (link)
-		second |= 1 << 14;
-
-	return (first << 16) | second;
-}
-#else
-static unsigned long ftrace_gen_branch(unsigned long pc, unsigned long addr,
-				       bool link)
-{
-	unsigned long opcode = 0xea000000;
-	long offset;
-
-	if (link)
-		opcode |= 1 << 24;
-
-	offset = (long)addr - (long)(pc + 8);
-	if (unlikely(offset < -33554432 || offset > 33554428)) {
-		/* Can't generate branches that far (from ARM ARM). Ftrace
-		 * doesn't generate branches outside of kernel text.
-		 */
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	offset = (offset >> 2) & 0x00ffffff;
-
-	return opcode | offset;
-}
-#endif
-
 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
 {
-	return ftrace_gen_branch(pc, addr, true);
+	return arm_gen_branch_link(pc, addr);
 }
 
 static int ftrace_modify_code(unsigned long pc, unsigned long old,
@@ -256,7 +203,7 @@ static int __ftrace_modify_caller(unsigned long *callsite,
 {
 	unsigned long caller_fn = (unsigned long) func;
 	unsigned long pc = (unsigned long) callsite;
-	unsigned long branch = ftrace_gen_branch(pc, caller_fn, false);
+	unsigned long branch = arm_gen_branch(pc, caller_fn);
 	unsigned long nop = 0xe1a00000;	/* mov r0, r0 */
 	unsigned long old = enable ? nop : branch;
 	unsigned long new = enable ? branch : nop;
diff --git a/arch/arm/kernel/insn.c b/arch/arm/kernel/insn.c
new file mode 100644
index 0000000..f65b68c
--- /dev/null
+++ b/arch/arm/kernel/insn.c
@@ -0,0 +1,60 @@
+#include <linux/kernel.h>
+
+static unsigned long
+__arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
+{
+	unsigned long s, j1, j2, i1, i2, imm10, imm11;
+	unsigned long first, second;
+	long offset;
+
+	offset = (long)addr - (long)(pc + 4);
+	if (offset < -16777216 || offset > 16777214) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	s	= (offset >> 24) & 0x1;
+	i1	= (offset >> 23) & 0x1;
+	i2	= (offset >> 22) & 0x1;
+	imm10	= (offset >> 12) & 0x3ff;
+	imm11	= (offset >>  1) & 0x7ff;
+
+	j1 = (!i1) ^ s;
+	j2 = (!i2) ^ s;
+
+	first = 0xf000 | (s << 10) | imm10;
+	second = 0x9000 | (j1 << 13) | (j2 << 11) | imm11;
+	if (link)
+		second |= 1 << 14;
+
+	return (first << 16) | second;
+}
+
+static unsigned long
+__arm_gen_branch_arm(unsigned long pc, unsigned long addr, bool link)
+{
+	unsigned long opcode = 0xea000000;
+	long offset;
+
+	if (link)
+		opcode |= 1 << 24;
+
+	offset = (long)addr - (long)(pc + 8);
+	if (unlikely(offset < -33554432 || offset > 33554428)) {
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	offset = (offset >> 2) & 0x00ffffff;
+
+	return opcode | offset;
+}
+
+unsigned long
+__arm_gen_branch(unsigned long pc, unsigned long addr, bool link)
+{
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
+		return __arm_gen_branch_thumb2(pc, addr, link);
+	else
+		return __arm_gen_branch_arm(pc, addr, link);
+}
diff --git a/arch/arm/kernel/insn.h b/arch/arm/kernel/insn.h
new file mode 100644
index 0000000..994d60f
--- /dev/null
+++ b/arch/arm/kernel/insn.h
@@ -0,0 +1,19 @@
+#ifndef __ASM_ARM_INSN_H
+#define __ASM_ARM_INSN_H
+
+unsigned long
+__arm_gen_branch(unsigned long pc, unsigned long addr, bool link);
+
+static inline unsigned long
+arm_gen_branch(unsigned long pc, unsigned long addr)
+{
+	return __arm_gen_branch(pc, addr, false);
+}
+
+static inline unsigned long
+arm_gen_branch_link(unsigned long pc, unsigned long addr)
+{
+	return __arm_gen_branch(pc, addr, true);
+}
+
+#endif
-- 
1.7.7.3
