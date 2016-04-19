From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Apr 2016 15:13:21 +0100
Subject: [PATCH] arm64: mm: take CWG into account in __inval_cache_range()
In-Reply-To: <CAKv+Gu91hFkn5k0s=xVmJ+z0vEYMNe6h6UD6z9Qb0fxe7ba0Vw@mail.gmail.com>
References: <1461061773-19571-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160419125615.GA20991@leverpostej>
 <CAKv+Gu91hFkn5k0s=xVmJ+z0vEYMNe6h6UD6z9Qb0fxe7ba0Vw@mail.gmail.com>
Message-ID: <20160419141321.GD8482@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 03:08:27PM +0200, Ard Biesheuvel wrote:
> On 19 April 2016 at 14:56, Mark Rutland <mark.rutland@arm.com> wrote:
> > Is sharing a CWG broken by design, or is there some caveat I'm missing
> > that prevents/prohibits unrelated data from being dirtied?
> 
> I think sharing a CWG window is broken by design, now that I think of
> it. The invalidate is part of the dma_unmap() code path, which means
> the cleaning we do on the edges of the buffer may clobber data in
> memory written by the device, and not cleaning isn't an option either.

Indeed. It only works if the cache line is always clean (e.g. read or
speculatively loaded) but you can't guarantee what's accessing it. I
think we shouldn't even bother with the edges at all in __dma_inv_range.

The best we could do is to warn if ARCH_DMA_MINALIGN is smaller than CWG
(as Robin suggested, we could do this only if we have non-coherent DMA
masters via arch_setup_dma_ops()). Quick hack below:

-------------------------------8<-----------------------------------
diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 5082b30bc2c0..5967fcbb617a 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -28,7 +28,7 @@
  * cache before the transfer is done, causing old data to be seen by
  * the CPU.
  */
-#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+#define ARCH_DMA_MINALIGN	128
 
 #ifndef __ASSEMBLY__
 
@@ -37,7 +37,7 @@
 static inline int cache_line_size(void)
 {
 	u32 cwg = cache_type_cwg();
-	return cwg ? 4 << cwg : L1_CACHE_BYTES;
+	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
 }
 
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 943f5140e0f3..b1d4d1f5b0dd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -970,7 +970,6 @@ static void __init setup_feature_capabilities(void)
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
-	int cls;
 
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
@@ -983,13 +982,9 @@ void __init setup_cpu_features(void)
 	 * Check for sane CTR_EL0.CWG value.
 	 */
 	cwg = cache_type_cwg();
-	cls = cache_line_size();
 	if (!cwg)
-		pr_warn("No Cache Writeback Granule information, assuming cache line size %d\n",
-			cls);
-	if (L1_CACHE_BYTES < cls)
-		pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
-			L1_CACHE_BYTES, cls);
+		pr_warn("No Cache Writeback Granule information, assuming %d\n",
+			ARCH_DMA_MINALIGN);
 }
 
 static bool __maybe_unused
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a6e757cbab77..08232faf38ad 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -987,6 +987,11 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			struct iommu_ops *iommu, bool coherent)
 {
+	WARN_TAINT_ONCE(!coherent && ARCH_DMA_MINALIGN < cache_line_size(),
+			TAINT_CPU_OUT_OF_SPEC,
+			"ARCH_DMA_MINALIGN smaller than the Cache Writeback Granule (%d < %d)",
+			ARCH_DMA_MINALIGN, cache_line_size());
+
 	if (!dev->archdata.dma_ops)
 		dev->archdata.dma_ops = &swiotlb_dma_ops;
 
-------------------------------8<-----------------------------------

This way we could also reduce L1_CACHE_SHIFT back to 6 as it shouldn't
cause any correctness issues (potentially performance but so far it
seems that increasing it made things worse on some SoCs).

The reason for cache_line_size() using ARCH_DMA_MINALIGN instead of
L1_CACHE_BYTES is that I can see it used in the sl*b code when
SLAB_HWCACHE_ALIGN is passed and on few occasions for DMA buffers.

-- 
Catalin
