From: rrichter@cavium.com (Robert Richter)
Date: Wed, 14 Dec 2016 10:42:30 +0100
Subject: [PATCH v2] arm64: mm: Fix NOMAP page initialization
Message-ID: <1481708550-1809-1-git-send-email-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ThunderX systems with certain memory configurations we see the
following BUG_ON():

 kernel BUG at mm/page_alloc.c:1848!

This happens for some configs with 64k page size enabled. The BUG_ON()
checks if start and end page of a memmap range belongs to the same
zone.

The BUG_ON() check fails if a memory zone contains NOMAP regions. In
this case the node information of those pages is not initialized. This
causes an inconsistency of the page links with wrong zone and node
information for that pages. NOMAP pages from node 1 still point to the
mem zone from node 0 and have the wrong nid assigned.

The reason for the mis-configuration is a change in pfn_valid() which
reports pages marked NOMAP as invalid:

 68709f45385a arm64: only consider memblocks with NOMAP cleared for linear mapping

This causes pages marked as nomap being no longer reassigned to the
new zone in memmap_init_zone() by calling __init_single_pfn().

Fixing this by implementing an arm64 specific early_pfn_valid(). This
causes all pages of sections with memory including NOMAP ranges to be
initialized by __init_single_page() and ensures consistency of page
links to zone, node and section.

The HAVE_ARCH_PFN_VALID config option now requires an explicit
definiton of early_pfn_valid() in the same way as pfn_valid(). This
allows a customized implementation of early_pfn_valid() which
redirects to pfn_present() for arm64.

v2:

 * Use pfn_present() instead of memblock_is_memory() to support also
   non-memory NOMAP holes

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm/include/asm/page.h   |  1 +
 arch/arm64/include/asm/page.h |  2 ++
 arch/arm64/mm/init.c          | 12 ++++++++++++
 include/linux/mmzone.h        |  5 ++++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0ec44d6..79761bd55f94 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,6 +158,7 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+#define early_pfn_valid(pfn)	pfn_valid(pfn)
 #endif
 
 #include <asm/memory.h>
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 8472c6def5ef..17ceb7435ded 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -49,6 +49,8 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+extern int early_pfn_valid(unsigned long);
+#define early_pfn_valid early_pfn_valid
 #endif
 
 #include <asm/memory.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 212c4d1e2f26..bf1f5db11428 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -145,11 +145,23 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
+
 int pfn_valid(unsigned long pfn)
 {
 	return memblock_is_map_memory(pfn << PAGE_SHIFT);
 }
 EXPORT_SYMBOL(pfn_valid);
+
+/*
+ * We use pfn_present() here to make sure all pages of a section
+ * including NOMAP pages are initialized with __init_single_page().
+ */
+int early_pfn_valid(unsigned long pfn)
+{
+	return pfn_present(pfn);
+}
+EXPORT_SYMBOL(early_pfn_valid);
+
 #endif
 
 #ifndef CONFIG_SPARSEMEM
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0f088f3a2fed..bedcf8a95881 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1170,12 +1170,16 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
 }
 
 #ifndef CONFIG_HAVE_ARCH_PFN_VALID
+
 static inline int pfn_valid(unsigned long pfn)
 {
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
+
+#define early_pfn_valid(pfn)	pfn_valid(pfn)
+
 #endif
 
 static inline int pfn_present(unsigned long pfn)
@@ -1200,7 +1204,6 @@ static inline int pfn_present(unsigned long pfn)
 #define pfn_to_nid(pfn)		(0)
 #endif
 
-#define early_pfn_valid(pfn)	pfn_valid(pfn)
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
-- 
2.1.4
