From: james.morse@arm.com (James Morse)
Date: Mon, 15 Aug 2016 18:12:02 +0100
Subject: [PATCH v4 3/3] arm64: hibernate: Support DEBUG_PAGEALLOC
In-Reply-To: <1471281122-26295-1-git-send-email-james.morse@arm.com>
References: <1471281122-26295-1-git-send-email-james.morse@arm.com>
Message-ID: <1471281122-26295-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DEBUG_PAGEALLOC removes the valid bit of page table entries to prevent
any access to unallocated memory. Hibernate uses this as a hint that those
pages don't need to be saved/restored. This patch adds the
kernel_page_present() function it uses.

hibernate.c copies the resume kernel's linear map for use during restore.
Add _copy_pte() to fill-in the holes made by DEBUG_PAGEALLOC in the resume
kernel, so we can restore data the original kernel had at these addresses.

Finally, DEBUG_PAGEALLOC means the linear-map alias of KERNEL_START to
KERNEL_END may have holes in it, so we can't lazily clean this whole
area to the PoC. Only clean the new mmuoff regions, and the kernel/kvm
idmaps.

This reverts commit da24eb1f3f9e2c7b75c5f8c40d8e48e2c4789596.

Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig            |  1 -
 arch/arm64/kernel/hibernate.c | 45 ++++++++++++++++++++++++++++++++++---------
 arch/arm64/mm/pageattr.c      | 40 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f586f1..9be0c164df4e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -607,7 +607,6 @@ source kernel/Kconfig.preempt
 source kernel/Kconfig.hz
 
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
-	depends on !HIBERNATION
 	def_bool y
 
 config ARCH_HAS_HOLES_MEMORYMODEL
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index b4082017c4cb..da4470de1807 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -235,6 +235,7 @@ out:
 	return rc;
 }
 
+#define dcache_clean_range(start, end)	__flush_dcache_area(start, (end - start))
 
 int swsusp_arch_suspend(void)
 {
@@ -252,8 +253,14 @@ int swsusp_arch_suspend(void)
 	if (__cpu_suspend_enter(&state)) {
 		ret = swsusp_save();
 	} else {
-		/* Clean kernel to PoC for secondary core startup */
-		__flush_dcache_area(LMADDR(KERNEL_START), KERNEL_END - KERNEL_START);
+		/* Clean kernel core startup/idle code to PoC*/
+		dcache_clean_range(__mmuoff_text_start, __mmuoff_text_end);
+		dcache_clean_range(__mmuoff_data_start, __mmuoff_data_end);
+		dcache_clean_range(__idmap_text_start, __idmap_text_end);
+
+		/* Clean kvm setup code to PoC? */
+		if (el2_reset_needed())
+			dcache_clean_range(__hyp_idmap_text_start, __hyp_idmap_text_end);
 
 		/*
 		 * Tell the hibernation core that we've just restored
@@ -269,6 +276,32 @@ int swsusp_arch_suspend(void)
 	return ret;
 }
 
+static void _copy_pte(pte_t *dst_pte, pte_t *src_pte, unsigned long addr)
+{
+	unsigned long pfn = virt_to_pfn(addr);
+
+	if (pte_valid(*src_pte)) {
+		/*
+		 * Resume will overwrite areas that may be marked
+		 * read only (code, rodata). Clear the RDONLY bit from
+		 * the temporary mappings we use during restore.
+		 */
+		set_pte(dst_pte, __pte(pte_val(*src_pte) & ~PTE_RDONLY));
+	} else if (debug_pagealloc_enabled()) {
+		/*
+		 * debug_pagealloc may have removed the PTE_VALID bit if
+		 * the page isn't in use by the resume kernel. It may have
+		 * been in use by the original kernel, in which case we need
+		 * to put it back in our copy to do the restore.
+		 *
+		 * Check for mappable memory that gives us a translation
+		 * like part of the linear map.
+		 */
+		if (pfn_valid(pfn) && pte_pfn(*src_pte) == pfn)
+			set_pte(dst_pte, __pte((pte_val(*src_pte) & ~PTE_RDONLY) | PTE_VALID));
+	}
+}
+
 static int copy_pte(pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long start,
 		    unsigned long end)
 {
@@ -284,13 +317,7 @@ static int copy_pte(pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long start,
 
 	src_pte = pte_offset_kernel(src_pmd, start);
 	do {
-		if (!pte_none(*src_pte))
-			/*
-			 * Resume will overwrite areas that may be marked
-			 * read only (code, rodata). Clear the RDONLY bit from
-			 * the temporary mappings we use during restore.
-			 */
-			set_pte(dst_pte, __pte(pte_val(*src_pte) & ~PTE_RDONLY));
+		_copy_pte(dst_pte, src_pte, addr);
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
 	return 0;
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index ca6d268e3313..b6c0da84258c 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -139,4 +139,42 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 					__pgprot(0),
 					__pgprot(PTE_VALID));
 }
-#endif
+#ifdef CONFIG_HIBERNATION
+/*
+ * When built with CONFIG_DEBUG_PAGEALLOC and CONFIG_HIBERNATION, this function
+ * is used to determine if a linear map page has been marked as not-present by
+ * CONFIG_DEBUG_PAGEALLOC. Walk the page table and check the PTE_VALID bit.
+ * This is based on kern_addr_valid(), which almost does what we need.
+ */
+bool kernel_page_present(struct page *page)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long addr = (unsigned long)page_address(page);
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd))
+		return false;
+
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud))
+		return false;
+	if (pud_sect(*pud))
+		return true;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return false;
+	if (pmd_sect(*pmd))
+		return true;
+
+	pte = pte_offset_kernel(pmd, addr);
+	if (pte_none(*pte))
+		return false;
+
+	return pte_valid(*pte);
+}
+#endif /* CONFIG_HIBERNATION */
+#endif /* CONFIG_DEBUG_PAGEALLOC */
-- 
2.8.0.rc3
