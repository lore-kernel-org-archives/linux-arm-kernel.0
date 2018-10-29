From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 29 Oct 2018 12:00:13 -0700
Subject: [PATCH 1/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
In-Reply-To: <20181029190014.6455-1-f.fainelli@gmail.com>
References: <20181029190014.6455-1-f.fainelli@gmail.com>
Message-ID: <20181029190014.6455-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override, just get rid of that
implementation and perform the virtual to physical conversion of these
addresses in arm64_memblock_init() where relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/memory.h |  8 -------
 arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
 2 files changed, 27 insertions(+), 23 deletions(-)

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
index 3cf87341859f..292570b08f85 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -62,6 +62,8 @@
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
+static phys_addr_t phys_initrd_start, phys_initrd_end;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
@@ -72,8 +74,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_end = start + size;
 	}
 	return 0;
 }
@@ -364,6 +366,7 @@ static void __init fdt_enforce_memory_region(void)
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+	u64 __maybe_unused base, size;
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -408,14 +411,25 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
+	    (initrd_start || phys_initrd_start)) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		if (phys_initrd_start) {
+			/* Command line specified the initrd location */
+			initrd_start = __phys_to_virt(phys_initrd_start);
+			initrd_end = __phys_to_virt(phys_initrd_end);
+		} else if (initrd_start) {
+			/* FDT specified the initrd location */
+			phys_initrd_start = __pa(initrd_start);
+			phys_initrd_end = __pa(initrd_end);
+		}
+
+		base = phys_initrd_start & PAGE_MASK;
+		size = PAGE_ALIGN(phys_initrd_end - phys_initrd_start);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -434,6 +448,13 @@ void __init arm64_memblock_init(void)
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+
+			/*
+			 * initrd_below_start_ok can be changed by
+			 * __early_init_dt_declare_initrd(), set it back to what
+			 * we want here.
+			 */
+			initrd_below_start_ok = 0;
 		}
 	}
 
@@ -455,19 +476,10 @@ void __init arm64_memblock_init(void)
 	}
 
 	/*
-	 * Register the kernel text, kernel data, initrd, and initial
+	 * Register the kernel text, kernel data and initial
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
-	}
-#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.17.1
