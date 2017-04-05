From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  5 Apr 2017 14:37:20 +0100
Subject: [PATCH v2 7/9] arm64: hugetlb: Override set_huge_swap_pte_at() to
 support contiguous hugepages
In-Reply-To: <20170405133722.6406-1-punit.agrawal@arm.com>
References: <20170405133722.6406-1-punit.agrawal@arm.com>
Message-ID: <20170405133722.6406-8-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default implementation of set_huge_swap_pte_at() does not support
hugepages consisting of contiguous ptes. Override it to add support for
contiguous hugepages.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: David Woods <dwoods@mellanox.com>
---
 arch/arm64/mm/hugetlbpage.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 53bda26c6e8f..6d3857f41b8d 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -143,6 +143,23 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep, pte_t pte, unsigned long sz)
+{
+	size_t pgsize;
+	int i;
+	int ncontig;
+
+	if (sz == PUD_SIZE || sz == PMD_SIZE) {
+		set_pte(ptep, pte);
+		return;
+	}
+
+	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
+	for (i = 0; i < ncontig; i++, ptep++)
+		set_pte(ptep, pte);
+}
+
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 		      unsigned long addr, unsigned long sz)
 {
-- 
2.11.0
