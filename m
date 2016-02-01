From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  1 Feb 2016 19:30:17 +0100
Subject: [PATCH] arm64: move back to generic memblock_enforce_memory_limit()
In-Reply-To: <20160201180256.GJ15514@e104818-lin.cambridge.arm.com>
References: <20160201180256.GJ15514@e104818-lin.cambridge.arm.com>
Message-ID: <1454351417-23732-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than implementing our own elaborate logic to clip the memory ranges
in order of preference, use the generic memblock_enforce_memory_limit() as
before, and explicitly add back that part of the kernel that needs to be
accessible via the linear mapping as well as via the kernel mapping.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 59 +++++++---------------------------------------------
 1 file changed, 7 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e8e853a1024c..361c91209031 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -160,41 +160,6 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
-/*
- * clip_mem_range() - remove memblock memory between @min and @max until
- *                    we meet the limit in 'memory_limit'.
- */
-static void __init clip_mem_range(u64 min, u64 max)
-{
-	u64 mem_size, to_remove;
-	int i;
-
-again:
-	mem_size = memblock_phys_mem_size();
-	if (mem_size <= memory_limit || max <= min)
-		return;
-
-	to_remove = mem_size - memory_limit;
-
-	for (i = memblock.memory.cnt - 1; i >= 0; i--) {
-		struct memblock_region *r = memblock.memory.regions + i;
-		u64 start = max(min, r->base);
-		u64 end = min(max, r->base + r->size);
-
-		if (start >= max || end <= min)
-			continue;
-
-		if (end > min) {
-			u64 size = min(to_remove, end - max(start, min));
-
-			memblock_remove(end - size, size);
-		} else {
-			memblock_remove(start, min(max - start, to_remove));
-		}
-		goto again;
-	}
-}
-
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
@@ -215,24 +180,14 @@ void __init arm64_memblock_init(void)
 	if (memblock_end_of_DRAM() > linear_region_size)
 		memblock_remove(0, memblock_end_of_DRAM() - linear_region_size);
 
+	/*
+	 * Apply the memory limit if it was set. Since the kernel may be loaded
+	 * high up in memory, add back the kernel region that must be accessible
+	 * via the linear mapping.
+	 */
 	if (memory_limit != (phys_addr_t)ULLONG_MAX) {
-		u64 kbase = round_down(__pa(_text), MIN_KIMG_ALIGN);
-		u64 kend = PAGE_ALIGN(__pa(_end));
-		u64 const sz_4g = 0x100000000UL;
-
-		/*
-		 * Clip memory in order of preference:
-		 * - above the kernel and above 4 GB
-		 * - between 4 GB and the start of the kernel (if the kernel
-		 *   is loaded high in memory)
-		 * - between the kernel and 4 GB (if the kernel is loaded
-		 *   low in memory)
-		 * - below 4 GB
-		 */
-		clip_mem_range(max(sz_4g, kend), ULLONG_MAX);
-		clip_mem_range(sz_4g, kbase);
-		clip_mem_range(kend, sz_4g);
-		clip_mem_range(0, min(kbase, sz_4g));
+		memblock_enforce_memory_limit(memory_limit);
+		memblock_add(__pa(__init_begin), (u64)(_end - __init_begin));
 	}
 
 	/*
-- 
2.5.0
