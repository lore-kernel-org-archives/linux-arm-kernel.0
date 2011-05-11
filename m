From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 17:25:35 +0100
Subject: [PATCH 2/2] ARM: use ARM_DMA_ZONE_SIZE to adjust the zone sizes
In-Reply-To: <20110511162450.GF5315@n2100.arm.linux.org.uk>
References: <20110511162450.GF5315@n2100.arm.linux.org.uk>
Message-ID: <E1QKCEB-0007Ns-AN@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than each platform providing its own function to adjust the
zone sizes, use the new ARM_DMA_ZONE_SIZE definition to perform this
adjustment.  This ensures that the actual DMA zone size and the
ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS definitions are consistent with
each other, and moves this complexity out of the platform code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c                     |    8 -------
 arch/arm/include/asm/memory.h                |    6 -----
 arch/arm/mach-davinci/include/mach/memory.h  |   15 --------------
 arch/arm/mach-ixp4xx/common-pci.c            |   23 ----------------------
 arch/arm/mach-ixp4xx/include/mach/memory.h   |    9 +-------
 arch/arm/mach-pxa/cm-x2xx-pci.c              |   27 --------------------------
 arch/arm/mach-pxa/include/mach/memory.h      |    7 +-----
 arch/arm/mach-realview/core.c                |   19 ------------------
 arch/arm/mach-realview/include/mach/memory.h |    6 +----
 arch/arm/mach-sa1100/include/mach/memory.h   |    9 --------
 arch/arm/mach-shark/include/mach/memory.h    |   17 ----------------
 arch/arm/mm/init.c                           |   23 +++++++++++++++++++++-
 12 files changed, 25 insertions(+), 144 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index a12b33c..9c49a46 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -185,14 +185,6 @@ static struct sa1111_dev_info sa1111_devices[] = {
 	},
 };
 
-void __init sa1111_adjust_zones(unsigned long *size, unsigned long *holes)
-{
-	unsigned int sz = SZ_1M >> PAGE_SHIFT;
-
-	size[1] = size[0] - sz;
-	size[0] = sz;
-}
-
 /*
  * SA1111 interrupt support.  Since clearing an IRQ while there are
  * active IRQs causes the interrupt output to pulse, the upper levels
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index ee5ff41..af44a8f 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -215,12 +215,6 @@ static inline unsigned long __phys_to_virt(unsigned long x)
 #define ISA_DMA_THRESHOLD	(PHYS_OFFSET + ARM_DMA_ZONE_SIZE - 1)
 #endif
 
-#ifndef arch_adjust_zones
-#define arch_adjust_zones(size,holes) do { } while (0)
-#elif !defined(CONFIG_ZONE_DMA)
-#error "custom arch_adjust_zones() requires CONFIG_ZONE_DMA"
-#endif
-
 /*
  * PFNs are used to describe any physical page; this means
  * PFN 0 == physical address 0.
diff --git a/arch/arm/mach-davinci/include/mach/memory.h b/arch/arm/mach-davinci/include/mach/memory.h
index 8d27246..491249e 100644
--- a/arch/arm/mach-davinci/include/mach/memory.h
+++ b/arch/arm/mach-davinci/include/mach/memory.h
@@ -41,26 +41,11 @@
  */
 #define CONSISTENT_DMA_SIZE (14<<20)
 
-#ifndef __ASSEMBLY__
 /*
  * Restrict DMA-able region to workaround silicon bug.  The bug
  * restricts buffers available for DMA to video hardware to be
  * below 128M
  */
-static inline void
-__arch_adjust_zones(unsigned long *size, unsigned long *holes)
-{
-	unsigned int sz = (128<<20) >> PAGE_SHIFT;
-
-	size[1] = size[0] - sz;
-	size[0] = sz;
-}
-
-#define arch_adjust_zones(zone_size, holes) \
-        if ((meminfo.bank[0].size >> 20) > 128) __arch_adjust_zones(zone_size, holes)
-
 #define ARM_DMA_ZONE_SIZE	SZ_128M
 
-#endif
-
 #endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index a54b3db..e9a5893 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -342,29 +342,6 @@ int dma_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
 	return (dev->bus == &pci_bus_type ) && ((dma_addr + size) >= SZ_64M);
 }
 
