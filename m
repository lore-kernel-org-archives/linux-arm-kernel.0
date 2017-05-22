From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 22 May 2017 15:39:58 +0100
Subject: [PATCH v3 11/11] arm64: hugetlb: Cleanup setup_hugepagesz
In-Reply-To: <20170522143958.12867-1-punit.agrawal@arm.com>
References: <20170522143958.12867-1-punit.agrawal@arm.com>
Message-ID: <20170522143958.12867-13-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@arm.com>

Replace a lot of if statements with switch and case labels to make it
much clearer which huge page sizes are supported.

Also, we prevent PUD_SIZE from being used on systems not running with
4KB PAGE_SIZE. Before if one supplied PUD_SIZE in these circumstances,
then unusuable huge page sizes would be in use.

Fixes: 084bd29810a5 ("ARM64: mm: HugeTLB support.")
Cc: David Woods <dwoods@mellanox.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index a10dfbd0ffd5..b5dc7cca3f45 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -381,20 +381,20 @@ static __init int setup_hugepagesz(char *opt)
 {
 	unsigned long ps = memparse(opt, &opt);
 
-	if (ps == PMD_SIZE) {
-		hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
-	} else if (ps == PUD_SIZE) {
-		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
-	} else if (ps == (PAGE_SIZE * CONT_PTES)) {
-		hugetlb_add_hstate(CONT_PTE_SHIFT);
-	} else if (ps == (PMD_SIZE * CONT_PMDS)) {
-		hugetlb_add_hstate((PMD_SHIFT + CONT_PMD_SHIFT) - PAGE_SHIFT);
-	} else {
-		hugetlb_bad_size();
-		pr_err("hugepagesz: Unsupported page size %lu K\n", ps >> 10);
-		return 0;
+	switch (ps) {
+#ifdef CONFIG_ARM64_4K_PAGES
+	case PUD_SIZE:
+#endif
+	case PMD_SIZE * CONT_PMDS:
+	case PMD_SIZE:
+	case PAGE_SIZE * CONT_PTES:
+		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
+		return 1;
 	}
-	return 1;
+
+	hugetlb_bad_size();
+	pr_err("hugepagesz: Unsupported page size %lu K\n", ps >> 10);
+	return 0;
 }
 __setup("hugepagesz=", setup_hugepagesz);
 
-- 
2.11.0
