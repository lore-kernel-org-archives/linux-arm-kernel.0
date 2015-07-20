From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jul 2015 19:29:37 -0700
Subject: [PATCH] arm64: Minor refactoring of cpu_switch_to() to fix build
 breakage
Message-ID: <1437359377-39932-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
moved the thread_struct to the bottom of task_struct. As a result, the
offset is now too large to be used in an immediate add on arm64 with
some kernel configs:

arch/arm64/kernel/entry.S: Assembler messages:
arch/arm64/kernel/entry.S:588: Error: immediate out of range
arch/arm64/kernel/entry.S:597: Error: immediate out of range

There's really no reason for cpu_switch_to to take a task_struct pointer
in the first place, since all it does is access the thread.cpu_context
member. So, just pass that in directly.

Fixes: 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/include/asm/processor.h |    4 ++--
 arch/arm64/kernel/asm-offsets.c    |    2 --
 arch/arm64/kernel/entry.S          |   34 ++++++++++++++++------------------
 arch/arm64/kernel/process.c        |    3 ++-
 4 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index e4c893e..ba90764 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -152,8 +152,8 @@ static inline void cpu_relax(void)
 #define cpu_relax_lowlatency()                cpu_relax()
 
 /* Thread switching */
-extern struct task_struct *cpu_switch_to(struct task_struct *prev,
-					 struct task_struct *next);
+extern struct task_struct *cpu_switch_to(struct cpu_context *prev,
+					 struct cpu_context *next);
 
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index c99701a..c9e13f6 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -39,8 +39,6 @@ int main(void)
   DEFINE(TI_TASK,		offsetof(struct thread_info, task));
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   BLANK();
-  DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_context));
-  BLANK();
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
   DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
   DEFINE(S_X2,			offsetof(struct pt_regs, regs[2]));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f860bfd..2216326 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -579,29 +579,27 @@ ENDPROC(el0_irq)
 /*
  * Register switch for AArch64. The callee-saved registers need to be saved
  * and restored. On entry:
- *   x0 = previous task_struct (must be preserved across the switch)
- *   x1 = next task_struct
+ *   x0 = previous cpu_context (must be preserved across the switch)
+ *   x1 = next cpu_context
  * Previous and next are guaranteed not to be the same.
  *
  */
 ENTRY(cpu_switch_to)
-	add	x8, x0, #THREAD_CPU_CONTEXT
 	mov	x9, sp
-	stp	x19, x20, [x8], #16		// store callee-saved registers
-	stp	x21, x22, [x8], #16
-	stp	x23, x24, [x8], #16
-	stp	x25, x26, [x8], #16
-	stp	x27, x28, [x8], #16
-	stp	x29, x9, [x8], #16
-	str	lr, [x8]
-	add	x8, x1, #THREAD_CPU_CONTEXT
-	ldp	x19, x20, [x8], #16		// restore callee-saved registers
-	ldp	x21, x22, [x8], #16
-	ldp	x23, x24, [x8], #16
-	ldp	x25, x26, [x8], #16
-	ldp	x27, x28, [x8], #16
-	ldp	x29, x9, [x8], #16
-	ldr	lr, [x8]
+	stp	x19, x20, [x0], #16		// store callee-saved registers
+	stp	x21, x22, [x0], #16
+	stp	x23, x24, [x0], #16
+	stp	x25, x26, [x0], #16
+	stp	x27, x28, [x0], #16
+	stp	x29, x9, [x0], #16
+	str	lr, [x0]
+	ldp	x19, x20, [x1], #16		// restore callee-saved registers
+	ldp	x21, x22, [x1], #16
+	ldp	x23, x24, [x1], #16
+	ldp	x25, x26, [x1], #16
+	ldp	x27, x28, [x1], #16
+	ldp	x29, x9, [x1], #16
+	ldr	lr, [x1]
 	mov	sp, x9
 	ret
 ENDPROC(cpu_switch_to)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 223b093..6b9a09c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -325,7 +325,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	dsb(ish);
 
 	/* the actual thread switch */
-	last = cpu_switch_to(prev, next);
+	last = cpu_switch_to(&prev->thread.cpu_context,
+			     &next->thread.cpu_context);
 
 	return last;
 }
-- 
1.7.10.4
