From: rabin@rab.in (Rabin Vincent)
Date: Sat, 23 Mar 2013 23:10:49 +0100
Subject: [PATCH] ARM: add unwind annotations to ftrace asm
Message-ID: <1364076649-16841-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add unwind annotations to the ftrace assembly code so that the function
tracer's stacktracing options (func_stack_trace, etc.) work when
CONFIG_ARM_UNWIND is enabled.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-common.S |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3248cde..fefd7f9 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -276,7 +276,13 @@ ENDPROC(ftrace_graph_caller_old)
  */
 
 .macro mcount_enter
+/*
+ * This pad compensates for the push {lr} at the call site.  Note that we are
+ * unable to unwind through a function which does not otherwise save its lr.
+ */
+ UNWIND(.pad	#4)
 	stmdb	sp!, {r0-r3, lr}
+ UNWIND(.save	{r0-r3, lr})
 .endm
 
 .macro mcount_get_lr reg
@@ -289,6 +295,7 @@ ENDPROC(ftrace_graph_caller_old)
 .endm
 
 ENTRY(__gnu_mcount_nc)
+UNWIND(.fnstart)
 #ifdef CONFIG_DYNAMIC_FTRACE
 	mov	ip, lr
 	ldmia	sp!, {lr}
@@ -296,17 +303,22 @@ ENTRY(__gnu_mcount_nc)
 #else
 	__mcount
 #endif
+UNWIND(.fnend)
 ENDPROC(__gnu_mcount_nc)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 ENTRY(ftrace_caller)
+UNWIND(.fnstart)
 	__ftrace_caller
+UNWIND(.fnend)
 ENDPROC(ftrace_caller)
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 ENTRY(ftrace_graph_caller)
+UNWIND(.fnstart)
 	__ftrace_graph_caller
+UNWIND(.fnend)
 ENDPROC(ftrace_graph_caller)
 #endif
 
-- 
1.7.10.4
