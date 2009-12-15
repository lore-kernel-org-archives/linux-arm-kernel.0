From: chripell@gmail.com (christian pellegrin)
Date: Tue, 15 Dec 2009 16:31:35 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
References: <20091207114218.GA19348@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
Message-ID: <cabda6420912150731s1570aa04w4eaff03bc93ee6a6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch here does what was described by Russell and seems to solve
the read/write and the MAP_PRIVATE in test cases like the one I
posted. As noted it may not be enough. If you don't think it's
complete crap I can try to check for other cases too by installing a
more complete system (X11, db4) and using ftrace to watch for which
flush_cache_* we actually use. Any suggestion is appreciated, it would
be a pity to have to turn off L2 cache.

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index d0d17b6..53ad00f 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -34,7 +34,7 @@ static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
  * Therefore those configurations which might call adjust_pte (those
  * without CONFIG_CPU_CACHE_VIPT) cannot support split page_table_lock.
  */
-static int adjust_pte(struct vm_area_struct *vma, unsigned long address)
+static int adjust_pte(struct vm_area_struct *vma, unsigned long
address, int update, int only_shared)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -65,7 +65,7 @@ static int adjust_pte(struct vm_area_struct *vma,
unsigned long address)
 	 * If this page isn't present, or is already setup to
 	 * fault (ie, is old), we can safely ignore any issues.
 	 */
-	if (ret && (pte_val(entry) & L_PTE_MT_MASK) != shared_pte_mask) {
+	if (ret && (pte_val(entry) & L_PTE_MT_MASK) != shared_pte_mask && update) {
 		unsigned long pfn = pte_pfn(entry);
 		flush_cache_page(vma, address, pfn);
 		outer_flush_range((pfn << PAGE_SHIFT),
@@ -74,7 +74,13 @@ static int adjust_pte(struct vm_area_struct *vma,
unsigned long address)
 		pte_val(entry) |= shared_pte_mask;
 		set_pte_at(vma->vm_mm, address, pte, entry);
 		flush_tlb_page(vma, address);
+		printk(KERN_INFO "Uncached vma %08x (addr %08lx flahs %08lx phy
%08x) from pid %d\n",
+		       (unsigned int) vma, vma->vm_start, vma->vm_flags,
+		       (unsigned int) (pfn << PAGE_SHIFT),
+		       current->pid);
 	}
+	if (only_shared && (pte_val(entry) & L_PTE_MT_MASK) != shared_pte_mask)
+	  ret = 0;
 	pte_unmap(pte);
 	return ret;

@@ -100,6 +106,9 @@ make_coherent(struct address_space *mapping,
struct vm_area_struct *vma, unsigne
 	unsigned long offset;
 	pgoff_t pgoff;
 	int aliases = 0;
+#if defined(CONFIG_OUTER_CACHE) && defined(CONFIG_CPU_CACHE_VIVT)
+	int run;
+#endif

 	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);

@@ -109,6 +118,32 @@ make_coherent(struct address_space *mapping,
struct vm_area_struct *vma, unsigne
 	 * cache coherency.
 	 */
 	flush_dcache_mmap_lock(mapping);
+#if defined(CONFIG_OUTER_CACHE) && defined(CONFIG_CPU_CACHE_VIVT)
+	/*
+	 * In the first run we just check if we have to make some
+	 * address space uncacheable cause of L1 VIVT. In the second
+	 * we check if there is an uncached map in other process.  If
+	 * one of the previous condition is true we proceed to make
+	 * *all* (both in current process VMA and that of others) of
+	 * them so. This should solve both cases of multiple shared
+	 * memories attached in the same process but not impact the
+	 * common case of just one mapping per process.
+	 */
+	for(run = 0; run < 3; run++) {
+		vma_prio_tree_foreach(mpnt, &iter, &mapping->i_mmap, pgoff, pgoff) {
+			if ((mpnt->vm_mm != mm || mpnt == vma) && run == 0)
+				continue;
+			if (!(mpnt->vm_flags & VM_MAYSHARE) && run != 2) /* update all mappings */
+				continue;
+			offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
+			aliases += adjust_pte(mpnt, mpnt->vm_start + offset,
+					      run == 2, /* update only on the last run */
+					      run == 1); /* on the second run catch shared in other procs */
+		}
+		if (aliases == 0 && run == 1)
+			break;
+	}
+#else
 	vma_prio_tree_foreach(mpnt, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
@@ -120,11 +155,12 @@ make_coherent(struct address_space *mapping,
struct vm_area_struct *vma, unsigne
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
index 7f294f3..b7c6986 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -209,6 +209,13 @@ void flush_dcache_page(struct page *page)
 			__flush_dcache_aliases(mapping, page);
 		else if (mapping)
 			__flush_icache_all();
+#ifdef CONFIG_OUTER_CACHE
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
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
