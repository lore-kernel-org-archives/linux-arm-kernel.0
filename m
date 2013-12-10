From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 10 Dec 2013 13:43:36 -0800
Subject: [PATCHv3 2/2] arm64: Enable CMA
In-Reply-To: <1386711816-20270-1-git-send-email-lauraa@codeaurora.org>
References: <1386711816-20270-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1386711816-20270-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 bit targets need the features CMA provides. Add the appropriate
hooks, header files, and Kconfig to allow this to happen.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/Kconfig                      |    1 +
 arch/arm64/include/asm/dma-contiguous.h |   29 +++++++++++++++++++++++++++++
 arch/arm64/mm/dma-mapping.c             |   25 +++++++++++++++++++++++--
 arch/arm64/mm/init.c                    |    3 +++
 4 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/dma-contiguous.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9737e97..26e4bef 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -22,6 +22,7 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_ATTRS
+	select HAVE_DMA_CONTIGUOUS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
diff --git a/arch/arm64/include/asm/dma-contiguous.h b/arch/arm64/include/asm/dma-contiguous.h
new file mode 100644
index 0000000..bc32516
--- /dev/null
+++ b/arch/arm64/include/asm/dma-contiguous.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef ASMARM64_DMA_CONTIGUOUS_H
+#define ASMARM64_DMA_CONTIGUOUS_H
+
+#ifdef __KERNEL__
+#ifdef CONFIG_CMA
+
+#include <linux/types.h>
+#include <asm-generic/dma-contiguous.h>
+
+static inline void
+dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
+
+#endif
+#endif
+
+#endif
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4134212..29d10b9 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -21,6 +21,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-contiguous.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
 
@@ -36,14 +37,34 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
 	if (dev && IS_ENABLED(CONFIG_ZONE_DMA32) &&
 	    dev->coherent_dma_mask <= DMA_BIT_MASK(32))
 		flags |= GFP_DMA32;
-	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
+	if (IS_ENABLED(CONFIG_DMA_CMA)) {
+		struct page *page;
+
+		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
+							get_order(size));
+		if (!page)
+			return NULL;
+
+		*dma_handle = phys_to_dma(dev, page_to_phys(page));
+		return page_address(page);
+	} else {
+		return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
+	}
 }
 
 static void arm64_swiotlb_free_coherent(struct device *dev, size_t size,
 					void *vaddr, dma_addr_t dma_handle,
 					struct dma_attrs *attrs)
 {
-	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
+	if (IS_ENABLED(CONFIG_DMA_CMA)) {
+		phys_addr_t paddr = dma_to_phys(dev, dma_handle);
+
+		dma_release_from_contiguous(dev,
+					phys_to_page(paddr),
+					size >> PAGE_SHIFT);
+	} else {
+		swiotlb_free_coherent(dev, size, vaddr, dma_handle);
+	}
 }
 
 static struct dma_map_ops arm64_swiotlb_dma_ops = {
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 67e8d7c..74b7da1 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -30,6 +30,7 @@
 #include <linux/memblock.h>
 #include <linux/sort.h>
 #include <linux/of_fdt.h>
+#include <linux/dma-contiguous.h>
 
 #include <asm/prom.h>
 #include <asm/sections.h>
@@ -173,6 +174,8 @@ void __init arm64_memblock_init(void)
 		memblock_reserve(base, size);
 	}
 
+	dma_contiguous_reserve(0);
+
 	memblock_allow_resize();
 	memblock_dump_all();
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
