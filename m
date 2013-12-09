From: murzin.v@gmail.com (Vladimir Murzin)
Date: Mon,  9 Dec 2013 17:35:45 +0100
Subject: [PATCH] arm: move arm_dma_limit to setup_dma_zone
Message-ID: <1386606945-2385-1-git-send-email-murzin.v@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 4dcfa600 (ARM: DMA-API: better handing of DMA masks for coherent
allocations) arm_dma_limit_pfn has almost substituted the arm_dma_limit. The
remaining user is dma_contiguous_reserve(). It is also referenced in
setup_dma_zone() to calculate arm_dma_limit_pfn.

Kill the global arm_dma_limit and equip setup_zone_dma with the local one.

Reported-by: Vassili Karpov <av1474@comtv.ru>
Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/arm/mm/init.c |    6 ++++--
 arch/arm/mm/mm.h   |    2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 3e8f106..7583951 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -208,7 +208,6 @@ EXPORT_SYMBOL(arm_dma_zone_size);
  * allocations.  This must be the smallest DMA mask in the system,
  * so a successful GFP_DMA allocation will always satisfy this.
  */
-phys_addr_t arm_dma_limit;
 unsigned long arm_dma_pfn_limit;
 
 static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
@@ -227,6 +226,8 @@ static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
 void __init setup_dma_zone(const struct machine_desc *mdesc)
 {
 #ifdef CONFIG_ZONE_DMA
+	phys_addr_t arm_dma_limit;
+
 	if (mdesc->dma_zone_size) {
 		arm_dma_zone_size = mdesc->dma_zone_size;
 		arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
@@ -381,7 +382,8 @@ void __init arm_memblock_init(struct meminfo *mi,
 	 * reserve memory for DMA contigouos allocations,
 	 * must come from DMA area inside low memory
 	 */
-	dma_contiguous_reserve(min(arm_dma_limit, arm_lowmem_limit));
+	dma_contiguous_reserve(min((phys_addr_t)arm_dma_pfn_limit << PAGE_SHIFT,
+				   arm_lowmem_limit));
 
 	arm_memblock_steal_permitted = false;
 	memblock_allow_resize();
diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index d5a982d..11f3509 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -80,10 +80,8 @@ extern __init void add_static_vm_early(struct static_vm *svm);
 #endif
 
 #ifdef CONFIG_ZONE_DMA
-extern phys_addr_t arm_dma_limit;
 extern unsigned long arm_dma_pfn_limit;
 #else
-#define arm_dma_limit ((phys_addr_t)~0)
 #define arm_dma_pfn_limit (~0ul >> PAGE_SHIFT)
 #endif
 
-- 
1.7.10.4
