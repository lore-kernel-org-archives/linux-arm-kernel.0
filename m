From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Dec 2016 13:45:02 +0000
Subject: [RFC v2 PATCH 1/3] ARM: NOMMU: introduce dma operations for noMMU
In-Reply-To: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
References: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1481636704-18948-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R/M classes of cpus can have momory covered by MPU which in turn might
configure RAM as Normal i.e. bufferable and cacheable. It breaks
dma_alloc_coherent() and friends, since data can stuck in caches now
or be buffered.

This patch introduces the way to specify region of memory (via
"memdma=size at start" command line option) suitable for consistent DMA
operations. It is supposed that such region is marked by MPU as
non-cacheable.

For configuration without cache support (like Cortex-M3/M4) dma
operations are forced to be coherent and wired with dma-noop. Such
decision is made based on cacheid global variable. In case cpu
supports caches and no coherent memory region is given - dma is
disallowed.

Reported-by: Alexandre Torgue <alexandre.torgue@st.com>
Reported-by: Andras Szemzo <sza@esh.hu>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/dma-mapping.h |    3 +-
 arch/arm/mm/Makefile               |    5 +-
 arch/arm/mm/dma-mapping-nommu.c    |  262 ++++++++++++++++++++++++++++++++++++
 arch/arm/mm/mm.h                   |    3 +
 arch/arm/mm/nommu.c                |    6 +
 5 files changed, 275 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mm/dma-mapping-nommu.c

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bf02dbd..559faad 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -20,7 +20,8 @@ static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
 {
 	if (dev && dev->archdata.dma_ops)
 		return dev->archdata.dma_ops;
-	return &arm_dma_ops;
+
+	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_noop_ops;
 }
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 2ac7988..5796357 100644
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
index 0000000..f92d98a
--- /dev/null
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -0,0 +1,262 @@
+/*
+ *  Based on linux/arch/arm/mm/dma-mapping.c
+ *
+ *  Copyright (C) 2000-2004 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  DMA uncached mapping support.
+ */
+
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
+#include <linux/genalloc.h>
+
+#include <asm/cachetype.h>
+#include <asm/cacheflush.h>
+#include <asm/outercache.h>
+
+#include "dma.h"
+
+unsigned long dma_start __initdata;
+unsigned long dma_size __initdata;
+
+static struct gen_pool *dma_pool;
+
+static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
+			    dma_addr_t *dma_handle, gfp_t gfp,
+			    unsigned long attrs)
+{
+	void *ptr;
+
+	if (!dma_pool)
+		return NULL;
+
+	ptr = (void *)gen_pool_alloc(dma_pool, size);
+	if (ptr) {
+		*dma_handle = __pa(ptr);
+		dmac_flush_range(ptr, ptr + size);
+		outer_flush_range(__pa(ptr), __pa(ptr) + size);
+	}
+
+	return ptr;
+}
+
+static void arm_nommu_dma_free(struct device *dev, size_t size,
+			  void *cpu_addr, dma_addr_t dma_addr,
+			  unsigned long attrs)
+{
+	gen_pool_free(dma_pool, (unsigned long)cpu_addr, size);
+}
+
+static void __dma_page_cpu_to_dev(dma_addr_t handle, size_t size,
+			 enum dma_data_direction dir)
+{
+	dmac_map_area(__va(handle), size, dir);
+
+	if (dir == DMA_FROM_DEVICE)
+		outer_inv_range(handle, handle + size);
+	else
+		outer_clean_range(handle, handle + size);
+}
+
+static void __dma_page_dev_to_cpu(dma_addr_t handle, size_t size,
+			 enum dma_data_direction dir)
+{
+	if (dir != DMA_TO_DEVICE) {
+		outer_inv_range(handle, handle + size);
+		dmac_unmap_area(__va(handle), size, dir);
+	}
+}
+
+static dma_addr_t arm_nommu_dma_map_page(struct device *dev, struct page *page,
+				      unsigned long offset, size_t size,
+				      enum dma_data_direction dir,
+				      unsigned long attrs)
+{
+	dma_addr_t handle = page_to_phys(page) + offset;
+
+	__dma_page_cpu_to_dev(handle, size, dir);
+
+	return handle;
+}
+
+static void arm_nommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	__dma_page_dev_to_cpu(handle, size, dir);
+}
+
+
+static int arm_nommu_dma_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+			     enum dma_data_direction dir,
+			     unsigned long attrs)
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
+static void arm_nommu_dma_unmap_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, unsigned long attrs)
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
+				      int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
+}
+
+static void arm_nommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
+				   int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
+}
+
+struct dma_map_ops arm_nommu_dma_ops = {
+	.alloc			= arm_nommu_dma_alloc,
+	.free			= arm_nommu_dma_free,
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
+static struct dma_map_ops *arm_nommu_get_dma_map_ops(bool coherent)
+{
+	return coherent ? &dma_noop_ops : &arm_nommu_dma_ops;
+}
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent)
+{
+	struct dma_map_ops *dma_ops;
+
+	/*
+	 * Cahe support for v7m is optional, so can be treated as
+	 * coherent if no cache has been detected.
+	 */
+	dev->archdata.dma_coherent = (cacheid) ? coherent : true;
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
+	if (cacheid && !dma_pool)
+		return 0;
+
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
+
+/*
+ * Initialise the coherent pool for DMA allocations.
+ */
+static int  __init dma_pool_init(void)
+{
+	int ret;
+
+	if (cacheid && !dma_size) {
+		pr_warn("DMA: coherent memory region has not been given.\n");
+		return 0;
+	}
+
+	dma_pool = gen_pool_create(PAGE_SHIFT, -1);
+
+	if (!dma_pool)
+		goto out;
+
+	ret = gen_pool_add_virt(dma_pool, (unsigned long)dma_start, (unsigned long)dma_start,
+				dma_size, -1);
+	if (ret)
+		goto destroy_genpool;
+
+	gen_pool_set_algo(dma_pool, gen_pool_first_fit_order_align, NULL);
+
+	pr_info("DMA: coherent memory region 0x%lx - 0x%lx (%lu KiB)\n",
+		dma_start, dma_start + dma_size, dma_size >> 10);
+
+	return 0;
+
+destroy_genpool:
+	gen_pool_destroy(dma_pool);
+	dma_pool = NULL;
+out:
+	pr_err("DMA: failed to allocate coherent memory region\n");
+	return -ENOMEM;
+}
+
+postcore_initcall(dma_pool_init);
+
+/* "memdma=<size>@<address>" parsing. */
+static int __init early_memdma(char *p)
+{
+	if (!p)
+		return -EINVAL;
+
+	dma_size = memparse(p, &p);
+	if (*p == '@')
+		dma_start = memparse(p + 1, &p);
+
+	return 0;
+}
+early_param("memdma", early_memdma);
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index ce727d4..18eb869 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -97,3 +97,6 @@ struct static_vm {
 void dma_contiguous_remap(void);
 
 unsigned long __clear_cr(unsigned long mask);
+
+extern unsigned long dma_start  __initdata;
+extern unsigned long dma_size  __initdata;
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 681cec8..5827e54 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -303,6 +303,12 @@ void __init sanity_check_meminfo(void)
 	end = memblock_end_of_DRAM();
 	high_memory = __va(end - 1) + 1;
 	memblock_set_current_limit(end);
+
+	if (dma_size &&
+	    memblock_overlaps_region(&memblock.memory, dma_start, dma_size)) {
+		pr_crit("DMA: coherent memory region overlaps with main memory.\n");
+		dma_size = 0;
+	}
 }
 
 /*
-- 
1.7.9.5
