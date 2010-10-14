From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Oct 2010 18:10:52 +0200
Subject: [PATCH 2/7] arm/versatile: boot-time configure xilinx-pci
In-Reply-To: <1287072657-32477-1-git-send-email-arnd@arndb.de>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
Message-ID: <1287072657-32477-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Xilinx-pci code is currently hardcoded to the registers
used on the versatile-pb platform. Make all dependencies on
specific register locations set at boot time so we can use
the same code on realview.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-versatile/versatile_pb.c            |   61 +++++++
 arch/arm/plat-versatile/include/plat/xilinx-pci.h |   27 +++
 arch/arm/plat-versatile/xilinx-pci.c              |  201 +++++++++------------
 3 files changed, 177 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm/plat-versatile/include/plat/xilinx-pci.h

diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 239cd30..4e5e1c7 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -28,6 +28,8 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <plat/xilinx-pci.h>
+
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
@@ -94,6 +96,63 @@ static struct amba_device *amba_devs[] __initdata = {
 	&mmc1_device,
 };
 
+#ifdef CONFIG_PCI_HOST_XILINX
+/*
+ * these spaces are mapped using the following base registers:
+ *
+ * Usage Local Bus Memory         Base/Map registers used
+ *
+ * Mem   44000000 - 4FFFFFFF      LB_BASE0/LB_MAP0,  unused
+ * Mem   50000000 - 5FFFFFFF      LB_BASE1/LB_MAP1,  non prefetch
+ * Mem   60000000 - 6FFFFFFF      LB_BASE2/LB_MAP2,  prefetch
+ * IO    43000000 - 43FFFFFF      IO space
+ * Cfg   42000000 - 42FFFFFF	  PCI config
+ *
+ */
+#define __IO_ADDRESS(n) ((void __iomem *)(unsigned long)IO_ADDRESS(n))
+static struct xilinx_pci_data versatile_pci_io = {
+	.base		= VERSATILE_PCI_VIRT_BASE,
+	.cfg_base	= VERSATILE_PCI_CFG_VIRT_BASE,
+	.io_base	= NULL,
+	.sys_pcictl	= __IO_ADDRESS(VERSATILE_SYS_PCICTL),
+	.core_base	= __IO_ADDRESS(VERSATILE_PCI_CORE_BASE),
+	.base_irq	= 27,
+
+	/* identity map outbound AHB addresses to PCI addresses */
+	.imap		= {
+		VERSATILE_PCI_MEM_BASE0 >> 28, /* 0x44000000 */
+		VERSATILE_PCI_MEM_BASE1 >> 28, /* 0x50000000 */
+		VERSATILE_PCI_MEM_BASE2 >> 28, /* 0x60000000 */
+	 },
+
+	/* map all three BARs of the inbound space to RAM */
+	.smap		= {
+		PHYS_OFFSET >> 28, /* inbound memory space mapping 0 */
+		PHYS_OFFSET >> 28, /* inbound memory space mapping 1 */
+		PHYS_OFFSET >> 28, /* inbound I/O space mapping */
+	 },
+
+	.mem_spaces	= {
+		{
+			.name	= "PCI unused",
+			.start	= VERSATILE_PCI_MEM_BASE0,
+			.end	= VERSATILE_PCI_MEM_BASE0+VERSATILE_PCI_MEM_BASE0_SIZE-1,
+			.flags	= IORESOURCE_IO,
+		}, {
+			.name	= "PCI non-prefetchable",
+			.start	= VERSATILE_PCI_MEM_BASE1,
+			.end	= VERSATILE_PCI_MEM_BASE1+VERSATILE_PCI_MEM_BASE1_SIZE-1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.name	= "PCI prefetchable",
+			.start	= VERSATILE_PCI_MEM_BASE2,
+			.end	= VERSATILE_PCI_MEM_BASE2+VERSATILE_PCI_MEM_BASE2_SIZE-1,
+			.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
+		},
+	},
+};
+#endif
+
 static void __init versatile_pb_init(void)
 {
 	int i;
@@ -104,6 +163,8 @@ static void __init versatile_pb_init(void)
 		struct amba_device *d = amba_devs[i];
 		amba_device_register(d, &iomem_resource);
 	}
