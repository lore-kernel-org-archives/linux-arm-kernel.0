From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 22 Aug 2012 16:44:29 +0200
Subject: [RFC 0/4] ARM: dma-mapping: IOMMU atomic allocation
In-Reply-To: <005901cd805e$4afd2e40$e0f78ac0$%szyprowski@samsung.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com><005901cd805e$4afd2e40$e0f78ac0$%szyprowski@samsung.com>
Message-ID: <20120822.174429.909991514856769456.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Marek Szyprowski <m.szyprowski@samsung.com> wrote @ Wed, 22 Aug 2012 14:04:26 +0200:

> Hi Hiroshi,
> 
> On Wednesday, August 22, 2012 12:20 PM Hiroshi Doyu wrote:
> 
> > The commit e9da6e9 "ARM: dma-mapping: remove custom consistent dma
> > region" breaks the compatibility with existing drivers. This causes
> > the following kernel oops(*1). That driver has called dma_pool_alloc()
> > to allocate memory from the interrupt context, and it hits
> > BUG_ON(in_interrpt()) in "get_vm_area_caller()". This patch seris
> > fixes this problem with making use of the pre-allocate atomic memory
> > pool which DMA is using in the same way as DMA does now.
> > 
> > Any comment would be really appreciated.
> 
> I was working on the similar patches, but You were faster. ;-)

Thank you for reviewing my patches.

> Basically the patch no 1 and 2 are fine, but I don't like the changes proposed in 
> patch 3 and 4. You should not alter the attributes provided by the user nor make any
> assumptions that such attributes has been provided - drivers are allowed to call 
> dma_alloc_attrs() directly. Please rework your patches to avoid such
> approach.

Sure. I'll send the series again later.

Instead of making use of DMA_ATTR_NO_KERNEL_MAPPING, I use the
following "__in_atomic_pool()" to see if buffer comes from atomic or
not at freeing.

>From cdf8621fd0876f3e56a55885c27e363893df2c98 Mon Sep 17 00:00:00 2001
From: Hiroshi Doyu <hdoyu@nvidia.com>
Date: Wed, 22 Aug 2012 17:26:29 +0300
Subject: [PATCH 1/1] ARM: dma-mapping: Refactor out to introduce
 __in_atomic_pool

Check the given range("start", "size") is included in "atomic_pool" or not.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 30bef80..26080ef 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -450,20 +450,30 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 	return ptr;
 }
 
-static int __free_from_pool(void *start, size_t size)
+static bool __in_atomic_pool(void *start, size_t size)
 {
 	struct dma_pool *pool = &atomic_pool;
-	unsigned long pageno, count;
-	unsigned long flags;
 
 	if (start < pool->vaddr || start > pool->vaddr + pool->size)
-		return 0;
+		return false;
 
 	if (start + size > pool->vaddr + pool->size) {
 		WARN(1, "freeing wrong coherent size from pool\n");
-		return 0;
+		return false;
 	}
 
+	return true;
+}
+
+static int __free_from_pool(void *start, size_t size)
+{
+	struct dma_pool *pool = &atomic_pool;
+	unsigned long pageno, count;
+	unsigned long flags;
+
+	if (!__in_atomic_pool(start, size))
+		return 0;
+
 	pageno = (start - pool->vaddr) >> PAGE_SHIFT;
 	count = size >> PAGE_SHIFT;
 
-- 
1.7.5.4
