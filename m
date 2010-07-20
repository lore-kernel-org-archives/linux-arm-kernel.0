From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Jul 2010 11:23:38 +0200
Subject: =?utf-8?q?=5BRFC=5D=C2=A0arm=3A_versatile=3A_enable_PCI_I/O?= space
Message-ID: <201007201123.38709.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I believe I have found out what is actually going on with PCI I/O
space mapping on the versatile platform, thanks to Catalin pointing
me in the right direction.

It seems that I/O space handling on the versatile platform is
currently broken in multiple ways. Most importantly, the ports do
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

Some of the issues seem to be duplicated on other platforms
and if I got it right, we should probably do similar changes
there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 3dff864..27051a3 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -200,26 +200,13 @@ static struct map_desc versatile_io_desc[] __initdata = {
 		.pfn		= __phys_to_pfn(VERSATILE_PCI_CFG_BASE),
 		.length		= VERSATILE_PCI_CFG_BASE_SIZE,
 		.type		= MT_DEVICE
-	},
-#if 0
- 	{
+	}, {
 		.virtual	=  VERSATILE_PCI_VIRT_MEM_BASE0,
 		.pfn		= __phys_to_pfn(VERSATILE_PCI_MEM_BASE0),
 		.length		= SZ_16M,
 		.type		= MT_DEVICE
-	}, {
-		.virtual	=  VERSATILE_PCI_VIRT_MEM_BASE1,
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_MEM_BASE1),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE
-	}, {
-		.virtual	=  VERSATILE_PCI_VIRT_MEM_BASE2,
-		.pfn		= __phys_to_pfn(VERSATILE_PCI_MEM_BASE2),
-		.length		= SZ_16M,
-		.type		= MT_DEVICE
 	},
 #endif
-#endif
 };
 
 void __init versatile_map_io(void)
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
index 4f8f99a..9b080ee 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -29,25 +29,16 @@
  */
 #define VERSATILE_PCI_VIRT_BASE		(void __iomem *)0xe8000000ul
 #define VERSATILE_PCI_CFG_VIRT_BASE	(void __iomem *)0xe9000000ul
+#define VERSATILE_PCI_VIRT_MEM_BASE0	(void __iomem *)0xeb000000ul
 
-#if 0
-#define VERSATILE_PCI_VIRT_MEM_BASE0	0xf4000000
-#define VERSATILE_PCI_VIRT_MEM_BASE1	0xf5000000
-#define VERSATILE_PCI_VIRT_MEM_BASE2	0xf6000000
-
-#define PCIO_BASE			VERSATILE_PCI_VIRT_MEM_BASE0
-#define PCIMEM_BASE			VERSATILE_PCI_VIRT_MEM_BASE1
-#endif
-
-/* CIK guesswork */
-#define PCIBIOS_MIN_IO			0x44000000
+#define PCIBIOS_MIN_IO			0x00001000
 #define PCIBIOS_MIN_MEM			0x50000000
 
 #define pcibios_assign_all_busses()     1
 
-/* macro to get at IO space when running virtually */
+/* macro to get at MMIO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
 
-#define __io_address(n)		__io(IO_ADDRESS(n))
+#define __io_address(n)		__typesafe_io(IO_ADDRESS(n))
 
 #endif
diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
index f067c14..a276171 100644
--- a/arch/arm/mach-versatile/include/mach/io.h
+++ b/arch/arm/mach-versatile/include/mach/io.h
@@ -20,9 +20,12 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#define IO_SPACE_LIMIT 0xffffffff
+#include <mach/hardware.h>
+#include <mach/platform.h>
 
-#define __io(a)		__typesafe_io(a)
+#define IO_SPACE_LIMIT (VERSATILE_PCI_MEM_BASE0_SIZE - 1)
+
+#define __io(a)		(a + VERSATILE_PCI_VIRT_MEM_BASE0)
 #define __mem_pci(a)	(a)
 
 #endif
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 334f0df..4630ff1 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -170,11 +170,18 @@ static struct pci_ops pci_versatile_ops = {
 	.write	= versatile_write_config,
 };
 
+static struct resource io_port = {
+	.name	= "PCI",
+	.start	= 0,
+	.end	= IO_SPACE_LIMIT,
+	.flags	= IORESOURCE_IO,
+};
+
 static struct resource io_mem = {
 	.name	= "PCI I/O space",
 	.start	= VERSATILE_PCI_MEM_BASE0,
 	.end	= VERSATILE_PCI_MEM_BASE0+VERSATILE_PCI_MEM_BASE0_SIZE-1,
-	.flags	= IORESOURCE_IO,
+	.flags	= IORESOURCE_MEM,
 };
 
 static struct resource non_mem = {
@@ -201,6 +208,12 @@ static int __init pci_versatile_setup_resources(struct resource **resource)
 		       "memory region (%d)\n", ret);
 		goto out;
 	}
+	ret = request_resource(&ioport_resource, &io_port);
+	if (ret) {
+		printk(KERN_ERR "PCI: unable to allocate I/O "
+		       "port region (%d)\n", ret);
+		goto out;
+	}
 	ret = request_resource(&iomem_resource, &non_mem);
 	if (ret) {
 		printk(KERN_ERR "PCI: unable to allocate non-prefetchable "
@@ -219,7 +232,7 @@ static int __init pci_versatile_setup_resources(struct resource **resource)
 	 * bus->resource[1] is the mem resource for this bus
 	 * bus->resource[2] is the prefetch mem resource for this bus
 	 */
-	resource[0] = &io_mem;
+	resource[0] = &io_port;
 	resource[1] = &non_mem;
 	resource[2] = &pre_mem;
 
@@ -250,6 +263,7 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 
 	if (nr == 0) {
 		sys->mem_offset = 0;
+		sys->io_offset = 0;
 		ret = pci_versatile_setup_resources(sys->resource);
 		if (ret < 0) {
 			printk("pci_versatile_setup: resources... oops?\n");
