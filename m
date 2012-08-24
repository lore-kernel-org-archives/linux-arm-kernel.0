From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 24 Aug 2012 11:29:04 +0300
Subject: [v3 3/4] ARM: dma-mapping: Introduce __atomic_get_pages() for
 __iommu_get_pages()
In-Reply-To: <1345796945-21115-1-git-send-email-hdoyu@nvidia.com>
References: <1345796945-21115-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1345796945-21115-4-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support atomic allocation in __iommu_get_pages().

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 508fde1..58a852b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -501,6 +501,15 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 	return ptr;
 }
 
+static struct page **__atomic_get_pages(void *addr)
+{
+	struct dma_pool *pool = &atomic_pool;
+	struct page **pages = pool->pages;
+	int offs = (addr - pool->vaddr) >> PAGE_SHIFT;
+
+	return pages + offs;
+}
+
 static bool __in_atomic_pool(void *start, size_t size)
 {
 	struct dma_pool *pool = &atomic_pool;
@@ -1184,6 +1193,9 @@ static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
 {
 	struct vm_struct *area;
 
+	if (__in_atomic_pool(cpu_addr, PAGE_SIZE))
+		return __atomic_get_pages(cpu_addr);
+
 	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
 		return cpu_addr;
 
-- 
1.7.5.4