+
+	xilinx_pci_init(&versatile_pci_io);
 }
 
 MACHINE_START(VERSATILE_PB, "ARM-Versatile PB")
diff --git a/arch/arm/plat-versatile/include/plat/xilinx-pci.h b/arch/arm/plat-versatile/include/plat/xilinx-pci.h
new file mode 100644
index 0000000..b0394c5
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/xilinx-pci.h
@@ -0,0 +1,27 @@
+#ifndef _PLAT_VERSATILE_XILINX_PCI_H
+#define _PLAT_VERSATILE_XILINX_PCI_H
+
+#include <linux/ioport.h>
+#include <linux/compiler.h>
+
+struct xilinx_pci_data {
+	void __iomem *sys_pcictl;
+	void __iomem *base;
+	void __iomem *core_base;
+	void __iomem *cfg_base;
+	void __iomem *io_base;
+	int base_irq;
+
+	u32 imap[3];
+	u32 smap[3];
+
+	struct resource mem_spaces[3];
+};
+
+#ifdef CONFIG_PCI_HOST_XILINX
+extern int __init xilinx_pci_init(struct xilinx_pci_data *x);
+#else
+#define xilinx_pci_init(x) do { } while (0)
+#endif
+
+#endif
diff --git a/arch/arm/plat-versatile/xilinx-pci.c b/arch/arm/plat-versatile/xilinx-pci.c
index 13c7e5f..28d1d7d 100644
--- a/arch/arm/plat-versatile/xilinx-pci.c
+++ b/arch/arm/plat-versatile/xilinx-pci.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/mach-versatile/pci.c
+ *  linux/arch/arm/plat-versatile/pci.c
  *
  * (C) Copyright Koninklijke Philips Electronics NV 2004. All rights reserved.
  * You can redistribute and/or modify this software under the terms of version 2
@@ -27,37 +27,31 @@
 #include <asm/system.h>
 #include <asm/mach/pci.h>
 
-/*
- * these spaces are mapped using the following base registers:
- *
- * Usage Local Bus Memory         Base/Map registers used
- *
- * Mem   50000000 - 5FFFFFFF      LB_BASE0/LB_MAP0,  non prefetch
- * Mem   60000000 - 6FFFFFFF      LB_BASE1/LB_MAP1,  prefetch
- * IO    44000000 - 4FFFFFFF      LB_BASE2/LB_MAP2,  IO
- * Cfg   42000000 - 42FFFFFF	  PCI config
- *
- */
-#define __IO_ADDRESS(n) ((void __iomem *)(unsigned long)IO_ADDRESS(n))
-#define SYS_PCICTL		__IO_ADDRESS(VERSATILE_SYS_PCICTL)
-#define PCI_IMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x0)
-#define PCI_IMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x4)
-#define PCI_IMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x8)
-#define PCI_SMAP0		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x10)
-#define PCI_SMAP1		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x14)
-#define PCI_SMAP2		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0x18)
-#define PCI_SELFID		__IO_ADDRESS(VERSATILE_PCI_CORE_BASE+0xc)
-
-#define DEVICE_ID_OFFSET		0x00
-#define CSR_OFFSET			0x04
-#define CLASS_ID_OFFSET			0x08
-
-#define VP_PCI_DEVICE_ID		0x030010ee
-#define VP_PCI_CLASS_ID			0x0b400000
+#include <plat/xilinx-pci.h>
+
+static struct xilinx_pci_data *xilinx_pci;
+
+#define XILINX_PCI_VIRT_BASE	(xilinx_pci->base)
+#define XILINX_PCI_CFG_VIRT_BASE (xilinx_pci->cfg_base)
+#define SYS_PCICTL		(xilinx_pci->sys_pcictl)
+#define PCI_IMAP0		(xilinx_pci->core_base+0x0)
+#define PCI_IMAP1		(xilinx_pci->core_base+0x4)
+#define PCI_IMAP2		(xilinx_pci->core_base+0x8)
+#define PCI_SMAP0		(xilinx_pci->core_base+0x14)
+#define PCI_SMAP1		(xilinx_pci->core_base+0x18)
+#define PCI_SMAP2		(xilinx_pci->core_base+0x1c)
+#define PCI_SELFID		(xilinx_pci->core_base+0xc)
+
+#define DEVICE_ID_OFFSET	0x00
+#define CSR_OFFSET		0x04
+#define CLASS_ID_OFFSET		0x08
+
+#define VP_PCI_DEVICE_ID	0x030010ee
+#define VP_PCI_CLASS_ID		0x0b400000
 
 static unsigned long pci_slot_ignore = 0;
 
