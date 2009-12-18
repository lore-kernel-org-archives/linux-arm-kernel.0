From: gadiyar@ti.com (Anand Gadiyar)
Date: Fri, 18 Dec 2009 14:07:07 +0530
Subject: [PATCH] ARM: Fix build break on ARM v6 and v7
Message-ID: <1261125427-17517-1-git-send-email-gadiyar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2c9b9c849 added an argument to __cpuc_flush_dcache_page
and renamed it.

Update a caller of the old function to fix this build error:

  CC      arch/arm/mm/copypage-v6.o
arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
make[1]: *** [arch/arm/mm/copypage-v6.o] Error 1
make: *** [arch/arm/mm] Error 2


Reported-by: Jinsung Yang <jsgood.yang@samsung.com>
NYET-Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Russell,

I fixed this almost independently at roughly the same time as your
mail on the list. Do I still get credit for the patch?

Either way, it's okay with me. I'm just asking.

- Anand

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index 841f355..0fa1319 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -48,7 +48,7 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
 	 */
 	if (page_address(to) != NULL)
 #endif
-		__cpuc_flush_dcache_page(kto);
+		__cpuc_flush_dcache_area(kto, PAGE_SIZE);
 	kunmap_atomic(kto, KM_USER1);
 	kunmap_atomic(kfrom, KM_USER0);
 }
