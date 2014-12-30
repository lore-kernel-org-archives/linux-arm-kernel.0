From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Dec 2014 13:43:47 +0100
Subject: [PATCH 6/6] ARM: mvebu: use arm_coherent_dma_ops
In-Reply-To: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1419943428-18491-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have enabled automatic I/O synchronization barriers, we no
longer need any explicit barriers. We can therefore simplify
arch/arm/mach-mvebu/coherency.c by using the existing
arm_coherent_dma_ops instead of our custom mvebu_hwcc_dma_ops.

Fixes: e60304f8cb7b ("arm: mvebu: Add hardware I/O Coherency support")
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 51 ++---------------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 3585cb3..440799b 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -33,6 +33,7 @@
 #include <asm/smp_plat.h>
 #include <asm/cacheflush.h>
 #include <asm/mach/map.h>
+#include <asm/dma-mapping.h>
 #include "coherency.h"
 #include "mvebu-soc-id.h"
 
@@ -76,54 +77,6 @@ int set_cpu_coherent(void)
 	return ll_enable_coherency();
 }
 
-static inline void mvebu_hwcc_sync_io_barrier(void)
-{
-	writel(0x1, coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET);
-	while (readl(coherency_cpu_base + IO_SYNC_BARRIER_CTL_OFFSET) & 0x1);
-}
-
-static dma_addr_t mvebu_hwcc_dma_map_page(struct device *dev, struct page *page,
-				  unsigned long offset, size_t size,
-				  enum dma_data_direction dir,
-				  struct dma_attrs *attrs)
-{
-	if (dir != DMA_TO_DEVICE)
-		mvebu_hwcc_sync_io_barrier();
-	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
-}
-
-
-static void mvebu_hwcc_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
-			      size_t size, enum dma_data_direction dir,
-			      struct dma_attrs *attrs)
-{
-	if (dir != DMA_TO_DEVICE)
-		mvebu_hwcc_sync_io_barrier();
-}
-
-static void mvebu_hwcc_dma_sync(struct device *dev, dma_addr_t dma_handle,
-			size_t size, enum dma_data_direction dir)
-{
-	if (dir != DMA_TO_DEVICE)
-		mvebu_hwcc_sync_io_barrier();
-}
-
-static struct dma_map_ops mvebu_hwcc_dma_ops = {
-	.alloc			= arm_dma_alloc,
-	.free			= arm_dma_free,
-	.mmap			= arm_dma_mmap,
-	.map_page		= mvebu_hwcc_dma_map_page,
-	.unmap_page		= mvebu_hwcc_dma_unmap_page,
-	.get_sgtable		= arm_dma_get_sgtable,
-	.map_sg			= arm_dma_map_sg,
-	.unmap_sg		= arm_dma_unmap_sg,
-	.sync_single_for_cpu	= mvebu_hwcc_dma_sync,
-	.sync_single_for_device	= mvebu_hwcc_dma_sync,
-	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
-	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
-	.set_dma_mask		= arm_dma_set_mask,
-};
-
 static int mvebu_hwcc_notifier(struct notifier_block *nb,
 			       unsigned long event, void *__dev)
 {
@@ -131,7 +84,7 @@ static int mvebu_hwcc_notifier(struct notifier_block *nb,
 
 	if (event != BUS_NOTIFY_ADD_DEVICE)
 		return NOTIFY_DONE;
-	set_dma_ops(dev, &mvebu_hwcc_dma_ops);
+	set_dma_ops(dev, &arm_coherent_dma_ops);
 
 	return NOTIFY_OK;
 }
-- 
2.1.0
