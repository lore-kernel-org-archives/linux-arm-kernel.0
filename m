From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 01:18:34 +0530
Subject: [PATCH 06/10] ARM: ftrace: add Thumb-2 support
Message-ID: <mailman.286.1270059955.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the mcount routines to build and run on a kernel built with the
Thumb-2 instruction set by correcting the following errors using the
fixes suggested by Catalin Marinas:

 - Problem: The following assembler errors appear at the "adr r0,
   ftrace_stub" instruction:

   entry-common.S: Assembler messages:
   entry-common.S:179: Error: invalid immediate for address calculation (value = 0x00000004)

   Fix: The errors don't occur with a non-global symbol, so use one.

 - Problem: The "mov lr, pc" does not set the lsb when storing the pc in
   lr.  The called function returns with "bx lr", and the mode changes
   to ARM.

   Fix: Add a label on the return address and use "adr lr, BSYM(label)".

We don't modify the old mcount because it won't be built when using
Thumb-2.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-common.S |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index c7a8c20..f5e75de 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -167,7 +167,7 @@ ENTRY(__gnu_mcount_nc)
 	stmdb	sp!, {r0-r3, lr}
 	ldr	r0, =ftrace_trace_function
 	ldr	r2, [r0]
-	adr	r0, ftrace_stub
+	adr	r0, .Lftrace_stub
 	cmp	r0, r2
 	bne	gnu_trace
 	ldmia	sp!, {r0-r3, ip, lr}
@@ -177,8 +177,9 @@ gnu_trace:
 	ldr	r1, [sp, #20]			@ lr of instrumented routine
 	mov	r0, lr
 	sub	r0, r0, #MCOUNT_INSN_SIZE
-	mov	lr, pc
+	adr	lr, BSYM(1f)
 	mov	pc, r2
+1:
 	ldmia	sp!, {r0-r3, ip, lr}
 	mov	pc, ip
 ENDPROC(__gnu_mcount_nc)
@@ -213,6 +214,7 @@ ENDPROC(mcount)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(ftrace_stub)
+.Lftrace_stub:
 	mov	pc, lr
 ENDPROC(ftrace_stub)
 
-- 
1.7.0
