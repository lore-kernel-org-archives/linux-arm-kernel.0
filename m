From: chripell@gmail.com (christian pellegrin)
Date: Mon, 14 Dec 2009 14:13:17 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091213120615.GB10698@n2100.arm.linux.org.uk>
References: <20091207114218.GA19348@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
Message-ID: <cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, I've been using the patch below for a couple of days now on an a
Feroceon based system. It tries to be smart in deciding when to mark a
mapping uncacheable and I haven't noticed many of them (but I am *not*
running it on a X11 system where maybe the situation could be
different). It solves the situation of the test program above. Please
be patient if there is something really wrong with it because I don't
have a deep understanding of the workings of Linux VM and neither the
Feroceon manuals (unfortunately I found that these are not available
*after* buying the hardware). Thank you for looking at this, I think
this problem should be fixed soon so we can trust our systems.

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index d0d17b6..36dc4a5 100644
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
@@ -74,7 +74,12 @@ static int adjust_pte(struct vm_area_struct *vma,
unsigned long address)
 		pte_val(entry) |= shared_pte_mask;
 		set_pte_at(vma->vm_mm, address, pte, entry);
 		flush_tlb_page(vma, address);
+		printk(KERN_INFO "Uncached vma %08x (phy %08x) from pid %d\n",
+		       (unsigned int) vma, (unsigned int) (pfn << PAGE_SHIFT),
+		       current->pid);
 	}
+	if (only_shared && (pte_val(entry) & L_PTE_MT_MASK) != shared_pte_mask)
+	  ret = 0;
 	pte_unmap(pte);
 	return ret;

@@ -100,6 +105,9 @@ make_coherent(struct address_space *mapping,
struct vm_area_struct *vma, unsigne
 	unsigned long offset;
 	pgoff_t pgoff;
 	int aliases = 0;
+#if defined(CONFIG_OUTER_CACHE) && defined(CONFIG_CPU_CACHE_VIVT)
+	int run;
+#endif

 	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);

@@ -109,6 +117,32 @@ make_coherent(struct address_space *mapping,
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
+			if (!(mpnt->vm_flags & VM_MAYSHARE))
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
@@ -120,11 +154,12 @@ make_coherent(struct address_space *mapping,
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


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
