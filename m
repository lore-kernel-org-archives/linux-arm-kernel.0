From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 12 Jan 2015 20:48:57 +0000
Subject: [RFC PATCH 5/5] arm64: hook up IOMMU dma_ops
In-Reply-To: <cover.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
Message-ID: <096cb0e8c8fe7f25ce4ae0dd5771d7dc920d80ed.1421086706.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With iommu_dma_ops in place, hook them up to the configuration code, so
IOMMU-fronted devices will get them automatically.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/dma-mapping.h | 10 +++++-----
 arch/arm64/mm/dma-mapping.c          | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)

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
index 82082c4..0791a78 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -45,13 +45,13 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
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
 
+void arch_teardown_dma_ops(struct device *dev);
+#define arch_teardown_dma_ops	arch_teardown_dma_ops
+
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 8e449a7..d52175d 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -729,10 +729,32 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	iommu_dma_release_mapping(mapping);
 }
 
+static void __iommu_teardown_dma_ops(struct device *dev)
+{
+	if (dev->archdata.mapping) {
+		iommu_dma_detach_device(dev);
+		dev->archdata.dma_ops = NULL;
+	}
+}
+
 #else
 
 static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 				  struct iommu_ops *iommu)
 { }
 
+static void __iommu_teardown_dma_ops(struct device *dev) { }
+
 #endif  /* CONFIG_IOMMU_DMA */
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			struct iommu_ops *iommu, bool coherent)
+{
+	dev->archdata.dma_coherent = coherent;
+	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
+}
+
+void arch_teardown_dma_ops(struct device *dev)
+{
+	__iommu_teardown_dma_ops(dev);
+}
-- 
1.9.1