-static int __init versatile_pci_slot_ignore(char *str)
+static int __init xilinx_pci_slot_ignore(char *str)
 {
 	int retval;
 	int slot;
@@ -72,7 +66,7 @@ static int __init versatile_pci_slot_ignore(char *str)
 	return 1;
 }
 
-__setup("pci_slot_ignore=", versatile_pci_slot_ignore);
+__setup("pci_slot_ignore=", xilinx_pci_slot_ignore);
 
 
 static void __iomem *__pci_addr(struct pci_bus *bus,
@@ -90,11 +84,11 @@ static void __iomem *__pci_addr(struct pci_bus *bus,
 	if (devfn > 255)
 		BUG();
 
-	return VERSATILE_PCI_CFG_VIRT_BASE + ((busnr << 16) |
+	return XILINX_PCI_CFG_VIRT_BASE + ((busnr << 16) |
 		(PCI_SLOT(devfn) << 11) | (PCI_FUNC(devfn) << 8) | offset);
 }
 
-static int versatile_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+static int xilinx_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 				 int size, u32 *val)
 {
 	void __iomem *addr = __pci_addr(bus, devfn, where & ~3);
@@ -138,7 +132,7 @@ static int versatile_read_config(struct pci_bus *bus, unsigned int devfn, int wh
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int versatile_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+static int xilinx_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 				  int size, u32 val)
 {
 	void __iomem *addr = __pci_addr(bus, devfn, where);
@@ -165,75 +159,48 @@ static int versatile_write_config(struct pci_bus *bus, unsigned int devfn, int w
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static struct pci_ops pci_versatile_ops = {
-	.read	= versatile_read_config,
-	.write	= versatile_write_config,
-};
-
-static struct resource io_mem = {
-	.name	= "PCI I/O space",
-	.start	= VERSATILE_PCI_MEM_BASE0,
-	.end	= VERSATILE_PCI_MEM_BASE0+VERSATILE_PCI_MEM_BASE0_SIZE-1,
-	.flags	= IORESOURCE_IO,
-};
-
-static struct resource non_mem = {
-	.name	= "PCI non-prefetchable",
-	.start	= VERSATILE_PCI_MEM_BASE1,
-	.end	= VERSATILE_PCI_MEM_BASE1+VERSATILE_PCI_MEM_BASE1_SIZE-1,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct resource pre_mem = {
-	.name	= "PCI prefetchable",
-	.start	= VERSATILE_PCI_MEM_BASE2,
-	.end	= VERSATILE_PCI_MEM_BASE2+VERSATILE_PCI_MEM_BASE2_SIZE-1,
-	.flags	= IORESOURCE_MEM | IORESOURCE_PREFETCH,
+static struct pci_ops pci_xilinx_ops = {
+	.read	= xilinx_read_config,
+	.write	= xilinx_write_config,
 };
 
-static int __init pci_versatile_setup_resources(struct resource **resource)
+static int __init pci_xilinx_setup_resources(struct resource **resource)
 {
 	int ret = 0;
-
-	ret = request_resource(&iomem_resource, &io_mem);
-	if (ret) {
-		printk(KERN_ERR "PCI: unable to allocate I/O "
-		       "memory region (%d)\n", ret);
-		goto out;
-	}
-	ret = request_resource(&iomem_resource, &non_mem);
-	if (ret) {
-		printk(KERN_ERR "PCI: unable to allocate non-prefetchable "
-		       "memory region (%d)\n", ret);
-		goto release_io_mem;
-	}
-	ret = request_resource(&iomem_resource, &pre_mem);
-	if (ret) {
-		printk(KERN_ERR "PCI: unable to allocate prefetchable "
-		       "memory region (%d)\n", ret);
-		goto release_non_mem;
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		ret = request_resource(&iomem_resource,
+					&xilinx_pci->mem_spaces[i]);
+		if (ret) {
+			printk(KERN_ERR "PCI: unable to allocate memory "
+				"region %d\n", i);
+			goto out_release;
+		}
 	}
-
 	/*
 	 * bus->resource[0] is the IO resource for this bus
 	 * bus->resource[1] is the mem resource for this bus
 	 * bus->resource[2] is the prefetch mem resource for this bus
 	 */
-	resource[0] = &io_mem;
-	resource[1] = &non_mem;
-	resource[2] = &pre_mem;
-
+	resource[0] = &xilinx_pci->mem_spaces[0];
+	resource[1] = &xilinx_pci->mem_spaces[1];
+	resource[2] = &xilinx_pci->mem_spaces[2];
 	goto out;
 
- release_non_mem:
-	release_resource(&non_mem);
- release_io_mem:
-	release_resource(&io_mem);
+ out_release:
+	switch(i) {
+	case 2:
+		release_resource(&xilinx_pci->mem_spaces[1]);
+	case 1:
+		release_resource(&xilinx_pci->mem_spaces[0]);
+		break;
+	}
  out:
 	return ret;
 }
 
-int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
+int __init pci_xilinx_setup(int nr, struct pci_sys_data *sys)
 {
 	int ret = 0;
         int i;
@@ -250,13 +217,13 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 
 	if (nr == 0) {
 		sys->mem_offset = 0;
-		ret = pci_versatile_setup_resources(sys->resource);
+		ret = pci_xilinx_setup_resources(sys->resource);
 		if (ret < 0) {
-			printk("pci_versatile_setup: resources... oops?\n");
+			printk("pci_xilinx_setup: resources... oops?\n");
 			goto out;
 		}
 	} else {
-		printk("pci_versatile_setup: resources... nr == 0??\n");
+		printk("pci_xilinx_setup: resources... nr == 0??\n");
 		goto out;
 	}
 
@@ -265,8 +232,8 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 	 *  before the main PCI probing is performed
 	 */
 	for (i=0; i<32; i++)
-		if ((__raw_readl(VERSATILE_PCI_VIRT_BASE+(i<<11)+DEVICE_ID_OFFSET) == VP_PCI_DEVICE_ID) &&
-		    (__raw_readl(VERSATILE_PCI_VIRT_BASE+(i<<11)+CLASS_ID_OFFSET) == VP_PCI_CLASS_ID)) {
+		if ((__raw_readl(XILINX_PCI_VIRT_BASE+(i<<11)+DEVICE_ID_OFFSET) == VP_PCI_DEVICE_ID) &&
+		    (__raw_readl(XILINX_PCI_VIRT_BASE+(i<<11)+CLASS_ID_OFFSET) == VP_PCI_CLASS_ID)) {
 			myslot = i;
 			break;
 		}
@@ -280,7 +247,7 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 	printk("PCI core found (slot %d)\n",myslot);
 
 	__raw_writel(myslot, PCI_SELFID);
-	local_pci_cfg_base = VERSATILE_PCI_CFG_VIRT_BASE + (myslot << 11);
+	local_pci_cfg_base = XILINX_PCI_CFG_VIRT_BASE + (myslot << 11);
 
 	val = __raw_readl(local_pci_cfg_base + CSR_OFFSET);
 	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
@@ -304,28 +271,38 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 }
 
 
-struct pci_bus * __init pci_versatile_scan_bus(int nr, struct pci_sys_data *sys)
+struct pci_bus * __init pci_xilinx_scan_bus(int nr, struct pci_sys_data *sys)
 {
-	return pci_scan_bus(sys->busnr, &pci_versatile_ops, sys);
+	return pci_scan_bus(sys->busnr, &pci_xilinx_ops, sys);
 }
 
-void __init pci_versatile_preinit(void)
+void __init pci_xilinx_preinit(void)
 {
-	__raw_writel(VERSATILE_PCI_MEM_BASE0 >> 28, PCI_IMAP0);
-	__raw_writel(VERSATILE_PCI_MEM_BASE1 >> 28, PCI_IMAP1);
-	__raw_writel(VERSATILE_PCI_MEM_BASE2 >> 28, PCI_IMAP2);
+	pr_debug("xilinx-pci: before: imap %x %x %x smap %x %x %x\n",
+		readl(PCI_IMAP0), readl(PCI_IMAP1), readl(PCI_IMAP2),
+		readl(PCI_SMAP0), readl(PCI_SMAP1), readl(PCI_SMAP2));
+
+	pr_debug("xilinx-pci: writing: imap %x %x %x smap %x %x %x\n",
+		xilinx_pci->imap[0], xilinx_pci->imap[1], xilinx_pci->imap[2],
+		xilinx_pci->smap[0], xilinx_pci->smap[1], xilinx_pci->smap[2]);
+
+	writel((xilinx_pci->imap[0]), PCI_IMAP0);
+	writel((xilinx_pci->imap[1]), PCI_IMAP1);
+	writel((xilinx_pci->imap[2]), PCI_IMAP2);
 
-	__raw_writel(PHYS_OFFSET >> 28, PCI_SMAP0);
-	__raw_writel(PHYS_OFFSET >> 28, PCI_SMAP1);
-	__raw_writel(PHYS_OFFSET >> 28, PCI_SMAP2);
+	writel((xilinx_pci->smap[0]), PCI_SMAP0);
+	writel((xilinx_pci->smap[1]), PCI_SMAP1);
+	writel((xilinx_pci->smap[2]), PCI_SMAP2);
 
-	__raw_writel(1, SYS_PCICTL);
+	pr_debug("xilinx-pci: after: imap %x %x %x smap %x %x %x\n",
+		readl(PCI_IMAP0), readl(PCI_IMAP1), readl(PCI_IMAP2),
+		readl(PCI_SMAP0), readl(PCI_SMAP1), readl(PCI_SMAP2));
 }
 
 /*
  * map the specified device/slot/pin to an IRQ.   Different backplanes may need to modify this.
  */
-static int __init versatile_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+static int __init xilinx_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq;
 	int devslot = PCI_SLOT(dev->devfn);
@@ -336,26 +313,26 @@ static int __init versatile_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 	 *  26     1     29
 	 *  27     1     30
 	 */
-	irq = 27 + ((slot + pin - 1) & 3);
+	irq = xilinx_pci->base_irq + ((slot + pin - 1) & 3);
 
 	printk("PCI map irq: slot %d, pin %d, devslot %d, irq: %d\n",slot,pin,devslot,irq);
 
 	return irq;
 }
 
-static struct hw_pci versatile_pci __initdata = {
+static struct hw_pci xilinx_hw_pci __initdata = {
 	.swizzle		= NULL,
-	.map_irq		= versatile_map_irq,
+	.map_irq		= xilinx_map_irq,
 	.nr_controllers		= 1,
-	.setup			= pci_versatile_setup,
-	.scan			= pci_versatile_scan_bus,
-	.preinit		= pci_versatile_preinit,
+	.setup			= pci_xilinx_setup,
+	.scan			= pci_xilinx_scan_bus,
+	.preinit		= pci_xilinx_preinit,
 };
 
-static int __init versatile_pci_init(void)
+int __init xilinx_pci_init(struct xilinx_pci_data *x)
 {
-	pci_common_init(&versatile_pci);
+	xilinx_pci = x;
+	pci_common_init(&xilinx_hw_pci);
 	return 0;
 }
 
-subsys_initcall(versatile_pci_init);
-- 
1.7.1
