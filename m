From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 10 Dec 2013 14:29:57 -0500
Subject: [PATCH 1/2] mm/ARM: dma: fix conflicting types for 'arm_dma_zone_size'
In-Reply-To: <1386703798-26521-1-git-send-email-santosh.shilimkar@ti.com>
References: <1386703798-26521-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1386703798-26521-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Commit 364230b9 "ARM: use phys_addr_t for DMA zone sizes" changes
type of arm_dma_zone_size to phys_addr_t, but misses to update
external definition of it in in arch/arm/include/asm/dma.h.
As result, kernel build is failed if CONFIG_ZONE_DMA is enabled:

arch/arm/mm/init.c:202:13: error: conflicting types for 'arm_dma_zone_size'
include/linux/bootmem.h:258:66: note: previous declaration of 'arm_dma_zone_size' was here

Hence, fix external definition of arm_dma_zone_size.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/dma.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index 58b8c6a..1439b80 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -8,7 +8,7 @@
 #define MAX_DMA_ADDRESS	0xffffffffUL
 #else
 #define MAX_DMA_ADDRESS	({ \
-	extern unsigned long arm_dma_zone_size; \
+	extern phys_addr_t arm_dma_zone_size; \
 	arm_dma_zone_size ? \
 		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
 #endif
-- 
1.7.9.5
