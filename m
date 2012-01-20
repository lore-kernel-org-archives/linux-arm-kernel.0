From: rabin@rab.in (Rabin Vincent)
Date: Fri, 20 Jan 2012 11:28:22 +0530
Subject: [PATCHv2] ARM: ftrace: clear zero bit in reported IPs for Thumb-2
In-Reply-To: <20111202124417.GA2892@localhost.localdomain>
References: <20111202124417.GA2892@localhost.localdomain>
Message-ID: <1327039102-17754-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dynamic ftrace ops startup test currently fails on Thumb-2 kernels:

 Testing tracer function: PASSED
 Testing dynamic ftrace: PASSED
 Testing dynamic ftrace ops #1: (0 0 0 0 0) FAILED!

This is because while the addresses in the mcount records do not have
the zero bit set, the IP reported by the mcount call does have it set
(because it is copied from the LR).  This mismatch causes the ops
filtering in ftrace_ops_list_func() to not call the relevant tracers.

Fix this by clearing the zero bit before adjusting the LR for the mcount
instruction size.  Also, combine the mov+sub into a single sub
instruction.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
v2: use bic

 arch/arm/kernel/entry-common.S |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index b2a27b6..683195c 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -149,6 +149,11 @@ ENDPROC(ret_from_fork)
 #endif
 #endif
 
+.macro mcount_adjust_addr rd, rn
+	bic	\rd, \rn, #1		@ clear the Thumb bit if present
+	sub	\rd, \rd, #MCOUNT_INSN_SIZE
+.endm
+
 .macro __mcount suffix
 	mcount_enter
 	ldr	r0, =ftrace_trace_function
@@ -173,8 +178,7 @@ ENDPROC(ret_from_fork)
 	mcount_exit
 
 1: 	mcount_get_lr	r1			@ lr of instrumented func
-	mov	r0, lr				@ instrumented function
-	sub	r0, r0, #MCOUNT_INSN_SIZE
+	mcount_adjust_addr	r0, lr		@ instrumented function
 	adr	lr, BSYM(2f)
 	mov	pc, r2
 2:	mcount_exit
@@ -184,8 +188,7 @@ ENDPROC(ret_from_fork)
 	mcount_enter
 
 	mcount_get_lr	r1			@ lr of instrumented func
-	mov	r0, lr				@ instrumented function
-	sub	r0, r0, #MCOUNT_INSN_SIZE
+	mcount_adjust_addr	r0, lr		@ instrumented function
 
 	.globl ftrace_call\suffix
 ftrace_call\suffix:
@@ -205,11 +208,11 @@ ftrace_graph_call\suffix:
 #ifdef CONFIG_DYNAMIC_FTRACE
 	@ called from __ftrace_caller, saved in mcount_enter
 	ldr	r1, [sp, #16]		@ instrumented routine (func)
+	mcount_adjust_addr	r1, r1
 #else
 	@ called from __mcount, untouched in lr
-	mov	r1, lr			@ instrumented routine (func)
+	mcount_adjust_addr	r1, lr	@ instrumented routine (func)
 #endif
-	sub	r1, r1, #MCOUNT_INSN_SIZE
 	mov	r2, fp			@ frame pointer
 	bl	prepare_ftrace_return
 	mcount_exit
-- 
1.7.7.3
