From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 10:13:48 +0100
Subject: [PATCH v3 4/7] ARM: Add a config option for the ARM11MPCore DMA
	cache maintenance workaround
In-Reply-To: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
References: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621091348.22752.90443.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f4d6477f introduced a workaround for the lack of hardware
broadcasting of the cache maintenance operations on ARM11MPCore.
However, the workaround is only valid on CPUs that do not do speculative
loads into the D-cache.

This patch adds a Kconfig option with the corresponding help to make the
above clear. When the DMA_CACHE_RWFO option is disabled, the kernel
behaviour is that prior to the f4d6477f commit. This also allows ARMv6
UP processors with speculative loads to work correctly.

For other processors, a different workaround may be needed.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ronen Shitrit <rshitrit@marvell.com>
---
 arch/arm/mm/Kconfig    |   19 +++++++++++++++++++
 arch/arm/mm/cache-v6.S |   15 ++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 346ae14..fc1b2fa 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -735,6 +735,25 @@ config NEEDS_SYSCALL_FOR_CMPXCHG
 	  Forget about fast user space cmpxchg support.
 	  It is just not possible.
 
+config DMA_CACHE_RWFO
+	bool "Enable read/write for ownership DMA cache maintenance"
+	depends on CPU_V6 && SMP
+	default y
+	help
+	  The Snoop Control Unit on ARM11MPCore does not detect the
+	  cache maintenance operations and the dma_{map,unmap}_area()
+	  functions may leave stale cache entries on other CPUs. By
+	  enabling this option, Read or Write For Ownership in the ARMv6
+	  DMA cache maintenance functions is performed. These LDR/STR
+	  instructions change the cache line state to shared or modified
+	  so that the cache operation has the desired effect.
+
+	  Note that the workaround is only valid on processors that do
+	  not perform speculative loads into the D-cache. For such
+	  processors, if cache maintenance operations are not broadcast
+	  in hardware, other workarounds are needed (e.g. cache
+	  maintenance broadcasting in software via FIQ).
+
 config OUTER_CACHE
 	bool
 
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 332b48c..86aa689 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -211,7 +211,7 @@ v6_dma_inv_range:
 	mcrne	p15, 0, r1, c7, c15, 1		@ clean & invalidate unified line
 #endif
 1:
-#ifdef CONFIG_SMP
+#ifdef CONFIG_DMA_CACHE_RWFO
 	ldr	r2, [r0]			@ read for ownership
 	str	r2, [r0]			@ write for ownership
 #endif
@@ -235,7 +235,7 @@ v6_dma_inv_range:
 v6_dma_clean_range:
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
-#ifdef CONFIG_SMP
+#ifdef CONFIG_DMA_CACHE_RWFO
 	ldr	r2, [r0]			@ read for ownership
 #endif
 #ifdef HARVARD_CACHE
@@ -258,7 +258,7 @@ v6_dma_clean_range:
 ENTRY(v6_dma_flush_range)
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
-#ifdef CONFIG_SMP
+#ifdef CONFIG_DMA_CACHE_RWFO
 	ldr	r2, [r0]			@ read for ownership
 	str	r2, [r0]			@ write for ownership
 #endif
@@ -284,9 +284,13 @@ ENTRY(v6_dma_map_area)
 	add	r1, r1, r0
 	teq	r2, #DMA_FROM_DEVICE
 	beq	v6_dma_inv_range
+#ifndef CONFIG_DMA_CACHE_RWFO
+	b	v6_dma_clean_range
+#else
 	teq	r2, #DMA_TO_DEVICE
 	beq	v6_dma_clean_range
 	b	v6_dma_flush_range
+#endif
 ENDPROC(v6_dma_map_area)
 
 /*
@@ -296,6 +300,11 @@ ENDPROC(v6_dma_map_area)
  *	- dir	- DMA direction
  */
 ENTRY(v6_dma_unmap_area)
+#ifndef CONFIG_DMA_CACHE_RWFO
+	add	r1, r1, r0
+	teq	r2, #DMA_TO_DEVICE
+	bne	v6_dma_inv_range
+#endif
 	mov	pc, lr
 ENDPROC(v6_dma_unmap_area)
 