-/*
- * Only first 64MB of memory can be accessed via PCI.
- * We use GFP_DMA to allocate safe buffers to do map/unmap.
- * This is really ugly and we need a better way of specifying
- * DMA-capable regions of memory.
- */
-void __init ixp4xx_adjust_zones(unsigned long *zone_size,
-	unsigned long *zhole_size)
-{
-	unsigned int sz = SZ_64M >> PAGE_SHIFT;
-
-	/*
-	 * Only adjust if > 64M on current system
-	 */
-	if (zone_size[0] <= sz)
-		return;
-
-	zone_size[1] = zone_size[0] - sz;
-	zone_size[0] = sz;
-	zhole_size[1] = zhole_size[0];
-	zhole_size[0] = 0;
-}
-
 void __init ixp4xx_pci_preinit(void)
 {
 	unsigned long cpuid = read_cpuid_id();
diff --git a/arch/arm/mach-ixp4xx/include/mach/memory.h b/arch/arm/mach-ixp4xx/include/mach/memory.h
index a5c26f8..34e7940 100644
--- a/arch/arm/mach-ixp4xx/include/mach/memory.h
+++ b/arch/arm/mach-ixp4xx/include/mach/memory.h
@@ -14,15 +14,8 @@
  */
 #define PLAT_PHYS_OFFSET	UL(0x00000000)
 
-#if !defined(__ASSEMBLY__) && defined(CONFIG_PCI)
-
-void ixp4xx_adjust_zones(unsigned long *size, unsigned long *holes);
-
-#define arch_adjust_zones(size, holes) \
-	ixp4xx_adjust_zones(size, holes)
-
+#ifdef CONFIG_PCI
 #define ARM_DMA_ZONE_SIZE	SZ_64M
-
 #endif
 
 #endif
diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index 8b1a309..1afc0fb 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -29,33 +29,6 @@
 unsigned long it8152_base_address;
 static int cmx2xx_it8152_irq_gpio;
 
-/*
- * Only first 64MB of memory can be accessed via PCI.
- * We use GFP_DMA to allocate safe buffers to do map/unmap.
- * This is really ugly and we need a better way of specifying
- * DMA-capable regions of memory.
- */
-void __init cmx2xx_pci_adjust_zones(unsigned long *zone_size,
-	unsigned long *zhole_size)
-{
-	unsigned int sz = SZ_64M >> PAGE_SHIFT;
-
-	if (machine_is_armcore()) {
-		pr_info("Adjusting zones for CM-X2XX\n");
-
-		/*
-		 * Only adjust if > 64M on current system
-		 */
-		if (zone_size[0] <= sz)
-			return;
-
-		zone_size[1] = zone_size[0] - sz;
-		zone_size[0] = sz;
-		zhole_size[1] = zhole_size[0];
-		zhole_size[0] = 0;
-	}
-}
-
 static void cmx2xx_it8152_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
 	/* clear our parent irq */
diff --git a/arch/arm/mach-pxa/include/mach/memory.h b/arch/arm/mach-pxa/include/mach/memory.h
index 57a0b68..07734f3 100644
--- a/arch/arm/mach-pxa/include/mach/memory.h
+++ b/arch/arm/mach-pxa/include/mach/memory.h
@@ -17,12 +17,7 @@
  */
 #define PLAT_PHYS_OFFSET	UL(0xa0000000)
 
-#if !defined(__ASSEMBLY__) && defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
-void cmx2xx_pci_adjust_zones(unsigned long *size, unsigned long *holes);
-
-#define arch_adjust_zones(size, holes) \
-	cmx2xx_pci_adjust_zones(size, holes)
-
+#if defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
 #define ARM_DMA_ZONE_SIZE	SZ_64M
 #endif
 
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 75dbc87..525ad17 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -56,25 +56,6 @@
 
 #include "core.h"
 
-#ifdef CONFIG_ZONE_DMA
-/*
- * Adjust the zones if there are restrictions for DMA access.
- */
-void __init realview_adjust_zones(unsigned long *size, unsigned long *hole)
-{
-	unsigned long dma_size = SZ_256M >> PAGE_SHIFT;
-
-	if (!machine_is_realview_pbx() || size[0] <= dma_size)
-		return;
-
-	size[ZONE_NORMAL] = size[0] - dma_size;
-	size[ZONE_DMA] = dma_size;
-	hole[ZONE_NORMAL] = hole[0];
-	hole[ZONE_DMA] = 0;
-}
-#endif
-
-
 #define REALVIEW_FLASHCTRL    (__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_FLASH_OFFSET)
 
 static int realview_flash_init(void)
diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
index 973428d..1759fa6 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -29,11 +29,7 @@
 #define PLAT_PHYS_OFFSET		UL(0x00000000)
 #endif
 
-#if !defined(__ASSEMBLY__) && defined(CONFIG_ZONE_DMA)
-extern void realview_adjust_zones(unsigned long *size, unsigned long *hole);
-#define arch_adjust_zones(size, hole) \
-	realview_adjust_zones(size, hole)
-
+#ifdef CONFIG_ZONE_DMA
 #define ARM_DMA_ZONE_SIZE	SZ_256M
 #endif
 
diff --git a/arch/arm/mach-sa1100/include/mach/memory.h b/arch/arm/mach-sa1100/include/mach/memory.h
index 090b829..cff31ee 100644
--- a/arch/arm/mach-sa1100/include/mach/memory.h
+++ b/arch/arm/mach-sa1100/include/mach/memory.h
@@ -14,17 +14,8 @@
  */
 #define PLAT_PHYS_OFFSET	UL(0xc0000000)
 
-#ifndef __ASSEMBLY__
-
 #ifdef CONFIG_SA1111
-void sa1111_adjust_zones(unsigned long *size, unsigned long *holes);
-
-#define arch_adjust_zones(size, holes) \
-	sa1111_adjust_zones(size, holes)
-
 #define ARM_DMA_ZONE_SIZE	SZ_1M
-
-#endif
 #endif
 
 /*
diff --git a/arch/arm/mach-shark/include/mach/memory.h b/arch/arm/mach-shark/include/mach/memory.h
index 48fe84b..4c0831f8 100644
--- a/arch/arm/mach-shark/include/mach/memory.h
+++ b/arch/arm/mach-shark/include/mach/memory.h
@@ -17,25 +17,8 @@
  */
 #define PLAT_PHYS_OFFSET     UL(0x08000000)
 
-#ifndef __ASSEMBLY__
-
-static inline void __arch_adjust_zones(unsigned long *zone_size, unsigned long *zhole_size)
-{
-  /* Only the first 4 MB (=1024 Pages) are usable for DMA */
-  /* See dev / -> .properties in OpenFirmware. */
-  zone_size[1] = zone_size[0] - 1024;
-  zone_size[0] = 1024;
-  zhole_size[1] = zhole_size[0];
-  zhole_size[0] = 0;
-}
-
-#define arch_adjust_zones(size, holes) \
-	__arch_adjust_zones(size, holes)
-
 #define ARM_DMA_ZONE_SIZE	SZ_4M
 
-#endif
-
 /*
  * Cache flushing area
  */
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index e5f6fc4..49eaad9 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -201,6 +201,20 @@ static void __init arm_bootmem_init(unsigned long start_pfn,
 	}
 }
 
