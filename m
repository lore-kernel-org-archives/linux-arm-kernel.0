From: abelvesa@linux.com (Abel Vesa)
Date: Tue,  6 Dec 2016 17:06:04 +0000
Subject: [PATCH 4/7] arm: Add ftrace with regs support
In-Reply-To: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
Message-ID: <1481043967-15602-5-git-send-email-abelvesa@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds __ftrace_regs_caller which, unlike __ftrace_caller,
adds register saving/restoring and livepatch handling if
the pc register gets modified by klp_ftrace_handler.

Signed-off-by: Abel Vesa <abelvesa@linux.com>
---
 arch/arm/kernel/entry-ftrace.S | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index c73c403..b6ada5c 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -92,6 +92,46 @@
 2:	mcount_exit
 .endm
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+
+.macro __ftrace_regs_caller suffix
+
+	stmdb	sp!, {r0-r15}
+	mov	r3, sp
+
+	ldr	r10, [sp, #60]
+
+	mcount_get_lr   r1                      @ lr of instrumented func
+	mcount_adjust_addr	r0, lr		@ instrumented function
+
+	.globl ftrace_regs_call\suffix
+ftrace_regs_call\suffix:
+	bl	ftrace_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl ftrace_regs_graph_call\suffix
+ftrace_regs_graph_call\suffix:
+	mov	r0, r0
+#endif
+#ifdef CONFIG_LIVEPATCH
+	ldr	r0, [sp, #60]
+	cmp	r0, r10
+	beq	ftrace_regs_caller_end
+	ldmia	sp!, {r0-r12}
+	add	sp, sp, #8
+	ldmia	sp!, {r11}
+	sub	sp, r12, #16
+	str	r11, [sp, #12]
+	ldmia	sp!, {r11, r12, lr, pc}
+#endif
+ftrace_regs_caller_end\suffix:
+	ldmia	sp!, {r0-r14}
+	add	sp, sp, #4
+	mov	pc, lr
+.endm
+
+#endif
+
 .macro __ftrace_caller suffix
 	mcount_enter
 
@@ -212,6 +252,15 @@ UNWIND(.fnstart)
 	__ftrace_caller
 UNWIND(.fnend)
 ENDPROC(ftrace_caller)
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+ENTRY(ftrace_regs_caller)
+UNWIND(.fnstart)
+	__ftrace_regs_caller
+UNWIND(.fnend)
+ENDPROC(ftrace_regs_caller)
+#endif
+
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-- 
2.7.4
