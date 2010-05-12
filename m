From: rshitrit@marvell.com (Ronen Shitrit)
Date: Wed, 12 May 2010 15:51:57 +0300
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the
	ARMv6	DMA cache ops
In-Reply-To: <20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

I'm using ARM v6 MP core.
I have applied this patch above 2.6.34-rc7 and my system hang while booting from NFS (through e1000 nic).
Previously I used 2.6.32 with the cache broadcast IPI mask and it worked just fine for me.
I have noticed that if I remove the str, write for ownership, in the dma_inv the system boot just fine.

- Why was the IPI solution dropped?
- I can think of few cases the above str might be problematic:
1) CPU 0 is doing inv, after the str cpu 1 change the line and then cpu 0 inv the line... probably won't happen since the dma buffer shouldn't be used by more the one CPU...
2) CPU 0 is doing inv, the str write garbage which get to the DRAM because of eviction and break the assumption that inv shouldn't change the DRAM...

Regards
Ronen Shitrit


-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Catalin Marinas
Sent: Tuesday, May 04, 2010 7:44 PM
To: linux-arm-kernel at lists.infradead.org
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the ARMv6 DMA cache ops

The Snoop Control Unit on the ARM11MPCore hardware does not detect the
cache operations and the dma_cache_maint*() functions may leave stale
cache entries on other CPUs. The solution implemented in this patch
performs a Read or Write For Ownership in the ARMv6 DMA cache
maintenance functions. These LDR/STR instructions change the cache line
state to shared or exclusive so that the cache maintenance operation has
the desired effect.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-v6.S |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 9d89c67..e46ecd8 100644
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
@@ -273,7 +283,9 @@ ENTRY(v6_dma_map_area)
 	add	r1, r1, r0
 	teq	r2, #DMA_FROM_DEVICE
 	beq	v6_dma_inv_range
-	b	v6_dma_clean_range
+	teq	r2, #DMA_TO_DEVICE
+	beq	v6_dma_clean_range
+	b	v6_dma_flush_range
 ENDPROC(v6_dma_map_area)
 
 /*
@@ -283,9 +295,6 @@ ENDPROC(v6_dma_map_area)
  *	- dir	- DMA direction
  */
 ENTRY(v6_dma_unmap_area)
-	add	r1, r1, r0
-	teq	r2, #DMA_TO_DEVICE
-	bne	v6_dma_inv_range
 	mov	pc, lr
 ENDPROC(v6_dma_unmap_area)
 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
