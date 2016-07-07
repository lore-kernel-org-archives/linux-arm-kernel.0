From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 7 Jul 2016 20:09:04 +0800
Subject: [PATCH 1/1] arm64/hugetlb: clear PG_dcache_clean if the page is dirty
 when munmap
Message-ID: <1467893344-8352-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At present, PG_dcache_clean is only cleared when the related huge page
is about to be freed. But sometimes, there maybe a process is in charge
to copy binary codes into a shared memory, and notifies other processes
to execute base on that. For the first time, there is no problem, because
the default value of page->flags is PG_dcache_clean cleared. So the cache
will be maintained at the time of set_pte_at for other processes. But if
the content of the shared memory have been updated again, there is no
cache operations, because the PG_dcache_clean is still set.

For example:
Process A
	open a hugetlbfs file
	mmap it as a shared memory
	copy some binary codes into it
	munmap

Process B
	open the hugetlbfs file
	mmap it as a shared memory, executable
	invoke the functions in the shared memory
	munmap

repeat the above steps.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/hugetlbpage.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 2e49bd2..547b158 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -201,6 +201,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	struct page *page;

 	if (pte_cont(*ptep)) {
 		int ncontig, i;
@@ -222,12 +223,21 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			if (pte_dirty(ptep_get_and_clear(mm, addr, cpte)))
 				is_dirty = true;
 		}
-		if (is_dirty)
-			return pte_mkdirty(pte);
-		else
-			return pte;
+		if (is_dirty) {
+			pte = pte_mkdirty(pte);
+			page = pte_page(pte);
+			clear_bit(PG_dcache_clean, &page->flags);
+		}
+
+		return pte;
 	} else {
-		return ptep_get_and_clear(mm, addr, ptep);
+		pte = ptep_get_and_clear(mm, addr, ptep);
+		if (huge_pte_dirty(pte)) {
+			page = pte_page(pte);
+			clear_bit(PG_dcache_clean, &page->flags);
+		}
+
+		return pte;
 	}
 }

--
2.5.0
