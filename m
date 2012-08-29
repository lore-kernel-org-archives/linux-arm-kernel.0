From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 29 Aug 2012 09:55:35 +0300
Subject: [RFC 5/5] ARM: dma-mapping: Introduce dma_map_linear_attrs() for IOVA
 linear map
In-Reply-To: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1346223335-31455-6-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a helper function, dma_map_linear(_attrs)() to create IOVA
linear map, where IOVA and kernel virtual addresses are mapped at the
same address linearly. This is useful to support legacy device drivers
which expects no IOMMU.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/include/asm/dma-mapping.h       |   13 +++++++++++++
 include/asm-generic/dma-mapping-common.h |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index f04a533..7a78dd4 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -212,6 +212,19 @@ static inline size_t dma_iova_get_free_max(struct device *dev)
 	return ops->iova_get_free_max(dev);
 }
 
+static inline dma_addr_t dma_map_linear_attrs(struct device *dev, void *va,
+				      size_t size, enum dma_data_direction dir,
+				      struct dma_attrs *attrs)
+{
+	dma_addr_t da;
+
+	da = dma_iova_alloc_at(dev, (dma_addr_t)va, size);
+	if (da == DMA_ERROR_CODE)
+		return DMA_ERROR_CODE;
+
+	return dma_map_single_at_attrs(dev, va, da, size, dir, attrs);
+}
+
 /**
  * arm_dma_mmap - map a coherent DMA allocation into user space
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index eada2d8..4564bf0 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -191,6 +191,7 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, NULL)
 #define dma_map_single_at(d, a, h, s, r)		\
 	dma_map_single_at_attrs(d, a, h, s, r, NULL)
+#define dma_map_linear(d, a, s, r) dma_map_linear_attrs(d, a, s, r, NULL)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, NULL)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
-- 
1.7.5.4
