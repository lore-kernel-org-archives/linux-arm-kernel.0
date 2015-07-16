From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu, 16 Jul 2015 10:37:14 -0400
Subject: [PATCH 2/2] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <1437057434-1616-1-git-send-email-chris.brandt@renesas.com>
References: <1437057434-1616-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <1437057434-1616-3-git-send-email-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For an XIP build, _edata_loc, not _etext, is the end of constant R/O
memory that needs to be mapped into the MODULES_VADDR area. This fixes
the bug where you might loose part of your R/O data after page table
setup is complete.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/kernel/module.c       |    2 +-
 arch/arm/mm/mmu.c              |    4 ++--
 include/asm-generic/sections.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index efdddcb..41ae2cc 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -34,7 +34,7 @@
  * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
  */
 #undef MODULES_VADDR
-#define MODULES_VADDR	(((unsigned long)_etext + ~PMD_MASK) & PMD_MASK)
+#define MODULES_VADDR	(((unsigned long)_edata_loc + ~PMD_MASK) & PMD_MASK)
 #endif
 
 #ifdef CONFIG_MMU
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6ca7d9a..57456df 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1162,7 +1162,7 @@ static inline void prepare_page_table(void)
 
 #ifdef CONFIG_XIP_KERNEL
 	/* The XIP kernel is mapped in the module area -- skip over it */
-	addr = ((unsigned long)_etext + PMD_SIZE - 1) & PMD_MASK;
+	addr = ((unsigned long)_edata_loc + PMD_SIZE - 1) & PMD_MASK;
 #endif
 	for ( ; addr < PAGE_OFFSET; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -1241,7 +1241,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
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
