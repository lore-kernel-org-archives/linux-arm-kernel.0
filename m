From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 01:18:34 +0530
Subject: [PATCH 06/10] ARM: ftrace: add Thumb-2 support
In-Reply-To: <1266090518-31120-1-git-send-email-rabin@rab.in>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
Message-ID: <1266090518-31120-7-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the mcount routines to build and run on a kernel built with the
Thumb-2 instruction set.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-common.S |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 42eb166..cd2a574 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -156,7 +156,8 @@ ENTRY(__gnu_mcount_nc)
 	stmdb	sp!, {r0-r3, lr}
 	ldr	r0, =ftrace_trace_function
 	ldr	r2, [r0]
-	adr	r0, ftrace_stub
+ THUMB(	orr	r2, r2, #1		)
+	adr	r0, BSYM(ftrace_stub)
 	cmp	r0, r2
 	bne	gnu_trace
 	ldmia	sp!, {r0-r3, ip, lr}
@@ -166,8 +167,9 @@ gnu_trace:
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
1.6.6
