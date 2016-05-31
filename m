From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 17:37:39 +0100
Subject: [PATCH 1/2] ARM: mm: ensure pmd_present only checks the valid bit
In-Reply-To: <1464712660-25177-1-git-send-email-catalin.marinas@arm.com>
References: <1464712660-25177-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1464712660-25177-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

In a subsequent patch, pmd_mknotpresent will clear the valid bit of the
pmd entry, resulting in a not-present entry from the hardware's
perspective. Unfortunately, pmd_present simply checks for a non-zero pmd
value and will therefore continue to return true even after a
pmd_mknotpresent operation. Since pmd_mknotpresent is only used for
managing huge entries, this is only an issue for the 3-level case.

This patch fixes the 3-level pmd_present implementation to take into
account the valid bit. For bisectability, the change is made before the
fix to pmd_mknotpresent.

Fixes: 8d9625070073 ("ARM: mm: Transparent huge page support for LPAE systems.")
Cc: <stable@vger.kernel.org> # 3.11+
Cc: Russell King <linux@armlinux.org.uk>
Cc: Steve Capper <Steve.Capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[catalin.marinas at arm.com: comment update regarding pmd_mknotpresent patch]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h | 1 +
 arch/arm/include/asm/pgtable-3level.h | 1 +
 arch/arm/include/asm/pgtable.h        | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index aeddd28b3595..92fd2c8a9af0 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -193,6 +193,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define pmd_large(pmd)		(pmd_val(pmd) & 2)
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+#define pmd_present(pmd)	(pmd_val(pmd))
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index fa70db7c714b..4dce1580bc15 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -211,6 +211,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 						: !!(pmd_val(pmd) & (val)))
 #define pmd_isclear(pmd, val)	(!(pmd_val(pmd) & (val)))
 
+#define pmd_present(pmd)	(pmd_isset((pmd), L_PMD_SECT_VALID))
 #define pmd_young(pmd)		(pmd_isset((pmd), PMD_SECT_AF))
 #define pte_special(pte)	(pte_isset((pte), L_PTE_SPECIAL))
 static inline pte_t pte_mkspecial(pte_t pte)
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 348caabb7625..d62204060cbe 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -182,7 +182,6 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 #define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
-#define pmd_present(pmd)	(pmd_val(pmd))
 
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
