From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Fri, 12 Oct 2018 09:29:57 +0530
Subject: [PATCH V2 3/5] mm/hugetlb: Enable arch specific huge page size
 support for migration
In-Reply-To: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1539316799-6064-4-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Architectures like arm64 have HugeTLB page sizes which are different than
generic sizes at PMD, PUD, PGD level and implemented via contiguous bits.
At present these special size HugeTLB pages cannot be identified through
macros like (PMD|PUD|PGDIR)_SHIFT and hence chosen not be migrated.

Enabling migration support for these special HugeTLB page sizes along with
the generic ones (PMD|PUD|PGD) would require identifying all of them on a
given platform. A platform specific hook can precisely enumerate all huge
page sizes supported for migration. Instead of comparing against standard
huge page orders let hugetlb_migration_support() function call a platform
hook arch_hugetlb_migration_support(). Default definition for the platform
hook maintains existing semantics which checks standard huge page order.
But an architecture can choose to override the default and provide support
for a comprehensive set of huge page sizes.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/hugetlb.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 456cb60..97a2fdb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -479,18 +479,29 @@ static inline pgoff_t basepage_index(struct page *page)
 extern int dissolve_free_huge_page(struct page *page);
 extern int dissolve_free_huge_pages(unsigned long start_pfn,
 				    unsigned long end_pfn);
-static inline bool hugepage_migration_supported(struct hstate *h)
-{
+
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
+#ifndef arch_hugetlb_migration_supported
+static inline bool arch_hugetlb_migration_supported(struct hstate *h)
+{
 	if ((huge_page_shift(h) == PMD_SHIFT) ||
 		(huge_page_shift(h) == PUD_SHIFT) ||
 			(huge_page_shift(h) == PGDIR_SHIFT))
 		return true;
 	else
 		return false;
+}
+#endif
 #else
+static inline bool arch_hugetlb_migration_supported(struct hstate *h)
+{
 	return false;
+}
 #endif
+
+static inline bool hugepage_migration_supported(struct hstate *h)
+{
+	return arch_hugetlb_migration_supported(h);
 }
 
 /*
-- 
2.7.4
