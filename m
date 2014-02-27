From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 27 Feb 2014 16:17:50 -0500
Subject: [PATCH v2 5/7] ARM: of: introduce common routine for DMA configuration
In-Reply-To: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1393535872-20915-6-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

This patch introduces ARM specific function arm_dt_dma_configure()
which intended to retrieve DMA configuration from DT and setup Platform
device's DMA parameters.

The DMA configuration in DT has to be specified using "dma-ranges"
and "dam-coherent" properties if supported. The DMA configuration applied
by arm_dt_dma_configure() as following:
 - call of_get_dma_range() and get supported DMA range info
   (dma_addr, cpu_addr, dma_size);
 - if "not found" then fill dma_mask as DMA_BIT_MASK(32)
   (this is default behaviour);
 - if "failed" then clean up dma_mask (DMA not supported)
 - if ok then update devices DMA configuration:
      set dma_mask to (dma_addr + dma_size - 1)
      set dma_pfn_offset to PFN_DOWN(cpu_addr - dma_addr)

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/include/asm/prom.h |    3 +++
 arch/arm/kernel/devtree.c   |   61 +++++++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c       |    5 +++-
 include/linux/of.h          |    2 +-
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
index b681575..1acb732 100644
--- a/arch/arm/include/asm/prom.h
+++ b/arch/arm/include/asm/prom.h
@@ -11,11 +11,13 @@
 #ifndef __ASMARM_PROM_H
 #define __ASMARM_PROM_H
 
+struct device;
 #ifdef CONFIG_OF
 
 extern const struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
 extern void arm_dt_memblock_reserve(void);
 extern void __init arm_dt_init_cpu_maps(void);
+extern void arm_dt_dma_configure(struct device *dev);
 
 #else /* CONFIG_OF */
 
@@ -26,6 +28,7 @@ static inline const struct machine_desc *setup_machine_fdt(unsigned int dt_phys)
 
 static inline void arm_dt_memblock_reserve(void) { }
 static inline void arm_dt_init_cpu_maps(void) { }
+static inline void arm_dt_dma_configure(struct device *dev) { }
 
 #endif /* CONFIG_OF */
 #endif /* ASMARM_PROM_H */
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index f751714..926b5dd 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -18,6 +18,9 @@
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/of_dma.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
 
 #include <asm/cputype.h>
 #include <asm/setup.h>
@@ -235,3 +238,61 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 	return mdesc;
 }
+
+void arm_dt_dma_configure(struct device *dev)
+{
+	dma_addr_t dma_addr;
+	phys_addr_t paddr, size;
+	dma_addr_t dma_mask;
+	int ret;
+
+	/*
+	 * if dma-ranges property doesn't exist - use 32 bits DMA mask
+	 * by default and don't set skip archdata.dma_pfn_offset
+	 */
+	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
+	if (ret == -ENODEV) {
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
+		if (!dev->dma_mask)
+			dev->dma_mask = &dev->coherent_dma_mask;
+		return;
+	}
+
+	/* if failed - disable DMA for device */
+	if (ret < 0) {
+		dev_err(dev, "failed to configure DMA\n");
+		return;
+	}
+
+	/* DMA ranges found. Calculate and set dma_pfn_offset */
+	dev->archdata.dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
+
+	/* Configure DMA mask */
+	dev->dma_mask = kmalloc(sizeof(*dev->dma_mask), GFP_KERNEL);
+	if (!dev->dma_mask)
+		return;
+
+	dma_mask = dma_addr + size - 1;
+
+	ret = arm_dma_set_mask(dev, dma_mask);
+	if (ret < 0) {
+		dev_err(dev, "failed to set DMA mask %#08x\n", dma_mask);
+		kfree(dev->dma_mask);
+		dev->dma_mask = NULL;
+		return;
+	}
+
+	dev_dbg(dev, "dma_pfn_offset(%#08lx) dma_mask(%#016llx)\n",
+		dev->archdata.dma_pfn_offset, *dev->dma_mask);
+
+	if (of_dma_is_coherent(dev->of_node)) {
+		set_dma_ops(dev, &arm_coherent_dma_ops);
+		dev_dbg(dev, "device is dma coherent\n");
+	}
+
+	ret = dma_set_coherent_mask(dev, dma_mask);
+	if (ret < 0) {
+		dev_err(dev, "failed to set coherent DMA mask %#08x\n",
+			dma_mask);
+	}
+}
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 404d1da..97d5533 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -213,10 +213,13 @@ static struct platform_device *of_platform_device_create_pdata(
 
 #if defined(CONFIG_MICROBLAZE)
 	dev->archdata.dma_mask = 0xffffffffUL;
-#endif
+#elif defined(CONFIG_ARM_LPAE)
+	arm_dt_dma_configure(&dev->dev);
+#else
 	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	if (!dev->dev.dma_mask)
 		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+#endif
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 70c64ba..a321058 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -136,7 +136,7 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 	return of_read_number(cell, size);
 }
 
-#if defined(CONFIG_SPARC)
+#if defined(CONFIG_SPARC) || defined(CONFIG_ARM_LPAE)
 #include <asm/prom.h>
 #endif
 
-- 
1.7.9.5
