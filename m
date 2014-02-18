From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 18 Feb 2014 15:27:12 +0000
Subject: [PATCH 2/5] arm: mm: Adjust the parameters for __sync_icache_dcache
In-Reply-To: <1392737235-27286-1-git-send-email-steve.capper@linaro.org>
References: <1392737235-27286-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1392737235-27286-3-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than take a pte_t as an input, break this down to the pfn
and whether or not the memory is executable.

This allows us to use this function for ptes and pmds.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/include/asm/pgtable.h | 6 +++---
 arch/arm/mm/flush.c            | 9 ++++-----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 7d59b52..9b4ad36 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -225,11 +225,11 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))
 
 #if __LINUX_ARM_ARCH__ < 6
-static inline void __sync_icache_dcache(pte_t pteval)
+static inline void __sync_icache_dcache(unsigned long pfn, int exec);
 {
 }
 #else
-extern void __sync_icache_dcache(pte_t pteval);
+extern void __sync_icache_dcache(unsigned long pfn, int exec);
 #endif
 
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
@@ -238,7 +238,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long ext = 0;
 
 	if (addr < TASK_SIZE && pte_present_user(pteval)) {
-		__sync_icache_dcache(pteval);
+		__sync_icache_dcache(pte_pfn(pteval), pte_exec(pteval));
 		ext |= PTE_EXT_NG;
 	}
 
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 3387e60..df0d5ca 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -232,16 +232,15 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 }
 
 #if __LINUX_ARM_ARCH__ >= 6
-void __sync_icache_dcache(pte_t pteval)
+void __sync_icache_dcache(unsigned long pfn, int exec)
 {
-	unsigned long pfn;
 	struct page *page;
 	struct address_space *mapping;
 
-	if (cache_is_vipt_nonaliasing() && !pte_exec(pteval))
+	if (cache_is_vipt_nonaliasing() && !exec)
 		/* only flush non-aliasing VIPT caches for exec mappings */
 		return;
-	pfn = pte_pfn(pteval);
+
 	if (!pfn_valid(pfn))
 		return;
 
@@ -254,7 +253,7 @@ void __sync_icache_dcache(pte_t pteval)
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
 		__flush_dcache_page(mapping, page);
 
-	if (pte_exec(pteval))
+	if (exec)
 		__flush_icache_all();
 }
 #endif
-- 
1.8.1.4
