From: rabin@rab.in (Rabin Vincent)
Date: Mon, 21 Apr 2014 20:07:44 +0200
Subject: [PATCH] ARM: fix v7-M signal return
Message-ID: <1398103664-23078-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the ARM ARM, the behaviour is UNDPREDICTABLE if the PC read
from the exception return stack is not half word aligned.  See the
pseudo code for ExceptionReturn() and PopStack().

The signal handler's address has the bit 0 set, and setup_return()
directly writes this to regs->ARM_pc.  Mask out bit 0 before the
exception return to get predictable behaviour.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/entry-header.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 1420725..ef72f4b 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -133,6 +133,7 @@
 	biceq	r5, V7M_xPSR_FRAMEPTRALIGN
 
 	@ write basic exception frame
+	bic	r4, r4, #1
 	stmdb	r2!, {r1, r3-r5}
 	ldmia	sp, {r1, r3-r5}
 	.if	\ret_r0
-- 
1.9.1
