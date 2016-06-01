From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:15 +0200
Subject: [PATCH 06/32] arm64: Fix physical to DMA mappings.
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-7-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: mzoran <mzoran@crowfest.net>

Gets USB and networking to work on Raspberry Pi 3 in 64 bit.

created by mzoran at crowfest.net

[ kraxel: some cleanups ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm64/include/asm/dma-mapping.h | 73 ++++++++++++++++++++++++++++++++++--
 arch/arm64/include/asm/memory.h      |  8 ++++
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 7dbea6c..48e8856 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -19,7 +19,11 @@
 #ifdef __KERNEL__
 
 #include <linux/types.h>
-#include <linux/vmalloc.h>
+#include <linux/scatterlist.h>
+#include <linux/dma-attrs.h>
+#include <linux/dma-debug.h>
+
+#include <asm/memory.h>
 
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
@@ -56,6 +60,54 @@ void arch_teardown_dma_ops(struct device *dev);
 #define arch_teardown_dma_ops	arch_teardown_dma_ops
 #endif
 
+/*
+ * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
+ * functions used internally by the DMA-mapping API to provide DMA
+ * addresses. They must not be used by drivers.
+ */
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
+{
+	if (dev)
+		pfn -= dev->dma_pfn_offset;
+	return (dma_addr_t)__pfn_to_bus(pfn);
+}
+
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
+{
+	unsigned long pfn = __bus_to_pfn(addr);
+
+	if (dev)
+		pfn += dev->dma_pfn_offset;
+
+	return pfn;
+}
+
+static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
+{
+	if (dev) {
+		unsigned long pfn = dma_to_pfn(dev, addr);
+
+		return phys_to_virt(__pfn_to_phys(pfn));
+	}
+
+	return (void *)__bus_to_virt((unsigned long)addr);
+}
+
+static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
+{
+	if (dev)
+		return pfn_to_dma(dev, virt_to_pfn(addr));
+
+	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
+}
+
+/* The ARM override for dma_max_pfn() */
+static inline unsigned long dma_max_pfn(struct device *dev)
+{
+	return PHYS_PFN_OFFSET + dma_to_pfn(dev, *dev->dma_mask);
+}
+#define dma_max_pfn(dev) dma_max_pfn(dev)
+
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
@@ -66,20 +118,33 @@ static inline bool is_device_dma_coherent(struct device *dev)
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return (dma_addr_t)paddr;
+	unsigned int offset = paddr & ~PAGE_MASK;
+	return pfn_to_dma(dev, __phys_to_pfn(paddr)) + offset;
 }
 
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
-	return (phys_addr_t)dev_addr;
+	unsigned int offset = dev_addr & ~PAGE_MASK;
+	return __pfn_to_phys(dma_to_pfn(dev, dev_addr)) + offset;
 }
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
+	u64 limit, mask;
+
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <= *dev->dma_mask;
+	mask = *dev->dma_mask;
+
+	limit = (mask + 1) & ~mask;
+	if (limit && size > limit)
+		return false;
+
+	if ((addr | (addr + size - 1)) & ~mask)
+		return false;
+
+	return true;
 }
 
 static inline void dma_mark_clean(void *addr, size_t size)
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 72a3025..ab4c65e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -226,6 +226,14 @@ static inline void *phys_to_virt(phys_addr_t x)
 #endif
 #endif
 
+#ifndef __virt_to_bus
+#define __virt_to_bus	__virt_to_phys
+#define __bus_to_virt	__phys_to_virt
+#define __pfn_to_bus(x)	__pfn_to_phys(x)
+#define __bus_to_pfn(x)	__phys_to_pfn(x)
+#endif
+
+
 #include <asm-generic/memory_model.h>
 
 #endif
-- 
1.8.3.1
