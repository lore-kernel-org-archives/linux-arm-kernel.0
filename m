From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Jun 2013 01:05:51 +0200
Subject: [PATCH 2/3] ARM: integrator: let pciv3 use mem/premem from device tree
Message-ID: <1372201551-25984-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of relying on the hard-coded mem/premem bases for
the PCI side, read in these from the device tree in the
DT probe path. Hard-code the old values on the non-DT probe
path. Introduce some static locals to hold these addresses
instead of the earlier static #defines.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/pci_v3.c | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index a0e069d..bef1005 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -52,7 +52,8 @@
  * the V3 only has two windows (therefore we need to map stuff on the fly),
  * we maintain the same addresses, even if they're not mapped.
  */
-#define PHYS_PCI_MEM_BASE               0x40000000 /* 512M */
+#define PHYS_PCI_MEM_BASE               0x40000000 /* 256M */
+#define PHYS_PCI_PRE_BASE               0x50000000 /* 256M */
 #define PHYS_PCI_IO_BASE                0x60000000 /* 16M */
 #define PHYS_PCI_CONFIG_BASE            0x61000000 /* 16M */
 #define PHYS_PCI_V3_BASE                0x62000000 /* 64K */
@@ -285,10 +286,16 @@
 
 /* Filled in by probe */
 static void __iomem *pci_v3_base;
+/* CPU side memory ranges */
 static struct resource conf_mem; /* FIXME: remap this instead of static map */
 static struct resource io_mem;
 static struct resource non_mem;
 static struct resource pre_mem;
+/* PCI side memory ranges */
+static u64 non_mem_pci;
+static u64 non_mem_pci_sz;
+static u64 pre_mem_pci;
+static u64 pre_mem_pci_sz;
 
 // V3 access routines
 #define v3_writeb(o,v) __raw_writeb(v, pci_v3_base + (unsigned int)(o))
@@ -354,19 +361,6 @@ static struct resource pre_mem;
  */
 static DEFINE_RAW_SPINLOCK(v3_lock);
 
-#define PCI_BUS_NONMEM_START	0x00000000
-#define PCI_BUS_NONMEM_SIZE	SZ_256M
-
-#define PCI_BUS_PREMEM_START	PCI_BUS_NONMEM_START + PCI_BUS_NONMEM_SIZE
-#define PCI_BUS_PREMEM_SIZE	SZ_256M
-
-#if PCI_BUS_NONMEM_START & 0x000fffff
-#error PCI_BUS_NONMEM_START must be megabyte aligned
-#endif
-#if PCI_BUS_PREMEM_START & 0x000fffff
-#error PCI_BUS_PREMEM_START must be megabyte aligned
-#endif
-
 #undef V3_LB_BASE_PREFETCH
 #define V3_LB_BASE_PREFETCH 0
 
@@ -453,7 +447,7 @@ static void v3_close_config_window(void)
 	v3_writel(V3_LB_BASE1, v3_addr_to_lb_base(pre_mem.start) |
 			V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_PREFETCH |
 			V3_LB_BASE_ENABLE);
-	v3_writew(V3_LB_MAP1, v3_addr_to_lb_map(PCI_BUS_PREMEM_START) |
+	v3_writew(V3_LB_MAP1, v3_addr_to_lb_map(pre_mem_pci) |
 			V3_LB_MAP_TYPE_MEM_MULTIPLE);
 
 	/*
@@ -694,7 +688,7 @@ static void __init pci_v3_preinit(void)
 	 */
 	v3_writel(V3_LB_BASE0, v3_addr_to_lb_base(non_mem.start) |
 			V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_ENABLE);
-	v3_writew(V3_LB_MAP0, v3_addr_to_lb_map(PCI_BUS_NONMEM_START) |
+	v3_writew(V3_LB_MAP0, v3_addr_to_lb_map(non_mem_pci) |
 			V3_LB_MAP_TYPE_MEM);
 
 	/*
@@ -704,7 +698,7 @@ static void __init pci_v3_preinit(void)
 	v3_writel(V3_LB_BASE1, v3_addr_to_lb_base(pre_mem.start) |
 			V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_PREFETCH |
 			V3_LB_BASE_ENABLE);
-	v3_writew(V3_LB_MAP1, v3_addr_to_lb_map(PCI_BUS_PREMEM_START) |
+	v3_writew(V3_LB_MAP1, v3_addr_to_lb_map(pre_mem_pci) |
 			V3_LB_MAP_TYPE_MEM_MULTIPLE);
 
 	/*
@@ -905,11 +899,15 @@ static int __init pci_v3_dtprobe(struct platform_device *pdev,
 		}
 		if ((range.flags & IORESOURCE_MEM) &&
 			!(range.flags & IORESOURCE_PREFETCH)) {
+			non_mem_pci = range.pci_addr;
+			non_mem_pci_sz = range.size;
 			of_pci_range_to_resource(&range, np, &non_mem);
 			non_mem.name = "PCIv3 non-prefetched mem";
 		}
 		if ((range.flags & IORESOURCE_MEM) &&
 			(range.flags & IORESOURCE_PREFETCH)) {
+			pre_mem_pci = range.pci_addr;
+			pre_mem_pci_sz = range.size;
 			of_pci_range_to_resource(&range, np, &pre_mem);
 			pre_mem.name = "PCIv3 prefetched mem";
 		}
@@ -976,16 +974,18 @@ static int __init pci_v3_probe(struct platform_device *pdev)
 	io_mem.end = PHYS_PCI_IO_BASE + SZ_16M - 1;
 	io_mem.flags = IORESOURCE_MEM;
 
+	non_mem_pci = 0x00000000;
+	non_mem_pci_sz = SZ_256M;
 	non_mem.name = "PCIv3 non-prefetched mem";
-	non_mem.start = PHYS_PCI_MEM_BASE + PCI_BUS_NONMEM_START;
-	non_mem.end = PHYS_PCI_MEM_BASE + PCI_BUS_NONMEM_START +
-		PCI_BUS_NONMEM_SIZE - 1;
+	non_mem.start = PHYS_PCI_MEM_BASE;
+	non_mem.end = PHYS_PCI_MEM_BASE + SZ_256M - 1;
 	non_mem.flags = IORESOURCE_MEM;
 
+	pre_mem_pci = 0x10000000;
+	pre_mem_pci_sz = SZ_256M;
 	pre_mem.name = "PCIv3 prefetched mem";
-	pre_mem.start = PHYS_PCI_MEM_BASE + PCI_BUS_PREMEM_START;
-	pre_mem.end = PHYS_PCI_MEM_BASE + PCI_BUS_PREMEM_START +
-		PCI_BUS_PREMEM_SIZE - 1;
+	pre_mem.start = PHYS_PCI_PRE_BASE + SZ_256M;
+	pre_mem.end = PHYS_PCI_PRE_BASE + SZ_256M - 1;
 	pre_mem.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 
 	pci_v3.map_irq = pci_v3_map_irq;
-- 
1.8.1.4
