From: labbott@redhat.com (Laura Abbott)
Date: Tue,  4 Apr 2017 14:09:00 -0700
Subject: [PATCH] mm/usercopy: Drop extra is_vmalloc_or_module check
Message-ID: <1491340140-18238-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virt_addr_valid was previously insufficient to validate if virt_to_page
could be called on an address on arm64. This has since been fixed up
so there is no need for the extra check. Drop it.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I've given this some testing on my machine and haven't seen any problems
(e.g. random crashes without the check) and the fix has been in for long
enough now. I'm in no rush to have this merged so I'm okay if this sits in
a tree somewhere to get more testing.
---
 mm/usercopy.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index d155e12563b1..4d23a0e0e232 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -206,17 +206,6 @@ static inline const char *check_heap_object(const void *ptr, unsigned long n,
 {
 	struct page *page;
 
-	/*
-	 * Some architectures (arm64) return true for virt_addr_valid() on
-	 * vmalloced addresses. Work around this by checking for vmalloc
-	 * first.
-	 *
-	 * We also need to check for module addresses explicitly since we
-	 * may copy static data from modules to userspace
-	 */
-	if (is_vmalloc_or_module_addr(ptr))
-		return NULL;
-
 	if (!virt_addr_valid(ptr))
 		return NULL;
 
-- 
2.12.1
