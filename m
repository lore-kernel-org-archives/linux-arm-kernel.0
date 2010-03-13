From: rabin@rab.in (Rabin Vincent)
Date: Sat, 13 Mar 2010 12:19:43 +0530
Subject: [PATCH 06/10] ARM: ftrace: add Thumb-2 support
In-Reply-To: <1268462987-8271-1-git-send-email-rabin@rab.in>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
Message-ID: <1268462987-8271-7-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the mcount routines to build and run on a kernel built with the
Thumb-2 instruction set:

 - Without the BSYM, the following assembler errors appear:

   entry-common.S: Assembler messages:
   entry-common.S:179: Error: invalid immediate for address calculation (value = 0x00000004)

 - Without the orr, the lsb is not set on the pointer loaded from
   ftrace_trace_function, but is set on BSYM(ftrace_stub), leading to the
   comparison failing even when the pointer is pointing to ftrace_stub.

 - The problem with the "mov lr, pc", is that it does not set the lsb when
   storing the pc in lr.  The called function returns with "bx lr", and the
   mode changes to ARM.  The blx is to avoid this.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-common.S |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index c3bdb05..573ed3b 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -167,7 +167,8 @@ ENTRY(__gnu_mcount_nc)
 	stmdb	sp!, {r0-r3, lr}
 	ldr	r0, =ftrace_trace_function
 	ldr	r2, [r0]
-	adr	r0, ftrace_stub
+ THUMB(	orr	r2, r2, #1		)
+	adr	r0, BSYM(ftrace_stub)
 	cmp	r0, r2
 	bne	gnu_trace
 	ldmia	sp!, {r0-r3, ip, lr}
@@ -177,8 +178,9 @@ gnu_trace:
 	ldr	r1, [sp, #20]			@ lr of instrumented routine
 	mov	r0, lr
 	sub	r0, r0, #MCOUNT_INSN_SIZE
-	mov	lr, pc
-	mov	pc, r2
+ ARM(	mov	lr, pc			)
+ ARM(	mov	pc, r2			)
+ THUMB(	blx	r2			)
 	ldmia	sp!, {r0-r3, ip, lr}
 	mov	pc, ip
 ENDPROC(__gnu_mcount_nc)
-- 
1.7.0
