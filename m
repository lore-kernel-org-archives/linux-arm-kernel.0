From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 May 2011 17:03:59 +0100
Subject: [PATCH] ARM: sparsemem: allow pfn_valid to be overridden when using
	SPARSEMEM
Message-ID: <1305734639-6561-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit eb33575c ("[ARM] Double check memmap is actually valid with a
memmap has unexpected holes V2"), a new function, memmap_valid_within,
was introduced to mmzone.h so that holes in the memmap which pass
pfn_valid in SPARSEMEM configurations can be detected and avoided.

The fix to this problem checks that the pfn <-> page linkages are
correct by calculating the page for the pfn and then checking that
page_to_pfn on that page returns the original pfn. Unfortunately, in
SPARSEMEM configurations, this results in reading from the page flags to
determine the correct section. Since the memmap here has been freed,
junk is read from memory and the check is no longer robust.

In the best case, reading from /proc/pagetypeinfo will give you the
wrong answer. In the worst case, you get SEGVs, Kernel OOPses and hung
CPUs.

This patch allows architectures to provide their own pfn_valid function
instead of using the default implementation used by sparsemem. The
architecture-specific version is aware of the memmap state and will
return false when passed a pfn for a freed page within a valid section.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mel Gorman <mgorman@suse.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig            |    3 +++
 arch/arm/include/asm/page.h |    2 +-
 arch/arm/mm/init.c          |    4 +++-
 include/linux/mmzone.h      |    2 ++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..d6cfc9c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1520,6 +1520,9 @@ config ARCH_SPARSEMEM_DEFAULT
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
+config ARCH_PROVIDES_PFN_VALID
+	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+
 config HIGHMEM
 	bool "High Memory Support (EXPERIMENTAL)"
 	depends on MMU && EXPERIMENTAL
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index f51a695..8702233 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -197,7 +197,7 @@ typedef unsigned long pgprot_t;
 
 typedef struct page *pgtable_t;
 
-#ifndef CONFIG_SPARSEMEM
+#ifdef CONFIG_ARCH_PROVIDES_PFN_VALID
 extern int pfn_valid(unsigned long);
 #endif
 
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index e591513..d425b36 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -252,13 +252,15 @@ static void __init arm_bootmem_free(unsigned long min, unsigned long max_low,
 	free_area_init_node(0, zone_size, min, zhole_size);
 }
 
-#ifndef CONFIG_SPARSEMEM
+#ifdef CONFIG_ARCH_PROVIDES_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
 	return memblock_is_memory(pfn << PAGE_SHIFT);
 }
 EXPORT_SYMBOL(pfn_valid);
+#endif
 
+#ifndef CONFIG_SPARSEMEM
 static void arm_memory_present(void)
 {
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e56f835..72225dd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1053,12 +1053,14 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
 	return __nr_to_section(pfn_to_section_nr(pfn));
 }
 
+#ifndef CONFIG_ARCH_PROVIDES_PFN_VALID
 static inline int pfn_valid(unsigned long pfn)
 {
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
+#endif
 
 static inline int pfn_present(unsigned long pfn)
 {
-- 
1.7.0.4
