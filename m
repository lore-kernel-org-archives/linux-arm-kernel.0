From: yj44.cho@samsung.com (YoungJun Cho)
Date: Mon, 17 Jun 2013 13:18:52 +0900
Subject: [PATCH] ARM: dma-mapping: Get pages if the cpu_addr is out of
 atomic_pool
Message-ID: <1371442732-15088-1-git-send-email-yj44.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In __iommu_get_pages(), the cpu_addr is checked wheather in
atomic_pool range or not. So if the cpu_addr is in atomic_pool
range, it does not need to check twice.

Signed-off-by: YoungJun Cho <yj44.cho@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ef3e0f3..1d158c2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1372,16 +1372,17 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 			  dma_addr_t handle, struct dma_attrs *attrs)
 {
-	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
+	struct page **pages;
 	size = PAGE_ALIGN(size);
 
-	if (!pages) {
-		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
+	if (__in_atomic_pool(cpu_addr, size)) {
+		__iommu_free_atomic(dev, cpu_addr, handle, size);
 		return;
 	}
 
-	if (__in_atomic_pool(cpu_addr, size)) {
-		__iommu_free_atomic(dev, cpu_addr, handle, size);
+	pages = __iommu_get_pages(cpu_addr, attrs);
+	if (!pages) {
+		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
 		return;
 	}
 
-- 
1.7.4.1
