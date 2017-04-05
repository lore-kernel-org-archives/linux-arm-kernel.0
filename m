From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  5 Apr 2017 14:37:17 +0100
Subject: [PATCH v2 4/9] arm64: hugetlb: Override huge_pte_clear() to support
 contiguous hugepages
In-Reply-To: <20170405133722.6406-1-punit.agrawal@arm.com>
References: <20170405133722.6406-1-punit.agrawal@arm.com>
Message-ID: <20170405133722.6406-5-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default huge_pte_clear() implementation does not clear contiguous
page table entries when it encounters contiguous hugepages that are
supported on arm64.

Fix this by overriding the default implementation to clear all the
entries associated with contiguous hugepages.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: David Woods <dwoods@mellanox.com>
---
 arch/arm64/mm/hugetlbpage.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 009648c4500f..53bda26c6e8f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -243,6 +243,22 @@ pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 	return entry;
 }
 
+void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, unsigned long sz)
+{
+	int ncontig, i;
+	size_t pgsize;
+
+	if (sz == PUD_SIZE || sz == PMD_SIZE) {
+		pte_clear(mm, addr, ptep);
+		return;
+	}
+
+	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
+		pte_clear(mm, addr, ptep);
+}
+
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
-- 
2.11.0
