From: gking@nvidia.com (Gary King)
Date: Mon,  2 Aug 2010 19:42:47 -0700
Subject: [PATCH 2/4] [ARM] mm: add page allocator for customizing cache
	attributes
In-Reply-To: <1280803369-13362-1-git-send-email-gking@nvidia.com>
References: <1280803369-13362-1-git-send-email-gking@nvidia.com>
Message-ID: <1280803369-13362-3-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM CPUs with speculative prefetching have undefined behaviors when the
same physical page is mapped to two different virtual addresses with
conflicting cache attributes.

since many recent systems include IOMMU functionality (i.e., remapping
of discontiguous physical pages into a virtually-contiguous address
range for I/O devices), it is desirable to support allocating any
available OS memory for use by the I/O devices. however, since many
systems do not support cache coherency between the CPU and DMA devices,
these devices are left with using DMA-coherent allocations from the OS
(which severely limits the benefit of an IOMMU) or performing cache
maintenance (which can be a severe performance loss, particularly on
systems with outer caches, compared to using DMA-coherent memory).

this change adds an API for allocating pages from the OS with specific
cache maintenance properties and ensures that the kernel's mapping
of the page reflects the desired cache attributes, in line with the
ARMv7 architectural requirements

since the kmap page properties are now page-dependent, to ensure that
highmem pages are always mapped with the desired attributes, kmap_prot
is implemented as a static inline function which expects that "page"
is declared as a struct page * variable in any function which uses
kmap_prot, so that the correct properties will be returned.

Signed-off-by: Gary King <gking@nvidia.com>
---
 arch/arm/include/asm/attrib_alloc.h |   57 ++++++++++++++++
 arch/arm/include/asm/highmem.h      |   12 ++++
 arch/arm/mm/Kconfig                 |   24 +++++++
 arch/arm/mm/Makefile                |    2 +
 arch/arm/mm/attrib_alloc.c          |  122 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/dma-mapping.c           |   16 ++++-
 arch/arm/mm/flush.c                 |    9 +++
 arch/arm/mm/highmem.c               |    3 +-
 8 files changed, 243 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/attrib_alloc.h
 create mode 100644 arch/arm/mm/attrib_alloc.c

diff --git a/arch/arm/include/asm/attrib_alloc.h b/arch/arm/include/asm/attrib_alloc.h
new file mode 100644
index 0000000..609939d
--- /dev/null
+++ b/arch/arm/include/asm/attrib_alloc.h
@@ -0,0 +1,57 @@
+/*
+ * arch/arm/include/asm/attrib_alloc.h
+ *
+ * Page allocator with custom cache attributes
+ *
+ * Copyright (c) 2010, NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARCH_ARM_ATTRIB_ALLOC_H
+#define __ARCH_ARM_ATTRIB_ALLOC_H
+
+#include <linux/types.h>
+#include <asm/page.h>
+
+#ifdef CONFIG_ARM_ATTRIB_ALLOCATOR
+struct page *arm_attrib_alloc_pages_node(int nid, gfp_t gfp,
+					 unsigned int order, pgprot_t prot);
+
+void arm_attrib_free_pages(struct page *page, unsigned int order);
+#else
+static inline struct page *arm_attrib_alloc_pages_node(int, gfp_t,
+						       unsigned int, pgprot_t)
+{
+	return NULL;
+}
+
+static inline arm_attrib_free_pages(struct page *, unsigned int)
+{
+}
+#endif
+
+static inline struct page *arm_attrib_alloc_pages(gfp_t gfp,
+					  unsigned int order, pgprot_t prot)
+{
+	return arm_attrib_alloc_pages_node(-1, gfp, order, prot);
+}
+
+#define arm_attrib_alloc_page(gfp, prot)	\
+	arm_attrib_alloc_pages((gfp), 0, (prot))
+
+#define arm_attrib_free_page(page)	arm_attrib_free_pages((page), 0)
+
+#endif /* __ARCH_ARM_ATTRIB_ALLOC_H */
diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index feb988a..d8c464c 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -9,7 +9,19 @@
 #define PKMAP_NR(virt)		(((virt) - PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)		(PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
+#ifndef CONFIG_ARM_ATTRIB_ALLOCATOR
 #define kmap_prot		PAGE_KERNEL
