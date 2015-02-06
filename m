From: robin.murphy@arm.com (Robin Murphy)
Date: Fri,  6 Feb 2015 14:55:15 +0000
Subject: [RFC PATCH v2 3/3] arm64: hook up IOMMU dma_ops
In-Reply-To: <cover.1423226542.git.robin.murphy@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>
Message-ID: <482b3b109a3d4818b1b1e693f488a919cf1bb707.1423226542.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With iommu_dma_ops in place, hook them up to the configuration code, so
IOMMU-fronted devices will get them automatically.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/dma-mapping.h | 11 ++++++-----
 arch/arm64/mm/dma-mapping.c          | 15 +++++++++++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1f9a20..e2abcdc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -66,6 +66,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
+	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index c1b271f..5246d1a 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -45,11 +45,8 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 		return __generic_dma_ops(dev);
 }
 
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				      struct iommu_ops *iommu, bool coherent)
-{
-	dev->archdata.dma_coherent = coherent;
-}
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			struct iommu_ops *iommu, bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
 /* do not use this function in a driver */
@@ -63,6 +60,10 @@ static inline bool is_device_dma_coherent(struct device *dev)
 #include <asm-generic/dma-mapping-common.h>
 
 #ifdef CONFIG_IOMMU_DMA
+
+void arch_teardown_dma_ops(struct device *dev);
+#define arch_teardown_dma_ops	arch_teardown_dma_ops
+
 static inline struct iommu_dma_domain *get_dma_domain(struct device *dev)
 {
 	return dev->archdata.dma_domain;
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 28e771c..2a30673 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -752,6 +752,14 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	iommu_dma_release_domain(dma_domain);
 }
 
+void arch_teardown_dma_ops(struct device *dev)
+{
+	if (dev->archdata.dma_domain) {
+		iommu_dma_detach_device(dev);
+		dev->archdata.dma_ops = NULL;
+	}
+}
+
 #else
 
 static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
@@ -759,3 +767,10 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 { }
 
 #endif  /* CONFIG_IOMMU_DMA */
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			struct iommu_ops *iommu, bool coherent)
+{
+	dev->archdata.dma_coherent = coherent;
+	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
+}
-- 
1.9.1
