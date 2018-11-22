From: Jan.JABLONSKY@thalesgroup.com (JABLONSKY Jan)
Date: Thu, 22 Nov 2018 07:36:26 +0000
Subject: arm: dma-mapping: CPU may not see up-to-date data after DMA
 transaction
Message-ID: <1542872133.26115.4.camel@atviedlbe741.rss.d3s.at.thales>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Proper cleaning and invalidating has to be performed also for inner cache,
otherwise CPU may work with data from inner cache

Problem appears on The Altera SoC FPGA (Cortex-A9), during
higher CPU and system memory load followed reading by CPU from memory after
DMA transaction.
That means CPU may not see most up-to-date and correct copy of DMA buffer.

Replace with functions __sync_cache_range_r/w, which handle mentioned
situation.
Protect against preemption to make sure, that the code is
running on the current CPU

Signed-off-by: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
---
 arch/arm/mm/dma-mapping.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 661fe48ab78d..f40dc8b250d8 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -997,11 +997,18 @@ static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
 
 	paddr = page_to_phys(page) + off;
+
+	/*
+	 * Protect against preemption
+	 * Ensure that the code is running on the current CPU
+	 */
+	preempt_disable();
 	if (dir == DMA_FROM_DEVICE) {
-		outer_inv_range(paddr, paddr + size);
+		__sync_cache_range_r(phys_to_virt(paddr), size);
 	} else {
-		outer_clean_range(paddr, paddr + size);
+		__sync_cache_range_w(phys_to_virt(paddr), size);
 	}
+	preempt_enable();
 	/* FIXME: non-speculating: flush on bidirectional mappings? */
 }
 
@@ -1013,7 +1020,13 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	/* FIXME: non-speculating: not required */
 	/* in any case, don't bother invalidating if DMA to device */
 	if (dir != DMA_TO_DEVICE) {
-		outer_inv_range(paddr, paddr + size);
+		/*
+		 * Protect against preemption
+		 * Ensure that the code is running on the current CPU
+		 */
+		preempt_disable();
+		__sync_cache_range_r(phys_to_virt(paddr), size);
+		preempt_enable();
 
 		dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
 	}
