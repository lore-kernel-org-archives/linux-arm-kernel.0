From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 31 Jul 2015 18:18:29 +0100
Subject: [PATCH v5 3/3] arm64: Hook up IOMMU dma_ops
In-Reply-To: <cover.1438362603.git.robin.murphy@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
Message-ID: <caecbce93dd4870995a000bebc8f58d1ca7e551e.1438362603.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With iommu_dma_ops in place, hook them up to the configuration code, so
IOMMU-fronted devices will get them automatically.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/dma-mapping.h | 15 +++++++--------
 arch/arm64/mm/dma-mapping.c          | 24 ++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c8933dc..81584ef 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -73,6 +73,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
+	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index f0d6d0b..7f9edcb 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -56,16 +56,15 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 		return __generic_dma_ops(dev);
 }
 
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				      struct iommu_ops *iommu, bool coherent)
-{
-	if (!acpi_disabled && !dev->archdata.dma_ops)
-		dev->archdata.dma_ops = dma_ops;
-
-	dev->archdata.dma_coherent = coherent;
-}
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			struct iommu_ops *iommu, bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
+#ifdef CONFIG_IOMMU_DMA
+void arch_teardown_dma_ops(struct device *dev);
+#define arch_teardown_dma_ops	arch_teardown_dma_ops
+#endif
+
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c735f45..175dcb2 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -952,6 +952,20 @@ out_no_domain:
 	pr_warn("Failed to set up IOMMU domain for device %s\n", dev_name(dev));
 }
 
+void arch_teardown_dma_ops(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain) {
+		iommu_detach_device(domain, dev);
+		if (domain->type & __IOMMU_DOMAIN_ARM64_IOVA)
+			iommu_put_dma_cookie(domain);
+		if (domain->type & __IOMMU_DOMAIN_ARM64)
+			iommu_domain_free(domain);
+		dev->archdata.dma_ops = NULL;
+	}
+}
+
 #else
 
 static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
@@ -959,3 +973,13 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 { }
 
 #endif  /* CONFIG_IOMMU_DMA */
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			struct iommu_ops *iommu, bool coherent)
+{
+	if (!acpi_disabled && !dev->archdata.dma_ops)
+		dev->archdata.dma_ops = dma_ops;
+
+	dev->archdata.dma_coherent = coherent;
+	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
+}
-- 
1.9.1
