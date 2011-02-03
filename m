From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  3 Feb 2011 18:07:14 +0000
Subject: [PATCH v2] ARM: bitops: Use BX instead of MOV PC,LR
Message-ID: <1296756434-26221-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel doesn't officially need to interwork, but using BX
wherever appropriate will help educate people into good assembler
coding habits.

BX is appropriate here because this code is predicated on
__LINUX_ARM_ARCH__ >= 6

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/lib/bitops.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index a9d9d15..5527e23 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -12,7 +12,7 @@
 	strex	r0, r2, [r1]
 	cmp	r0, #0
 	bne	1b
-	mov	pc, lr
+	bx	lr
 	.endm
 
 	.macro	testop, instr, store
@@ -33,7 +33,7 @@
 	smp_dmb
 	cmp	r0, #0
 	movne	r0, #1
-2:	mov	pc, lr
+2:	bx	lr
 	.endm
 #else
 	.macro	bitop, instr
-- 
1.7.1
