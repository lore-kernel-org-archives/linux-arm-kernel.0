From: shijie.huang@arm.com (Huang Shijie)
Date: Thu, 3 Nov 2016 10:27:39 +0800
Subject: [PATCH 2/2] arm64: hugetlb: fix the wrong address for several
 functions
In-Reply-To: <1478140059-13829-1-git-send-email-shijie.huang@arm.com>
References: <1478140059-13829-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1478140059-13829-3-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The libhugetlbfs meets several failures since the following functions
do not use the correct address:
   huge_ptep_get_and_clear()
   huge_ptep_set_access_flags()
   huge_ptep_set_wrprotect()
   huge_ptep_clear_flush()

This patch fixes the wrong address for them.

Acked-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 4811ef1..0e9401b 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -208,7 +208,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 		ncontig = find_num_contig(mm, addr, cpte, *cpte, &pgsize);
 		/* save the 1st pte to return */
 		pte = ptep_get_and_clear(mm, addr, cpte);
-		for (i = 1; i < ncontig; ++i) {
+		for (i = 1, addr += pgsize; i < ncontig; ++i, addr += pgsize) {
 			/*
 			 * If HW_AFDBM is enabled, then the HW could
 			 * turn on the dirty bit for any of the page
@@ -246,7 +246,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 		pfn = pte_pfn(*cpte);
 		ncontig = find_num_contig(vma->vm_mm, addr, cpte,
 					  *cpte, &pgsize);
-		for (i = 0; i < ncontig; ++i, ++cpte) {
+		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize) {
 			changed = ptep_set_access_flags(vma, addr, cpte,
 							pfn_pte(pfn,
 								hugeprot),
@@ -269,7 +269,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
 		cpte = huge_pte_offset(mm, addr);
 		ncontig = find_num_contig(mm, addr, cpte, *cpte, &pgsize);
-		for (i = 0; i < ncontig; ++i, ++cpte)
+		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize)
 			ptep_set_wrprotect(mm, addr, cpte);
 	} else {
 		ptep_set_wrprotect(mm, addr, ptep);
@@ -287,7 +287,7 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
 		cpte = huge_pte_offset(vma->vm_mm, addr);
 		ncontig = find_num_contig(vma->vm_mm, addr, cpte,
 					  *cpte, &pgsize);
-		for (i = 0; i < ncontig; ++i, ++cpte)
+		for (i = 0; i < ncontig; ++i, ++cpte, addr += pgsize)
 			ptep_clear_flush(vma, addr, cpte);
 	} else {
 		ptep_clear_flush(vma, addr, ptep);
-- 
2.5.5
