From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:51 -0400
Subject: [PATCH 07/37] ARM: OMAP: move OMAP1 memory config from plat/memory.h
	to its mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-7-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-omap1/include/mach/memory.h |   54 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/memory.h  |   45 +-----------------------
 2 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index e9b600c..5f96515 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -2,4 +2,56 @@
  * arch/arm/mach-omap1/include/mach/memory.h
  */
 
-#include <plat/memory.h>
+#ifndef __ASM_ARCH_MEMORY_H
+#define __ASM_ARCH_MEMORY_H
+
+/*
+ * Physical DRAM offset.
+ */
+#define PLAT_PHYS_OFFSET		UL(0x10000000)
+
+/*
+ * Bus address is physical address, except for OMAP-1510 Local Bus.
+ * OMAP-1510 bus address is translated into a Local Bus address if the
+ * OMAP bus type is lbus. We do the address translation based on the
+ * device overriding the defaults used in the dma-mapping API.
+ * Note that the is_lbus_device() test is not very efficient on 1510
+ * because of the strncmp().
+ */
+#ifdef CONFIG_ARCH_OMAP15XX
+
+/*
+ * OMAP-1510 Local Bus address offset
+ */
+#define OMAP1510_LB_OFFSET	UL(0x30000000)
+
+#define virt_to_lbus(x)		((x) - PAGE_OFFSET + OMAP1510_LB_OFFSET)
+#define lbus_to_virt(x)		((x) - OMAP1510_LB_OFFSET + PAGE_OFFSET)
+#define is_lbus_device(dev)	(cpu_is_omap15xx() && dev && (strncmp(dev_name(dev), "ohci", 4) == 0))
+
+#define __arch_pfn_to_dma(dev, pfn)	\
+	({ dma_addr_t __dma = __pfn_to_phys(pfn); \
+	   if (is_lbus_device(dev)) \
+		__dma = __dma - PHYS_OFFSET + OMAP1510_LB_OFFSET; \
+	   __dma; })
+
+#define __arch_dma_to_pfn(dev, addr)	\
+	({ dma_addr_t __dma = addr;				\
+	   if (is_lbus_device(dev))				\
+		__dma += PHYS_OFFSET - OMAP1510_LB_OFFSET;	\
+	   __phys_to_pfn(__dma);				\
+	})
+
+#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
+						lbus_to_virt(addr) : \
+						__phys_to_virt(addr)); })
+
+#define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
+					   (dma_addr_t) (is_lbus_device(dev) ? \
+						virt_to_lbus(__addr) : \
+						__virt_to_phys(__addr)); })
+
+#endif	/* CONFIG_ARCH_OMAP15XX */
+
+#endif
+
diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
index 7f9df6f..5b1a86d 100644
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ b/arch/arm/plat-omap/include/plat/memory.h
@@ -37,53 +37,10 @@
  * Physical DRAM offset.
  */
 #if defined(CONFIG_ARCH_OMAP1)
-#define PLAT_PHYS_OFFSET		UL(0x10000000)
+#error "OMAP1 should not be including this"
 #else
 #define PLAT_PHYS_OFFSET		UL(0x80000000)
 #endif
 
-/*
- * Bus address is physical address, except for OMAP-1510 Local Bus.
- * OMAP-1510 bus address is translated into a Local Bus address if the
- * OMAP bus type is lbus. We do the address translation based on the
- * device overriding the defaults used in the dma-mapping API.
- * Note that the is_lbus_device() test is not very efficient on 1510
- * because of the strncmp().
- */
-#ifdef CONFIG_ARCH_OMAP15XX
-
-/*
- * OMAP-1510 Local Bus address offset
- */
-#define OMAP1510_LB_OFFSET	UL(0x30000000)
-
-#define virt_to_lbus(x)		((x) - PAGE_OFFSET + OMAP1510_LB_OFFSET)
-#define lbus_to_virt(x)		((x) - OMAP1510_LB_OFFSET + PAGE_OFFSET)
-#define is_lbus_device(dev)	(cpu_is_omap15xx() && dev && (strncmp(dev_name(dev), "ohci", 4) == 0))
-
-#define __arch_pfn_to_dma(dev, pfn)	\
-	({ dma_addr_t __dma = __pfn_to_phys(pfn); \
-	   if (is_lbus_device(dev)) \
-		__dma = __dma - PHYS_OFFSET + OMAP1510_LB_OFFSET; \
-	   __dma; })
-
-#define __arch_dma_to_pfn(dev, addr)	\
-	({ dma_addr_t __dma = addr;				\
-	   if (is_lbus_device(dev))				\
-		__dma += PHYS_OFFSET - OMAP1510_LB_OFFSET;	\
-	   __phys_to_pfn(__dma);				\
-	})
-
-#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
-						lbus_to_virt(addr) : \
-						__phys_to_virt(addr)); })
-
-#define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
-					   (dma_addr_t) (is_lbus_device(dev) ? \
-						virt_to_lbus(__addr) : \
-						__virt_to_phys(__addr)); })
-
-#endif	/* CONFIG_ARCH_OMAP15XX */
-
 #endif
 
-- 
1.7.4
