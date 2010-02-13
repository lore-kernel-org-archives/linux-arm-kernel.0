From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 01:18:33 +0530
Subject: [PATCH] ARM: ftrace: add ENDPROC annotations
Message-ID: <mailman.311.1271877837.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building as Thumb-2, the ".type foo, %function" annotation in
ENDPROC seems to be required in order for the assembly routines to be
recognized as Thumb-2 code.  If the ENDPROC annotations are not present,
calls to these routines are generated as BLX instead of BL.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-common.S |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 6805a72..c7a8c20 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -146,6 +146,7 @@ mcount_call:
 	bl	ftrace_stub
 	ldr	lr, [fp, #-4]			@ restore lr
 	ldmia	sp!, {r0-r3, pc}
+ENDPROC(mcount)
 
 ENTRY(ftrace_caller)
 	stmdb	sp!, {r0-r3, lr}
@@ -158,6 +159,7 @@ ftrace_call:
 	bl	ftrace_stub
 	ldr	lr, [fp, #-4]			@ restore lr
 	ldmia	sp!, {r0-r3, pc}
+ENDPROC(ftrace_caller)
 
 #else
 
@@ -179,6 +181,7 @@ gnu_trace:
 	mov	pc, r2
 	ldmia	sp!, {r0-r3, ip, lr}
 	mov	pc, ip
+ENDPROC(__gnu_mcount_nc)
 
 #ifdef CONFIG_OLD_MCOUNT
 /*
@@ -204,13 +207,14 @@ trace:
 	mov	pc, r2
 	ldr	lr, [fp, #-4]			@ restore lr
 	ldmia	sp!, {r0-r3, pc}
+ENDPROC(mcount)
 #endif
 
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-	.globl ftrace_stub
-ftrace_stub:
+ENTRY(ftrace_stub)
 	mov	pc, lr
+ENDPROC(ftrace_stub)
 
 #endif /* CONFIG_FUNCTION_TRACER */
 
-- 
1.7.0.4
