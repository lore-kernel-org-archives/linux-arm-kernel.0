From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 May 2018 14:55:46 +0100
Subject: [PATCH v3 2/3] arm64: Increase ARCH_DMA_MINALIGN to 128
In-Reply-To: <20180511135547.34521-1-catalin.marinas@arm.com>
References: <20180511135547.34521-1-catalin.marinas@arm.com>
Message-ID: <20180511135547.34521-3-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch increases the ARCH_DMA_MINALIGN to 128 so that it covers the
currently known Cache Writeback Granule (CTR_EL0.CWG) on arm64 and moves
the fallback in cache_line_size() from L1_CACHE_BYTES to this constant.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cache.h | 4 ++--
 arch/arm64/kernel/cpufeature.c | 9 ++-------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 1dd2c2db0010..5df5cfe1c143 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -43,7 +43,7 @@
  * cache before the transfer is done, causing old data to be seen by
  * the CPU.
  */
-#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+#define ARCH_DMA_MINALIGN	(128)
 
 #ifndef __ASSEMBLY__
 
@@ -77,7 +77,7 @@ static inline u32 cache_type_cwg(void)
 static inline int cache_line_size(void)
 {
 	u32 cwg = cache_type_cwg();
-	return cwg ? 4 << cwg : L1_CACHE_BYTES;
+	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
 }
 
 #endif	/* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9d1b06d67c53..fbee8c17a4e6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1606,7 +1606,6 @@ static void __init setup_system_capabilities(void)
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
-	int cls;
 
 	setup_system_capabilities();
 	mark_const_caps_ready();
@@ -1627,13 +1626,9 @@ void __init setup_cpu_features(void)
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