+#ifdef CONFIG_ZONE_DMA
+static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
+	unsigned long dma_size)
+{
+	if (size[0] <= dma_size)
+		return;
+
+	size[ZONE_NORMAL] = size[0] - dma_size;
+	size[ZONE_DMA] = dma_size;
+	hole[ZONE_NORMAL] = hole[0];
+	hole[ZONE_DMA] = 0;
+}
+#endif
+
 static void __init arm_bootmem_free(unsigned long min, unsigned long max_low,
 	unsigned long max_high)
 {
@@ -243,11 +257,18 @@ static void __init arm_bootmem_free(unsigned long min, unsigned long max_low,
 #endif
 	}
 
+#ifdef ARM_DMA_ZONE_SIZE
+#ifndef CONFIG_ZONE_DMA
+#error ARM_DMA_ZONE_SIZE set but no DMA zone to limit allocations
+#endif
+
 	/*
 	 * Adjust the sizes according to any special requirements for
 	 * this machine type.
 	 */
-	arch_adjust_zones(zone_size, zhole_size);
+	arm_adjust_dma_zone(zone_size, zhole_size,
+		ARM_DMA_ZONE_SIZE >> PAGE_SHIFT);
+#endif
 
 	free_area_init_node(0, zone_size, min, zhole_size);
 }
-- 
1.7.4.4
