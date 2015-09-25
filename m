From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 25 Sep 2015 13:15:46 +0100
Subject: [PATCH 4/4] dma-debug: Allow poisoning nonzero allocations
In-Reply-To: <cover.1443178314.git.robin.murphy@arm.com>
References: <cover.1443178314.git.robin.murphy@arm.com>
Message-ID: <0405c6131def5aa179ff4ba5d4201ebde89cede3.1443178314.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since some dma_alloc_coherent implementations return a zeroed buffer
regardless of whether __GFP_ZERO is passed, there exist drivers which
are implicitly dependent on this and pass otherwise uninitialised
buffers to hardware. This can lead to subtle and awkward-to-debug issues
using those drivers on different platforms, where nonzero uninitialised
junk may for instance occasionally look like a valid command which
causes the hardware to start misbehaving. To help with debugging such
issues, add the option to make uninitialised buffers much more obvious.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/asm-generic/dma-mapping-common.h |  2 +-
 include/linux/dma-debug.h                |  6 ++++--
 include/linux/poison.h                   |  3 +++
 lib/Kconfig.debug                        | 10 ++++++++++
 lib/dma-debug.c                          |  6 +++++-
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index b1bc954..0f3e16b 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -260,7 +260,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 		return NULL;
 
 	cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
-	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
+	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, flag);
 	return cpu_addr;
 }
 
diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index fe8cb61..e5f539d 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -51,7 +51,8 @@ extern void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			       int nelems, int dir);
 
 extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
-				     dma_addr_t dma_addr, void *virt);
+				     dma_addr_t dma_addr, void *virt,
+				     gfp_t flags);
 
 extern void debug_dma_free_coherent(struct device *dev, size_t size,
 				    void *virt, dma_addr_t addr);
@@ -132,7 +133,8 @@ static inline void debug_dma_unmap_sg(struct device *dev,
 }
 
 static inline void debug_dma_alloc_coherent(struct device *dev, size_t size,
-					    dma_addr_t dma_addr, void *virt)
+					    dma_addr_t dma_addr, void *virt,
+					    gfp_t flags)
 {
 }
 
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 317e16d..174104e 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -73,6 +73,9 @@
 #define MUTEX_DEBUG_INIT	0x11
 #define MUTEX_DEBUG_FREE	0x22
 
+/********** lib/dma_debug.c **********/
+#define DMA_ALLOC_POISON	0xee
+
 /********** lib/flex_array.c **********/
 #define FLEX_ARRAY_FREE	0x6c	/* for use-after-free poisoning */
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ab76b99..f2da7a1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1752,6 +1752,16 @@ config DMA_API_DEBUG
 
 	  If unsure, say N.
 
+config DMA_API_DEBUG_POISON
+	bool "Poison coherent DMA buffers"
+	depends on DMA_API_DEBUG && EXPERT
+	help
+	  Poison DMA buffers returned by dma_alloc_coherent unless __GFP_ZERO
+	  is explicitly specified, to catch drivers depending on zeroed buffers
+	  without passing the correct flags.
+
+	  Only say Y if you're prepared for almost everything to break.
+
 config TEST_LKM
 	tristate "Test module loading with 'hello world' module"
 	default n
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 908fb35..40514ed 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
+#include <linux/poison.h>
 #include <linux/slab.h>
 
 #include <asm/sections.h>
@@ -1447,7 +1448,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 EXPORT_SYMBOL(debug_dma_unmap_sg);
 
 void debug_dma_alloc_coherent(struct device *dev, size_t size,
-			      dma_addr_t dma_addr, void *virt)
+			      dma_addr_t dma_addr, void *virt, gfp_t flags)
 {
 	struct dma_debug_entry *entry;
 
@@ -1457,6 +1458,9 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 	if (unlikely(virt == NULL))
 		return;
 
+	if (IS_ENABLED(CONFIG_DMA_API_DEBUG_POISON) && !(flags & __GFP_ZERO))
+		memset(virt, DMA_ALLOC_POISON, size);
+
 	entry = dma_entry_alloc();
 	if (!entry)
 		return;
-- 
1.9.1
