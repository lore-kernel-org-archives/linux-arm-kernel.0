From: grgupta@ti.com (Gupta, Ramesh)
Date: Tue, 19 Jun 2012 16:51:28 +0530
Subject: [PATCH v2 3/4] ARM: add flush_mem api for ARMv7
Message-ID: <CADysL2ZDtJf1P+2jAsRJbczaowTwTbhXqNt3dpd5dFL4df0RSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 635d33cf6c6758fb2063aa2adc03b69ce0d2799a Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Fri, 15 Jun 2012 16:45:41 +0530
Subject: [PATCH v2 3/4] ARM: add flush_mem api for ARMv7

Added flush_mem cache maintenance api for ARMv7.
The implementation is based on dma_flush_range.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/mm/cache-v7.S |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a655d3d..2e041c8 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -322,6 +322,27 @@ ENTRY(v7_dma_flush_range)
 	dsb
 	mov	pc, lr
 ENDPROC(v7_dma_flush_range)
+/*
+ *	v7_flush_mem(start,end)
+ *	- start   - virtual start address of region
+ *	- end     - virtual end address of region
+ */
+ENTRY(v7_flush_mem)
+	dcache_line_size r2, r3
+	sub	r3, r2, #1
+	bic	r0, r0, r3
+#ifdef CONFIG_ARM_ERRATA_764369
+	ALT_SMP(W(dsb))
+	ALT_UP(W(nop))
+#endif
+1:
+	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
+	add	r0, r0, r2
+	cmp	r0, r1
+	blo	1b
+	dsb
+	mov	pc, lr
+ENDPROC(v7_flush_mem)

 /*
  *	dma_map_area(start, size, dir)
-- 
1.7.0.4


-- 
regards
Ramesh Gupta G
