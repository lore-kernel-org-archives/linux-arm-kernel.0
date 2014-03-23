From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 23 Mar 2014 01:36:48 +0100
Subject: [PATCH 2/3] IXP4xx: Fix DMA masks.
In-Reply-To: <m3siq9iyt2.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Sun, 23 Mar 2014 00:44:09 +0100")
References: <m3siq9iyt2.fsf@intrepid.localdomain>
Message-ID: <m37g7liwdb.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, devices will have 32-bit default DMA masks (0xFFFFFFFF) as per DMA API.

Fixes:
$ ifconfig eth0 up
net eth0: coherent DMA mask is unset

$ ifconfig hdlc0 up
net hdlc0: coherent DMA mask is unset

Also fixes a cosmetic off-by-one bug which caused DMA transfers ending exactly
on the 64 MiB boundary to go through dmabounce unnecessarily.

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 200970d..4977296 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -315,33 +315,6 @@ static int abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *r
 	return 0;
 }
 
-
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
-	if (dev_is_pci(dev)) {
-		*dev->dma_mask =  SZ_64M - 1;
-		dev->coherent_dma_mask = SZ_64M - 1;
-		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
-	}
-	return 0;
-}
-
-static int ixp4xx_pci_platform_notify_remove(struct device *dev)
-{
-	if (dev_is_pci(dev))
-		dmabounce_unregister_dev(dev);
-
-	return 0;
-}
-
 void __init ixp4xx_pci_preinit(void)
 {
 	unsigned long cpuid = read_cpuid_id();
@@ -475,20 +448,8 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
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
index 6d68aed..12c71a4 100644
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
@@ -578,6 +577,54 @@ void ixp4xx_restart(enum reboot_mode mode, const char *cmd)
 	}
 }
 
+#ifdef CONFIG_PCI
+static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
+{
+	return (dma_addr + size) > SZ_64M;
+}
+
+static int ixp4xx_platform_notify_remove(struct device *dev)
+{
+	if (dev_is_pci(dev))
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
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+#ifdef CONFIG_PCI
+	if (dev_is_pci(dev)) {
+		dev->coherent_dma_mask = DMA_BIT_MASK(28); /* 64 MB */
+		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
+		return 0;
+	}
+#endif
+
+	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	return 0;
+}
+
+int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if (dev_is_pci(dev))
+		mask &= DMA_BIT_MASK(28); /* 64 MB */
+
+	if ((mask & DMA_BIT_MASK(28)) == DMA_BIT_MASK(28)) {
+		dev->coherent_dma_mask = mask;
+		return 0;
+	}
+
+	return -EIO;		/* device wanted sub-64MB mask */
+}
+EXPORT_SYMBOL(dma_set_coherent_mask);
+
 #ifdef CONFIG_IXP4XX_INDIRECT_PCI
 /*
  * In the case of using indirect PCI, we simply return the actual PCI
@@ -600,12 +647,16 @@ static void ixp4xx_iounmap(void __iomem *addr)
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
