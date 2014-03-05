From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 05 Mar 2014 10:21:01 +0100
Subject: [PATCH 2/2] ixp4xx_eth: Setup coherent_dma_mask
In-Reply-To: <20140305085549.3eb22236@marrow.netinsight.se> ("Simon
 =?utf-8?B?S8OlZ3N0csO2bSIncw==?= message of "Wed, 5 Mar 2014 08:55:49
 +0100")
References: <20140305085311.07b3922a@marrow.netinsight.se>
 <20140305085549.3eb22236@marrow.netinsight.se>
Message-ID: <m3d2i1atmq.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:

> --- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
> +++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> @@ -1426,6 +1426,10 @@ static int eth_init_one(struct platform_device *pdev)
>  	port->netdev = dev;
>  	port->id = pdev->id;
>  
> +	err = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
> +	if (err < 0)
> +		goto err_free;
> +

Both David and the DMA API say 32 bits must be the default. OTOH there
is other code like this in the kernel, guess IXP4xx is not alone with
such constrains.
Personally I think it should be done by the API, with ixp4xx core code
providing default 32-bit masks (FYI I've attached a 3.13 patch
I personally use).

I'm a bit tired of this and was waiting until Russell's DMA mask code is
merged (I'm busy doing other stuff ATM), perhaps there could be some way
out done incrementally now (sticking to the 32-bit default as a result).

What I don't like is specifying the "platform" DMA mask(s) for each
platform, as if the CPU built-in interface was anything-platform.
It's against my good programming rules, and it also increases the line
count unnecessarily which probably doesn't make Linus happy either.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

Author: Krzysztof Ha?asa <khalasa@piap.pl>
Date:   Thu Sep 5 15:16:16 2013 +0200

    IXP4xx: Fix DMA masks.
    
    Now, devices will have 32-bit default DMA masks (0xFFFFFFFF) as per DMA API.
    
    Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 6d6bde3..cefb80b 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -316,32 +316,6 @@ static int abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *r
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
 	unsigned long cpuid = read_cpuid_id();
@@ -475,20 +449,8 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
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
index a7906eb..0b6d146 100644
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
@@ -578,6 +577,56 @@ void ixp4xx_restart(enum reboot_mode mode, const char *cmd)
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
+#ifdef CONFIG_PCI
+	if (dev_is_pci(dev))
+		mask &= DMA_BIT_MASK(28); /* 64 MB */
+#endif
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
@@ -600,12 +649,16 @@ static void ixp4xx_iounmap(void __iomem *addr)
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
