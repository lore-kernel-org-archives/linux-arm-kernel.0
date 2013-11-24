From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 22:47:33 -0500
Subject: [PATCH 1/2] ARM: mm: Fix the arm_dma_limit calculation
In-Reply-To: <1385264854-30162-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385264854-30162-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385264854-30162-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code is using PHYS_OFFSET to calculate the arm_dma_limit which
will lead to wrong calculations in cases where PHYS_OFFSET is updated
runtime.

So fix the code by using __pv_phys_offset instead of PHYS_OFFSET.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 3e8f106..1f7b19a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -229,7 +229,7 @@ void __init setup_dma_zone(const struct machine_desc *mdesc)
 #ifdef CONFIG_ZONE_DMA
 	if (mdesc->dma_zone_size) {
 		arm_dma_zone_size = mdesc->dma_zone_size;
-		arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
+		arm_dma_limit = __pv_phys_offset + arm_dma_zone_size - 1;
 	} else
 		arm_dma_limit = 0xffffffff;
 	arm_dma_pfn_limit = arm_dma_limit >> PAGE_SHIFT;
-- 
1.7.9.5
