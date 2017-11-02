From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 2 Nov 2017 13:43:07 +0900
Subject: [PATCH 1/2] arm64: Fix static use of function graph
In-Reply-To: <1509546824-46165-2-git-send-email-julien.thierry@arm.com>
References: <1509546824-46165-1-git-send-email-julien.thierry@arm.com>
 <1509546824-46165-2-git-send-email-julien.thierry@arm.com>
Message-ID: <20171102044306.GL10563@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 02:33:43PM +0000, Julien Thierry wrote:
> Function graph does not work currently when CONFIG_DYNAMIC_TRACE is not
> set. This is because ftrace_function_trace is not always set to ftrace_stub
> when function_graph is in use.
> 
> Do not skip checking of graph tracer functions when ftrace_function_trace
> is set.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>

Reviewed-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

I think that arm has the same issue, hoping the following patch
will fix it:
===
>From e25bcf50d1acde698285a0c64f72d97f8b17e3fb Mon Sep 17 00:00:00 2001
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Thu, 2 Nov 2017 11:35:04 +0900
Subject: [PATCH] arm: ftrace: function_graph with DYNAMIC_FTRACE

---
 arch/arm/kernel/entry-ftrace.S | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index efcd9f25a14b..ef94c73ad996 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -68,8 +68,12 @@
 	ldr	r2, [r0]
 	adr	r0, .Lftrace_stub
 	cmp	r0, r2
-	bne	1f
+	beq	1f
 
+ 	mcount_get_lr	r1			@ lr of instrumented func
+	mcount_adjust_addr	r0, lr		@ instrumented function
+	blx	r2
+1:
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	ldr     r1, =ftrace_graph_return
 	ldr     r2, [r1]
@@ -84,12 +88,6 @@
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
2.14.1
