From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 22 May 2017 15:39:48 +0100
Subject: [PATCH v3 01/11] arm64: hugetlb: set_huge_pte_at Add WARN_ON on
 !pte_present
In-Reply-To: <20170522143958.12867-1-punit.agrawal@arm.com>
References: <20170522143958.12867-1-punit.agrawal@arm.com>
Message-ID: <20170522143958.12867-3-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@arm.com>

This patch adds a WARN_ON to set_huge_pte_at as the accessor assumes
that entries to be written down are all present. (There are separate
accessors to clear huge ptes).

We will need to handle the !pte_present case where memory offlining
is used on hugetlb pages. swap and migration entries will be supplied
to set_huge_pte_at in this case.

Cc: David Woods <dwoods@mellanox.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 425a8fcd3d38..0389e2ed51f1 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -69,6 +69,12 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long pfn;
 	pgprot_t hugeprot;
 
+	/*
+	 * Code needs to be expanded to handle huge swap and migration
+	 * entries. Needed for HUGETLB and MEMORY_FAILURE.
+	 */
+	WARN_ON(!pte_present(pte));
+
 	if (ncontig == 1) {
 		set_pte_at(mm, addr, ptep, pte);
 		return;
-- 
2.11.0
