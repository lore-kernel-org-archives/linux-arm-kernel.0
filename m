From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 29 Mar 2012 18:55:32 +0900
Subject: arm: mm: fix faulty calculation of area to perform cache operation
Message-ID: <002c01cd0d92$14acd5f0$3e0681d0$%cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In dma_cache_maint_page(), if offset is larger than PAGE_SIZE,
len becomes PAGE_SIZE - offset. If size is smaller than
PAGE_SIZE - offset, next calcuation of left cause overflow.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1aa664a..14f53b6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -517,7 +517,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 					page += offset / PAGE_SIZE;
 					offset %= PAGE_SIZE;
 				}
-				len = PAGE_SIZE - offset;
+				len = min_t(size_t, PAGE_SIZE - offset, len);
 			}
 			vaddr = kmap_high_get(page);
 			if (vaddr) {
-- 
1.7.1
