From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 24 May 2017 11:24:30 +0100
Subject: [PATCH v5 5/7] ARM: NOMMU: Introduce dma operations for noMMU
In-Reply-To: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1495621472-9323-6-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R/M classes of cpus can have memory covered by MPU which in turn might
configure RAM as Normal i.e. bufferable and cacheable. It breaks
dma_alloc_coherent() and friends, since data can stuck in caches now
or be buffered.

This patch factors out DMA support for NOMMU configuration into
separate entity which provides dedicated dma_ops. We have to handle
there several cases:
- configurations with MMU/MPU setup
- configurations without MMU/MPU setup
- special case for M-class, since caches and MPU there are optional

In general we rely on default DMA area for coherent allocations or/and
per-device memory reserves suitable for coherent DMA, so if such
regions are set coherent allocations go from there.

In case MMU/MPU was not setup we fallback to normal page allocator for
DMA memory allocation.

In case we run M-class cpus, for configuration without cache support
(like Cortex-M3/M4) dma operations are forced to be coherent and wired
with dma-noop (such decision is made based on cacheid global
variable); however, if caches are detected there and no DMA coherent
region is given (either default or per-device), dma is disallowed even
MPU is not set - it is because M-class implement system memory map
which defines part of address space as Normal memory.

Reported-by: Alexandre Torgue <alexandre.torgue@st.com>
Reported-by: Andras Szemzo <sza@esh.hu>
Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                   |   1 +
 arch/arm/include/asm/dma-mapping.h |   2 +-
 arch/arm/mm/Makefile               |   5 +-
 arch/arm/mm/dma-mapping-nommu.c    | 253 +++++++++++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mm/dma-mapping-nommu.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ed801f0..98e15d0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -22,6 +22,7 @@ config ARM
 	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select DMA_NOOP_OPS if !MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 680d3f3..0eec080 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -18,7 +18,7 @@ extern const struct dma_map_ops arm_coherent_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return &arm_dma_ops;
+	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_noop_ops;
 }
 
 #define HAVE_ARCH_DMA_SUPPORTED 1
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 54857bc..ea80df7 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -2,9 +2,8 @@
 # Makefile for the linux arm-specific parts of the memory manager.
 #
 
