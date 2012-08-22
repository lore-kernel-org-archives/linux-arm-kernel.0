From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 22 Aug 2012 15:02:51 +0200
Subject: [PATCH v2] ARM: DMA-Mapping: print warning when atomic coherent
 allocation fails
In-Reply-To: <20120822083053.42efc6162076534250112652@nvidia.com>
References: <20120822083053.42efc6162076534250112652@nvidia.com>
Message-ID: <1345640571-14349-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print a loud warning when system runs out of memory from atomic DMA
coherent pool to let users notice the potential problem.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index d1cc9c1..acced93 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -461,6 +461,10 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 		bitmap_set(pool->bitmap, pageno, count);
 		ptr = pool->vaddr + PAGE_SIZE * pageno;
 		*ret_page = pool->page + pageno;
+	} else {
+		pr_err_once("ERROR: %u KiB atomic DMA coherent pool is too small!\n"
+			    "Please increase it with coherent_pool= kernel parameter!\n",
+			    (unsigned)pool->size / 1024);
 	}
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-- 
1.7.1.569.g6f426
