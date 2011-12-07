From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Dec 2011 12:25:44 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111207112320.GB23720@arm.com>
References: <20111202182054.GA3250@arm.com>
 <20111206124109.GT14542@n2100.arm.linux.org.uk>
 <20111206140729.GA31720@arm.com>
 <20111206233058.GZ14542@n2100.arm.linux.org.uk>
 <20111207112320.GB23720@arm.com>
Message-ID: <20111207122544.GD23720@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 11:23:20AM +0000, Catalin Marinas wrote:
> On Tue, Dec 06, 2011 at 11:30:58PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 06, 2011 at 02:07:29PM +0000, Catalin Marinas wrote:
> > > This patch wasn't
> > > originally part of my LPAE series as I hoped you would have merged it
> > > during the last cycle. Now it had to be part of the pull request as LPAE
> > > patches depend on it.
> > 
> > I've stated many times why it's not merged, and for the N'th time: it
> > generates warnings.  I'm _not_ merging something that is known to add
> > warnings such as those which this patch produces without there being a
> > fix for it.  You know that _very well_ because I've said it several
> > times, not only by email but also on our various phone calls.
> > 
> > I've dealt with this patch in exactly the same way at every merge window
> > we've had for the last _year_ - I've queued it up with the expectation
> > that hopefully someone would fix the warnings, the warnings didn't get
> > fixed, so it got dropped from the pull request.  Immediately after the
> > merge window (which includes this) it gets reinstated back into
> > linux-next.
> 
> Yes, I'm fully aware, and I sent you a fix-up in the past. I can
> re-write that fix-up in a few other ways if you don't like the current
> one, just let me know.

OK, I took the time to implement another RFC fix-up for this. It's only
compile-tested at the moment and may need a few more tweaks but it gives
you an idea on what it tries to achieve. With the classic MMU, all the
pud_alloc/pmd_alloc just translate to pud_offset/pmd_offset so the
current behaviour should not be affected. In theory, it could work with
LPAE as well as it allocates the pmd at run-time (we don't really need
freeing them during unmap). Any thoughts?


ARM: pgtable: Fix compiler warning in ioremap.c introduced by nopud

From: Catalin Marinas <catalin.marinas@arm.com>

With the arch/arm code conversion to pgtable-nopud.h, the section and
supersection (un|re)map code triggers compiler warnings on UP systems.
This is caused by pmd_offset() being given a pgd_t argument rather than
a pud_t one. This patch makes the necessary conversion via pud_alloc()
and pmd_alloc().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/ioremap.c |   50 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index bdb248c..4827851 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -78,13 +78,20 @@ void __check_kvm_seq(struct mm_struct *mm)
 static void unmap_area_sections(unsigned long virt, unsigned long size)
 {
 	unsigned long addr = virt, end = virt + (size & ~(SZ_1M - 1));
-	pgd_t *pgd;
 
 	flush_cache_vunmap(addr, end);
-	pgd = pgd_offset_k(addr);
 	do {
-		pmd_t pmd, *pmdp = pmd_offset(pgd, addr);
+		pgd_t *pgd = pgd_offset_k(addr);
+		pud_t *pud;
+		pmd_t pmd, *pmdp;
 
+		if (pgd_none(*pgd))
+			continue;
+		pud = pud_offset(pgd, addr);
+		if (pud_none(*pud))
+			continue;
+
+		pmdp = pmd_offset(pud, addr);
 		pmd = *pmdp;
 		if (!pmd_none(pmd)) {
 			/*
@@ -103,10 +110,7 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
 			if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
 				pte_free_kernel(&init_mm, pmd_page_vaddr(pmd));
 		}
-
-		addr += PGDIR_SIZE;
-		pgd++;
-	} while (addr < end);
+	} while (addr += PMD_SIZE, addr < end);
 
 	/*
 	 * Ensure that the active_mm is up to date - we want to
@@ -123,7 +127,6 @@ remap_area_sections(unsigned long virt, unsigned long pfn,
 		    size_t size, const struct mem_type *type)
 {
 	unsigned long addr = virt, end = virt + size;
-	pgd_t *pgd;
 
 	/*
 	 * Remove and free any PTE-based mapping, and
@@ -131,9 +134,17 @@ remap_area_sections(unsigned long virt, unsigned long pfn,
 	 */
 	unmap_area_sections(virt, size);
 
-	pgd = pgd_offset_k(addr);
 	do {
-		pmd_t *pmd = pmd_offset(pgd, addr);
+		pgd_t *pgd = pgd_offset_k(addr);
+		pud_t *pud;
+		pmd_t *pmd;
+
+		pud = pud_alloc(&init_mm, pgd, addr);
+		if (!pud)
+			return -ENOMEM;
+		pmd = pmd_alloc(&init_mm, pud, addr);
+		if (!pmd)
+			return -ENOMEM;
 
 		pmd[0] = __pmd(__pfn_to_phys(pfn) | type->prot_sect);
 		pfn += SZ_1M >> PAGE_SHIFT;
@@ -141,8 +152,7 @@ remap_area_sections(unsigned long virt, unsigned long pfn,
 		pfn += SZ_1M >> PAGE_SHIFT;
 		flush_pmd_entry(pmd);
 
-		addr += PGDIR_SIZE;
-		pgd++;
+		addr += PMD_SIZE;
 	} while (addr < end);
 
 	return 0;
@@ -153,7 +163,6 @@ remap_area_supersections(unsigned long virt, unsigned long pfn,
 			 size_t size, const struct mem_type *type)
 {
 	unsigned long addr = virt, end = virt + size;
-	pgd_t *pgd;
 
 	/*
 	 * Remove and free any PTE-based mapping, and
@@ -161,23 +170,30 @@ remap_area_supersections(unsigned long virt, unsigned long pfn,
 	 */
 	unmap_area_sections(virt, size);
 
-	pgd = pgd_offset_k(virt);
 	do {
+		pgd_t *pgd = pgd_offset_k(addr);
+		pud_t *pud;
 		unsigned long super_pmd_val, i;
 
+		pud = pud_alloc(&init_mm, pgd, addr);
+		if (!pud)
+			return -ENOMEM;
 		super_pmd_val = __pfn_to_phys(pfn) | type->prot_sect |
 				PMD_SECT_SUPER;
 		super_pmd_val |= ((pfn >> (32 - PAGE_SHIFT)) & 0xf) << 20;
 
 		for (i = 0; i < 8; i++) {
-			pmd_t *pmd = pmd_offset(pgd, addr);
+			pmd_t *pmd;
+
+			pmd = pmd_alloc(&init_mm, pud, addr);
+			if (!pmd)
+				return -ENOMEM;
 
 			pmd[0] = __pmd(super_pmd_val);
 			pmd[1] = __pmd(super_pmd_val);
 			flush_pmd_entry(pmd);
 
-			addr += PGDIR_SIZE;
-			pgd++;
+			addr += PMD_SIZE;
 		}
 
 		pfn += SUPERSECTION_SIZE >> PAGE_SHIFT;

-- 
Catalin
