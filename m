From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 15 Jan 2013 16:48:16 +0000
Subject: [RFC PATCH 2/4] ARM: b.L: vlocks: Add architecturally required memory
 barriers
In-Reply-To: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1358268498-8086-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For architectural correctness even Strongly-Ordered memory accesses
require barriers in order to guarantee that multiple CPUs have a
coherent view of the ordering of memory accesses.

Whether or not this matters depends on hardware implementation
details of the memory system.

Since the purpose of this code is to provide a clean, generic
locking mechanism with no platform-specific dependencies the
barriers should be present to avoid unpleasant surprises on future
platforms.

This patch adds the required barriers.

Note:

  * When taking the lock, we don't care about implicit background
    memory operations and other signalling which may be pending,
    because those are not part of the critical section anyway.

    A DMB is sufficient to ensure correctly observed ordering if
    the explicit memory accesses in vlock_trylock.

  * No barrier is required after checking the election result,
    because the result is determined by the store st
    VLOCK_OWNER_OFFSET and is already globally observed due to the
    barriers in voting_end.  This means that global agreement on
    the winner is guaranteed, even before the winner is known
    locally.

  * The magic to guarantee correct barrierless access to the vlocks
    by aligning them in memory now makes no sense and is removed.
    However, we must still ensure that these don't share a
    cacheline with anything else.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/common/bL_head.S |   19 -------------------
 arch/arm/common/vlock.S   |    7 +++++--
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/arm/common/bL_head.S b/arch/arm/common/bL_head.S
index 314d4ae..fd71ff6 100644
--- a/arch/arm/common/bL_head.S
+++ b/arch/arm/common/bL_head.S
@@ -187,26 +187,7 @@ ENDPROC(bL_entry_point)
 
 	.bss
 
-	@ Magic to size and align the first-man vlock structures
-	@ so that each does not cross a 1KB boundary.
-	@ We also must ensure that none of these shares a cacheline with
-	@ any data which might be accessed through the cache.
-
-	.equ	.Log2, 0
-	.rept	11
-		.if (1 << .Log2) < VLOCK_SIZE
-			.equ .Log2, .Log2 + 1
-		.endif
-	.endr
-	.if	.Log2 > 10
-		.error "vlock struct is too large for guaranteed barrierless access ordering"
-	.endif
-	.equ	.Lvlock_size, 1 << .Log2
-
-	@ The presence of two .align directives here is deliberate: we must
-	@ align to whichever of the two boundaries is larger:
 	.align	__CACHE_WRITEBACK_ORDER
-	.align	.Log2
 first_man_locks:
 	.rept	BL_NR_CLUSTERS
 	.space	.Lvlock_size
diff --git a/arch/arm/common/vlock.S b/arch/arm/common/vlock.S
index 0a1ee3a..f55744f 100644
--- a/arch/arm/common/vlock.S
+++ b/arch/arm/common/vlock.S
@@ -39,10 +39,11 @@
 .macro voting_begin rbase:req, rcpu:req, rscratch:req
 	mov	\rscratch, #1
 	strb	\rscratch, [\rbase, \rcpu]
-	dsb
+	dmb
 .endm
 
 .macro voting_end rbase:req, rcpu:req, rscratch:req
+	dmb
 	mov	\rscratch, #0
 	strb	\rscratch, [\rbase, \rcpu]
 	dsb
@@ -68,6 +69,7 @@ ENTRY(vlock_trylock)
 	cmp	r2, #VLOCK_OWNER_NONE
 	bne	trylock_fail			@ fail if so
 
+	dmb
 	strb	r1, [r0, #VLOCK_OWNER_OFFSET]	@ submit my vote
 
 	voting_end	r0, r1, r2
@@ -87,6 +89,7 @@ ENTRY(vlock_trylock)
 
 	@ Check who won:
 
+	dmb
 	ldrb	r2, [r0, #VLOCK_OWNER_OFFSET]
 	eor	r0, r1, r2			@ zero if I won, else nonzero
 	bx	lr
@@ -99,8 +102,8 @@ ENDPROC(vlock_trylock)
 
 @ r0: lock structure base
 ENTRY(vlock_unlock)
+	dmb
 	mov	r1, #VLOCK_OWNER_NONE
-	dsb
 	strb	r1, [r0, #VLOCK_OWNER_OFFSET]
 	dsb
 	sev
-- 
1.7.4.1
