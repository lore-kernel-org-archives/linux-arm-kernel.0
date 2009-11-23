From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 10:26:17 +0000
Subject: [PATCH 7/7] ARM: dma-mapping: no need to clean overlapping cache
	lines on invalidate
In-Reply-To: <alpine.LFD.2.00.0911221714190.2059@xanadu.home>
References: <alpine.LFD.2.00.0911221714190.2059@xanadu.home>
Message-ID: <E1NCW7d-0000kn-Rt@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now clean the DMA buffers on map, there's no need to clean
overlapping cache lines on invalidation anymore.  (Note: the DMA API
prohibits other data sharing the same cache line as a DMA buffer
anyway.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-fa.S      |    5 -----
 arch/arm/mm/cache-v4wb.S    |    5 -----
 arch/arm/mm/cache-v6.S      |   13 -------------
 arch/arm/mm/cache-v7.S      |    6 ------
 arch/arm/mm/proc-arm1020.S  |    8 --------
 arch/arm/mm/proc-arm1020e.S |    4 ----
 arch/arm/mm/proc-arm1022.S  |    4 ----
 arch/arm/mm/proc-arm1026.S  |    4 ----
 arch/arm/mm/proc-arm920.S   |    4 ----
 arch/arm/mm/proc-arm922.S   |    4 ----
 arch/arm/mm/proc-arm925.S   |    6 ------
 arch/arm/mm/proc-arm926.S   |    6 ------
 arch/arm/mm/proc-arm946.S   |    7 -------
 arch/arm/mm/proc-feroceon.S |    8 --------
 arch/arm/mm/proc-mohawk.S   |    4 ----
 arch/arm/mm/proc-xsc3.S     |    4 ----
 arch/arm/mm/proc-xscale.S   |    4 ----
 17 files changed, 0 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index b63a8f7..1711386 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -157,12 +157,7 @@ ENTRY(fa_flush_kern_dcache_page)
  *	- end	 - virtual end address
  */
 ENTRY(fa_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	bic	r1, r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index 2ebc1b3..553931a 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -173,16 +173,11 @@ ENTRY(v4wb_coherent_user_range)
  *	- end	 - virtual end address
  */
 ENTRY(v4wb_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 295e25d..d1dfd87 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -195,20 +195,7 @@ ENTRY(v6_flush_kern_dcache_page)
  *	- end     - virtual end address of region
  */
 ENTRY(v6_dma_inv_range)
-	tst	r0, #D_CACHE_LINE_SIZE - 1
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
-#ifdef HARVARD_CACHE
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D line
-#else
-	mcrne	p15, 0, r0, c7, c11, 1		@ clean unified line
-#endif
-	tst	r1, #D_CACHE_LINE_SIZE - 1
-	bic	r1, r1, #D_CACHE_LINE_SIZE - 1
-#ifdef HARVARD_CACHE
-	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D line
-#else
-	mcrne	p15, 0, r1, c7, c15, 1		@ clean & invalidate unified line
-#endif
 1:
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index e1bd975..893ee59 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -218,13 +218,7 @@ ENDPROC(v7_flush_kern_dcache_page)
 ENTRY(v7_dma_inv_range)
 	dcache_line_size r2, r3
 	sub	r3, r2, #1
-	tst	r0, r3
 	bic	r0, r0, r3
-	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
-
-	tst	r1, r3
-	bic	r1, r1, r3
-	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D / U line
 1:
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
 	add	r0, r0, r2
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index d9fb4b9..7bbf624 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -267,15 +267,7 @@ ENTRY(arm1020_flush_kern_dcache_page)
 ENTRY(arm1020_dma_inv_range)
 	mov	ip, #0
 #ifndef CONFIG_CPU_DCACHE_DISABLE
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, ip, c7, c10, 4
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, ip, c7, c10, 4
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-	mcrne	p15, 0, ip, c7, c10, 4		@ drain WB
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index 7453b75..d379cb7 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -260,11 +260,7 @@ ENTRY(arm1020e_flush_kern_dcache_page)
 ENTRY(arm1020e_dma_inv_range)
 	mov	ip, #0
 #ifndef CONFIG_CPU_DCACHE_DISABLE
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index 8eb72d7..f5a7949 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -249,11 +249,7 @@ ENTRY(arm1022_flush_kern_dcache_page)
 ENTRY(arm1022_dma_inv_range)
 	mov	ip, #0
 #ifndef CONFIG_CPU_DCACHE_DISABLE
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 3b59f0d..1dc26f8 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -243,11 +243,7 @@ ENTRY(arm1026_flush_kern_dcache_page)
 ENTRY(arm1026_dma_inv_range)
 	mov	ip, #0
 #ifndef CONFIG_CPU_DCACHE_DISABLE
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 2b7c197..078a873 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -239,11 +239,7 @@ ENTRY(arm920_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(arm920_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index 06a1aa4..22ca857 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -241,11 +241,7 @@ ENTRY(arm922_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(arm922_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index cb53435..ff04299 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -283,12 +283,6 @@ ENTRY(arm925_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(arm925_dma_inv_range)
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-#endif
 	bic	r0, r0, #CACHE_DLINESIZE - 1
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 1c48487..4b4c717 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -246,12 +246,6 @@ ENTRY(arm926_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(arm926_dma_inv_range)
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-#endif
 	bic	r0, r0, #CACHE_DLINESIZE - 1
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 40c0449..589a61c 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -215,18 +215,11 @@ ENTRY(arm946_flush_kern_dcache_page)
  * (same as arm926)
  */
 ENTRY(arm946_dma_inv_range)
-#ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
-#endif
 	bic	r0, r0, #CACHE_DLINESIZE - 1
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
 	mov	pc, lr
 
 /*
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index d0d7795..1262b92 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -274,11 +274,7 @@ ENTRY(feroceon_range_flush_kern_dcache_page)
  */
 	.align	5
 ENTRY(feroceon_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
 	bic	r0, r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
@@ -289,10 +285,6 @@ ENTRY(feroceon_dma_inv_range)
 	.align	5
 ENTRY(feroceon_range_dma_inv_range)
 	mrs	r2, cpsr
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 	cmp	r1, r0
 	subne	r1, r1, #1			@ top address is inclusive
 	orr	r3, r2, #PSR_I_BIT
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 52b5fd7..191ea6d 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -218,10 +218,6 @@ ENTRY(mohawk_flush_kern_dcache_page)
  * (same as v4wb)
  */
 ENTRY(mohawk_dma_inv_range)
-	tst	r0, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHE_DLINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 	bic	r0, r0, #CACHE_DLINESIZE - 1
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHE_DLINESIZE
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 2028f37..2c1ac69 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -257,11 +257,7 @@ ENTRY(xsc3_flush_kern_dcache_page)
  *	- end	 - virtual end address
  */
 ENTRY(xsc3_dma_inv_range)
-	tst	r0, #CACHELINESIZE - 1
 	bic	r0, r0, #CACHELINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean L1 D line
-	tst	r1, #CACHELINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean L1 D line
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate L1 D line
 	add	r0, r0, #CACHELINESIZE
 	cmp	r0, r1
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index f056c28..3170348 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -315,11 +315,7 @@ ENTRY(xscale_flush_kern_dcache_page)
  *	- end	 - virtual end address
  */
 ENTRY(xscale_dma_inv_range)
-	tst	r0, #CACHELINESIZE - 1
 	bic	r0, r0, #CACHELINESIZE - 1
-	mcrne	p15, 0, r0, c7, c10, 1		@ clean D entry
-	tst	r1, #CACHELINESIZE - 1
-	mcrne	p15, 0, r1, c7, c10, 1		@ clean D entry
 1:	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D entry
 	add	r0, r0, #CACHELINESIZE
 	cmp	r0, r1
-- 
1.6.2.5
