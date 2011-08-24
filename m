From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 24 Aug 2011 10:21:46 -0700
Subject: [PATCH 1/2] arm: add dump_stack_regs to dump stack from registers
In-Reply-To: <1314206507-6487-1-git-send-email-lauraa@codeaurora.org>
References: <1314206507-6487-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1314206507-6487-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, there is no API to be able to dump a stack
from registers. Use dump_backtrace to walk the stack
with a given set of registers.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/stacktrace.h |    4 ++++
 arch/arm/kernel/traps.c           |    7 +++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 4d0a164..614b017 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_STACKTRACE_H
 #define __ASM_STACKTRACE_H
 
+#include <asm/system.h>
+
 struct stackframe {
 	unsigned long fp;
 	unsigned long sp;
@@ -12,4 +14,6 @@ extern int unwind_frame(struct stackframe *frame);
 extern void walk_stackframe(struct stackframe *frame,
 			    int (*fn)(struct stackframe *, void *), void *data);
 
+void dump_stack_regs(struct pt_regs *regs);
+
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index bc9f9da..983ba41 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -209,6 +209,13 @@ void dump_stack(void)
 
 EXPORT_SYMBOL(dump_stack);
 
+
+void dump_stack_regs(struct pt_regs *regs)
+{
+	dump_backtrace(regs, NULL);
+}
+EXPORT_SYMBOL(dump_stack_regs);
+
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
 	dump_backtrace(NULL, tsk);
-- 
1.7.3.3
