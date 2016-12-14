From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Dec 2016 09:11:46 +0000
Subject: [PATCH 1/2] mm: don't dereference struct page fields of invalid pages
In-Reply-To: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1481706707-6211-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1481706707-6211-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VM_BUG_ON() check in move_freepages() checks whether the node
id of a page matches the node id of its zone. However, it does this
before having checked whether the struct page pointer refers to a
valid struct page to begin with. This is guaranteed in most cases,
but may not be the case if CONFIG_HOLES_IN_ZONE=y.

So reorder the VM_BUG_ON() with the pfn_valid_within() check.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f64e7bcb43b7..4e298e31fa86 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1864,14 +1864,14 @@ int move_freepages(struct zone *zone,
 #endif
 
 	for (page = start_page; page <= end_page;) {
-		/* Make sure we are not inadvertently changing nodes */
-		VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
-
 		if (!pfn_valid_within(page_to_pfn(page))) {
 			page++;
 			continue;
 		}
 
+		/* Make sure we are not inadvertently changing nodes */
+		VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
+
 		if (!PageBuddy(page)) {
 			page++;
 			continue;
-- 
2.7.4
