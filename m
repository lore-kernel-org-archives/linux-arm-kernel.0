From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jul 2017 19:18:27 +0100
Subject: [PATCHv2 4/7] arm64: unwind: avoid percpu indirection for irq stack
In-Reply-To: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1501093110-3844-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our IRQ_STACK_PTR() and on_irq_stack() helpers both take a cpu argument,
used to generate a percpu address. In all cases, they are passed
{raw_,}smp_processor_id(), so this parameter is redundant.

Since {raw_,}smp_processor_id() use a percpu variable internally, this
approach means we generate a percpu offset to find the current cpu, then
use this to index an array of percpu offsets, which we then use to find
the current CPU's IRQ stack pointer. Thus, most of the work is
redundant.

Instead, we can consistently use raw_cpu_ptr() to generate the CPU's
irq_stack pointer by simply adding the percpu offset to the irq_stack
address, which is simpler in both respects.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/irq.h   | 6 +++---
 arch/arm64/kernel/ptrace.c     | 2 +-
 arch/arm64/kernel/stacktrace.c | 4 ++--
 arch/arm64/kernel/traps.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b77197d..6d6f85e 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -32,7 +32,7 @@
  * from kernel_entry can be found.
  *
  */
-#define IRQ_STACK_PTR(cpu) ((unsigned long)per_cpu(irq_stack, cpu) + IRQ_STACK_START_SP)
+#define IRQ_STACK_PTR() ((unsigned long)raw_cpu_ptr(irq_stack) + IRQ_STACK_START_SP)
 
 /*
  * The offset from irq_stack_ptr where entry.S will store the original
@@ -47,10 +47,10 @@ static inline int nr_legacy_irqs(void)
 	return 0;
 }
 
-static inline bool on_irq_stack(unsigned long sp, int cpu)
+static inline bool on_irq_stack(unsigned long sp)
 {
 	/* variable names the same as kernel/stacktrace.c */
-	unsigned long low = (unsigned long)per_cpu(irq_stack, cpu);
+	unsigned long low = (unsigned long)raw_cpu_ptr(irq_stack);
 	unsigned long high = low + IRQ_STACK_START_SP;
 
 	return (low <= sp && sp <= high);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1b38c01..baf0838 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -127,7 +127,7 @@ static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
 {
 	return ((addr & ~(THREAD_SIZE - 1))  ==
 		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1))) ||
-		on_irq_stack(addr, raw_smp_processor_id());
+		on_irq_stack(addr);
 }
 
 /**
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 09d37d6..6ffb965 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -54,13 +54,13 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	 * non-preemptible context.
 	 */
 	if (tsk == current && !preemptible())
-		irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
+		irq_stack_ptr = IRQ_STACK_PTR();
 	else
 		irq_stack_ptr = 0;
 
 	low  = frame->sp;
 	/* irq stacks are not THREAD_SIZE aligned */
-	if (on_irq_stack(frame->sp, raw_smp_processor_id()))
+	if (on_irq_stack(frame->sp))
 		high = irq_stack_ptr;
 	else
 		high = ALIGN(low, THREAD_SIZE) - 0x20;
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c7c7088..7ba80f2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -159,7 +159,7 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	 * non-preemptible context.
 	 */
 	if (tsk == current && !preemptible())
-		irq_stack_ptr = IRQ_STACK_PTR(smp_processor_id());
+		irq_stack_ptr = IRQ_STACK_PTR();
 	else
 		irq_stack_ptr = 0;
 
-- 
1.9.1
