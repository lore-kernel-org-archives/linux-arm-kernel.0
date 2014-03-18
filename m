From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 18 Mar 2014 08:41:12 +0100
Subject: [PATCH RESEND 1/2] ARM: ixp4xx: Make dma_set_coherent_mask common,
 correct implementation
In-Reply-To: <20140317105659.449505d8@marrow.netinsight.se> ("Simon
 =?utf-8?B?S8OlZ3N0csO2bSIncw==?= message of "Mon, 17 Mar 2014 10:56:59
 +0100")
References: <20140317105448.14bcb617@marrow.netinsight.se>
 <20140317105659.449505d8@marrow.netinsight.se>
Message-ID: <m3iorcj6nb.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch is incorrect, the functionality is reversed:

Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:

> +++ b/arch/arm/mach-ixp4xx/common-pci.c
> @@ -481,14 +481,6 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
>  	return 1;
>  }
>  
> -int dma_set_coherent_mask(struct device *dev, u64 mask)
> -{
> -	if (mask >= SZ_64M - 1)
> -		return 0;
> -
> -	return -EIO;

Originally, coherent masks equal to 64 MiB or wider are accepted.

> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c

> +int dma_set_coherent_mask(struct device *dev, u64 mask)
> +{
> +	if (dev_is_pci(dev) && mask >= SZ_64M)
> +		return -EIO;

Now, you reject them. However, with coherent allocations, big masks
(usually 32-bit) are ok. They have to be internally limited to 64 MiB,
though.
It's a narrow mask (e.g. 16 MiB) which can't be used, because we only
have two memory pools (4 GiB and 64 MiB), and we simply have no means to
request e.g. memory from 16 MiB range. Doesn't matter in practice,
otherwise we would have additional memory pool.

This differs a bit from the streaming mask. For streaming, we still
accept basically everything (because we obviously want to support 32-bit
capable devices) and we limit the masks to 64 MiB internally, but we
then have to use dmabounce or whatever (perhaps swiotlb could be an
option?).
Also, we can limit some heavy duty allocations to 64 MiB (e.g. skbuffs
on routers, with a custom patch). We don't do DAC, IXP4xx address space
is 32-bit anyway. BTW possibility to use some system-wide DMA mask while
creating skbuffs, disk buffers etc. could be an improvement (drivers
would still need to check the addresses with dmabounce).


Believe it or not, the correct patch is the one I'm attaching. One can
add extra *set_masks* (e.g. the new call setting both streaming and
coherent masks) in the drivers, but essentially it must do what this one
does. Also, converting the mask (in the dev struct) from a pointer to a
simple value would IMHO make sense, too.

Also, comparing bit masks with ">=" etc. doesn't look very valid to me.
What if some device wants a mask which isn't a power of 2 - 1?

I'm unable to look at this ATM but I will update the patch to the new
kernel, perhaps soon.

IXP4xx: Fix DMA masks.

Now, devices will have 32-bit default DMA masks (0xFFFFFFFF) as per DMA
API, and the masks will actually work.

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


-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
