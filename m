From: rabin@rab.in (Rabin Vincent)
Date: Sat, 13 Mar 2010 12:19:42 +0530
Subject: [PATCH 05/10] ARM: ftrace: add ENDPROC annotations
In-Reply-To: <1268462987-8271-1-git-send-email-rabin@rab.in>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
Message-ID: <1268462987-8271-6-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building as Thumb-2, the ".type foo, %function" annotation in
ENDPROC seems to be required in order for the assembly routines to be
recognized as Thumb-2 code.  If the ENDPROC annotations are not present,
calls to these routines are generated as BLX instead of BL.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-common.S |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 6805a72..c3bdb05 100644
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
@@ -204,13 +207,15 @@ trace:
 	mov	pc, r2
 	ldr	lr, [fp, #-4]			@ restore lr
 	ldmia	sp!, {r0-r3, pc}
+ENDPROC(mcount)
 #endif
 
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 	.globl ftrace_stub
-ftrace_stub:
+ENTRY(ftrace_stub)
 	mov	pc, lr
+ENDPROC(ftrace_stub)
 
 #endif /* CONFIG_FUNCTION_TRACER */
 
-- 
1.7.0
