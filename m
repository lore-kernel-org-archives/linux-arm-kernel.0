From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 3 Feb 2017 15:13:18 +0900
Subject: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
In-Reply-To: <20170202145553.GA3238@fireball>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
 <20170201160354.GF4756@leverpostej>
 <20170202102131.GD13549@linaro.org>
 <20170202114437.GH31394@leverpostej>
 <20170202140102.GA22666@fireball>
 <20170202143535.GM31394@leverpostej>
 <20170202145553.GA3238@fireball>
Message-ID: <20170203061317.GC29585@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Feb 02, 2017 at 11:55:54PM +0900, AKASHI Takahiro wrote:
> On Thu, Feb 02, 2017 at 02:35:35PM +0000, Mark Rutland wrote:
> > On Thu, Feb 02, 2017 at 11:01:03PM +0900, AKASHI Takahiro wrote:
> > > On Thu, Feb 02, 2017 at 11:44:38AM +0000, Mark Rutland wrote:
> > > > On Thu, Feb 02, 2017 at 07:21:32PM +0900, AKASHI Takahiro wrote:
> > > > > On Wed, Feb 01, 2017 at 04:03:54PM +0000, Mark Rutland wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Wed, Feb 01, 2017 at 09:46:23PM +0900, AKASHI Takahiro wrote:
> > > > > > > A new function, remove_pgd_mapping(), is added.
> > > > > > > It allows us to unmap a specific portion of kernel mapping later as far as
> > > > > > > the mapping is made using create_pgd_mapping() and unless we try to free
> > > > > > > a sub-set of memory range within a section mapping.
> > > > > > 
> > > > > > I'm not keen on adding more page table modification code. It was painful
> > > > > > enough to ensure that those worked in all configurations.
> > > > > > 
> > > > > > Why can't we reuse create_pgd_mapping()? If we pass page_mappings_only,
> > > > > > and use an invalid prot (i.e. 0), what is the problem?
> > > > > 
> > > > > As I did in v30?
> > > > > (though my implementation in v30 should be improved.)
> > > > 
> > > > Something like that. I wasn't entirely sure why we needed to change
> > > > those functions so much, so I'm clearly missing something there. I'll go
> > > > have another look.
> > > 
> > > I would be much easier if you see my new code.
> > 
> > Sure. FWIW, I took a look, and I understand why those changes were
> > necessary.
> > 
> > > > > If we don't need to free unused page tables, that would make things
> > > > > much simple. There are still some minor problems on the merge, but
> > > > > we can sort it out.
> > > > 
> > > > I'm not sure I follow what you mean by 'on merge' here. Could you
> > > > elaborate?
> > > 
> > > What I had in mind is some changes needed to handle "__prot(0)" properly
> > > in alloc_init_pxx(). For example, p[mu]d_set_huge() doesn't make
> > > a "zeroed" entry.
> > 
> > I think that if we only allow ourselves to make PTEs invalid, we don't
> > have to handle that case. If we use page_mappings_only, we should only
> > check pgattr_change_is_safe() for the pte level, and the {pmd,pud,pgd}
> > entries shouldn't change.
> > 
> > Is the below sufficient to allow that, or have I missed something?
> 
> I think it will be OK, but will double-check tomorrow.
> However, is is acceptable that create_pgd_mapping( __prot(0) ) can
> only handle the cases of page-mapping-only?
> That would be fine to kdump, but in general?

My proposed code is attached below.
I think that the changes are quite trivial and it works even if
there is a section mapping as far as we refrain from reclaiming
unsed p[ug]d tables.

(Of course, we can't merely unmap a subset of a section mapping here.)

Thanks,
-Takahiro AKASHI

===8<===
arch/arm64/include/asm/pgtable-prot.h |  1 +
arch/arm64/mm/mmu.c                   | 36 +++++++++++++++++++++++++----------
2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2142c7726e76..945d84cd5df7 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -54,6 +54,7 @@
#define PAGE_KERNEL_ROX		__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
#define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
+#define PAGE_KERNEL_INVALID	__pgprot(0)

#define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
#define PAGE_HYP_EXEC		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 17243e43184e..7f96eabc99d7 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -140,7 +140,11 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
                        __prot = prot;
        }

-		set_pte(pte, pfn_pte(pfn, __prot));
+		if (pgprot_val(prot) & PTE_VALID)
+			set_pte(pte, pfn_pte(pfn, __prot));
+		else
+			pte_clear(null, null, pte);
+
        pfn++;

        /*
@@ -185,7 +189,8 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,

        /* try section mapping first */
        if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
-		      !page_mappings_only) {
+		    !page_mappings_only &&
+		    (pmd_none(old_pmd) || pmd_sect(old_pmd))) {
                /*
                 * Set the contiguous bit for the subsequent group of
                 * PMDs if its size and alignment are appropriate.
@@ -256,7 +261,8 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
        /*
         * For 4K granule only, attempt to put down a 1GB block
         */
-		if (use_1G_block(addr, next, phys) && !page_mappings_only) {
+		if (use_1G_block(addr, next, phys) && !page_mappings_only &&
+		    (pud_none(old_pud) || pud_sect(old_pud))) {
                pud_set_huge(pud, phys, prot);

                /*
@@ -334,12 +340,10 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, false);
}

-void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
-			       unsigned long virt, phys_addr_t size,
-			       pgprot_t prot, bool page_mappings_only)
+void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
+			unsigned long virt, phys_addr_t size,
+			pgprot_t prot, bool page_mappings_only)
{
-	BUG_ON(mm == &init_mm);
-
__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
                     pgd_pgtable_alloc, page_mappings_only);
}
@@ -791,14 +795,26 @@ int __init arch_ioremap_pmd_supported(void)
int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
{
BUG_ON(phys & ~PUD_MASK);
-	set_pud(pud, __pud(phys | PUD_TYPE_SECT | pgprot_val(mk_sect_prot(prot))));
+
+	if (pgprot_val(prot) & PTE_VALID)
+		set_pud(pud, __pud(phys | PUD_TYPE_SECT |
+				   pgprot_val(mk_sect_prot(prot))));
+	else
+		pud_clear(pud);
+
return 1;
}

int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
{
BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmd, __pmd(phys | PMD_TYPE_SECT | pgprot_val(mk_sect_prot(prot))));
+
+	if (pgprot_val(prot) & PTE_VALID)
+		set_pmd(pmd, __pmd(phys | PMD_TYPE_SECT |
+				   pgprot_val(mk_sect_prot(prot))));
+	else
+		pmd_clear(pmd);
+
return 1;
}
===>8===
