From: steve.capper@linaro.org (Steve Capper)
Date: Tue,  6 May 2014 14:02:27 +0100
Subject: [PATH V3] arm64: mm: Create gigabyte kernel logical mappings where
 possible
Message-ID: <1399381347-28676-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have the capability to map 1GB level 1 blocks when using a 4K
granule.

This patch adjusts the create_mapping logic s.t. when mapping physical
memory on boot, we attempt to use a 1GB block if both the VA and PA
start and end are 1GB aligned. This both reduces the levels of lookup
required to resolve a kernel logical address, as well as reduces TLB
pressure on cores that support 1GB TLB entries.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
Changed in V3: added awareness of 1GB blocks to kern_addr_valid.
This was tested via gdb:
gdb ./vmlinux /proc/kcore
disassemble kern_addr_valid

The output looked valid.
In V2 of the patch, I got an oops.

I've defined constants with pgdval_t type. Ideally, I would like to
define pudval_t types, but due to the way folding works this does not
exist for <4 levels. I'm not sure if it would be better to define
pudval_t for <4 levels or leave this as is?

Changed in V2: free the original pmd table from swapper_pg_dir if we
replace it with a block pud entry.
---
 arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
 arch/arm64/include/asm/pgtable.h       |  7 +++++++
 arch/arm64/mm/mmu.c                    | 28 +++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 5fc8a66..955e8c5 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -29,6 +29,8 @@
  */
 
 #define PUD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
+#define PUD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
+#define PUD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
 
 /*
  * Level 2 descriptor (PMD).
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 90c811f..946d5fc 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -265,6 +265,7 @@ static inline pmd_t pte_pmd(pte_t pte)
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
 #define pmd_page(pmd)           pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
+#define pud_pfn(pud)		(((pud_val(pud) & PUD_MASK) & PHYS_MASK) >> PAGE_SHIFT)
 
 #define set_pmd_at(mm, addr, pmdp, pmd)	set_pmd(pmdp, pmd)
 
@@ -295,6 +296,12 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 				 PMD_TYPE_SECT)
 
+#ifdef ARM64_64K_PAGES
+#define pud_sect(pud)		(0)
+#else
+#define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
+				 PUD_TYPE_SECT)
+#endif
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 0a472c4..1baa92e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -227,7 +227,30 @@ static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
 
 	do {
 		next = pud_addr_end(addr, end);
-		alloc_init_pmd(pud, addr, next, phys);
+
+		/*
+		 * For 4K granule only, attempt to put down a 1GB block
+		 */
+		if ((PAGE_SHIFT == 12) &&
+			((addr | next | phys) & ~PUD_MASK) == 0) {
+			pud_t old_pud = *pud;
+			set_pud(pud, __pud(phys | prot_sect_kernel));
+
+			/*
+			 * If we have an old value for a pud, it will
+			 * be pointing to a pmd table that we no longer
+			 * need (from swapper_pg_dir).
+			 *
+			 * Look up the old pmd table and free it.
+			 */
+			if (!pud_none(old_pud)) {
+				phys_addr_t table = __pa(pmd_offset(&old_pud, 0));
+				memblock_free(table, PAGE_SIZE);
+				flush_tlb_all();
+			}
+		} else {
+			alloc_init_pmd(pud, addr, next, phys);
+		}
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
 }
@@ -370,6 +393,9 @@ int kern_addr_valid(unsigned long addr)
 	if (pud_none(*pud))
 		return 0;
 
+	if (pud_sect(*pud))
+		return pfn_valid(pud_pfn(*pud));
+
 	pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd))
 		return 0;
-- 
1.8.1.4
