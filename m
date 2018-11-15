From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Nov 2018 22:42:02 +0000
Subject: [PATCH 5/6] arm64: ftrace: remove return_regs macros
In-Reply-To: <20181115224203.24847-1-mark.rutland@arm.com>
References: <20181115224203.24847-1-mark.rutland@arm.com>
Message-ID: <20181115224203.24847-6-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The save_return_regs and restore_return_regs macros are only used by
return_to_handler, and having them defined out-of-line only serves to
obscure the logic.

Before we complicate, let's clean this up and fold the logic directly
into return_to_handler, saving a few lines of macro boilerplate in the
process. At the same time, a missing trailing space is added to the
comments, fixing a code style violation.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Torsten Duwe <duwe@suse.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry-ftrace.S | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index a74d2ff49192..6b8230f79a67 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -172,24 +172,6 @@ ENTRY(ftrace_stub)
 ENDPROC(ftrace_stub)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	/* save return value regs*/
-	.macro save_return_regs
-	sub sp, sp, #64
-	stp x0, x1, [sp]
-	stp x2, x3, [sp, #16]
-	stp x4, x5, [sp, #32]
-	stp x6, x7, [sp, #48]
-	.endm
-
-	/* restore return value regs*/
-	.macro restore_return_regs
-	ldp x0, x1, [sp]
-	ldp x2, x3, [sp, #16]
-	ldp x4, x5, [sp, #32]
-	ldp x6, x7, [sp, #48]
-	add sp, sp, #64
-	.endm
-
 /*
  * void ftrace_graph_caller(void)
  *
@@ -215,11 +197,24 @@ ENDPROC(ftrace_graph_caller)
  * @fp is checked against the value passed by ftrace_graph_caller().
  */
 ENTRY(return_to_handler)
-	save_return_regs
+	/* save return value regs */
+	sub sp, sp, #64
+	stp x0, x1, [sp]
+	stp x2, x3, [sp, #16]
+	stp x4, x5, [sp, #32]
+	stp x6, x7, [sp, #48]
+
 	mov	x0, x29			//     parent's fp
 	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
 	mov	x30, x0			// restore the original return address
-	restore_return_regs
+
+	/* restore return value regs */
+	ldp x0, x1, [sp]
+	ldp x2, x3, [sp, #16]
+	ldp x4, x5, [sp, #32]
+	ldp x6, x7, [sp, #48]
+	add sp, sp, #64
+
 	ret
 END(return_to_handler)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.11.0
