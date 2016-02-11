From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 11 Feb 2016 15:41:21 +0100
Subject: [PATCH] arm64: defer __va() translations of initrd_start and
 initrd_end
Message-ID: <1455201681-29972-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 66f51676a095 ("arm64: allow kernel Image to be loaded anywhere in
physical memory") defers the assignment of memstart_addr to the point where
all memory has been discovered and possibly clipped based on the size of
the linear region and the presence of a mem= command line parameter.

However, this results in __va() translations that have been performed up
to this point to have been carried out with a preliminary, incorrect value
of memstart_addr, and these values need to be fixed up.

To make this more transparent, change the initial value of memstart_addr to
PAGE_OFFSET so that __va() translations are effectively identity functions,
and fix up the values of initrd_start and initrd_end before use.

Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This is the least ugly way to address this issue in the short term (since the
offending patch is already in -next). The preferred way of dealing with this
would be to parametrise early_init_dt_check_for_initrd() in such a way that
we can decide per-arch whether it should perform the __va() translation or
not. If this is the preferred approach also for the short term, I am happy
to code that up as well.

 arch/arm64/mm/init.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3a9fc46cbf80..bb53236e54d9 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -48,7 +48,13 @@
 
 #include "mm.h"
 
-phys_addr_t memstart_addr __read_mostly = 0;
+/*
+ * Initialize memstart_addr to PAGE_OFFSET so that __va() translations
+ * performed before arm64_memblock_init() executes (i.e., assignments
+ * of initrd_start and initrd_end in the early FDT parsing code) are
+ * effectively identity functions.
+ */
+phys_addr_t memstart_addr __read_mostly = PAGE_OFFSET;
 phys_addr_t arm64_dma_phys_limit __read_mostly;
 
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -61,8 +67,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = (unsigned long)__va(start);
-		initrd_end = (unsigned long)__va(start + size);
+		initrd_start = start;
+		initrd_end = start + size;
 	}
 	return 0;
 }
@@ -213,8 +219,12 @@ void __init arm64_memblock_init(void)
 	 */
 	memblock_reserve(__pa(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
+	if (initrd_start) {
+		memblock_reserve(initrd_start, initrd_end - initrd_start);
+
+		initrd_start = phys_to_virt(initrd_start);
+		initrd_end = phys_to_virt(initrd_end);
+	}
 #endif
 
 	early_init_fdt_scan_reserved_mem();
-- 
2.5.0
