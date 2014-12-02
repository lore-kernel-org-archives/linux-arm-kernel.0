From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 2 Dec 2014 17:27:36 +0800
Subject: [RFC V2] mm:add zero_page _mapcount when mapped into user space
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B313E0@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add/dec zero_page's _mapcount to make sure
the mapcount is correct for zero_page,
so that when read from /proc/kpagecount, zero_page's
mapcount is also correct, userspace process like procrank can
calculate PSS correctly.

Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
---
 mm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 3e50383..7215423 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2198,6 +2198,7 @@ gotten:
 		new_page = alloc_zeroed_user_highpage_movable(vma, address);
 		if (!new_page)
 			goto oom;
+		atomic_dec(&pfn_to_page(pte_pfn(orig_pte))->_mapcount);
 	} else {
 		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
 		if (!new_page)
@@ -2647,6 +2648,7 @@ static int do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 		if (!pte_none(*page_table))
 			goto unlock;
+		atomic_inc(&pfn_to_page(my_zero_pfn(address))->_mapcount);
 		goto setpte;
 	}
 
-- 
2.1.3
