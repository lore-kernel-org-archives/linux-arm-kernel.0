From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 28 Aug 2012 08:13:02 +0300
Subject: [v4 2/4] ARM: dma-mapping: Refactor out to introduce __in_atomic_pool
In-Reply-To: <1346130784-23571-1-git-send-email-hdoyu@nvidia.com>
References: <1346130784-23571-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1346130784-23571-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check the given range("start", "size") is included in "atomic_pool" or not.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 51d5e2b..a62f552 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -503,20 +503,34 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 	return ptr;
 }
 
+static bool __in_atomic_pool(void *start, size_t size)
+{
+	struct dma_pool *pool = &atomic_pool;
+	void *end = start + size;
+	void *pool_start = pool->vaddr;
+	void *pool_end = pool->vaddr + pool->size;
+
+	if (start < pool_start || start > pool_end)
+		return false;
+
+	if (end <= pool_end)
+		return true;
+
+	WARN(1, "Wrong coherent size(%p-%p) from atomic pool(%p-%p)\n",
+	     start, end - 1, pool_start, pool_end - 1);
+
+	return false;
+}
+
 static int __free_from_pool(void *start, size_t size)
 {
 	struct dma_pool *pool = &atomic_pool;
 	unsigned long pageno, count;
 	unsigned long flags;
 
-	if (start < pool->vaddr || start > pool->vaddr + pool->size)
+	if (!__in_atomic_pool(start, size))
 		return 0;
 
-	if (start + size > pool->vaddr + pool->size) {
-		WARN(1, "freeing wrong coherent size from pool\n");
-		return 0;
-	}
-
 	pageno = (start - pool->vaddr) >> PAGE_SHIFT;
 	count = size >> PAGE_SHIFT;
 
-- 
1.7.5.4
