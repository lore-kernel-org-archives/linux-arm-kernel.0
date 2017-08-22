From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 22 Aug 2017 11:42:48 +0100
Subject: [PATCH v7 8/9] arm64: Re-enable support for contiguous hugepages
In-Reply-To: <20170822104249.2189-1-punit.agrawal@arm.com>
References: <20170822104249.2189-1-punit.agrawal@arm.com>
Message-ID: <20170822104249.2189-9-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

also known as -

Revert "Revert "Revert "commit 66b3923a1a0f ("arm64: hugetlb: add
support for PTE contiguous bit")"""

Now that our hugetlb implementation is compliant with the
break-before-make requirements of the architecture and we have addressed
some of the issues in core code required for properly dealing with
hardware poisoning of contiguous hugepages let's re-enable support for
contiguous hugepages.

This reverts commit 6ae979ab39a368c18ceb0424bf824d172d6ab56f.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 01f0d7e8a8d8..b5e9c5b5e897 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -410,6 +410,10 @@ static __init int setup_hugepagesz(char *opt)
 		hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
 	} else if (ps == PUD_SIZE) {
 		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
+	} else if (ps == (PAGE_SIZE * CONT_PTES)) {
+		hugetlb_add_hstate(CONT_PTE_SHIFT);
+	} else if (ps == (PMD_SIZE * CONT_PMDS)) {
+		hugetlb_add_hstate((PMD_SHIFT + CONT_PMD_SHIFT) - PAGE_SHIFT);
 	} else {
 		hugetlb_bad_size();
 		pr_err("hugepagesz: Unsupported page size %lu K\n", ps >> 10);
@@ -418,3 +422,13 @@ static __init int setup_hugepagesz(char *opt)
 	return 1;
 }
 __setup("hugepagesz=", setup_hugepagesz);
+
+#ifdef CONFIG_ARM64_64K_PAGES
+static __init int add_default_hugepagesz(void)
+{
+	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
+		hugetlb_add_hstate(CONT_PTE_SHIFT);
+	return 0;
+}
+arch_initcall(add_default_hugepagesz);
+#endif
-- 
2.13.2
