From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 31 Jul 2013 14:51:58 +0200
Subject: [PATCH v4 3/4] drivers: of: add initialization code for dma reserved
 memory
In-Reply-To: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1375275119-12787-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for contiguous and reserved memory regions
defined in device tree. Initialization is done in 2 steps. First, the
memory is reserved, what happens very early when only flattened device
tree is available. Then on device initialization the corresponding cma
and reserved regions are assigned to each device structure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/devicetree/bindings/memory.txt |  152 ++++++++++++++++++++++
 drivers/of/Kconfig                           |    6 +
 drivers/of/Makefile                          |    1 +
 drivers/of/of_reserved_mem.c                 |  175 ++++++++++++++++++++++++++
 include/asm-generic/dma-coherent.h           |    6 +
 5 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory.txt
 create mode 100644 drivers/of/of_reserved_mem.c

diff --git a/Documentation/devicetree/bindings/memory.txt b/Documentation/devicetree/bindings/memory.txt
new file mode 100644
index 0000000..4aece19
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory.txt
@@ -0,0 +1,152 @@
+*** Memory binding ***
+
+The /memory node provides basic information about the address and size
+of the physical memory. This node is usually filled or updated by the
+bootloader, depending on the actual memory configuration of the given
+hardware.
+
+The memory layout is described by the folllowing node:
+
+memory {
+	reg =  <(baseaddr1) (size1)
+		(baseaddr2) (size2)
+		...
+		(baseaddrN) (sizeN)>;
+};
+
+baseaddrX:	the base address of the defined memory bank
+sizeX:		the size of the defined memory bank
+
+More than one memory bank can be defined.
+
+
+*** Reserved memory regions ***
+
+In /memory/reserved-memory node one can create additional nodes
+describing particular reserved (excluded from normal use) memory
+regions. Such memory regions are usually designed for the special usage
+by various device drivers. A good example are contiguous memory
+allocations or memory sharing with other operating system on the same
+hardware board. Those special memory regions might depend on the board
+configuration and devices used on the target system.
+
+Parameters for each memory region can be encoded into the device tree
+wit the following convention:
+
+[(label):] (name)@(address) {
+	compatible = "contiguous-memory-region", "reserved-memory-region";
+	reg = <(address) (size)>;
+	(linux,contiguous-region);
+	(linux,default-contiguous-region);
+};
+
+label:		label given to the defined region (optional)
+name:		an name given to the defined region
+address:	the base address of the defined region
+size:		the size of the memory region
+
+compatible:	"contiguous-memory-region" - enables binding of this
+		region to Contiguous Memory Allocator (special region for
+		contiguous memory allocations, shared with movable system
+		memory, Linux kernel-specific), alternatively if
+		"reserved-memory-region" - compatibility is defined, given
+		region is assigned for exclusive usage for DMA transfers
+
+linux,default-contiguous-region: property indicating that the region
+		is the default region for all contiguous memory
+		allocations, Linux specific (optional)
+
+Each defined region must use unique name. It is optional to specify the
+base address, so if one wants to use autoconfiguration of the base
+address, he must specify the '0' as base address in the 'reg' property
+and assign ann uniqe name to such regions.
+
+
+*** Device node's properties ***
+
+Once the regions in the /memory/reserved-memory node are defined, they
+can be assigned to device nodes to enable drivers for their special use.
+The following properties are defined:
+
+dma-memory-region = <&phandle_to_defined_region>;
+
+This property indicates that the device driver should use the
+memory region pointed by the given phandle.
+
+
+*** Example ***
+
+This example defines a memory consisting of 4 memory banks. 3 contiguous
+regions are defined for Linux kernel, one default of all device drivers
+(named contig_mem, placed at 0x72000000, 64MiB), one dedicated to the
+framebuffer device (labelled display_mem, placed at 0x78000000, 8MiB)
+and one for multimedia processing (labelled multimedia_mem, placed at
+0x77000000, 64MiB). 'display_mem' region is then assigned to fb at 12300000
+device for DMA memory allocations (Linux kernel drivers will use CMA is
+available or dma-exclusive usage otherwise). 'multimedia_mem' is
+assigned to scaller at 12500000 and codec at 12600000 devices for contiguous
+memory allocations when CMA driver is enabled.
+
+The reason for creating a separate region for framebuffer device is to
+match the framebuffer base address to the one configured by bootloader,
+so once Linux kernel drivers starts no glitches on the displayed boot
+logo appears. Scaller and codec drivers should share the memory
+allocations.
+
+/ {
+	/* ... */
+	memory {
+		reg =  <0x40000000 0x10000000
+			0x50000000 0x10000000
+			0x60000000 0x10000000
+			0x70000000 0x10000000>;
+
+		reserved-memory {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/*
+			 * global autoconfigured region for contiguous allocations
+			 * (used only with Contiguous Memory Allocator)
+			 */
+			contig_region at 0 {
+				compatible = "contiguous-memory-region";
+				reg = <0x0 0x4000000>;
+				linux,default-contiguous-region;
+			};
+
+			/*
+			 * special region for framebuffer
+			 */
+			display_mem: region at 78000000 {
+				compatible = "contiguous-memory-region", "reserved-memory-region";
+				reg = <0x78000000 0x800000>;
+			};
+
+			/*
+			 * special region for multimedia processing devices
+			 */
+			multimedia_mem: region at 77000000 {
+				compatible = "contiguous-memory-region";
+				reg = <0x77000000 0x4000000>;
+			};
+		};
+	};
+
+	/* ... */
+
+	fb0: fb at 12300000 {
+		status = "okay";
+		dma-memory-region = <&display_mem>;
+	};
+
+	scaller: scaller at 12500000 {
+		status = "okay";
+		dma-memory-region = <&multimedia_mem>;
+	};
+
+	codec: codec at 12600000 {
+		status = "okay";
+		dma-memory-region = <&multimedia_mem>;
+	};
+};
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80e5c13..a83ab43 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -80,4 +80,10 @@ config OF_MTD
 	depends on MTD
 	def_bool y
 
