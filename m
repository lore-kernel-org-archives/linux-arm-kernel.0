From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Dec 2009 16:38:50 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <4B1931B3.90301@denx.de>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
	<4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
Message-ID: <20091204163850.GC20386@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 04:58:43PM +0100, Heiko Schocher wrote:
> Hello Russell King,
> 
> Russell King - ARM Linux wrote:
> > On Fri, Dec 04, 2009 at 02:42:12PM +0100, Heiko Schocher wrote:
> >> Hello Russell King,
> >>
> >> Russell King - ARM Linux wrote:
> >>> On Fri, Dec 04, 2009 at 12:23:45PM +0100, Heiko Schocher wrote:
> >>>> [4] Log from Demoprogramm, not working
> >>> I think this is messed up - this is not from your first script but your
> >>> second script which starts four independent read processes.
> >>>
> >>> I determined this because:
> >>> (1) the read thread addresses are mostly the same
> >>> (2) there are four "Read form in_msg" strings, which you only print
> >>> once at the start of the program.
> >> Ups, sorry for the confusion, here 2 logs with the right values:
> > 
> > I don't remember whether 2.6.28 has highmem.  Can you check whether you're
> > using highmem please?
> 
> No, there is no HIGHMEM in the defconfig, if you mean this config option.
> 
> You can find the complete defconfig here:
> 
> http://git.denx.de/?p=linux-2.6-denx.git;a=blob;f=arch/arm/configs/suen3_defconfig;h=905f9bc6a36c03ab41b97a292fca5b3a0011a2a0;hb=3dc3e4dc957f216ec5cdcd2a770f5c4b0cefca4a

Please apply this patch and re-run your program.  Expect a fair bit of
output - the last 50 or so lines from the kernel messages should cover
everything that's required.  Also useful would be the output from the
program giving the addresses of the shm regions.

(This patch is a little messy because it contains a bit of restructuring
for 2.6.32 bug fixing...)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 7296022..c457920 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -27,6 +27,8 @@
 
 static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
 
+#define is_debug() (strcmp(current->comm, "shmtest2") == 0)
+
 /*
  * We take the easy way out of this problem - we make the
  * PTE uncacheable.  However, we leave the write buffer on.
@@ -36,33 +38,18 @@ static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
  * Therefore those configurations which might call adjust_pte (those
  * without CONFIG_CPU_CACHE_VIPT) cannot support split page_table_lock.
  */
-static int adjust_pte(struct vm_area_struct *vma, unsigned long address)
+static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
+	pte_t *ptep)
 {
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte, entry;
+	pte_t entry = *ptep;
 	int ret;
 
-	pgd = pgd_offset(vma->vm_mm, address);
-	if (pgd_none(*pgd))
-		goto no_pgd;
-	if (pgd_bad(*pgd))
-		goto bad_pgd;
-
-	pmd = pmd_offset(pgd, address);
-	if (pmd_none(*pmd))
-		goto no_pmd;
-	if (pmd_bad(*pmd))
-		goto bad_pmd;
-
-	pte = pte_offset_map(pmd, address);
-	entry = *pte;
-
 	/*
 	 * If this page is present, it's actually being shared.
 	 */
 	ret = pte_present(entry);
-
+if (is_debug()) printk("%s:%d: vma %p addr %lx pte %08lx\n",
+  current->comm, current->pid, vma, address, pte_val(entry));
 	/*
 	 * If this page isn't present, or is already setup to
 	 * fault (ie, is old), we can safely ignore any issues.
@@ -74,23 +61,36 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address)
 				  (pfn << PAGE_SHIFT) + PAGE_SIZE);
 		pte_val(entry) &= ~L_PTE_MT_MASK;
 		pte_val(entry) |= shared_pte_mask;
-		set_pte_at(vma->vm_mm, address, pte, entry);
+		set_pte_at(vma->vm_mm, address, ptep, entry);
 		flush_tlb_page(vma, address);
+if (is_debug()) printk("%s:%d: modified %08lx\n", current->comm, current->pid, pte_val(entry));
 	}
-	pte_unmap(pte);
 	return ret;
+}
+
+static int adjust_pte(struct vm_area_struct *vma, unsigned long address)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	int ret;
 
-bad_pgd:
-	pgd_ERROR(*pgd);
-	pgd_clear(pgd);
-no_pgd:
-	return 0;
-
-bad_pmd:
-	pmd_ERROR(*pmd);
-	pmd_clear(pmd);
-no_pmd:
-	return 0;
+	pgd = pgd_offset(vma->vm_mm, address);
+	if (pgd_none_or_clear_bad(pgd))
+		return 0;
+
+	pmd = pmd_offset(pgd, address);
+	if (pmd_none_or_clear_bad(pmd))
+		return 0;
+
+	/*
+	 * This may be called while another page table is mapped.
+	 */
+	pte = pte_offset_map_nested(pmd, address);
+	ret = do_adjust_pte(vma, address, pte);
+	pte_unmap_nested(pte);
+
+	return ret;
 }
 
 static void
@@ -105,6 +105,9 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigne
 
 	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
 
+if (is_debug()) printk("%s:%d: %p %p %lx %lx %lx\n",
+ current->comm, current->pid, mapping, vma, pgoff, addr, pfn);
+
 	/*
 	 * If we have any shared mappings that are in the same mm
 	 * space, then we need to handle them specially to maintain
@@ -125,6 +128,7 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigne
 		aliases += adjust_pte(mpnt, mpnt->vm_start + offset);
 	}
 	flush_dcache_mmap_unlock(mapping);
+if (is_debug()) printk("%s:%d: aliases %d\n", current->comm, current->pid, aliases);
 	if (aliases)
 		adjust_pte(vma, addr);
 	else
