From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:33 -0400
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
Message-ID: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having this value defined at compile time prevents multiple machines with
conflicting definitions to coexist.  Move it to a variable in preparation
for having a per machine value selected at run time.  This is relevant
only when CONFIG_ZONE_DMA is selected.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/dma.h    |    7 ++++---
 arch/arm/include/asm/memory.h |    7 +++++--
 arch/arm/mm/init.c            |   20 +++++++++++++-------
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index 4200554..1d34c11 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -6,10 +6,11 @@
 /*
  * This is the maximum virtual address which can be DMA'd from.
  */
-#ifndef ARM_DMA_ZONE_SIZE
-#define MAX_DMA_ADDRESS	0xffffffff
+#ifndef CONFIG_ZONE_DMA
+#define MAX_DMA_ADDRESS	0xffffffffUL
 #else
-#define MAX_DMA_ADDRESS	(PAGE_OFFSET + ARM_DMA_ZONE_SIZE)
+extern unsigned long arm_dma_zone_size;
+#define MAX_DMA_ADDRESS	(PAGE_OFFSET + arm_dma_zone_size)
 #endif
 
 #ifdef CONFIG_ISA_DMA_API
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index af44a8f..deb2eaa 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -209,10 +209,13 @@ static inline unsigned long __phys_to_virt(unsigned long x)
  * allocations.  This must be the smallest DMA mask in the system,
  * so a successful GFP_DMA allocation will always satisfy this.
  */
-#ifndef ARM_DMA_ZONE_SIZE
+#ifndef CONFIG_ZONE_DMA
 #define ISA_DMA_THRESHOLD	(0xffffffffULL)
 #else
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + ARM_DMA_ZONE_SIZE - 1)
+#define ISA_DMA_THRESHOLD	({ \
+	extern unsigned long arm_dma_zone_size; \
+	arm_dma_zone_size ? \
+		(PHYS_OFFSET + arm_dma_zone_size - 1) : 0xffffffffULL; })
 #endif
 
 /*
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c19571c..a14caff 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -34,6 +34,15 @@
 
 #include "mm.h"
 
+#ifdef CONFIG_ZONE_DMA
+#ifdef ARM_DMA_ZONE_SIZE
+unsigned long arm_dma_zone_size = ARM_DMA_ZONE_SIZE;
+#else
+unsigned long arm_dma_zone_size __read_mostly;
+#endif
+EXPORT_SYMBOL(arm_dma_zone_size);
+#endif
+
 static unsigned long phys_initrd_start __initdata = 0;
 static unsigned long phys_initrd_size __initdata = 0;
 
@@ -267,17 +276,14 @@ static void __init arm_bootmem_free(unsigned long min, unsigned long max_low,
 #endif
 	}
 
-#ifdef ARM_DMA_ZONE_SIZE
-#ifndef CONFIG_ZONE_DMA
-#error ARM_DMA_ZONE_SIZE set but no DMA zone to limit allocations
-#endif
-
+#ifdef CONFIG_ZONE_DMA
 	/*
 	 * Adjust the sizes according to any special requirements for
 	 * this machine type.
 	 */
-	arm_adjust_dma_zone(zone_size, zhole_size,
-		ARM_DMA_ZONE_SIZE >> PAGE_SHIFT);
+	if (arm_dma_zone_size)
+		arm_adjust_dma_zone(zone_size, zhole_size,
+			arm_dma_zone_size >> PAGE_SHIFT);
 #endif
 
 	free_area_init_node(0, zone_size, min, zhole_size);
-- 
1.7.4
