From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 27 May 2015 15:09:18 +0100
Subject: [PATCH 4/4] arm64: Hook up IOMMU dma_ops
In-Reply-To: <cover.1432735420.git.robin.murphy@arm.com>
References: <cover.1432735420.git.robin.murphy@arm.com>
Message-ID: <b3dae5461f2a90939b05076d6e58c631b4971fea.1432735420.git.robin.murphy@arm.com>
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
index 7796af4..257cd7e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -70,6 +70,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
+	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 835a8d1..a87b507 100644
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
@@ -64,6 +61,10 @@ static inline bool is_device_dma_coherent(struct device *dev)
 #include <linux/dma-iommu.h>
 
 #ifdef CONFIG_IOMMU_DMA
+
+void arch_teardown_dma_ops(struct device *dev);
+#define arch_teardown_dma_ops	arch_teardown_dma_ops
+
 static inline struct iommu_dma_domain *arch_get_dma_domain(struct device *dev)
 {
 	return dev->archdata.dma_domain;
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 189477b..f9d4184 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -769,6 +769,14 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	mutex_unlock(&iommu_dma_notifier_lock);
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
@@ -776,3 +784,10 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
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
