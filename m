From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 26 Oct 2018 15:39:50 -0700
Subject: [PATCH v4 1/2] arm64: Get rid of __early_init_dt_declare_initrd()
In-Reply-To: <20181026223951.30936-1-f.fainelli@gmail.com>
References: <20181026223951.30936-1-f.fainelli@gmail.com>
Message-ID: <20181026223951.30936-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override, just get rid of that
implementation and perform the virtual to physical conversion of these
addresses in arm64_memblock_init() where relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 26 ++++++++++++++++----------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3cf87341859f..98ff0f7a0f7a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -364,6 +364,9 @@ static void __init fdt_enforce_memory_region(void)
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+	unsigned long __maybe_unused phys_initrd_size;
+	u64 __maybe_unused phys_initrd_start;
+	u64 __maybe_unused base, size;
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -414,8 +417,11 @@ void __init arm64_memblock_init(void)
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		phys_initrd_start = __pa(initrd_start);
+		phys_initrd_size = __pa(initrd_end) - phys_initrd_start;
+
+		base = phys_initrd_start & PAGE_MASK;
+		size = PAGE_ALIGN(phys_initrd_size);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -459,15 +465,15 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+		memblock_reserve(phys_initrd_start, phys_initrd_size);
+		/*
+		 * initrd_below_start_ok can be changed by
+		 * __early_init_dt_declare_initrd(), set it back to what
+		 * we want here.
+		 */
+		initrd_below_start_ok = 0;
 	}
-#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.17.1
