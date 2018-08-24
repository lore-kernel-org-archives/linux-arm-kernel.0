From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:38 +0100
Subject: [RFC PATCH 03/11] arm64: pgtable: Implement p[mu]d_valid() and check
 in set_p[mu]d()
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535125966-7666-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that our walk-cache invalidation routines imply a DSB before the
invalidation, we no longer need one when we are clearing an entry during
unmap.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1bdeca8918a6..2ab2031b778c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -360,6 +360,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
+#define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
@@ -431,7 +432,9 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	WRITE_ONCE(*pmdp, pmd);
-	dsb(ishst);
+
+	if (pmd_valid(pmd))
+		dsb(ishst);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
@@ -477,11 +480,14 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
 #define pud_present(pud)	pte_present(pud_pte(pud))
+#define pud_valid(pud)		pte_valid(pud_pte(pud))
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
 	WRITE_ONCE(*pudp, pud);
-	dsb(ishst);
+
+	if (pud_valid(pud))
+		dsb(ishst);
 }
 
 static inline void pud_clear(pud_t *pudp)
-- 
2.1.4
