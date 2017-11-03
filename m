From: julien.thierry@arm.com (Julien Thierry)
Date: Fri,  3 Nov 2017 11:44:17 +0000
Subject: [PATCH v2 2/3] arm: ftrace: function_graph with DYNAMIC_FTRACE
In-Reply-To: <1509709458-44541-1-git-send-email-julien.thierry@arm.com>
References: <1509709458-44541-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1509709458-44541-3-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function graph does not work currently when CONFIG_DYNAMIC_TRACE is not
set. This is because ftrace_function_trace is not always set to ftrace_stub
when function_graph is in use.

Do not skip checking of graph tracer functions when ftrace_function_trace
is set.

Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/kernel/entry-ftrace.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Takahiro's patch was not signed-off, let me know if I need to change the
Suggested-by into a Signed-off-by.

diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index efcd9f2..e3555f8 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -68,7 +68,13 @@
 	ldr	r2, [r0]
 	adr	r0, .Lftrace_stub
 	cmp	r0, r2
-	bne	1f
+	beq	1f
+
+	mcount_get_lr	r1			@ lr of instrumented func
+	mcount_adjust_addr	r0, lr		@ instrumented function
+	badr	lr, 1f
+	mov	pc, r2
+1:

 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	ldr     r1, =ftrace_graph_return
@@ -84,12 +90,6 @@
 #endif

 	mcount_exit
-
-1: 	mcount_get_lr	r1			@ lr of instrumented func
-	mcount_adjust_addr	r0, lr		@ instrumented function
-	badr	lr, 2f
-	mov	pc, r2
-2:	mcount_exit
 .endm

 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
--
1.9.1
