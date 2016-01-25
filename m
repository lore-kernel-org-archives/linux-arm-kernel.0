From: labbott@fedoraproject.org (Laura Abbott)
Date: Mon, 25 Jan 2016 08:52:14 -0800
Subject: [RFC][PATCH 3/4] arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
In-Reply-To: <1453740735-17898-1-git-send-email-labbott@fedoraproject.org>
References: <1453740735-17898-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <1453740735-17898-4-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With support for forcing all memory, we can now easily map and unmap
individual pages for debugging purposes. Add support for
ARCH_SUPPORTS_DEBUG_PAGEALLOC to map and unmap pages when this
debugging feature is enabled.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
 arch/arm64/Kconfig       |  3 +++
 arch/arm64/mm/pageattr.c | 40 +++++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index faf7eac..0d757eb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -518,6 +518,9 @@ config FORCE_PAGES
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz
 
+config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	def_bool y if FORCE_PAGES
+
 config ARCH_HAS_HOLES_MEMORYMODEL
 	def_bool y if SPARSEMEM
 
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 1360a02..16efc7c 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -38,7 +38,8 @@ static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
 }
 
 static int change_memory_common(unsigned long addr, int numpages,
-				pgprot_t set_mask, pgprot_t clear_mask)
+				pgprot_t set_mask, pgprot_t clear_mask,
+				bool ignore_vma_check)
 {
 	unsigned long start = addr;
 	unsigned long size = PAGE_SIZE*numpages;
@@ -65,11 +66,14 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 *
 	 * So check whether the [addr, addr + size) interval is entirely
 	 * covered by precisely one VM area that has the VM_ALLOC flag set.
+	 *
+	 * The one exception to this is is we're forcing everything to be
+	 * page mapped
 	 */
 	area = find_vm_area((void *)addr);
-	if (!area ||
+	if (!ignore_vma_check && (!area ||
 	    end > (unsigned long)area->addr + area->size ||
-	    !(area->flags & VM_ALLOC))
+	    !(area->flags & VM_ALLOC)))
 		return -EINVAL;
 
 	data.set_mask = set_mask;
@@ -86,21 +90,24 @@ int set_memory_ro(unsigned long addr, int numpages)
 {
 	return change_memory_common(addr, numpages,
 					__pgprot(PTE_RDONLY),
-					__pgprot(PTE_WRITE));
+					__pgprot(PTE_WRITE),
+					false);
 }
 
 int set_memory_rw(unsigned long addr, int numpages)
 {
 	return change_memory_common(addr, numpages,
 					__pgprot(PTE_WRITE),
-					__pgprot(PTE_RDONLY));
+					__pgprot(PTE_RDONLY),
+					false);
 }
 
 int set_memory_nx(unsigned long addr, int numpages)
 {
 	return change_memory_common(addr, numpages,
 					__pgprot(PTE_PXN),
-					__pgprot(0));
+					__pgprot(0),
+					false);
 }
 EXPORT_SYMBOL_GPL(set_memory_nx);
 
@@ -108,6 +115,25 @@ int set_memory_x(unsigned long addr, int numpages)
 {
 	return change_memory_common(addr, numpages,
 					__pgprot(0),
-					__pgprot(PTE_PXN));
+					__pgprot(PTE_PXN),
+					false);
 }
 EXPORT_SYMBOL_GPL(set_memory_x);
+
+#ifdef CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	unsigned long addr = (unsigned long) page_address(page);
+
+	if (enable)
+		change_memory_common(addr, numpages,
+					__pgprot(PTE_VALID),
+					__pgprot(0),
+					true);
+	else
+		change_memory_common(addr, numpages,
+					__pgprot(0),
+					__pgprot(PTE_VALID),
+					true);
+}
+#endif
-- 
2.5.0
