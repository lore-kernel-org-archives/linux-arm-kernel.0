From: chripell@fsfe.org (Christian Pellegrin)
Date: Sat, 19 Dec 2009 12:27:26 +0100
Subject: [PATCH] Fix coherency problems on ARM v5 with L2 PIPT cache.
In-Reply-To: <cabda6420912190324s1e2c7864tadd5aca9aacc640e@mail.gmail.com>
References: <cabda6420912190324s1e2c7864tadd5aca9aacc640e@mail.gmail.com>
Message-ID: <1261222046-2537-1-git-send-email-chripell@fsfe.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes coherency problems on ARM systems that have a
VIVT L1 cache and a PIPT L2 one. The modifications to fault-armv.c
assure that we don't mix cached and uncached mappings of the same
physical memory area after we made a mapping uncached to prevent
problems with L1 aliasing. The modifications to flush.c assure
coherency with read/write because kernel PIO memory access is
always cached.

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 arch/arm/mm/Kconfig      |    8 ++++++
 arch/arm/mm/fault-armv.c |   55 ++++++++++++++++++++++++++++++++++++++++++---
 arch/arm/mm/flush.c      |    7 ++++++
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9264d81..2eacf29 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -776,3 +776,11 @@ config ARM_L1_CACHE_SHIFT
 	int
 	default 6 if ARCH_OMAP3
 	default 5
+
+config ARM_ARMV5_L2_CACHE_COHERENCY_FIX
+       bool "Enable L2 coherency problem fix on ARMv5"
+       depends on OUTER_CACHE && CPU_CACHE_VIVT
+       default y
+       help
+         Fixes coherency problems on ARM systems that have
+	 a non-disableable VIVT L1 cache and a PIPT L2 one.
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index d0d17b6..bf6d98c 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -34,7 +34,8 @@ static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
  * Therefore those configurations which might call adjust_pte (those
  * without CONFIG_CPU_CACHE_VIPT) cannot support split page_table_lock.
  */
-static int adjust_pte(struct vm_area_struct *vma, unsigned long address)
+static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
+		      int update, int only_shared)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -65,7 +66,9 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address)
 	 * If this page isn't present, or is already setup to
 	 * fault (ie, is old), we can safely ignore any issues.
 	 */
-	if (ret && (pte_val(entry) & L_PTE_MT_MASK) != shared_pte_mask) {
+	if (ret &&
+	    (pte_val(entry) & L_PTE_MT_MASK) != shared_pte_mask &&
+	    update) {
 		unsigned long pfn = pte_pfn(entry);
 		flush_cache_page(vma, address, pfn);
 		outer_flush_range((pfn << PAGE_SHIFT),
@@ -74,7 +77,14 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address)
 		pte_val(entry) |= shared_pte_mask;
 		set_pte_at(vma->vm_mm, address, pte, entry);
 		flush_tlb_page(vma, address);
+		printk(KERN_DEBUG "Uncached vma %08x "
+		       "(addr %08lx flags %08lx phy %08x) from pid %d\n",
+		       (unsigned int) vma, vma->vm_start, vma->vm_flags,
+		       (unsigned int) (pfn << PAGE_SHIFT),
+		       current->pid);
 	}
+	if (only_shared && (pte_val(entry) & L_PTE_MT_MASK) != shared_pte_mask)
+		ret = 0;
 	pte_unmap(pte);
 	return ret;
 
@@ -100,6 +110,9 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigne
 	unsigned long offset;
 	pgoff_t pgoff;
 	int aliases = 0;
+#ifdef CONFIG_ARM_ARMV5_L2_CACHE_COHERENCY_FIX
+	int run;
+#endif
 
 	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
 
@@ -109,6 +122,39 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigne
 	 * cache coherency.
 	 */
 	flush_dcache_mmap_lock(mapping);
+#ifdef CONFIG_ARM_ARMV5_L2_CACHE_COHERENCY_FIX
+	/*
+	 * In the first run we just check if we have to make some
+	 * address space uncacheable because of L1 VIVT. In the second
+	 * we check if there is an uncached map in other processes.  If
+	 * one of the previous condition is true we proceed to make
+	 * *all* (both in current process VMA and that of others) of
+	 * them so. This should solve both cases of multiple shared
+	 * memories attached in the same process but not impact the
+	 * common case of just one mapping per process.
+	 */
+	for (run = 0; run < 3; run++) {
+		vma_prio_tree_foreach(mpnt, &iter, &mapping->i_mmap,
+				      pgoff, pgoff) {
+			if ((mpnt->vm_mm != mm || mpnt == vma) && run == 0)
+				continue;
+			if (!(mpnt->vm_flags & VM_MAYSHARE) &&
+			    run != 2) /* update all mappings */
+				continue;
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			aliases += adjust_pte(mpnt, mpnt->vm_start + offset,
+					      /* update only on the last run */
+					      run == 2,
+					      /*
+					       * on the second run
+					       * catch shared in other procs
+					       */
+					      run == 1);
+		}
+		if (aliases == 0 && run == 1)
+			break;
+	}
+#else
 	vma_prio_tree_foreach(mpnt, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
@@ -120,11 +166,12 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigne
 		if (!(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		aliases += adjust_pte(mpnt, mpnt->vm_start + offset);
+		aliases += adjust_pte(mpnt, mpnt->vm_start + offset, 1, 0);
 	}
+#endif
 	flush_dcache_mmap_unlock(mapping);
 	if (aliases)
-		adjust_pte(vma, addr);
+		adjust_pte(vma, addr, 1, 0);
 	else
 		flush_cache_page(vma, addr, pfn);
 }
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7f294f3..779a7f9 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -209,6 +209,13 @@ void flush_dcache_page(struct page *page)
 			__flush_dcache_aliases(mapping, page);
 		else if (mapping)
 			__flush_icache_all();
+#ifdef CONFIG_ARM_ARMV5_L2_CACHE_COHERENCY_FIX
+		{
+		  unsigned long pfn = page_to_pfn(page);
+		  outer_flush_range((pfn << PAGE_SHIFT),
+				    (pfn << PAGE_SHIFT) + PAGE_SIZE);
+		}
+#endif
 	}
 }
 EXPORT_SYMBOL(flush_dcache_page);
-- 
1.5.6.5