+#else
+static inline pgprot_t kmap_prot_of(struct page *page)
+{
+	if (PageUncached(page)) {
+		return __pgprot_modify(PAGE_KERNEL, L_PTE_MT_MASK,
+				       page->private);
+	} else
+		return PAGE_KERNEL;
+}
+#define kmap_prot		kmap_prot_of(page)
+#endif
 
 #define flush_cache_kmaps() \
 	do { \
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 176e815..4abe9ee 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -811,6 +811,30 @@ config ARM_L1_CACHE_SHIFT
 	default 6 if ARM_L1_CACHE_SHIFT_6
 	default 5
 
+config ARM_ATTRIB_ALLOCATOR
+	bool "Support custom cache attribute allocations in low memory"
+	select ARCH_LOWMEM_IN_PTES
+	select ARCH_USES_PG_UNCACHED
+	depends on MMU && !CPU_CACHE_VIVT
+	help
+	  Historically, the kernel has only reserved a small region
+	  of physical memory for uncached access, and relied on
+	  explicit cache maintenance for ensuring coherency between
+	  the CPU and DMA.
+
+	  However, many recent systems support mapping discontiguous
+	  physical pages into contiguous DMA addresses (so-called
+	  system MMUs). For some DMA clients (notably graphics and
+	  multimedia engines), performing explict cache maintenance
+	  between CPU and DMA mappings can be prohibitively expensive,
+	  and since ARMv7, mapping the same physical page with different
+	  cache attributes is disallowed and has unpredictable behavior.
+
+	  Say 'Y' here to include page allocation support with explicit
+	  cache attributes; on ARMv7 systems this will also force the
+	  kernel's page tables to be mapped using page tables rather
+	  than sections.
+
 config ARM_DMA_MEM_BUFFERABLE
 	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
 	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index e8d34a8..ce803db 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -12,6 +12,8 @@ ifneq ($(CONFIG_MMU),y)
 obj-y				+= nommu.o
 endif
 
+obj-$(CONFIG_ARM_ATTRIB_ALLOCATOR) += attrib_alloc.o
+
 obj-$(CONFIG_MODULES)		+= proc-syms.o
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
diff --git a/arch/arm/mm/attrib_alloc.c b/arch/arm/mm/attrib_alloc.c
new file mode 100644
index 0000000..c188772
--- /dev/null
+++ b/arch/arm/mm/attrib_alloc.c
@@ -0,0 +1,122 @@
+/*
+ * arch/arm/mm/attrib_alloc.c
+ *
+ * Page allocator with custom cache attributes
+ *
+ * Copyright (c) 2010, NVIDIA Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/highmem.h>
+#include <linux/gfp.h>
+#include <linux/page-flags.h>
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/fixmap.h>
+#include <asm/outercache.h>
+#include <asm/attrib_alloc.h>
+#include "mm.h"
+
+#define pgprot_type(pte)	(pgprot_val(pte) & ~L_PTE_MT_MASK)
+
+static void update_kmap_pte(struct page *page, pgprot_t prot)
+{
+	unsigned long addr;
+	pte_t *pte;
+
+	addr = (unsigned long)kmap_high_get(page);
+	BUG_ON(!PageHighMem(page) || addr >= FIXADDR_START);
+	if (!addr)
+		return;
+
+	pte = &pkmap_page_table[PKMAP_NR(addr)];
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, __pgprot(prot)));
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	kunmap_high(page);
+}
+
+static void update_pte(struct page *page, pgprot_t prot)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	pgd_t *pgd = pgd_offset_k(addr);
+	pmd_t *pmd = pmd_offset(pgd, addr);
+	pte_t *pte;
+
+	BUG_ON(pmd_none(*pmd));
+	pte = pte_offset_kernel(pmd, addr);
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, __pgprot(prot)));
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+}
+
+void arm_attrib_free_pages(struct page *page, unsigned int order)
+{
+	/* reset the page's mappings back to the standard kernel mappings
+	 * before returning it to the page allocator */
+	if (PageUncached(page)) {
+		struct page *loop;
+		unsigned int i;
+
+		for (i = 0, loop = page; i < (1 << order); i++, loop++) {
+
+			if (PageHighMem(loop))
+				update_kmap_pte(loop, pgprot_kernel);
+			else
+				update_pte(loop, pgprot_kernel);
+
+			ClearPageUncached(page);
+			set_page_private(page, 0);
+		}
+	}
+	__free_pages(page, order);
+}
+
+struct page *arm_attrib_alloc_pages_node(int nid, gfp_t gfp,
+					 unsigned int order, pgprot_t prot)
+{
+	struct page *page, *loop;
+	unsigned int i;
+	unsigned int type = pgprot_type(prot);
+
+	page = alloc_pages_node(nid, gfp, order);
+	/* if the requested cache attributes match the default value,
+	 * just return because no special handling will be needed for
+	 * this page */
+	if (!page || (type == pgprot_type(pgprot_kernel)))
+		return page;
+
+	for (i = 0, loop = page; i < (1 << order); i++, loop++) {
+		unsigned long phys = page_to_phys(page);
+		__flush_dcache_page(page_mapping(page), page);
+		outer_flush_range(phys, phys + PAGE_SIZE);
+
+		SetPageUncached(loop);
+		set_page_private(page, type);
+
+		/* even though a freshly-allocated highmem page shouldn't
+		 * be mapped, because the kmaps are flushed lazily, it
+		 * is possible that a mapping from an old kmap_high call
+		 * is still present, and its cache attributes need to
+		 * be updated to match the new expectations */
+		if (PageHighMem(loop))
+			update_kmap_pte(loop, prot);
+		else
+			update_pte(loop, prot);
+	}
+	return page;
+}
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9e7742f..fa94be5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -485,6 +485,12 @@ void ___dma_page_cpu_to_dev(struct page *page, unsigned long off,
 {
 	unsigned long paddr;
 
+	if (PageUncached(page) &&
+	    !(page_private(page) == L_PTE_MT_WRITEBACK ||
+	      page_private(page) == L_PTE_MT_WRITEALLOC ||
+	      page_private(page) == L_PTE_MT_DEV_CACHED))
+		return;
+
 	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
 
 	paddr = page_to_phys(page) + off;
@@ -500,7 +506,15 @@ EXPORT_SYMBOL(___dma_page_cpu_to_dev);
 void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
-	unsigned long paddr = page_to_phys(page) + off;
+	unsigned long paddr;
+
+	if (PageUncached(page) &&
+	    !(page_private(page) == L_PTE_MT_WRITEBACK ||
+	      page_private(page) == L_PTE_MT_WRITEALLOC ||
+	      page_private(page) == L_PTE_MT_DEV_CACHED))
+		return;
+
+	paddr = page_to_phys(page) + off;
 
 	/* FIXME: non-speculating: not required */
 	/* don't bother invalidating if DMA to device */
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index c6844cb..33e900a 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -153,6 +153,15 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 
 void __flush_dcache_page(struct address_space *mapping, struct page *page)
 {
+	/* PageUncached is used to indicate that cache attribute flags
+	 * are stored with the page; cache maintenance may still be
+	 * required if the page is mapped inner-cacheable, outer
+	 * non-cacheable */
+	if (PageUncached(page) &&
+	    !(page_private(page) == L_PTE_MT_WRITEBACK ||
+	      page_private(page) == L_PTE_MT_WRITEALLOC ||
+	      page_private(page) == L_PTE_MT_DEV_CACHED))
+		return;
 	/*
 	 * Writeback any data associated with the kernel mapping of this
 	 * page.  This ensures that data in the physical page is mutually
diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 6ab2440..b25ebee 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -109,6 +109,7 @@ void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
 {
 	unsigned int idx;
 	unsigned long vaddr;
+	struct page *page = pfn_to_page(pfn);
 
 	pagefault_disable();
 
@@ -117,7 +118,7 @@ void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
 #ifdef CONFIG_DEBUG_HIGHMEM
 	BUG_ON(!pte_none(*(TOP_PTE(vaddr))));
 #endif
-	set_pte_ext(TOP_PTE(vaddr), pfn_pte(pfn, kmap_prot), 0);
+	set_pte_ext(TOP_PTE(vaddr), mk_pte(page, kmap_prot), 0);
 	local_flush_tlb_kernel_page(vaddr);
 
 	return (void *)vaddr;
-- 
1.7.0.4
