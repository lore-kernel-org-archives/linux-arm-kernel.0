From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Oct 2010 18:10:53 +0200
Subject: [PATCH 3/7] arm/versatile: enable PCI I/O space
In-Reply-To: <1287072657-32477-1-git-send-email-arnd@arndb.de>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
Message-ID: <1287072657-32477-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I/O space handling on the versatile platform is currently
broken in multiple ways. Most importantly, the ports do
not get mapped into the virtual address space at all.

Also, there is some amount of confusion between PCI I/O
space and other statically mapped MMIO registers in the
platform code:

* The __io_address() macro that is used to access the
  platform register maps to the same __io macro that gets
  used for I/O space.

* The IO_SPACE_LIMIT is set to a value that is much larger
  than the total available space.

* The I/O resource of the PCI bus is set to the physical
  address of the mapping, which is way outside of the
  actual I/O space limit as well as the address range that
  gets decoded by traditional PCI cards.

* No attempt is made to stay outside of the ISA port range
  that some device drivers try access.

* No resource gets requested as a child of ioport_resource,
  but an IORESOURCE_IO type mapping gets requested
  as a child of iomem_resource.

This patch attempts to correct all of the above. This makes
it possible to use virtio-pci based virtual devices as well
as actual PCI cards including those with legacy ISA port
ranges like VGA.

Some of the issues seem to be duplicated on other platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-versatile/core.c                  |   19 +++----------------
 arch/arm/mach-versatile/include/mach/hardware.h |   15 +++++++--------
 arch/arm/mach-versatile/include/mach/io.h       |    6 ++++--
 arch/arm/mach-versatile/include/mach/platform.h |    4 +++-
 arch/arm/mach-versatile/versatile_pb.c          |    4 ++--
 arch/arm/plat-versatile/xilinx-pci.c            |   19 +++++++++++++++++--
 6 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e38acb0..b03a6d5 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -201,26 +201,13 @@ static struct map_desc versatile_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(VERSATILE_PCI_CFG_BASE),
 		.length		= VERSATILE_PCI_CFG_BASE_SIZE,
 		.type		= MT_DEVICE
-	},
-#if 0
- 	{
-		.virtual	=  VERSATILE_PCI_VIRT_MEM_BASE0,
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_MEM_BASE0),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE
 	}, {
-		.virtual	=  VERSATILE_PCI_VIRT_MEM_BASE1,
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_MEM_BASE1),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	=  VERSATILE_PCI_VIRT_MEM_BASE2,
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_MEM_BASE2),
-		.length		= SZ_16M,
+		.virtual	=  (unsigned long)PCIO_BASE,
+		.pfn		= __phys_to_pfn(VERSATILE_PCI_IO_BASE),
+		.length		= IO_SPACE_LIMIT,
 		.type		= MT_DEVICE
 	},
 #endif
-#endif
 };
 
 void __init versatile_map_io(void)
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
index b5e75bb..59b7716 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -24,21 +24,20 @@
 
 #include <asm/sizes.h>
 
+/* macro to get at MMIO space when running virtually */
+#define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
+#define __io_address(n)		((void __iomem *)(IO_ADDRESS(n)))
+
 /*
  * PCI space virtual addresses
  */
 #define VERSATILE_PCI_VIRT_BASE		(void __iomem *)0xe8000000ul
 #define VERSATILE_PCI_CFG_VIRT_BASE	(void __iomem *)0xe9000000ul
+#define VERSATILE_PCI_IO_VIRT_BASE	(void __iomem *)PCIO_BASE
 
-/* CIK guesswork */
-#define PCIBIOS_MIN_IO			0x44000000
-#define PCIBIOS_MIN_MEM			0x50000000
+#define PCIBIOS_MIN_IO			0x00001000
+#define PCIBIOS_MIN_MEM			0x00000000
 
 #define pcibios_assign_all_busses()     1
 
-/* macro to get at IO space when running virtually */
-#define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
-
-#define __io_address(n)		__io(IO_ADDRESS(n))
-
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
index f067c14..07f3aaf 100644
--- a/arch/arm/mach-versatile/include/mach/io.h
+++ b/arch/arm/mach-versatile/include/mach/io.h
@@ -20,9 +20,11 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
+#define PCIO_BASE	(void __iomem *)0xeb000000ul
+#define PCIO_SIZE	0x00100000ul
+#define IO_SPACE_LIMIT  (PCIO_SIZE - 1)
 
