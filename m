From: james.morse@arm.com (James Morse)
Date: Fri, 31 Aug 2018 16:19:43 +0100
Subject: [PATCH] arm64: Kconfig: Remove ARCH_HAS_HOLES_MEMORYMODEL
Message-ID: <20180831151943.9281-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/linux/mmzone.h describes ARCH_HAS_HOLES_MEMORYMODEL as
relevant when parts the memmap have been free()d. This would
happen on systems where memory is smaller than a sparsemem-section,
and the extra struct pages are expensive. pfn_valid() on these
systems returns true for the whole sparsemem-section, so an extra
memmap_valid_within() check is needed.

On arm64 we have nomap memory, so always provide pfn_valid() to test
for nomap pages. This means ARCH_HAS_HOLES_MEMORYMODEL's extra checks
are already rolled up into pfn_valid().

Remove it.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig            | 5 +----
 arch/arm64/include/asm/page.h | 2 --
 arch/arm64/mm/init.c          | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..6082d47bfc32 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -769,9 +769,6 @@ source kernel/Kconfig.hz
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
-config ARCH_HAS_HOLES_MEMORYMODEL
-	def_bool y if SPARSEMEM
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
@@ -786,7 +783,7 @@ config ARCH_FLATMEM_ENABLE
 	def_bool !NUMA
 
 config HAVE_ARCH_PFN_VALID
-	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+	def_bool y
 
 config HW_PERF_EVENTS
 	def_bool y
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 60d02c81a3a2..c88a3cb117a1 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -37,9 +37,7 @@ extern void clear_page(void *to);
 
 typedef struct page *pgtable_t;
 
-#ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
-#endif
 
 #include <asm/memory.h>
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 787e27964ab9..3cf87341859f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -284,7 +284,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 
 #endif /* CONFIG_NUMA */
 
-#ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
 	phys_addr_t addr = pfn << PAGE_SHIFT;
@@ -294,7 +293,6 @@ int pfn_valid(unsigned long pfn)
 	return memblock_is_map_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
-#endif
 
 #ifndef CONFIG_SPARSEMEM
 static void __init arm64_memory_present(void)
-- 
2.18.0
