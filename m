From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  2 Jun 2017 11:27:20 +0000
Subject: [PATCH] mm: vmalloc: make vmalloc_to_page() deal with PMD/PUD mappings
Message-ID: <20170602112720.28948-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While vmalloc() itself strictly uses page mappings only on all
architectures, some of the support routines are aware of the possible
existence of PMD or PUD size mappings inside the VMALLOC region.
This is necessary given that ioremap() shares this region and the
unmap routines with vmalloc(), and ioremap() may use huge pages on
some architectures.

On arm64 running with 4 KB pages, VM_MAP mappings will exist in the
VMALLOC region that are mapped to some extent using PMD size mappings.
As reported by Zhong Jiang, this confuses the kcore code, given that
vread() does not expect having to deal with PMD mappings, resulting
in oopses.

Even though we could work around this by special casing kcore or vmalloc
code for the VM_MAP mappings used by the arm64 kernel, the fact is that
there is already a precedent for dealing with PMD/PUD mappings in the
VMALLOC region, and so we could update the vmalloc_to_page() routine to
deal with such mappings as well. This solves the problem, and brings us
a step closer to huge page support in vmalloc/vmap, which could well be
in our future anyway.

Reported-by: Zhong Jiang <zhongjiang@huawei.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 mm/vmalloc.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 34a1c3e46ed7..cd79e62f8011 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/hugetlb.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -263,6 +264,38 @@ int is_vmalloc_or_module_addr(const void *x)
 }
 
 /*
+ * Some architectures (such as arm64) allow vmap() mappings in the
+ * vmalloc region that may consist of PMD block mappings.
+ */
+static struct page *vmalloc_to_pud_page(unsigned long addr, pud_t *pud)
+{
+	struct page *page = NULL;
+#ifdef CONFIG_HUGETLB_PAGE
+	pte_t pte = huge_ptep_get((pte_t *)pud);
+
+	if (pte_present(pte))
+		page = pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+#else
+	VIRTUAL_BUG_ON(1);
+#endif
+	return page;
+}
+
+static struct page *vmalloc_to_pmd_page(unsigned long addr, pmd_t *pmd)
+{
+	struct page *page = NULL;
+#ifdef CONFIG_HUGETLB_PAGE
+	pte_t pte = huge_ptep_get((pte_t *)pmd);
+
+	if (pte_present(pte))
+		page = pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+#else
+	VIRTUAL_BUG_ON(1);
+#endif
+	return page;
+}
+
+/*
  * Walk a vmap address to the struct page it maps.
  */
 struct page *vmalloc_to_page(const void *vmalloc_addr)
@@ -289,9 +322,13 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	pud = pud_offset(p4d, addr);
 	if (pud_none(*pud))
 		return NULL;
+	if (pud_huge(*pud))
+		return vmalloc_to_pud_page(addr, pud);
 	pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd))
 		return NULL;
+	if (pmd_huge(*pmd))
+		return vmalloc_to_pmd_page(addr, pmd);
 
 	ptep = pte_offset_map(pmd, addr);
 	pte = *ptep;
-- 
2.9.3
