From: jld@mozilla.com (Jed Davis)
Date: Fri, 12 Jul 2013 20:17:14 -0700
Subject: [PATCH] ARM: perf: Implement perf_arch_fetch_caller_regs
Message-ID: <1373685434-1581-1-git-send-email-jld@mozilla.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need a perf_arch_fetch_caller_regs for at least some software events
to be able to get a callchain; even user stacks won't work without
at least the CPSR bits for non-user-mode (see perf_callchain).  In
particular, profiling context switches needs this.

This records the state of the point at which perf_arch_fetch_caller_regs
is expanded, instead of that function activation's call site, because we
need SP and PC to be consistent for EHABI unwinding; hopefully nothing
will be inconvenienced by the extra stack frame.

Signed-off-by: Jed Davis <jld@mozilla.com>
---
 arch/arm/include/asm/perf_event.h |   43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 7558775..2cc7255 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -12,6 +12,8 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
+#include <asm/ptrace.h>
+
 /*
  * The ARMv7 CPU PMU supports up to 32 event counters.
  */
@@ -28,4 +30,45 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs)	perf_misc_flags(regs)
 #endif
 
+/*
+ * We can't actually get the caller's registers here; the saved PC and
+ * SP values have to be consistent or else EHABI unwinding won't work,
+ * and the only way to find the matching SP for the return address is
+ * to unwind the current function.  So we save the current state
+ * instead.
+ *
+ * Note that the ARM Exception Handling ABI allows unwinding to depend
+ * on the contents of any core register, but our unwinder is limited
+ * to the ones in struct stackframe (which are the only ones we expect
+ * GCC to need for kernel code), so we just record those.
+ */
+#ifdef CONFIG_THUMB2_KERNEL
+#define perf_arch_fetch_caller_regs(regs, ip)				\
+	do {								\
+		__u32 _cpsr, _pc;					\
+		__asm__ __volatile__("str r7, [%[_regs], #(7 * 4)]\n\t" \
+				     "str r13, [%[_regs], #(13 * 4)]\n\t" \
+				     "str r14, [%[_regs], #(14 * 4)]\n\t" \
+				     "mov %[_pc],  r15\n\t"		\
+				     "mrs %[_cpsr], cpsr\n\t"		\
+				     : [_cpsr] "=r" (_cpsr),		\
+				       [_pc] "=r" (_pc)			\
+				     : [_regs] "r" (&(regs)->uregs)	\
+				     : "memory");			\
+		(regs)->ARM_pc = _pc;					\
+		(regs)->ARM_cpsr = _cpsr;				\
+	} while (0)
+#else
+#define perf_arch_fetch_caller_regs(regs, ip)				\
+	do {								\
+		__u32 _cpsr;						\
+		__asm__ __volatile__("stmia %[_regs11], {r11 - r15}\n\t" \
+				     "mrs %[_cpsr], cpsr\n\t"		\
+				     : [_cpsr] "=r" (_cpsr)		\
+				     : [_regs11] "r" (&(regs)->uregs[11]) \
+				     : "memory");			\
+		(regs)->ARM_cpsr = _cpsr;				\
+	} while (0)
+#endif
+
 #endif /* __ARM_PERF_EVENT_H__ */
-- 
1.7.10.4
