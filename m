From: yuehaibing@huawei.com (YueHaibing)
Date: Tue, 24 Jul 2018 22:04:35 +0800
Subject: [PATCH] ARM: dma-mapping: always clear allocated buffers
Message-ID: <20180724140435.17112-1-yuehaibing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sean Wang report dma_zalloc_coherent doesn't work as expect on his
armv7,the allocated mem is not zeroed.The reason is __alloc_from_pool
doesn't honor __GFP_ZERO.

Like commit 6829e274a623 ("arm64: dma-mapping: always clear allocated buffers")
does,always clear allocated buffers to fix this.

Reported-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm/mm/dma-mapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6656647..cf5882f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -564,6 +564,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 
 		*ret_page = phys_to_page(phys);
 		ptr = (void *)val;
+		memset(ptr, 0, size);
 	}
 
 	return ptr;
-- 
2.7.0
