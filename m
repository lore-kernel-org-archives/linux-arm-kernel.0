From: yaojun8558363@gmail.com (Jun Yao)
Date: Tue, 17 Jul 2018 17:56:07 +0800
Subject: [PATCH v4 5/6] arm64/mm: Populate swapper_pg_dir by fixmap
In-Reply-To: <20180717095608.11008-1-yaojun8558363@gmail.com>
References: <20180717095608.11008-1-yaojun8558363@gmail.com>
Message-ID: <20180717095608.11008-6-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To move swapper_pg_dir to .rodata section, we populate it by
fixmap.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/pgtable.h | 68 ++++++++++++++++++++++++++------
 arch/arm64/mm/mmu.c              |  2 +
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 46ef21ebfe47..d5c3df99af7b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -45,6 +45,13 @@
 #include <linux/mm_types.h>
 #include <linux/sched.h>
 
+extern pgd_t init_pg_dir[PTRS_PER_PGD];
+extern pgd_t init_pg_end[];
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+extern pgd_t swapper_pg_end[];
+extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
+extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
+
 extern void __pte_error(const char *file, int line, unsigned long val);
 extern void __pmd_error(const char *file, int line, unsigned long val);
 extern void __pud_error(const char *file, int line, unsigned long val);
@@ -428,8 +435,32 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				 PUD_TYPE_TABLE)
 #endif
 
+extern spinlock_t swapper_pgdir_lock;
+
+#define pgd_set_fixmap(addr)	((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
+#define pgd_clear_fixmap()	clear_fixmap(FIX_PGD)
+
+static inline bool in_swapper_pgdir(void *addr)
+{
+	return ((unsigned long)addr & PAGE_MASK) ==
+		((unsigned long)swapper_pg_dir & PAGE_MASK);
+}
+
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
+#ifdef __PAGETABLE_PMD_FOLDED
+	if (in_swapper_pgdir(pmdp)) {
+		pmd_t *fixmap_pmdp;
+
+		spin_lock(&swapper_pgdir_lock);
+		fixmap_pmdp = (pmd_t *)pgd_set_fixmap(__pa(pmdp));
+		WRITE_ONCE(*fixmap_pmdp, pmd);
+		dsb(ishst);
+		pgd_clear_fixmap();
+		spin_unlock(&swapper_pgdir_lock);
+		return;
+	}
+#endif
 	WRITE_ONCE(*pmdp, pmd);
 	dsb(ishst);
 }
@@ -480,6 +511,19 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
+#ifdef __PAGETABLE_PUD_FOLDED
+	if (in_swapper_pgdir(pudp)) {
+		pud_t *fixmap_pudp;
+
+		spin_lock(&swapper_pgdir_lock);
+		fixmap_pudp = (pud_t *)pgd_set_fixmap(__pa(pudp));
+		WRITE_ONCE(*fixmap_pudp, pud);
+		dsb(ishst);
+		pgd_clear_fixmap();
+		spin_unlock(&swapper_pgdir_lock);
+		return;
+	}
+#endif
 	WRITE_ONCE(*pudp, pud);
 	dsb(ishst);
 }
@@ -532,8 +576,19 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 
 static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	WRITE_ONCE(*pgdp, pgd);
-	dsb(ishst);
+	if (in_swapper_pgdir(pgdp)) {
+		pgd_t *fixmap_pgdp;
+
+		spin_lock(&swapper_pgdir_lock);
+		fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
+		WRITE_ONCE(*fixmap_pgdp, pgd);
+		dsb(ishst);
+		pgd_clear_fixmap();
+		spin_unlock(&swapper_pgdir_lock);
+	} else {
+		WRITE_ONCE(*pgdp, pgd);
+		dsb(ishst);
+	}
 }
 
 static inline void pgd_clear(pgd_t *pgdp)
@@ -586,8 +641,6 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
-#define pgd_set_fixmap(addr)	((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
-#define pgd_clear_fixmap()	clear_fixmap(FIX_PGD)
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
@@ -712,13 +765,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
-extern pgd_t init_pg_dir[PTRS_PER_PGD];
-extern pgd_t init_pg_end[];
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern pgd_t swapper_pg_end[];
-extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
-extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
-
 /*
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d24be05ec1d4..acaeb726bf6a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -67,6 +67,8 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
 static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
+DEFINE_SPINLOCK(swapper_pgdir_lock);
+
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
-- 
2.17.1
