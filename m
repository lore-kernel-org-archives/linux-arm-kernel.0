From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  5 Nov 2018 14:54:29 -0800
Subject: [PATCH v4 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
Message-ID: <20181105225431.24485-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override we can leverage
drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
populate those variables for us.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/mm/init.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9d9582cac6c4..a66ffcde5f13 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -71,8 +71,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_size = size;
 	}
 	return 0;
 }
@@ -407,14 +407,14 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		u64 base = phys_initrd_start & PAGE_MASK;
+		u64 size = PAGE_ALIGN(phys_initrd_size);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -458,15 +458,11 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
+		initrd_start = __phys_to_virt(phys_initrd_start);
+		initrd_end = initrd_start + phys_initrd_size;
 	}
-#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.17.1
