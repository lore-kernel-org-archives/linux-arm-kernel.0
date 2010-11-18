From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Nov 2010 15:46:35 +0000
Subject: [PATCH 2/2] ARM: Use CTR for the I-cache line size on ARMv7
Message-ID: <20101118154635.5680.95918.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of the v7_coherent_*_range function assumes
that the D and I cache lines have the same size, which is incorrect
architecturally. This patch adds the icache_line_size macro which reads
the CTR register. The main loop in v7_coherent_*_range is split in two
independent loops or the D and I caches. This also has the performance
advantage that the DSB is moved outside the main loop.

Reported-by: Kevin Sapp <ksapp@quicinc.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-v7.S    |   27 +++++++++++++++++----------
 arch/arm/mm/proc-macros.S |   10 ++++++++++
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a3ebf7a..6136e68 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -173,15 +173,22 @@ ENTRY(v7_coherent_user_range)
  UNWIND(.fnstart		)
 	dcache_line_size r2, r3
 	sub	r3, r2, #1
-	bic	r0, r0, r3
+	bic	r12, r0, r3
 1:
- USER(	mcr	p15, 0, r0, c7, c11, 1	)	@ clean D line to the point of unification
+ USER(	mcr	p15, 0, r12, c7, c11, 1	)	@ clean D line to the point of unification
+	add	r12, r12, r2
+	cmp	r12, r1
+	blo	1b
 	dsb
- USER(	mcr	p15, 0, r0, c7, c5, 1	)	@ invalidate I line
-	add	r0, r0, r2
+	icache_line_size r2, r3
+	sub	r3, r2, #1
+	bic	r12, r0, r3
 2:
-	cmp	r0, r1
-	blo	1b
+ USER(	mcr	p15, 0, r12, c7, c5, 1	)	@ invalidate I line
+	add	r12, r12, r2
+	cmp	r12, r1
+	blo	2b
+3:
 	mov	r0, #0
 	ALT_SMP(mcr	p15, 0, r0, c7, c1, 6)	@ invalidate BTB Inner Shareable
 	ALT_UP(mcr	p15, 0, r0, c7, c5, 6)	@ invalidate BTB
@@ -194,10 +201,10 @@ ENTRY(v7_coherent_user_range)
  * isn't mapped, just try the next page.
  */
 9001:
-	mov	r0, r0, lsr #12
-	mov	r0, r0, lsl #12
-	add	r0, r0, #4096
-	b	2b
+	mov	r12, r12, lsr #12
+	mov	r12, r12, lsl #12
+	add	r12, r12, #4096
+	b	3b
  UNWIND(.fnend		)
 ENDPROC(v7_coherent_kern_range)
 ENDPROC(v7_coherent_user_range)
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index a5e2253..f8f777d 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -72,6 +72,16 @@
 	mov	\reg, \reg, lsl \tmp		@ actual cache line size
 	.endm
 
+/*
+ * icache_line_size - get the minimum I-cache line size from the CTR register
+ * on ARMv7.
+ */
+	.macro	icache_line_size, reg, tmp
+	mrc	p15, 0, \tmp, c0, c0, 1		@ read ctr
+	and	\tmp, \tmp, #0xf		@ cache line size encoding
+	mov	\reg, #4			@ bytes per word
+	mov	\reg, \reg, lsl \tmp		@ actual cache line size
+	.endm
 
 /*
  * Sanity check the PTE configuration for the code below - which makes
