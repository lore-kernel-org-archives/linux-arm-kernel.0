From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Mar 2018 15:13:23 +0200
Subject: [PATCH resend v2 2/2] arm64: assembler: add macros to conditionally
 yield the NEON under PREEMPT
In-Reply-To: <20180329131323.15881-1-ard.biesheuvel@linaro.org>
References: <20180329131323.15881-1-ard.biesheuvel@linaro.org>
Message-ID: <20180329131323.15881-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support macros to conditionally yield the NEON (and thus the CPU)
that may be called from the assembler code.

In some cases, yielding the NEON involves saving and restoring a non
trivial amount of context (especially in the CRC folding algorithms),
and so the macro is split into three, and the code in between is only
executed when the yield path is taken, allowing the context to be preserved.
The third macro takes an optional label argument that marks the resume
path after a yield has been performed.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/assembler.h | 73 ++++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c    |  3 +
 2 files changed, 76 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index fe2ff3efe1f0..0bcc98dbba56 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -628,4 +628,77 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.endif
 	.endm
 
+/*
+ * Check whether to yield to another runnable task from kernel mode NEON code
+ * (which runs with preemption disabled).
+ *
+ * if_will_cond_yield_neon
+ *        // pre-yield patchup code
+ * do_cond_yield_neon
+ *        // post-yield patchup code
+ * endif_yield_neon    <label>
+ *
+ * where <label> is optional, and marks the point where execution will resume
+ * after a yield has been performed. If omitted, execution resumes right after
+ * the endif_yield_neon invocation. Note that the entire sequence, including
+ * the provided patchup code, will be omitted from the image if CONFIG_PREEMPT
+ * is not defined.
+ *
+ * As a convenience, in the case where no patchup code is required, the above
+ * sequence may be abbreviated to
+ *
+ * cond_yield_neon <label>
+ *
+ * Note that the patchup code does not support assembler directives that change
+ * the output section, any use of such directives is undefined.
+ *
+ * The yield itself consists of the following:
+ * - Check whether the preempt count is exactly 1, in which case disabling
+ *   preemption once will make the task preemptible. If this is not the case,
+ *   yielding is pointless.
+ * - Check whether TIF_NEED_RESCHED is set, and if so, disable and re-enable
+ *   kernel mode NEON (which will trigger a reschedule), and branch to the
+ *   yield fixup code.
+ *
+ * This macro sequence may clobber all CPU state that is not guaranteed by the
+ * AAPCS to be preserved across an ordinary function call.
+ */
+
+	.macro		cond_yield_neon, lbl
+	if_will_cond_yield_neon
+	do_cond_yield_neon
+	endif_yield_neon	\lbl
+	.endm
+
+	.macro		if_will_cond_yield_neon
+#ifdef CONFIG_PREEMPT
+	get_thread_info	x0
+	ldr		w1, [x0, #TSK_TI_PREEMPT]
+	ldr		x0, [x0, #TSK_TI_FLAGS]
+	cmp		w1, #PREEMPT_DISABLE_OFFSET
+	csel		x0, x0, xzr, eq
+	tbnz		x0, #TIF_NEED_RESCHED, .Lyield_\@	// needs rescheduling?
+	/* fall through to endif_yield_neon */
+	.subsection	1
+.Lyield_\@ :
+#else
+	.section	".discard.cond_yield_neon", "ax"
+#endif
+	.endm
+
+	.macro		do_cond_yield_neon
+	bl		kernel_neon_end
+	bl		kernel_neon_begin
+	.endm
+
+	.macro		endif_yield_neon, lbl
+	.ifnb		\lbl
+	b		\lbl
+	.else
+	b		.Lyield_out_\@
+	.endif
+	.previous
+.Lyield_out_\@ :
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 1303e04110cd..b7c33642de6e 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/kvm_host.h>
+#include <linux/preempt.h>
 #include <linux/suspend.h>
 #include <asm/cpufeature.h>
 #include <asm/fixmap.h>
@@ -93,6 +94,8 @@ int main(void)
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
   DEFINE(DMA_FROM_DEVICE,	DMA_FROM_DEVICE);
   BLANK();
+  DEFINE(PREEMPT_DISABLE_OFFSET, PREEMPT_DISABLE_OFFSET);
+  BLANK();
   DEFINE(CLOCK_REALTIME,	CLOCK_REALTIME);
   DEFINE(CLOCK_MONOTONIC,	CLOCK_MONOTONIC);
   DEFINE(CLOCK_MONOTONIC_RAW,	CLOCK_MONOTONIC_RAW);
-- 
2.11.0
