From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 19 Apr 2016 12:29:33 +0200
Subject: [PATCH] arm64: mm: take CWG into account in __inval_cache_range()
Message-ID: <1461061773-19571-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the arm64 implementation of __inval_cache_range() [aka
__dma_inv_range()] takes CTR_EL0.Dminline into account for two purposes:
- the stride to use for doing by-VA cache maintenance,
- to check whether the start and end arguments are unaligned with respect
  to the cache line size, in which case the unaligned extremes need to be
  cleaned before being invalidated, to avoid corrupting adjacent unrelated
  memory contents.

In the second case, the use of Dminline is incorrect, and should use the
CWG field instead, since an invalidate operation could result in cache
lines that are larger than Dminline to be evicted at any level of the
cache hierarchy.

So introduce a macro cache_cwg_size to retrieve the CWG value, and use it
to clean as many cachelines as required on either end of the [start, end)
interval.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/cache.S       | 34 ++++++++++++++++++++++------------
 arch/arm64/mm/proc-macros.S | 13 +++++++++++++
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 6df07069a025..e5067e87e1b5 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -120,19 +120,29 @@ ENTRY(__inval_cache_range)
  *	- end     - virtual end address of region
  */
 __dma_inv_range:
-	dcache_line_size x2, x3
-	sub	x3, x2, #1
-	tst	x1, x3				// end cache line aligned?
-	bic	x1, x1, x3
-	b.eq	1f
-	dc	civac, x1			// clean & invalidate D / U line
-1:	tst	x0, x3				// start cache line aligned?
-	bic	x0, x0, x3
+	dcache_line_size x2, x3			// get Dminline in x2
+	sub	x3, x2, #1			// Dminline mask in x3
+	bic	x0, x0, x3			// align start down to line size
+
+	cache_cwg_size x4, x3			// get CWG
+	sub	x3, x4, #1			// CWG mask in x3
+
+	tst	x1, x3				// end CWG aligned?
 	b.eq	2f
-	dc	civac, x0			// clean & invalidate D / U line
-	b	3f
-2:	dc	ivac, x0			// invalidate D / U line
-3:	add	x0, x0, x2
+	bic	x5, x1, x3
+0:	dc	civac, x5			// clean & invalidate D / U line
+	add	x5, x5, x2
+	tst	x5, x3
+	b.ne	0b
+	b	2f
+
+1:	dc	civac, x0			// clean & invalidate D / U line
+	add	x0, x0, x2
+2:	tst	x0, x3				// start CWG aligned?
+	b.ne	1b
+
+	dc	ivac, x0			// invalidate D / U line
+	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	2b
 	dsb	sy
diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
index e6a30e1268a8..872299ce3081 100644
--- a/arch/arm64/mm/proc-macros.S
+++ b/arch/arm64/mm/proc-macros.S
@@ -54,6 +54,19 @@
 	.endm
 
 /*
+ * cache_cwg_size - get the maximum cache line size from the CTR register
+ */
+	.macro	cache_cwg_size, reg, tmp
+	mrs	\tmp, ctr_el0			// read CTR
+	ubfm	\tmp, \tmp, #24, #27		// CTR_EL0.CWG [27:24]
+	mov	\reg, #9			// use architectural default of
+	cmp	\tmp, xzr			// 2 KB (2^9 words) if CWG is
+	csel	\tmp, \tmp, \reg, ne		// not provided
+	mov	\reg, #4			// bytes per word
+	lsl	\reg, \reg, \tmp		// actual cache line size
+	.endm
+
+/*
  * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
  */
 	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
-- 
2.5.0
