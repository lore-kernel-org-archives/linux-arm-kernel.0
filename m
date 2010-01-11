From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:35 -0800
Subject: [RFC 16/18] arm: msm: add arch_has_speculative_dfetch()
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-17-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@quicinc.com>

The Scorpion CPU speculatively reads data into the cache. This
may occur while a region of memory is being written via DMA, so
that region must be invalidated when it is brought under CPU
control after the DMA transaction finishes, assuming the DMA
was either bidirectional or from the device.

Currently both a clean and invalidate are being done for
DMA_BIDIRECTIONAL in dma_unmap_single. Only an invalidate should be
required here. There are drivers that currently rely on the clean
however so this will be removed when those drivers are updated.

Signed-off-by: Steve Muckle <smuckle@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/include/asm/dma-mapping.h      |   11 ++++++++++-
 arch/arm/include/asm/memory.h           |    7 +++++++
 arch/arm/mach-msm/include/mach/memory.h |    3 +++
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index a96300b..db81a59 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -352,7 +352,12 @@ static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 static inline void dma_unmap_single(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	/* nothing to do */
+	BUG_ON(!valid_dma_direction(dir));
+
+	if (arch_has_speculative_dfetch() && dir != DMA_TO_DEVICE)
+		/* For DMA_BIDIRECTIONAL only an invalidate should be required
+		 * here, fix when all drivers are ready */
+		dma_cache_maint(dma_to_virt(dev, handle), size, dir);
 }
 
 /**
@@ -401,6 +406,10 @@ static inline void dma_sync_single_range_for_cpu(struct device *dev,
 	BUG_ON(!valid_dma_direction(dir));
 
 	dmabounce_sync_for_cpu(dev, handle, offset, size, dir);
+
+	if (arch_has_speculative_dfetch() && dir != DMA_TO_DEVICE)
+		dma_cache_maint(dma_to_virt(dev, handle) + offset, size,
+				DMA_FROM_DEVICE);
 }
 
 static inline void dma_sync_single_range_for_device(struct device *dev,
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 5421d82..792011b 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -309,6 +309,13 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 #define arch_is_coherent()		0
 #endif
 
+/*
+ * Set if the architecture speculatively fetches data into cache.
+ */
+#ifndef arch_has_speculative_dfetch
+#define arch_has_speculative_dfetch()	0
+#endif
+
 #endif
 
 #include <asm-generic/memory_model.h>
diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
index f4698ba..a538f2e 100644
--- a/arch/arm/mach-msm/include/mach/memory.h
+++ b/arch/arm/mach-msm/include/mach/memory.h
@@ -19,5 +19,8 @@
 /* physical offset of RAM */
 #define PHYS_OFFSET		UL(0x10000000)
 
+#ifdef CONFIG_ARCH_MSM_SCORPION
+#define arch_has_speculative_dfetch()	1
 #endif
 
+#endif
-- 
1.6.3.3
