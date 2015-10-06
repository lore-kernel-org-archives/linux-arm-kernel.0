From: chanho.min@lge.com (Chanho Min)
Date: Tue, 6 Oct 2015 20:09:33 +0900
Subject: [PATCH] ARM:mm: fix kmap_atomic_to_page
Message-ID: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since kmap_atomic returns the pkmap address without a new mapping to
fixmap for the page that is already mapped by kmap, It should be
considered for the pkmap address in kmap_atomic_to_page.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm/mm/highmem.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index 45aeaac..3e973b7 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -145,8 +145,13 @@ struct page *kmap_atomic_to_page(const void *ptr)
 {
 	unsigned long vaddr = (unsigned long)ptr;
 
-	if (vaddr < FIXADDR_START)
-		return virt_to_page(ptr);
+	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
+		int i = PKMAP_NR(vaddr);
+		return pte_page(pkmap_page_table[i]);
+	}
+
+	if (vaddr >= FIXADDR_START)
+		return pte_page(get_fixmap_pte(vaddr));
 
-	return pte_page(get_fixmap_pte(vaddr));
+	return virt_to_page(ptr);
 }
-- 
1.7.9.5
