From: robherring2@gmail.com (Rob Herring)
Date: Mon,  5 Aug 2013 17:50:05 -0500
Subject: [PATCH 1/5] ARM: use phys_addr_t for DMA zone sizes
Message-ID: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In order to specify a DMA zone size of 4GB on LPAE systems, the sizes need
to be 64-bit. So make machine_desc.dma_zone_size and arm_dma_zone_size be
phys_addr_t instead of unsigned long.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/mach/arch.h | 2 +-
 arch/arm/mm/init.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 441efc4..d91b168 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -35,7 +35,7 @@ struct machine_desc {
 	unsigned int		nr_irqs;	/* number of IRQs */
 
 #ifdef CONFIG_ZONE_DMA
-	unsigned long		dma_zone_size;	/* size of DMA-able area */
+	phys_addr_t		dma_zone_size;	/* size of DMA-able area */
 #endif
 
 	unsigned int		video_start;	/* start of video RAM	*/
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 15225d8..c0bb66e 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -207,7 +207,7 @@ static void __init arm_bootmem_init(unsigned long start_pfn,
 
 #ifdef CONFIG_ZONE_DMA
 
-unsigned long arm_dma_zone_size __read_mostly;
+phys_addr_t arm_dma_zone_size __read_mostly;
 EXPORT_SYMBOL(arm_dma_zone_size);
 
 /*
-- 
1.8.1.2
