From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Jan 2015 11:31:03 +0000
Subject: [PATCH] arm64: mm: mark alloc_init_p{m,u}d as __ref
Message-ID: <1422531063-29554-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both alloc_init_pmd and alloc_init_pud refer to the __init function
early_alloc as part of a BUG_ON(alloc != early_alloc) statement.

This patch marks the functions as __ref to avoid the spurious section
mismatch.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2eeac10aa0cf..611750b771c4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -118,10 +118,10 @@ void split_pud(pud_t *old_pud, pmd_t *pmd)
 	} while (pmd++, i++, i < PTRS_PER_PMD);
 }
 
-static void alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
-				  unsigned long addr, unsigned long end,
-				  phys_addr_t phys, pgprot_t prot,
-				  void *(*alloc)(unsigned long size))
+static void __ref alloc_init_pmd(struct mm_struct *mm, pud_t *pud,
+				 unsigned long addr, unsigned long end,
+				 phys_addr_t phys, pgprot_t prot,
+				 void *(*alloc)(unsigned long size))
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -183,10 +183,10 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 	return true;
 }
 
-static void alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
-				  unsigned long addr, unsigned long end,
-				  phys_addr_t phys, pgprot_t prot,
-				  void *(*alloc)(unsigned long size))
+static void __ref alloc_init_pud(struct mm_struct *mm, pgd_t *pgd,
+				 unsigned long addr, unsigned long end,
+				 phys_addr_t phys, pgprot_t prot,
+				 void *(*alloc)(unsigned long size))
 {
 	pud_t *pud;
 	unsigned long next;
-- 
2.1.4