-#define __io(a)		__typesafe_io(a)
+#define __io(a)		((a) + PCIO_BASE)
 #define __mem_pci(a)	(a)
 
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/platform.h b/arch/arm/mach-versatile/include/mach/platform.h
index ec08740..efb5328 100644
--- a/arch/arm/mach-versatile/include/mach/platform.h
+++ b/arch/arm/mach-versatile/include/mach/platform.h
@@ -231,12 +231,14 @@
 /* PCI space */
 #define VERSATILE_PCI_BASE             0x41000000	/* PCI Interface */
 #define VERSATILE_PCI_CFG_BASE	       0x42000000
+#define VERSATILE_PCI_IO_BASE	       0x43000000
 #define VERSATILE_PCI_MEM_BASE0        0x44000000
 #define VERSATILE_PCI_MEM_BASE1        0x50000000
 #define VERSATILE_PCI_MEM_BASE2        0x60000000
 /* Sizes of above maps */
 #define VERSATILE_PCI_BASE_SIZE	       0x01000000
-#define VERSATILE_PCI_CFG_BASE_SIZE    0x02000000
+#define VERSATILE_PCI_CFG_BASE_SIZE    0x01000000
+#define VERSATILE_PCI_IO_BASE_SIZE     0x01000000
 #define VERSATILE_PCI_MEM_BASE0_SIZE   0x0c000000	/* 32Mb */
 #define VERSATILE_PCI_MEM_BASE1_SIZE   0x10000000	/* 256Mb */
 #define VERSATILE_PCI_MEM_BASE2_SIZE   0x10000000	/* 256Mb */
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 4e5e1c7..0f39fde 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -113,7 +113,7 @@ static struct amba_device *amba_devs[] __initdata = {
 static struct xilinx_pci_data versatile_pci_io = {
 	.base		= VERSATILE_PCI_VIRT_BASE,
 	.cfg_base	= VERSATILE_PCI_CFG_VIRT_BASE,
-	.io_base	= NULL,
+	.io_base	= PCIO_BASE,
 	.sys_pcictl	= __IO_ADDRESS(VERSATILE_SYS_PCICTL),
 	.core_base	= __IO_ADDRESS(VERSATILE_PCI_CORE_BASE),
 	.base_irq	= 27,
@@ -137,7 +137,7 @@ static struct xilinx_pci_data versatile_pci_io = {
 			.name	= "PCI unused",
 			.start	= VERSATILE_PCI_MEM_BASE0,
 			.end	= VERSATILE_PCI_MEM_BASE0+VERSATILE_PCI_MEM_BASE0_SIZE-1,
-			.flags	= IORESOURCE_IO,
+			.flags	= IORESOURCE_MEM,
 		}, {
 			.name	= "PCI non-prefetchable",
 			.start	= VERSATILE_PCI_MEM_BASE1,
diff --git a/arch/arm/plat-versatile/xilinx-pci.c b/arch/arm/plat-versatile/xilinx-pci.c
index 28d1d7d..425604a 100644
--- a/arch/arm/plat-versatile/xilinx-pci.c
+++ b/arch/arm/plat-versatile/xilinx-pci.c
@@ -164,11 +164,25 @@ static struct pci_ops pci_xilinx_ops = {
 	.write	= xilinx_write_config,
 };
 
+static struct resource io_port = {
+	.name	= "PCI",
+	.start	= 0,
+	.end	= IO_SPACE_LIMIT,
+	.flags	= IORESOURCE_IO,
+};
+
 static int __init pci_xilinx_setup_resources(struct resource **resource)
 {
 	int ret = 0;
 	int i;
 
+	ret = request_resource(&ioport_resource, &io_port);
+	if (ret) {
+		printk(KERN_ERR "PCI: unable to allocate I/O "
+		       "port region (%d)\n", ret);
+		goto out;
+	}
+
 	for (i = 0; i < 3; i++) {
 		ret = request_resource(&iomem_resource,
 					&xilinx_pci->mem_spaces[i]);
@@ -183,7 +197,7 @@ static int __init pci_xilinx_setup_resources(struct resource **resource)
 	 * bus->resource[1] is the mem resource for this bus
 	 * bus->resource[2] is the prefetch mem resource for this bus
 	 */
-	resource[0] = &xilinx_pci->mem_spaces[0];
+	resource[0] = &io_port;
 	resource[1] = &xilinx_pci->mem_spaces[1];
 	resource[2] = &xilinx_pci->mem_spaces[2];
 	goto out;
@@ -194,6 +208,8 @@ static int __init pci_xilinx_setup_resources(struct resource **resource)
 		release_resource(&xilinx_pci->mem_spaces[1]);
 	case 1:
 		release_resource(&xilinx_pci->mem_spaces[0]);
+	case 0:
+		release_resource(&io_port);
 		break;
 	}
  out:
@@ -335,4 +351,3 @@ int __init xilinx_pci_init(struct xilinx_pci_data *x)
 	pci_common_init(&xilinx_hw_pci);
 	return 0;
 }
-
-- 
1.7.1
