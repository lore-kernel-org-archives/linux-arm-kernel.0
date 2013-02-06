From: sw0312.kim@samsung.com (Seung-Woo Kim)
Date: Wed, 06 Feb 2013 13:21:14 +0900
Subject: [RESEND][PATCH] ARM: dma-mapping: Add maximum alignment order for dma
 iommu buffers
In-Reply-To: <1360116403-14112-1-git-send-email-sw0312.kim@samsung.com>
References: <1360116403-14112-1-git-send-email-sw0312.kim@samsung.com>
Message-ID: <1360124474-16636-1-git-send-email-sw0312.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alignment order for a dma iommu buffer is set by buffer size. For
large buffer, it is a waste of iommu address space. So configurable
parameter to limit maximum alignment order can reduce the waste.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Signed-off-by: Kyungmin.park <kyungmin.park@samsung.com>
---
There was stupid misses in previous patch, so I resend fixed version.

 arch/arm/Kconfig          |   21 +++++++++++++++++++++
 arch/arm/mm/dma-mapping.c |    3 +++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..4e89112 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -75,6 +75,27 @@ config ARM_DMA_USE_IOMMU
 	select ARM_HAS_SG_CHAIN
 	select NEED_SG_DMA_LENGTH
 
+if ARM_DMA_USE_IOMMU
+
+config ARM_DMA_IOMMU_ALIGNMENT
+	int "Maximum PAGE_SIZE order of alignment for DMA IOMMU buffers"
+	range 4 9
+	default 8
+	help
+	  DMA mapping framework by default aligns all buffers to the smallest
+	  PAGE_SIZE order which is greater than or equal to the requested buffer
+	  size. This works well for buffers up to a few hundreds kilobytes, but
+	  for larger buffers it just a waste of address space. Drivers which has
+	  relatively small addressing window (like 64Mib) might run out of
+	  virtual space with just a few allocations.
+
+	  With this parameter you can specify the maximum PAGE_SIZE order for
+	  DMA IOMMU buffers. Larger buffers will be aligned only to this
+	  specified order. The order is expressed as a power of two multiplied
+	  by the PAGE_SIZE.
+
+endif
+
 config HAVE_PWM
 	bool
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 076c26d..4cce854 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1002,6 +1002,9 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	unsigned int count, start;
 	unsigned long flags;
 
+	if (order > CONFIG_ARM_DMA_IOMMU_ALIGNMENT)
+		order = CONFIG_ARM_DMA_IOMMU_ALIGNMENT;
+
 	count = ((PAGE_ALIGN(size) >> PAGE_SHIFT) +
 		 (1 << mapping->order) - 1) >> mapping->order;
 
-- 
1.7.4.1
