From: john.stultz@linaro.org (John Stultz)
Date: Mon, 13 Dec 2010 20:57:37 -0800
Subject: [PATCH 2/4] Optionally flush entire dcache from v6_dma_flush_range
In-Reply-To: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
Message-ID: <1292302659-1863-3-git-send-email-john.stultz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arve Hj?nnev?g <arve@android.com>

If CACHE_FLUSH_RANGE_LIMIT is defined, then the entire dcache will
be flushed if the requested range is larger than this limit.

CC: Nicolas Pitre <nicolas.pitre@linaro.org>
CC: Russell King <linux@arm.linux.org.uk>
Change-Id: I29277d645a9d6716b1952cf3b870c78496261dd0
Signed-off-by: Arve Hj?nnev?g <arve@android.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm/mm/cache-v6.S |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 99fa688..92c66b4 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -263,6 +263,11 @@ v6_dma_clean_range:
  *	- end     - virtual end address of region
  */
 ENTRY(v6_dma_flush_range)
+#ifdef CONFIG_CACHE_FLUSH_RANGE_LIMIT
+	sub	r2, r1, r0
+	cmp	r2, #CONFIG_CACHE_FLUSH_RANGE_LIMIT
+	bhi	v6_dma_flush_dcache_all
+#endif
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
 #ifdef CONFIG_DMA_CACHE_RWFO
@@ -281,6 +286,18 @@ ENTRY(v6_dma_flush_range)
 	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr
 
+#ifdef CONFIG_CACHE_FLUSH_RANGE_LIMIT
+v6_dma_flush_dcache_all:
+	mov	r0, #0
+#ifdef HARVARD_CACHE
+	mcr	p15, 0, r0, c7, c14, 0		@ D cache clean+invalidate
+#else
+	mcr	p15, 0, r0, c7, c15, 0		@ Cache clean+invalidate
+#endif
+	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
+	mov	pc, lr
+#endif
+
 /*
  *	dma_map_area(start, size, dir)
  *	- start	- kernel virtual start address
-- 
1.7.3.2.146.gca209
