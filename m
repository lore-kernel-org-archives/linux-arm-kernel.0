From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 26 Oct 2012 14:02:48 -0700
Subject: [RFC] Using CMA with devicetree generated devices
Message-ID: <508AFA78.4080602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is it possible to use the devices generated from device tree for use 
with CMA? The API for reserving a CMA region (dma_declare_contiguous) 
requires a device pointer to properly associate a region with a device. 
By the time the devices from devicetree are actually available 
(generally during machine_init), dma_contiguous_remap has already been 
called so it's too late to have a properly setup region.

I currently see several options:

1) All CMA devices must be statically declared in the board file
2) Scan the FDT to set up 'dummy' devices early which can later be used 
to set up CMA with the 'proper' devices
3) My assumption is completely wrong and the check that I was using is 
invalid:

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8404601..6d37516 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -368,9 +368,11 @@ struct dma_contig_early_reserve {
  static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] 
__initdata;

  static int dma_mmu_remap_num __initdata;
+static int is_remapped;

  void __init dma_contiguous_early_fixup(phys_addr_t base, unsigned long 
size)
  {
+       BUG_ON(is_remapped);
         dma_mmu_remap[dma_mmu_remap_num].base = base;
         dma_mmu_remap[dma_mmu_remap_num].size = size;
         dma_mmu_remap_num++;
@@ -404,6 +406,7 @@ void __init dma_contiguous_remap(void)

                 iotable_init(&map, 1);
         }
+       is_remapped = 1;
  }

  static void *

I'm currently leaning towards setting up #2 unless I'm missing something
obvious here. Thanks.

Laura
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
