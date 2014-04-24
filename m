From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Apr 2014 11:30:07 -0400
Subject: [PATCH v3 7/7] ARM: dma: use phys_addr_t in
 __dma_page_[cpu_to_dev/dev_to_cpu]
In-Reply-To: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1398353407-2345-8-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a 32 bit ARM architecture with LPAE extension physical addresses
cannot fit into unsigned long variable.

So fix it by using phys_addr_t instead of unsigned long.

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/dma-mapping.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f62aa06..5260f43 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -885,7 +885,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
-	unsigned long paddr;
+	phys_addr_t paddr;
 
 	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
 
@@ -901,7 +901,7 @@ static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	size_t size, enum dma_data_direction dir)
 {
-	unsigned long paddr = page_to_phys(page) + off;
+	phys_addr_t paddr = page_to_phys(page) + off;
 
 	/* FIXME: non-speculating: not required */
 	/* don't bother invalidating if DMA to device */
-- 
1.7.9.5