+config OF_RESERVED_MEM
+	depends on CMA || (HAVE_GENERIC_DMA_COHERENT && HAVE_MEMBLOCK)
+	def_bool y
+	help
+	  Initialization code for DMA reserved memory
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 1f9c0c4..e7e3322 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
 obj-$(CONFIG_OF_MTD)	+= of_mtd.o
+obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
new file mode 100644
index 0000000..d97fcdf
--- /dev/null
+++ b/drivers/of/of_reserved_mem.c
@@ -0,0 +1,175 @@
+/*
+ * Device tree based initialization code for reserved memory.
+ *
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License or (at your optional) any later version of the license.
+ */
+
+#include <asm/dma-contiguous.h>
+
+#include <linux/memblock.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/mm.h>
+#include <linux/sizes.h>
+#include <linux/mm_types.h>
+#include <linux/dma-contiguous.h>
+#include <linux/dma-mapping.h>
+
+#define MAX_RESERVED_REGIONS	16
+struct reserved_mem {
+	phys_addr_t		base;
+	unsigned long		size;
+	struct cma		*cma;
+	char			name[32];
+};
+static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static int reserved_mem_count;
+
+static int __init reserved_mem_fdt_scan(unsigned long node, const char *uname,
+				    int depth, void *data)
+{
+	phys_addr_t base, size;
+	int is_cma, is_reserved;
+	unsigned long len;
+	void *prop;
+
+	is_cma = of_flat_dt_is_compatible(node, "contiguous-memory-region");
+	is_reserved = of_flat_dt_is_compatible(node, "reserved-memory-region");
+
+	if (!is_reserved && !(is_cma && IS_ENABLED(CONFIG_CMA)))
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "reg", &len);
+	if (!prop || (len != 2 * sizeof(unsigned long))) {
+		pr_err("Reserved mem: node %s, incorrect \"reg\" property\n",
+		       uname);
+		return 0;
+	}
+
+	if (sizeof(unsigned long) == 4) {
+		base = be32_to_cpu(((__be32 *)prop)[0]);
+		size = be32_to_cpu(((__be32 *)prop)[1]);
+	} else {
+		base = be64_to_cpu(((__be64 *)prop)[0]);
+		size = be64_to_cpu(((__be64 *)prop)[1]);
+	}
+
+	pr_info("Reserved mem: found %s, memory base %lx, size %ld MiB\n",
+		uname, (unsigned long)base, (unsigned long)size / SZ_1M);
+
+	if (reserved_mem_count == ARRAY_SIZE(reserved_mem))
+		return -ENOMEM;
+
+	reserved_mem[reserved_mem_count].base = base;
+	reserved_mem[reserved_mem_count].size = size;
+	strcpy(reserved_mem[reserved_mem_count].name, uname);
+
+	if (IS_ENABLED(CONFIG_CMA) && is_cma) {
+		struct cma *cma;
+		if (dma_contiguous_reserve_area(size, base, 0, &cma) == 0) {
+			reserved_mem[reserved_mem_count].cma = cma;
+			reserved_mem_count++;
+
+			if (of_get_flat_dt_prop(node,
+						"linux,default-contiguous-region",
+						NULL))
+				dma_contiguous_set_default_area(cma);
+		}
+	} else if (is_reserved) {
+		if (memblock_remove(base, size) == 0)
+			reserved_mem_count++;
+		else
+			pr_err("Failed to reserve memory for %s\n", uname);
+	}
+
+	return 0;
+}
+
+static struct reserved_mem *get_dma_memory_region(struct device *dev)
+{
+	struct device_node *node;
+	const char *name;
+	int i;
+
+	node = of_parse_phandle(dev->of_node, "dma-memory-region", 0);
+	if (!node)
+		return NULL;
+
+	name = kbasename(node->full_name);
+	for (i = 0; i < reserved_mem_count; i++)
+		if (strcmp(name, reserved_mem[i].name) == 0)
+			return &reserved_mem[i];
+	return NULL;
+}
+
+static void reserved_mem_assign_device_from_dt(struct device *dev)
+{
+	struct reserved_mem *region = get_dma_memory_region(dev);
+	if (!region)
+		return;
+
+	if (region->cma) {
+		dma_contiguous_add_device(dev, region->cma);
+		pr_info("Assigned CMA %s to %s device\n", region->name,
+			dev_name(dev));
+	} else {
+		if (dma_declare_coherent_memory(dev, region->base, region->base,
+		    region->size, DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE) != 0)
+			pr_info("Declared reserved memory %s to %s device\n",
+				region->name, dev_name(dev));
+	}
+}
+
+static void reserved_mem_release_device_from_dt(struct device *dev)
+{
+	struct reserved_mem *region = get_dma_memory_region(dev);
+	if (!region)
+		return;
+	if (!region->cma)
+		dma_release_declared_memory(dev);
+}
+
+static int reserved_mem_device_init_notifier_call(struct notifier_block *nb,
+						unsigned long event, void *data)
+{
+	struct device *dev = data;
+	if (event == BUS_NOTIFY_ADD_DEVICE && dev->of_node)
+		reserved_mem_assign_device_from_dt(dev);
+	else if (event == BUS_NOTIFY_DEL_DEVICE && dev->of_node)
+		reserved_mem_release_device_from_dt(dev);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block reserved_mem_dev_init_nb = {
+	.notifier_call = reserved_mem_device_init_notifier_call,
+};
+
+static int __init reserved_mem_init_reserved_areas(void)
+{
+	bus_register_notifier(&platform_bus_type, &reserved_mem_dev_init_nb);
+	return 0;
+}
+core_initcall(reserved_mem_init_reserved_areas);
+
+/**
+ * dma_reserved_mem_reserve() - grab memory reserved for device exclusive use
+ *
+ * This function grabs memory from early allocator for device exclusive use
+ * defined in device tree structures. It should be called by arch specific code
+ * once the early allocator (memblock) has been activated and all other
+ * subsystems have already allocated/reserved memory.
+ */
+void __init dma_reserved_mem_of_reserve(void)
+{
+	of_scan_flat_dt_by_path("/memory/reserved-memory",
+				reserved_mem_fdt_scan, NULL);
+}
diff --git a/include/asm-generic/dma-coherent.h b/include/asm-generic/dma-coherent.h
index 2be8a2d..06111d00 100644
--- a/include/asm-generic/dma-coherent.h
+++ b/include/asm-generic/dma-coherent.h
@@ -32,4 +32,10 @@ dma_mark_declared_memory_occupied(struct device *dev,
 #define dma_mmap_from_coherent(dev, vma, vaddr, order, ret) (0)
 #endif
 
+#ifdef CONFIG_OF_RESERVED_MEM
+void __init dma_reserved_mem_of_reserve(void);
+#else
+#define dma_reserved_mem_of_reserve()
+#endif
+
 #endif
-- 
1.7.9.5
