From: chris.brandt@renesas.com (Chris Brandt)
Date: Wed, 11 Nov 2015 09:17:35 -0500
Subject: [PATCH] ARM: xip: Use correct symbol for end of ROM marker
Message-ID: <1447251455-22731-1-git-send-email-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For an XIP build, _edata_loc, not _etext, represents the end of the
binary image that will be programmed into ROM and mapped into the
MODULES_VADDR area.
With an XIP kernel, nothing is loaded into RAM before boot, meaning
you have to take into account the size of the entire binary image
that was programmed, including the init data values that will be copied
to RAM during kernel boot.

This fixes the bug where you might lose the end of your kernel area
after page table setup is complete.


Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/mm/mmu.c              |    4 ++--
 include/asm-generic/sections.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 4867f5d..dd5a56b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1210,7 +1210,7 @@ static inline void prepare_page_table(void)
 
 #ifdef CONFIG_XIP_KERNEL
 	/* The XIP kernel is mapped in the module area -- skip over it */
-	addr = ((unsigned long)_etext + PMD_SIZE - 1) & PMD_MASK;
+	addr = ((unsigned long)_edata_loc + PMD_SIZE - 1) & PMD_MASK;
 #endif
 	for ( ; addr < PAGE_OFFSET; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -1292,7 +1292,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 #ifdef CONFIG_XIP_KERNEL
 	map.pfn = __phys_to_pfn(CONFIG_XIP_PHYS_ADDR & SECTION_MASK);
 	map.virtual = MODULES_VADDR;
-	map.length = ((unsigned long)_etext - map.virtual + ~SECTION_MASK) & SECTION_MASK;
+	map.length = ((unsigned long)_edata_loc - map.virtual + ~SECTION_MASK) & SECTION_MASK;
 	map.type = MT_ROM;
 	create_mapping(&map);
 #endif
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index b58fd66..195554d 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -26,7 +26,7 @@
  *	__ctors_start, __ctors_end
  */
 extern char _text[], _stext[], _etext[];
-extern char _data[], _sdata[], _edata[];
+extern char _data[], _sdata[], _edata[], _edata_loc[];
 extern char __bss_start[], __bss_stop[];
 extern char __init_begin[], __init_end[];
 extern char _sinittext[], _einittext[];
-- 
1.7.9.5
