From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Feb 2013 13:45:28 +0100
Subject: [PATCH 2/2] drivers: dma-contiguous: add initialization from device
 tree
In-Reply-To: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1360845928-8107-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for contiguous memory regions defined in device
tree. Initialization is done in 2 steps. First, the contiguous memory is
reserved, what happens very early, when only flattened device tree is
available. Then on device initialization the corresponding cma regions are
assigned to device structures.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/devicetree/bindings/memory.txt |  101 ++++++++++++++++++++++++++
 arch/arm/boot/dts/skeleton.dtsi              |    7 +-
 drivers/base/dma-contiguous.c                |   72 ++++++++++++++++++
 3 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/memory.txt

diff --git a/Documentation/devicetree/bindings/memory.txt b/Documentation/devicetree/bindings/memory.txt
new file mode 100644
index 0000000..74e0476
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory.txt
@@ -0,0 +1,101 @@
+* Memory binding
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
+* Memory regions
+
+In /memory node one can create additional nodes describing particular
+memory regions, usually for the special usage by various device drivers.
+A good example are contiguous memory allocations or memory sharing with
+other operating system on the same hardware board. Those special memory
+regions might depend on the board configuration and devices used on the
+target system.
+
+Parameters for each memory region can be encoded into the device tree
+wit the following convention:
+
+(name): region@(base-address) {
+	reg = <(baseaddr) (size)>;
+	(linux,contiguous-region);
+	(linux,default-contiguous-region);
+};
+
+name:		an name given to the defined region.
+base-address:	the base address of the defined region.
+size:		the size of the memory region.
+linux,contiguous-region: property indicating that the defined memory
+		region is used for contiguous memory allocations,
+		Linux specific (optional)
+linux,default-contiguous-region: property indicating that the region
+		is the default region for all contiguous memory
+		allocations, Linux specific (optional)
+
+
+* Device nodes
+
+Once the regions in the /memory node are defined, they can be assigned
+to device some device nodes for their special use. The following
+properties are defined:
+
+linux,contiguous-region = <&phandle>;
+	This property indicates that the device driver should use the
+	memory region pointed by the given phandle.
+
+
+* Example:
+
+This example defines a memory consisting of 4 memory banks. 2 contiguous
+regions are defined for Linux kernel, one default of all device drivers
+(named contig_mem, placed at 0x72000000, 64MiB) and one dedicated to the
+framebuffer device (named display_mem, placed at 0x78000000, 16MiB). The
+display_mem region is then assigned to fb at 12300000 device for contiguous
+memory allocation with Linux kernel drivers.
+
+The reason for creating a separate region for framebuffer device is to
+match the framebuffer address of from configuration done by bootloader,
+so once Linux kernel drivers starts, no glitches on the displayed boot
+logo appears.
+
+/ {
+	/* ... */
+	memory {
+		reg =  <0x40000000 0x10000000
+			0x50000000 0x10000000
+			0x60000000 0x10000000
+			0x70000000 0x10000000>;
+
+		contig_mem: region at 72000000 {
+			linux,contiguous-region;
+			linux,default-contiguous-region;
+			reg = <0x72000000 0x4000000>;
+		};
+
+		display_mem: region at 78000000 {
+			linux,contiguous-region;
+			reg = <0x78000000 0x1000000>;
+		};
+	};
+
+	fb at 12300000 {
+		linux,contiguous-region = <&display_mem>;
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/skeleton.dtsi b/arch/arm/boot/dts/skeleton.dtsi
index b41d241..f9988cd 100644
--- a/arch/arm/boot/dts/skeleton.dtsi
+++ b/arch/arm/boot/dts/skeleton.dtsi
@@ -9,5 +9,10 @@
 	#size-cells = <1>;
 	chosen { };
 	aliases { };
-	memory { device_type = "memory"; reg = <0 0>; };
+	memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "memory";
+		reg = <0 0>;
+	};
 };
diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 085389c..5761f73 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -24,6 +24,9 @@
 
 #include <linux/memblock.h>
 #include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/page-isolation.h>
@@ -177,6 +180,35 @@ no_mem:
 	return ERR_PTR(ret);
 }
 
+/*****************************************************************************/
+
+#ifdef CONFIG_OF
+int __init cma_fdt_scan(unsigned long node, const char *uname,
+				int depth, void *data)
+{
+	phys_addr_t base, size;
+	unsigned long len;
+	__be32 *prop;
+
+	if (strncmp(uname, "region@", 7) != 0 || depth != 2 ||
+	    !of_get_flat_dt_prop(node, "contiguous-region", NULL))
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "reg", &len);
+	if (!prop || (len != 2 * sizeof(unsigned long)))
+		return 0;
+
+	base = be32_to_cpu(prop[0]);
+	size = be32_to_cpu(prop[1]);
+
+	pr_info("Found %s, memory base %lx, size %ld MiB\n", uname,
+		(unsigned long)base, (unsigned long)size / SZ_1M);
+	dma_contiguous_reserve_area(size, &base, 0);
+
+	return 0;
+}
+#endif
+
 /**
  * dma_contiguous_reserve() - reserve area for contiguous memory handling
  * @limit: End address of the reserved memory (optional, 0 for any).
@@ -215,6 +247,9 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 		if (dma_contiguous_reserve_area(sel_size, &base, limit) == 0)
 			dma_contiguous_def_base = base;
 	}
+#ifdef CONFIG_OF
+	of_scan_flat_dt(cma_fdt_scan, NULL);
+#endif
 };
 
 /**
@@ -319,6 +354,40 @@ int __init dma_contiguous_add_device(struct device *dev, phys_addr_t base)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static void cma_assign_device_from_dt(struct device *dev)
+{
+	struct device_node *node;
+	struct cma *cma;
+	u32 value;
+
+	node = of_parse_phandle(dev->of_node, "linux,contiguous-region", 0);
+	if (!node)
+		return;
+	if (of_property_read_u32(node, "reg", &value) && !value)
+		return;
+	cma = cma_get_area(value);
+	if (!cma)
+		return;
+
+	dev_set_cma_area(dev, cma);
+	pr_info("Assigned CMA region at %lx to %s device\n", (unsigned long)value, dev_name(dev));
+}
+
+static int cma_device_init_notifier_call(struct notifier_block *nb,
+					 unsigned long event, void *data)
+{
+	struct device *dev = data;
+	if (event == BUS_NOTIFY_ADD_DEVICE && dev->of_node)
+		cma_assign_device_from_dt(dev);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block cma_dev_init_nb = {
+	.notifier_call = cma_device_init_notifier_call,
+};
+#endif
+
 static int __init cma_init_reserved_areas(void)
 {
 	struct cma *cma;
@@ -340,6 +409,9 @@ static int __init cma_init_reserved_areas(void)
 		dev_set_cma_area(cma_maps[i].dev, cma);
 	}
 
+#ifdef CONFIG_OF
+	bus_register_notifier(&platform_bus_type, &cma_dev_init_nb);
+#endif
 	return 0;
 }
 core_initcall(cma_init_reserved_areas);
-- 
1.7.9.5
