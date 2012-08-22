From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 22 Aug 2012 10:21:19 -0000
Subject: [RFC 4/4] ARM: dma-mapping: dma_{alloc,
 free}_coherent with empty attrs
In-Reply-To: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1345630830-9586-5-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's possibility that this attrs be used later to set.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/include/asm/dma-mapping.h |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c27d855..96b67c7 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -125,8 +125,6 @@ extern int dma_supported(struct device *dev, u64 mask);
 extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			   gfp_t gfp, struct dma_attrs *attrs);
 
-#define dma_alloc_coherent(d, s, h, f) dma_alloc_attrs(d, s, h, f, NULL)
-
 static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag,
 				       struct dma_attrs *attrs)
@@ -135,11 +133,21 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	void *cpu_addr;
 	BUG_ON(!ops);
 
+	if (flag & GFP_ATOMIC)
+		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs);
+
 	cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
 	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
 	return cpu_addr;
 }
 
+static inline void *dma_alloc_coherent(struct device *dev, size_t size,
+				       dma_addr_t *dma_handle, gfp_t flag)
+{
+	DEFINE_DMA_ATTRS(attrs);
+	return dma_alloc_attrs(dev, size, dma_handle, flag, &attrs);
+}
+
 /**
  * arm_dma_free - free memory allocated by arm_dma_alloc
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
@@ -157,8 +165,6 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 			 dma_addr_t handle, struct dma_attrs *attrs);
 
-#define dma_free_coherent(d, s, c, h) dma_free_attrs(d, s, c, h, NULL)
-
 static inline void dma_free_attrs(struct device *dev, size_t size,
 				     void *cpu_addr, dma_addr_t dma_handle,
 				     struct dma_attrs *attrs)
@@ -170,6 +176,13 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 	ops->free(dev, size, cpu_addr, dma_handle, attrs);
 }
 
+static inline void dma_free_coherent(struct device *dev, size_t size,
+				     void *cpu_addr, dma_addr_t dma_handle)
+{
+	DEFINE_DMA_ATTRS(attrs);
+	return dma_free_attrs(dev, size, cpu_addr, dma_handle, &attrs);
+}
+
 /**
  * arm_dma_mmap - map a coherent DMA allocation into user space
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
-- 
1.7.5.4
