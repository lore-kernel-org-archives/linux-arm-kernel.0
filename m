From: kirill@shutemov.name (Kirill A. Shutsemov)
Date: Mon, 19 Jul 2010 11:53:25 +0300
Subject: [PATCH 5/5] Workaround infinity loop in handling of translation faults
In-Reply-To: <cover.1279529223.git.kirill@shutemov.name>
References: <cover.1279529223.git.kirill@shutemov.name>
Message-ID: <541e62886acbf6f25993c549777b577c7912e51d.1279529223.git.kirill@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kirill A. Shutemov <kirill@shutemov.name>

On ARM one Linux PGD entry contains two hardware entries (see page
tables layout in pgtable.h). We normally guarantee that we always
fill both L1 entries. But create_mapping() doesn't follow the rule.
It can create inidividual L1 entries, so here we have to call
pmd_none() check in do_translation_fault() for the entry really
corresponded to address, not for the first of pair.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 arch/arm/mm/fault.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 7e866e9..f5f1190 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -413,7 +413,16 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 	pmd_k = pmd_offset(pgd_k, addr);
 	pmd   = pmd_offset(pgd, addr);
 
-	if (pmd_none(*pmd_k))
+	/*
+	 * On ARM one Linux PGD entry contains two hardware entries (see page
+	 * tables layout in pgtable.h). We normally guarantee that we always
+	 * fill both L1 entries. But create_mapping() doesn't follow the rule.
+	 * It can create inidividual L1 entries, so here we have to call
+	 * pmd_none() check for the entry really corresponded to address, not
+	 * for the first of pair.
+	 */
+	index = (addr >> SECTION_SHIFT) & 1;
+	if (pmd_none(pmd_k[index]))
 		goto bad_area;
 
 	copy_pmd(pmd, pmd_k);
-- 
1.7.1.1
