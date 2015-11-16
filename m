From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 17:25:48 +0100
Subject: [RFC] ARM64: simplify dma_get_ops
Message-ID: <4270550.cGd11OgA5n@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Including linux/acpi.h from asm/dma-mapping.h causes tons of compile-time
warnings, e.g.

 drivers/isdn/mISDN/dsp_ecdis.h:43:0: warning: "FALSE" redefined
 drivers/isdn/mISDN/dsp_ecdis.h:44:0: warning: "TRUE" redefined
 drivers/net/fddi/skfp/h/targetos.h:62:0: warning: "TRUE" redefined
 drivers/net/fddi/skfp/h/targetos.h:63:0: warning: "FALSE" redefined

However, it looks like the dependency should not even there as
I do not see why __generic_dma_ops() cares about whether we have
an ACPI based system or not.

The current behavior is to fall back to the global dma_ops when
a device has not set its own dma_ops, but only for DT based systems.
This seems dangerous, as a random device might have different
requirements regarding IOMMU or coherency, so we should really
never have that fallback and just forbid DMA when we have not
initialized DMA for a device.

This removes the global dma_ops variable and the special-casing
for ACPI, and just returns the dma ops that got set for the
device, or the dummy_dma_ops if none were present.

The original code has apparently been copied from arm32 where we
rely on it for ISA devices things like the floppy controller, but
we should have no such devices on ARM64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 54d0ead41afc..04e841a1c1f3 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -18,7 +18,6 @@
 
 #ifdef __KERNEL__
 
-#include <linux/acpi.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 
@@ -26,22 +25,17 @@
 #include <asm/xen/hypervisor.h>
 
 #define DMA_ERROR_CODE	(~(dma_addr_t)0)
-extern struct dma_map_ops *dma_ops;
 extern struct dma_map_ops dummy_dma_ops;
 
 static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
 {
-	if (unlikely(!dev))
-		return dma_ops;
-	else if (dev->archdata.dma_ops)
+	if (dev && dev->archdata.dma_ops)
 		return dev->archdata.dma_ops;
-	else if (acpi_disabled)
-		return dma_ops;
 
 	/*
-	 * When ACPI is enabled, if arch_set_dma_ops is not called,
-	 * we will disable device DMA capability by setting it
-	 * to dummy_dma_ops.
+	 * we expect no ISA devices, and all other DMA masters are
+	 * expected to have someone call arch_setup_dma_ops at
+	 * device creation time
 	 */
 	return &dummy_dma_ops;
 }
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 131a199114b4..9e351c1f89e2 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/gfp.h>
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/genalloc.h>
@@ -28,9 +29,6 @@
 
 #include <asm/cacheflush.h>
 
-struct dma_map_ops *dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
 				 bool coherent)
 {
@@ -515,13 +513,7 @@ EXPORT_SYMBOL(dummy_dma_ops);
 
 static int __init arm64_dma_init(void)
 {
-	int ret;
-
-	dma_ops = &swiotlb_dma_ops;
-
-	ret = atomic_pool_init();
-
-	return ret;
+	return atomic_pool_init();
 }
 arch_initcall(arm64_dma_init);
 
@@ -985,7 +977,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			struct iommu_ops *iommu, bool coherent)
 {
 	if (!acpi_disabled && !dev->archdata.dma_ops)
-		dev->archdata.dma_ops = dma_ops;
+		dev->archdata.dma_ops = &swiotlb_dma_ops;
 
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
