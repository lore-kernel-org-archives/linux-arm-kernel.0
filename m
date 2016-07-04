From: dennis.chen@arm.com (Dennis Chen)
Date: Mon, 4 Jul 2016 12:53:14 +0800
Subject: [PATCH] arm64:mm Remove the redundant initrd memblock codes
Message-ID: <1467607994-14368-1-git-send-email-dennis.chen@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory range between initrd_start and initrd_end was added to the memblock
twice unnecessarily in the same function before initrd memory range can be freed.
This patch merge those codes into one piece of block and add the initrd memory
range only once, also it makes the code clean and simple.

Signed-off-by: Dennis Chen <dennis.chen@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/init.c | 58 +++++++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 2ade7a6..cf26cdb 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -228,6 +228,29 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa(_text), (u64)(_end - _text));
 	}
 
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		extern u16 memstart_offset_seed;
+		u64 range = linear_region_size -
+			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
+
+		/*
+		 * If the size of the linear region exceeds, by a sufficient
+		 * margin, the size of the region that the available physical
+		 * memory spans, randomize the linear region as well.
+		 */
+		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
+			range = range / ARM64_MEMSTART_ALIGN + 1;
+			memstart_addr -= ARM64_MEMSTART_ALIGN *
+					 ((range * memstart_offset_seed) >> 16);
+		}
+	}
+
+	/*
+	 * Register the kernel text, kernel data, initrd, and initial
+	 * pagetables with memblock.
+	 */
+	memblock_reserve(__pa(_text), _end - _text);
+
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
 		/*
 		 * Add back the memory we just removed if it results in the
@@ -254,41 +277,12 @@ void __init arm64_memblock_init(void)
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+			/* the generic initrd code expects virtual addresses */
+			initrd_start = __phys_to_virt(initrd_start);
+			initrd_end = __phys_to_virt(initrd_end);
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		extern u16 memstart_offset_seed;
-		u64 range = linear_region_size -
-			    (memblock_end_of_DRAM() - memblock_start_of_DRAM());
-
-		/*
-		 * If the size of the linear region exceeds, by a sufficient
-		 * margin, the size of the region that the available physical
-		 * memory spans, randomize the linear region as well.
-		 */
-		if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
-			range = range / ARM64_MEMSTART_ALIGN + 1;
-			memstart_addr -= ARM64_MEMSTART_ALIGN *
-					 ((range * memstart_offset_seed) >> 16);
-		}
-	}
-
-	/*
-	 * Register the kernel text, kernel data, initrd, and initial
-	 * pagetables with memblock.
-	 */
-	memblock_reserve(__pa(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
-	}
-#endif
-
 	early_init_fdt_scan_reserved_mem();
 
 	/* 4GB maximum for 32-bit only capable devices */
-- 
1.8.3.1
