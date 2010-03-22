From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Mar 2010 15:19:45 +0000
Subject: [PATCH 2/5] ARM: Implement read/write for ownership in the ARMv6
	DMA cache ops
In-Reply-To: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100322151945.6353.7333.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Snoop Control Unit on the ARM11MPCore hardware does not detect the
cache operations and the dma_cache_maint*() functions may leave stale
cache entries on other CPUs. The solution implemented in this patch
performs a Read or Write For Ownership in the ARMv6 DMA cache
maintenance functions. These LDR/STR instructions change the cache line
state to shared or exclusive so that the cache maintenance operation has
the desired effect.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-v6.S |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 9d89c67..b9f2cbd 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -211,6 +211,9 @@ v6_dma_inv_range:
 	mcrne	p15, 0, r1, c7, c15, 1		@ clean & invalidate unified line
 #endif
 1:
+#ifdef CONFIG_SMP
+	str	r0, [r0]			@ write for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D line
 #else
@@ -231,6 +234,9 @@ v6_dma_inv_range:
 v6_dma_clean_range:
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
+#ifdef CONFIG_SMP
+	ldr	r2, [r0]			@ read for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c10, 1		@ clean D line
 #else
@@ -251,6 +257,10 @@ v6_dma_clean_range:
 ENTRY(v6_dma_flush_range)
 	bic	r0, r0, #D_CACHE_LINE_SIZE - 1
 1:
+#ifdef CONFIG_SMP
+	ldr	r2, [r0]			@ read for ownership
+	str	r2, [r0]			@ write for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
 #else
