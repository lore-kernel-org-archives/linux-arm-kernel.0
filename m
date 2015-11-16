From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 12:23:13 +0100
Subject: [PATCH v3 2/7] arm64: use more granular reservations for static page
 table allocations
In-Reply-To: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1447672998-20981-3-git-send-email-ard.biesheuvel@linaro.org>
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
index 17bf39ac83ba..b3b0175d7135 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -36,6 +36,7 @@
 #include <linux/swiotlb.h>
 
 #include <asm/fixmap.h>
+#include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -165,11 +166,13 @@ void __init arm64_memblock_init(void)
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