-obj-y				:= dma-mapping.o extable.o fault.o init.o \
-				   iomap.o
-
+obj-y				:= extable.o fault.o init.o iomap.o
+obj-y				+= dma-mapping$(MMUEXT).o
 obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
 				   mmap.o pgd.o mmu.o pageattr.o
 
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
new file mode 100644
index 0000000..3ba3003
--- /dev/null
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -0,0 +1,253 @@
+/*
+ *  Based on linux/arch/arm/mm/dma-mapping.c
+ *
+ *  Copyright (C) 2000-2004 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+
+#include <asm/cachetype.h>
+#include <asm/cacheflush.h>
+#include <asm/outercache.h>
+#include <asm/cp15.h>
+
+#include "dma.h"
+
+/*
+ *  dma_noop_ops is used if
+ *   - MMU/MPU is off
+ *   - cpu is v7m w/o cache support
+ *   - device is coherent
+ *  otherwise arm_nommu_dma_ops is used.
+ *
+ *  arm_nommu_dma_ops rely on consistent DMA memory (please, refer to
+ *  [1] on how to declare such memory).
+ *
+ *  [1] Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+ */
+
+static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp,
+				 unsigned long attrs)
+
+{
+	const struct dma_map_ops *ops = &dma_noop_ops;
+
+	/*
+	 * We are here because:
+	 * - no consistent DMA region has been defined, so we can't
+	 *   continue.
+	 * - there is no space left in consistent DMA region, so we
+	 *   only can fallback to generic allocator if we are
+	 *   advertised that consistency is not required.
+	 */
+
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		return ops->alloc(dev, size, dma_handle, gfp, attrs);
+
+	WARN_ON_ONCE(1);
+	return NULL;
+}
+
+static void arm_nommu_dma_free(struct device *dev, size_t size,
+			       void *cpu_addr, dma_addr_t dma_addr,
+			       unsigned long attrs)
+{
+	const struct dma_map_ops *ops = &dma_noop_ops;
+
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		ops->free(dev, size, cpu_addr, dma_addr, attrs);
+	else
+		WARN_ON_ONCE(1);
+
+	return;
+}
+
+static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			      unsigned long attrs)
+{
+	const struct dma_map_ops *ops = &dma_noop_ops;
+	int ret;
+
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+
+	WARN_ON_ONCE(1);
+	return -ENXIO;
+}
+
+static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
+				  enum dma_data_direction dir)
+{
+	dmac_map_area(__va(paddr), size, dir);
+
+	if (dir == DMA_FROM_DEVICE)
+		outer_inv_range(paddr, paddr + size);
+	else
+		outer_clean_range(paddr, paddr + size);
+}
+
+static void __dma_page_dev_to_cpu(phys_addr_t paddr, size_t size,
+				  enum dma_data_direction dir)
+{
+	if (dir != DMA_TO_DEVICE) {
+		outer_inv_range(paddr, paddr + size);
+		dmac_unmap_area(__va(paddr), size, dir);
+	}
+}
+
+static dma_addr_t arm_nommu_dma_map_page(struct device *dev, struct page *page,
+					 unsigned long offset, size_t size,
+					 enum dma_data_direction dir,
+					 unsigned long attrs)
+{
+	dma_addr_t handle = page_to_phys(page) + offset;
+
+	__dma_page_cpu_to_dev(handle, size, dir);
+
+	return handle;
+}
+
+static void arm_nommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	__dma_page_dev_to_cpu(handle, size, dir);
+}
+
+
+static int arm_nommu_dma_map_sg(struct device *dev, struct scatterlist *sgl,
+				int nents, enum dma_data_direction dir,
+				unsigned long attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sgl, sg, nents, i) {
+		sg_dma_address(sg) = sg_phys(sg);
+		sg_dma_len(sg) = sg->length;
+		__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
+	}
+
+	return nents;
+}
+
+static void arm_nommu_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
+				   int nents, enum dma_data_direction dir,
+				   unsigned long attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
+}
+
+static void arm_nommu_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	__dma_page_cpu_to_dev(handle, size, dir);
+}
+
+static void arm_nommu_dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	__dma_page_cpu_to_dev(handle, size, dir);
+}
+
+static void arm_nommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
+					     int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
+}
+
+static void arm_nommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
+					  int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
+}
+
+const struct dma_map_ops arm_nommu_dma_ops = {
+	.alloc			= arm_nommu_dma_alloc,
+	.free			= arm_nommu_dma_free,
+	.mmap			= arm_nommu_dma_mmap,
+	.map_page		= arm_nommu_dma_map_page,
+	.unmap_page		= arm_nommu_dma_unmap_page,
+	.map_sg			= arm_nommu_dma_map_sg,
+	.unmap_sg		= arm_nommu_dma_unmap_sg,
+	.sync_single_for_device	= arm_nommu_dma_sync_single_for_device,
+	.sync_single_for_cpu	= arm_nommu_dma_sync_single_for_cpu,
+	.sync_sg_for_device	= arm_nommu_dma_sync_sg_for_device,
+	.sync_sg_for_cpu	= arm_nommu_dma_sync_sg_for_cpu,
+};
+EXPORT_SYMBOL(arm_nommu_dma_ops);
+
+static const struct dma_map_ops *arm_nommu_get_dma_map_ops(bool coherent)
+{
+	return coherent ? &dma_noop_ops : &arm_nommu_dma_ops;
+}
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent)
+{
+	const struct dma_map_ops *dma_ops;
+
+	if (IS_ENABLED(CONFIG_CPU_V7M)) {
+		/*
+		 * Cache support for v7m is optional, so can be treated as
+		 * coherent if no cache has been detected. Note that it is not
+		 * enough to check if MPU is in use or not since in absense of
+		 * MPU system memory map is used.
+		 */
+		dev->archdata.dma_coherent = (cacheid) ? coherent : true;
+	} else {
+		/*
+		 * Assume coherent DMA in case MMU/MPU has not been set up.
+		 */
+		dev->archdata.dma_coherent = (get_cr() & CR_M) ? coherent : true;
+	}
+
+	dma_ops = arm_nommu_get_dma_map_ops(dev->archdata.dma_coherent);
+
+	set_dma_ops(dev, dma_ops);
+}
+
+void arch_teardown_dma_ops(struct device *dev)
+{
+}
+
+int dma_supported(struct device *dev, u64 mask)
+{
+	return 1;
+}
+
+EXPORT_SYMBOL(dma_supported);
+
+#define PREALLOC_DMA_DEBUG_ENTRIES	4096
+
+static int __init dma_debug_do_init(void)
+{
+	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
+	return 0;
+}
+core_initcall(dma_debug_do_init);
-- 
2.0.0
