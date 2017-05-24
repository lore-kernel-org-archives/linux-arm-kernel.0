From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 24 May 2017 14:11:15 +0100
Subject: [PATCH v4 2/9] arm64: hugetlb: Introduce pte_pgprot helper
In-Reply-To: <20170524131122.5309-1-punit.agrawal@arm.com>
References: <20170524131122.5309-1-punit.agrawal@arm.com>
Message-ID: <20170524131122.5309-3-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@arm.com>

Rather than xor pte bits in various places, use this helper function.

Cc: David Woods <dwoods@mellanox.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 7b61e4833432..cb84ca33bc6b 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -41,6 +41,16 @@ int pud_huge(pud_t pud)
 #endif
 }
 
+/*
+ * Select all bits except the pfn
+ */
+static inline pgprot_t pte_pgprot(pte_t pte)
+{
+	unsigned long pfn = pte_pfn(pte);
+
+	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
+}
+
 static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, size_t *pgsize)
 {
@@ -80,7 +90,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 	pfn = pte_pfn(pte);
-	hugeprot = __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
+	hugeprot = pte_pgprot(pte);
 	for (i = 0; i < ncontig; i++) {
 		pr_debug("%s: set pte %p to 0x%llx\n", __func__, ptep,
 			 pte_val(pfn_pte(pfn, hugeprot)));
@@ -223,9 +233,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 		size_t pgsize = 0;
 		unsigned long pfn = pte_pfn(pte);
 		/* Select all bits except the pfn */
-		pgprot_t hugeprot =
-			__pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^
-				 pte_val(pte));
+		pgprot_t hugeprot = pte_pgprot(pte);
 
 		pfn = pte_pfn(pte);
 		ncontig = find_num_contig(vma->vm_mm, addr, ptep,
-- 
2.11.0
