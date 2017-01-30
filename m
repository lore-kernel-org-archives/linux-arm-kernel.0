From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 30 Jan 2017 17:42:33 +0900
Subject: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170127185612.GA31485@leverpostej>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-4-takahiro.akashi@linaro.org>
 <5888E262.4050208@arm.com> <20170126112811.GG23406@linaro.org>
 <588B2CC4.70904@arm.com> <20170127171513.GA3119@fireball>
 <20170127185612.GA31485@leverpostej>
Message-ID: <20170130084232.GI23406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Fri, Jan 27, 2017 at 06:56:13PM +0000, Mark Rutland wrote:
> On Sat, Jan 28, 2017 at 02:15:16AM +0900, AKASHI Takahiro wrote:
> > On Fri, Jan 27, 2017 at 11:19:32AM +0000, James Morse wrote:
> > > Hi Akashi,
> > >
> > > On 26/01/17 11:28, AKASHI Takahiro wrote:
> > > > On Wed, Jan 25, 2017 at 05:37:38PM +0000, James Morse wrote:
> > > >> On 24/01/17 08:49, AKASHI Takahiro wrote:
> > > >>> To protect the memory reserved for crash dump kernel once after loaded,
> > > >>> arch_kexec_protect_crashres/unprotect_crashres() are meant to deal with
> > > >>> permissions of the corresponding kernel mappings.
> > > >>>
> > > >>> We also have to
> > > >>> - put the region in an isolated mapping, and
> > > >>> - move copying kexec's control_code_page to machine_kexec_prepare()
> > > >>> so that the region will be completely read-only after loading.
> > > >>
> > > >>
> > > >>> Note that the region must reside in linear mapping and have corresponding
> > > >>> page structures in order to be potentially freed by shrinking it through
> > > >>> /sys/kernel/kexec_crash_size.
> 
> Ah; I did not realise that this was a possibility.
> 
> > Now I understand why we should stick with page_mapping_only option.
> 
> Likewise, I now agree.
> 
> Apologies for guiding you down the wrong path here.

Your comments are always welcome.

Anyhow, I think we'd better have a dedicated function of unmapping.
Can you please take a look at the following hack?

(We need to carefully use this function except for kdump usage since
it doesn't care whether the region to be unmapped is used somewhere else.)

Thanks,
-Takahiro AKASHI

===8<===
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
index 17243e43184e..81173b594195 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -307,6 +307,101 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgd++, addr = next, addr != end);
 }
 
+static void free_pte(pmd_t *pmd, unsigned long addr, unsigned long end,
+			bool dealloc_table)
+{
+	pte_t *pte;
+	bool do_free = (dealloc_table && ((end - addr) == PMD_SIZE));
+
+	BUG_ON(pmd_none(*pmd) || pmd_bad(*pmd));
+
+	pte = pte_set_fixmap_offset(pmd, addr);
+	do {
+		pte_clear(NULL, NULL, pte);
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+	pte_clear_fixmap();
+
+	if (do_free) {
+		__free_page(pmd_page(*pmd));
+		pmd_clear(pmd);
+	}
+}
+
+static void free_pmd(pud_t *pud, unsigned long addr, unsigned long end,
+			bool dealloc_table)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	bool do_free = (dealloc_table && ((end - addr) == PUD_SIZE));
+
+	BUG_ON(pud_none(*pud) || pud_bad(*pud));
+
+	pmd = pmd_set_fixmap_offset(pud, addr);
+
+	do {
+		next = pmd_addr_end(addr, end);
+
+		if (pmd_table(*pmd)) {
+			free_pte(pmd, addr, next, dealloc_table);
+		} else {
+			pmd_clear(pmd);
+		}
+	} while (pmd++, addr = next, addr != end);
+
+	pmd_clear_fixmap();
+
+	if (do_free) {
+		__free_page(pud_page(*pud));
+		pud_clear(pud);
+	}
+}
+
+static void free_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
+			bool dealloc_table)
+{
+	pud_t *pud;
+	unsigned long next;
+	bool do_free = (dealloc_table && ((end - addr) == PGDIR_SIZE));
+
+	BUG_ON(pgd_none(*pgd) || pgd_bad(*pgd));
+
+	pud = pud_set_fixmap_offset(pgd, addr);
+
+	do {
+		next = pud_addr_end(addr, end);
+
+		if (pud_table(*pud)) {
+			free_pmd(pud, addr, next, dealloc_table);
+		} else {
+			pud_clear(pud);
+		}
+	} while (pud++, addr = next, addr != end);
+
+	pud_clear_fixmap();
+
+	if (do_free) {
+		__free_page(pgd_page(*pgd));
+		pgd_clear(pgd);
+	}
+}
+
+static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long virt,
+				 phys_addr_t size, bool dealloc_table)
+{
+	unsigned long addr, length, end, next;
+	pgd_t *pgd = pgd_offset_raw(pgdir, virt);
+
+	addr = virt & PAGE_MASK;
+	length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
+
+	end = addr + length;
+	do {
+		next = pgd_addr_end(addr, end);
+		free_pud(pgd, addr, next, dealloc_table);
+	} while (pgd++, addr = next, addr != end);
+}
+
 static phys_addr_t pgd_pgtable_alloc(void)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
@@ -334,14 +429,15 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
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
-	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
-			     pgd_pgtable_alloc, page_mappings_only);
+	if (pgprot_val(prot))
+		__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
+				     pgd_pgtable_alloc, page_mappings_only);
+	else
+		__remove_pgd_mapping(mm->pgd, virt, size, true);
 }
 
 static void create_mapping_late(phys_addr_t phys, unsigned long virt,
===>8===


> Thanks,
> Mark.
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
