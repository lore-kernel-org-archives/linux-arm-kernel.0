From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 22 Sep 2015 17:37:38 -0700
Subject: [PATCH v2 2/7] arm64: use more granular reservations for static page
 table allocations
In-Reply-To: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442968663-31843-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before introducing new statically allocated page tables and increasing
their alignment in subsequent patches, update the reservation logic
so that only pages that are in actual use end up as reserved with
memblock.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f5c0680d17d9..b9390eb1e29f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -37,6 +37,7 @@
 
 #include <asm/fixmap.h>
 #include <asm/memory.h>
+#include <asm/mmu_context.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/sizes.h>
@@ -164,11 +165,13 @@ void __init arm64_memblock_init(void)
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
 	 */
-	memblock_reserve(__pa(_text), _end - _text);
+	memblock_reserve(__pa(_text), __bss_stop - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
 		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
 #endif
+	memblock_reserve(__pa(idmap_pg_dir), IDMAP_DIR_SIZE);
+	memblock_reserve(__pa(swapper_pg_dir), SWAPPER_DIR_SIZE);
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
1.9.1
