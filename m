From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 18 Sep 2013 09:40:48 +0200
Subject: [PATCH] IXP4xx: Fix DMA masks.
Message-ID: <m3r4cma873.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, devices will have 32-bit default DMA masks (0xFFFFFFFF) as per DMA API.

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 3dcf479..fbd4a23 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -301,32 +301,6 @@ static int abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *r
 }
 
 
-static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
-{
-	return (dma_addr + size) >= SZ_64M;
-}
-
-/*
- * Setup DMA mask to 64MB on PCI devices. Ignore all other devices.
- */
-static int ixp4xx_pci_platform_notify(struct device *dev)
-{
-	if(dev->bus == &pci_bus_type) {
-		*dev->dma_mask =  SZ_64M - 1;
-		dev->coherent_dma_mask = SZ_64M - 1;
-		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
-	}
-	return 0;
-}
-
-static int ixp4xx_pci_platform_notify_remove(struct device *dev)
-{
-	if(dev->bus == &pci_bus_type) {
-		dmabounce_unregister_dev(dev);
-	}
-	return 0;
-}
-
 void __init ixp4xx_pci_preinit(void)
 {
 #ifdef CONFIG_IXP4XX_INDIRECT_PCI
@@ -446,20 +420,8 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
 	pci_add_resource_offset(&sys->resources, &res[0], sys->io_offset);
 	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
 
-	platform_notify = ixp4xx_pci_platform_notify;
-	platform_notify_remove = ixp4xx_pci_platform_notify_remove;
-
 	return 1;
 }
 
-int dma_set_coherent_mask(struct device *dev, u64 mask)
-{
-	if (mask >= SZ_64M - 1)
-		return 0;
-
-	return -EIO;
-}
-
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);
-EXPORT_SYMBOL(dma_set_coherent_mask);
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 5327dec..780517a 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -30,8 +30,8 @@
 #include <linux/export.h>
 #include <linux/gpio.h>
 #include <linux/cpu.h>
+#include <linux/pci.h>
 #include <linux/sched_clock.h>
-
 #include <mach/udc.h>
 #include <mach/hardware.h>
 #include <mach/io.h>
@@ -40,7 +40,6 @@
 #include <asm/page.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
-
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
@@ -551,6 +550,49 @@ void ixp4xx_restart(enum reboot_mode mode, const char *cmd)
 	}
 }
 
+#ifdef CONFIG_PCI
+static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
+{
+	return (dma_addr + size) >= SZ_64M;
+}
+
+static int ixp4xx_platform_notify_remove(struct device *dev)
+{
+	if (dev->bus == &pci_bus_type)
+		dmabounce_unregister_dev(dev);
+
+	return 0;
+}
+#endif
+
+/*
+ * Setup DMA mask to 64MB on PCI devices and 4 GB on all other things.
+ */
+static int ixp4xx_platform_notify(struct device *dev)
+{
+#ifdef CONFIG_PCI
+	if (dev->bus == &pci_bus_type) {
+		dev->coherent_dma_mask = DMA_BIT_MASK(28); /* 64 MB */
+		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
+	} else
+#endif
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	dev->dma_mask = &dev->coherent_dma_mask;
+	return 0;
+}
+
+int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if ((mask & DMA_BIT_MASK(28)) == DMA_BIT_MASK(28)) {
+		dev->coherent_dma_mask = mask;
+		return 0;
+	}
+
+	return -EIO;
+}
+EXPORT_SYMBOL(dma_set_coherent_mask);
+
 #ifdef CONFIG_IXP4XX_INDIRECT_PCI
 /*
  * In the case of using indirect PCI, we simply return the actual PCI
@@ -573,12 +615,16 @@ static void ixp4xx_iounmap(void __iomem *addr)
 	if (!is_pci_memory((__force u32)addr))
 		__iounmap(addr);
 }
+#endif
 
 void __init ixp4xx_init_early(void)
 {
+	platform_notify = ixp4xx_platform_notify;
+#ifdef CONFIG_PCI
+	platform_notify_remove = ixp4xx_platform_notify_remove;
+#endif
+#ifdef CONFIG_IXP4XX_INDIRECT_PCI
 	arch_ioremap_caller = ixp4xx_ioremap_caller;
 	arch_iounmap = ixp4xx_iounmap;
-}
-#else
-void __init ixp4xx_init_early(void) {}
 #endif
+}
