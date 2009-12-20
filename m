From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 20 Dec 2009 10:33:50 +0200
Subject: [PATCH] ARM: fix arch/arm/mm/copypage-v6.c build
Message-ID: <4B2DE16E.4050708@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 115b22474eb1905da2f606a057da3455833333d3 (ARM: 5794/1: Flush the
D-cache during copy_user_highpage()) breaks build for ARM v7:

  CC      arch/arm/mm/copypage-v6.o
arch/arm/mm/copypage-v6.c: In function'v6_copy_user_highpage_nonaliasing':
arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
make[2]: *** [arch/arm/mm/copypage-v6.o] Error 1

Fix it.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mm/copypage-v6.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
-- 
1.6.4.4



-- 
Sincerely yours,
Mike.
