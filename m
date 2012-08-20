From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Aug 2012 12:47:27 +0200
Subject: [PATCH 2/3] ARM: DMA-Mapping: print warning when atomic coherent
 allocation fails
In-Reply-To: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1345459648-24263-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print a loud warning when system runs out of memory from atomic coherent
pool to let users notice the potential problem.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index d1cc9c1..25963ea 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -461,6 +461,9 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 		bitmap_set(pool->bitmap, pageno, count);
 		ptr = pool->vaddr + PAGE_SIZE * pageno;
 		*ret_page = pool->page + pageno;
+	} else {
+		pr_err("Atomic coherent pool too small!\n"
+		       "Please increase it with coherent_pool= kernel parameter!\n");
 	}
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-- 
1.7.1.569.g6f426
