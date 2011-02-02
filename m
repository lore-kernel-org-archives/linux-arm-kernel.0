From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  2 Feb 2011 18:53:44 +0000
Subject: [PATCH] ARM: bitops: Fix low-level code to be Thumb-2 compatible
Message-ID: <1296672824-22743-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new bitops code cunningly str <Rt>, [r1, -r1] to trigger
a fault by attempting to store to address zero.

This code doesn't assemble in Thumb-2, since Thumb-2 doesn't
allow negative register offsets at all for loads and stores.

The patch loads 0 into r2 and uses that as a base register
instead for the Thumb-2 case: r2 seems non-live at every
instance of this problem.

The ARM case is unaffected.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/lib/bitops.h |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index f8a2bd3..87d6b17 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -1,7 +1,9 @@
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, instr
 	tst	r1, #3
-	strne	r1, [r1, -r1]		@ assert word-aligned
+ ARM(	strne	r1, [r1, -r1]	)	@ assert word-aligned
+ THUMB(	movne	r2, #0		)
+ THUMB(	strne	r1, [r2]	)
 	mov	r2, #1
 	and	r3, r0, #31		@ Get bit offset
 	mov	r0, r0, lsr #5
@@ -17,7 +19,9 @@
 
 	.macro	testop, instr, store
 	tst	r1, #3
-	strne	r1, [r1, -r1]		@ assert word-aligned
+ ARM(	strne	r1, [r1, -r1]	)	@ assert word-aligned
+ THUMB(	movne	r2, #0		)
+ THUMB(	strne	r1, [r2]	)
 	mov	r2, #1
 	and	r3, r0, #31		@ Get bit offset
 	mov	r0, r0, lsr #5
@@ -38,7 +42,9 @@
 #else
 	.macro	bitop, instr
 	tst	r1, #3
-	strne	r1, [r1, -r1]		@ assert word-aligned
+ ARM(	strne	r1, [r1, -r1]	)	@ assert word-aligned
+ THUMB(	movne	r2, #0		)
+ THUMB(	strne	r1, [r2]	)
 	and	r2, r0, #31
 	mov	r0, r0, lsr #5
 	mov	r3, #1
@@ -61,7 +67,9 @@
  */
 	.macro	testop, instr, store
 	tst	r1, #3
-	strne	r1, [r1, -r1]		@ assert word-aligned
+ ARM(	strne	r1, [r1, -r1]	)	@ assert word-aligned
+ THUMB(	movne	r2, #0		)
+ THUMB(	strne	r1, [r2]	)
 	and	r3, r0, #31
 	mov	r0, r0, lsr #5
 	save_and_disable_irqs ip
-- 
1.7.1
