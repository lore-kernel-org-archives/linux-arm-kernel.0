From: allen.pais@oracle.com (Allen Pais)
Date: Tue, 23 Oct 2018 06:36:57 +0530
Subject: [PATCH] arm64: hugetlb: Register hugepages during arch init
Message-ID: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hstate for each supported hugepage size using arch initcall.

* no hugepage parameters

  Without hugepage parameters, only a default hugepage size is
  available for dynamic allocation.  It's different, for example, from
  x86_64 and sparc64 where all supported hugepage sizes are available.

* only default_hugepagesz= is specified and set not to HPAGE_SIZE

  In spite of the fact that default_hugepagesz= is set to a valid
  hugepage size, it's treated as unsupported and reverted to
  HPAGE_SIZE.  Such behaviour is also different from x86_64 and
  sparc64.

Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
Signed-off-by: Dmitry Klochkov <dmitry.klochkov@oracle.com>
Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/arm64/mm/hugetlbpage.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f58ea50..28cbc22 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -429,6 +429,27 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
 	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
 }
 
+static void __init add_huge_page_size(unsigned long size)
+{
+	if (size_to_hstate(size))
+		return;
+
+	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
+}
+
+static int __init hugetlbpage_init(void)
+{
+#ifdef CONFIG_ARM64_4K_PAGES
+	add_huge_page_size(PUD_SIZE);
+#endif
+	add_huge_page_size(PMD_SIZE * CONT_PMDS);
+	add_huge_page_size(PMD_SIZE);
+	add_huge_page_size(PAGE_SIZE * CONT_PTES);
+
+	return 0;
+}
+arch_initcall(hugetlbpage_init);
+
 static __init int setup_hugepagesz(char *opt)
 {
 	unsigned long ps = memparse(opt, &opt);
@@ -440,7 +461,7 @@ static __init int setup_hugepagesz(char *opt)
 	case PMD_SIZE * CONT_PMDS:
 	case PMD_SIZE:
 	case PAGE_SIZE * CONT_PTES:
-		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
+		add_huge_page_size(ps);
 		return 1;
 	}
 
@@ -449,13 +470,3 @@ static __init int setup_hugepagesz(char *opt)
 	return 0;
 }
 __setup("hugepagesz=", setup_hugepagesz);
-
-#ifdef CONFIG_ARM64_64K_PAGES
-static __init int add_default_hugepagesz(void)
-{
-	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
-		hugetlb_add_hstate(CONT_PTE_SHIFT);
-	return 0;
-}
-arch_initcall(add_default_hugepagesz);
-#endif
-- 
1.8.3.1
